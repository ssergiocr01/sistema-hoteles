import NextAuth from "next-auth";
import Credentials from "next-auth/providers/credentials";
import bcrypt from "bcryptjs";
import { authConfig } from "./auth.config";
import { getPool, sql } from "@/lib/db";

/**
 * Configuración completa de Auth.js.
 * Usa el "Credentials provider": nuestra propia autenticación con email
 * y contraseña, validada contra SQL Server (sp_login) + bcrypt.
 */
export const { handlers, auth, signIn, signOut } = NextAuth({
  ...authConfig,
  providers: [
    Credentials({
      // Campos que espera el formulario de login.
      credentials: {
        email: { label: "Correo", type: "email" },
        password: { label: "Contraseña", type: "password" },
      },
      // Auth.js llama a esta función al intentar iniciar sesión.
      authorize: async (credentials) => {
        const email = credentials?.email as string | undefined;
        const password = credentials?.password as string | undefined;
        if (!email || !password) return null;

        // 1. Buscar al usuario llamando al procedimiento almacenado.
        const pool = await getPool();
        const result = await pool
          .request()
          .input("email", sql.NVarChar(150), email)
          .execute("sp_login");

        const row = result.recordset[0];
        // 2. Si no existe o está inhabilitado, se rechaza.
        if (!row || !row.activo) return null;

        // 3. Comparar la contraseña con el hash (bcrypt, en la app).
        const passwordOk = await bcrypt.compare(password, row.password_hash);
        if (!passwordOk) return null;

        // 4. Devolver el usuario: Auth.js crea la sesión a partir de esto.
        return {
          id: String(row.id),
          name: row.nombre,
          email: row.email,
          perfilId: row.perfil_id,
          perfil: row.perfil,
        };
      },
    }),
  ],
  callbacks: {
    ...authConfig.callbacks,
    // Se ejecuta al crear/actualizar el token. Guardamos el perfil en él.
    async jwt({ token, user }) {
      if (user) {
        token.perfilId = user.perfilId;
        token.perfil = user.perfil;
      }
      return token;
    },
    // Expone los datos del token en la sesión que usa la app.
    async session({ session, token }) {
      if (session.user) {
        session.user.id = token.sub ?? "";
        session.user.perfilId = token.perfilId as number | undefined;
        session.user.perfil = token.perfil as string | undefined;
      }
      return session;
    },
  },
});

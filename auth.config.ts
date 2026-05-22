import type { NextAuthConfig } from "next-auth";

/**
 * Configuración base de Auth.js (sin dependencias de base de datos).
 * Se mantiene "ligera" para que el middleware pueda usarla sin cargar
 * el driver de SQL Server. Los providers se agregan en auth.ts.
 */
export const authConfig = {
  // Página propia de inicio de sesión (en vez de la que trae Auth.js).
  pages: {
    signIn: "/login",
  },
  // La sesión se guarda como un JWT en cookie httpOnly.
  session: { strategy: "jwt" },
  providers: [],
  callbacks: {
    /**
     * Lo usa el middleware (paso 4): si devuelve false, redirige al login.
     * De momento: solo se permite el acceso si hay un usuario en sesión.
     */
    authorized({ auth }) {
      return !!auth?.user;
    },
  },
} satisfies NextAuthConfig;

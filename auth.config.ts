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
     * Lo usa el middleware para decidir el acceso en cada petición.
     * - Si devuelve false en una ruta privada → Auth.js redirige al login.
     * - Puede devolver un Response para redirigir manualmente.
     */
    authorized({ auth, request: { nextUrl } }) {
      const isLoggedIn = !!auth?.user;
      const isOnLogin = nextUrl.pathname.startsWith("/login");

      if (isOnLogin) {
        // Si ya tiene sesión y entra al login, lo mandamos al inicio.
        if (isLoggedIn) return Response.redirect(new URL("/", nextUrl));
        return true; // sin sesión: puede ver el login
      }

      // Cualquier otra ruta requiere sesión.
      return isLoggedIn;
    },
  },
} satisfies NextAuthConfig;

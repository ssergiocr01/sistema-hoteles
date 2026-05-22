import type { DefaultSession } from "next-auth";

/**
 * Extiende los tipos de Auth.js para incluir nuestros campos propios
 * (id del usuario, perfilId y perfil) en el User, la Session y el JWT.
 */
declare module "next-auth" {
  interface User {
    perfilId?: number;
    perfil?: string;
  }

  interface Session {
    user: {
      id?: string;
      perfilId?: number;
      perfil?: string;
    } & DefaultSession["user"];
  }
}

declare module "next-auth/jwt" {
  interface JWT {
    perfilId?: number;
    perfil?: string;
  }
}

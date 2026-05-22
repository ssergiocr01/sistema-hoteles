import NextAuth from "next-auth";
import { authConfig } from "./auth.config";

/**
 * Middleware de autenticación.
 * Usa solo la configuración base (auth.config.ts), sin la base de datos,
 * para ser compatible con el entorno edge donde corre el middleware.
 * La decisión de acceso la toma el callback `authorized`.
 */
export default NextAuth(authConfig).auth;

export const config = {
  // Aplica a todas las rutas EXCEPTO: API, archivos estáticos de Next y favicon.
  matcher: ["/((?!api|_next/static|_next/image|favicon.ico).*)"],
};

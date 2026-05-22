// Route handler que Auth.js necesita para procesar el login, logout, etc.
// Reexporta los handlers GET y POST generados en auth.ts.
import { handlers } from "@/auth";

export const { GET, POST } = handlers;

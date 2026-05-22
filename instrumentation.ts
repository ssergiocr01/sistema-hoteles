/**
 * Captura centralizada de errores del servidor.
 * Next.js llama a onRequestError ante cualquier error no controlado
 * en el servidor (páginas, server actions, route handlers).
 * Así no hay que poner try/catch en todos lados para registrarlos.
 */
export async function onRequestError(
  error: unknown,
  request: { path?: string; method?: string }
) {
  // El registro en BD usa el driver de SQL Server, que solo funciona en
  // el runtime de Node (no en edge, p. ej. el middleware).
  if (process.env.NEXT_RUNTIME !== "nodejs") return;

  try {
    const { registrarError } = await import("@/services/log");
    const err = error as Error;
    await registrarError({
      mensaje: err?.message ?? "Error desconocido",
      detalle: err?.stack ?? null,
      ruta: request?.path ?? null,
      metodo: request?.method ?? null,
      origen: "servidor",
    });
  } catch (e) {
    console.error("[instrumentation] no se pudo registrar el error:", e);
  }
}

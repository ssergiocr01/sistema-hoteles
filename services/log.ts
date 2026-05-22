import { getPool } from "@/lib/db";

type DatosError = {
  mensaje: string;
  detalle?: string | null;
  ruta?: string | null;
  metodo?: string | null;
  origen?: string | null;
  usuarioId?: number | null;
};

/**
 * Registra un error en la tabla log_errores.
 * Está envuelto en try/catch: el registro NUNCA debe lanzar un error
 * (si la BD falla, al menos queda en consola).
 */
export async function registrarError(datos: DatosError): Promise<void> {
  try {
    const pool = await getPool();
    const req = pool.request().input("mensaje", datos.mensaje.slice(0, 1000));

    // Solo agregamos los parámetros que tienen valor; el resto usa el
    // valor por defecto NULL del procedimiento.
    if (datos.detalle) req.input("detalle", datos.detalle);
    if (datos.ruta) req.input("ruta", datos.ruta);
    if (datos.metodo) req.input("metodo", datos.metodo);
    if (datos.origen) req.input("origen", datos.origen);
    if (datos.usuarioId != null) req.input("usuario_id", datos.usuarioId);

    await req.execute("sp_log_error");
  } catch (e) {
    console.error("[log] No se pudo registrar el error en la BD:", e);
    console.error("[log] Error original:", datos.mensaje, datos.detalle);
  }
}

export type ErrorLog = {
  id: number;
  fecha_hora: Date;
  mensaje: string;
  detalle: string | null;
  ruta: string | null;
  metodo: string | null;
  origen: string | null;
  usuario_id: number | null;
  usuario_email: string | null;
};

/**
 * Lista los últimos errores registrados (más recientes primero).
 */
export async function listarErrores(top = 100): Promise<ErrorLog[]> {
  const pool = await getPool();
  const result = await pool.request().input("top", top).execute("sp_log_errores_listar");
  return result.recordset as ErrorLog[];
}

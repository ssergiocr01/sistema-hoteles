import { getPool } from "@/lib/db";

/**
 * Indica si un perfil tiene permiso de VER una ruta.
 * Refuerza el RBAC en el servidor (llama a sp_perfil_puede_ver).
 */
export async function puedeVer(perfilId: number, ruta: string): Promise<boolean> {
  const pool = await getPool();
  const result = await pool
    .request()
    .input("perfil_id", perfilId)
    .input("ruta", ruta)
    .execute("sp_perfil_puede_ver");

  return result.recordset[0]?.puede_ver === true;
}

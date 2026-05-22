import { getPool } from "@/lib/db";

/**
 * Una opción de menú, ya con sus hijos anidados (submenús).
 */
export type MenuItem = {
  id: number;
  padreId: number | null;
  nombre: string;
  ruta: string | null;
  icono: string | null;
  orden: number;
  hijos: MenuItem[];
};

type MenuRow = {
  id: number;
  padre_id: number | null;
  nombre: string;
  ruta: string | null;
  icono: string | null;
  orden: number;
};

/**
 * Obtiene el menú que un perfil puede ver, ya organizado como árbol.
 * Llama al procedimiento almacenado sp_menu_por_perfil.
 */
export async function getMenuPorPerfil(perfilId: number): Promise<MenuItem[]> {
  const pool = await getPool();
  const result = await pool
    .request()
    .input("perfil_id", perfilId)
    .execute("sp_menu_por_perfil");

  const rows = result.recordset as MenuRow[];

  // 1. Convertir cada fila en un MenuItem y guardarlo en un mapa por id.
  const mapa = new Map<number, MenuItem>();
  for (const r of rows) {
    mapa.set(r.id, {
      id: r.id,
      padreId: r.padre_id,
      nombre: r.nombre,
      ruta: r.ruta,
      icono: r.icono,
      orden: r.orden,
      hijos: [],
    });
  }

  // 2. Enlazar cada hijo con su padre; lo que no tenga padre es raíz.
  const raices: MenuItem[] = [];
  for (const item of mapa.values()) {
    if (item.padreId && mapa.has(item.padreId)) {
      mapa.get(item.padreId)!.hijos.push(item);
    } else {
      raices.push(item);
    }
  }

  // 3. Ordenar raíces e hijos por el campo orden.
  const porOrden = (a: MenuItem, b: MenuItem) => a.orden - b.orden;
  raices.sort(porOrden);
  for (const r of raices) r.hijos.sort(porOrden);

  return raices;
}

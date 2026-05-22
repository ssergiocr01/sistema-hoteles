"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import type { MenuItem } from "@/services/menu";

/**
 * Lista de enlaces del menú. Es Client Component porque usa usePathname()
 * para resaltar la opción activa.
 */
export default function NavLinks({ menu }: { menu: MenuItem[] }) {
  const pathname = usePathname();

  const linkClass = (ruta: string | null) =>
    `block rounded px-3 py-2 text-sm transition-colors ${
      ruta && pathname === ruta
        ? "bg-gray-700 text-white"
        : "text-gray-300 hover:bg-gray-800 hover:text-white"
    }`;

  return (
    <nav className="flex-1 space-y-1 overflow-y-auto p-2">
      {menu.map((item) => (
        <div key={item.id}>
          {item.ruta ? (
            <Link href={item.ruta} className={linkClass(item.ruta)}>
              {item.nombre}
            </Link>
          ) : (
            <span className="block px-3 py-2 text-xs uppercase tracking-wide text-gray-500">
              {item.nombre}
            </span>
          )}

          {item.hijos.length > 0 && (
            <div className="ml-3 border-l border-gray-700 pl-2">
              {item.hijos.map((h) => (
                <Link key={h.id} href={h.ruta ?? "#"} className={linkClass(h.ruta)}>
                  {h.nombre}
                </Link>
              ))}
            </div>
          )}
        </div>
      ))}
    </nav>
  );
}

"use client";

import { useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import type { MenuItem } from "@/services/menu";

/**
 * Lista de enlaces del menú con submenús colapsables.
 * - Las opciones con hijos son botones que muestran/ocultan sus submenús.
 * - Si la ruta actual es un hijo, su padre aparece abierto por defecto.
 * Es Client Component porque usa estado (useState) y usePathname().
 */
export default function NavLinks({ menu }: { menu: MenuItem[] }) {
  const pathname = usePathname();

  // Abrir por defecto el padre cuyo hijo coincide con la ruta actual.
  const aperturaInicial: Record<number, boolean> = {};
  for (const item of menu) {
    if (item.hijos.some((h) => h.ruta === pathname)) {
      aperturaInicial[item.id] = true;
    }
  }
  const [abiertos, setAbiertos] = useState<Record<number, boolean>>(aperturaInicial);

  const alternar = (id: number) =>
    setAbiertos((prev) => ({ ...prev, [id]: !prev[id] }));

  const linkClass = (ruta: string | null) =>
    `block rounded px-3 py-2 text-sm transition-colors ${
      ruta && pathname === ruta
        ? "bg-gray-700 text-white"
        : "text-gray-300 hover:bg-gray-800 hover:text-white"
    }`;

  return (
    <nav className="flex-1 space-y-1 overflow-y-auto p-2">
      {menu.map((item) => {
        const tieneHijos = item.hijos.length > 0;

        // Opción simple (sin hijos): un enlace directo.
        if (!tieneHijos) {
          return (
            <Link key={item.id} href={item.ruta ?? "#"} className={linkClass(item.ruta)}>
              {item.nombre}
            </Link>
          );
        }

        // Opción con hijos: botón que despliega/colapsa el submenú.
        const abierto = !!abiertos[item.id];
        return (
          <div key={item.id}>
            <button
              type="button"
              onClick={() => alternar(item.id)}
              aria-expanded={abierto}
              className="flex w-full items-center justify-between rounded px-3 py-2 text-sm text-gray-300 transition-colors hover:bg-gray-800 hover:text-white"
            >
              <span>{item.nombre}</span>
              <span
                className={`text-xs transition-transform duration-200 ${
                  abierto ? "rotate-90" : ""
                }`}
              >
                ▶
              </span>
            </button>

            {abierto && (
              <div className="ml-3 mt-1 space-y-1 border-l border-gray-700 pl-2">
                {item.hijos.map((h) => (
                  <Link key={h.id} href={h.ruta ?? "#"} className={linkClass(h.ruta)}>
                    {h.nombre}
                  </Link>
                ))}
              </div>
            )}
          </div>
        );
      })}
    </nav>
  );
}

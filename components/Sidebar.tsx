import { signOut } from "@/auth";
import NavLinks from "@/components/NavLinks";
import type { MenuItem } from "@/services/menu";

/**
 * Barra lateral del área privada. Server Component: recibe el menú ya
 * filtrado por perfil y los datos del usuario en sesión.
 */
export default function Sidebar({
  menu,
  user,
}: {
  menu: MenuItem[];
  user: { name?: string | null; perfil?: string };
}) {
  return (
    <aside className="flex w-64 flex-col bg-gray-900 text-gray-100">
      <div className="border-b border-gray-700 p-4">
        <p className="font-bold leading-tight">Cadena Hotelera</p>
        <p className="text-xs text-gray-400">Andina</p>
      </div>

      <NavLinks menu={menu} />

      <div className="border-t border-gray-700 p-4">
        <p className="text-sm font-medium">{user.name}</p>
        <p className="mb-3 text-xs text-gray-400">{user.perfil}</p>
        <form
          action={async () => {
            "use server";
            await signOut({ redirectTo: "/login" });
          }}
        >
          <button className="w-full rounded bg-gray-700 px-3 py-2 text-sm hover:bg-gray-600">
            Cerrar sesión
          </button>
        </form>
      </div>
    </aside>
  );
}

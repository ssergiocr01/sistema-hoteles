import { auth } from "@/auth";
import { redirect } from "next/navigation";
import { getMenuPorPerfil } from "@/services/menu";
import Sidebar from "@/components/Sidebar";

/**
 * Layout del área privada. Envuelve todas las páginas autenticadas:
 * obtiene la sesión, carga el menú según el perfil y muestra la barra lateral.
 */
export default async function AppLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const session = await auth();
  if (!session?.user) {
    redirect("/login");
  }

  const menu = session.user.perfilId
    ? await getMenuPorPerfil(session.user.perfilId)
    : [];

  return (
    <div className="flex min-h-screen bg-gray-100">
      <Sidebar
        menu={menu}
        user={{ name: session.user.name, perfil: session.user.perfil }}
      />
      <main className="flex-1 overflow-y-auto p-8">{children}</main>
    </div>
  );
}

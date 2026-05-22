import { auth, signOut } from "@/auth";
import { redirect } from "next/navigation";

/**
 * Página de inicio (provisional).
 * Es un Server Component: lee la sesión en el servidor.
 * Si no hay sesión, redirige al login. (La protección formal de rutas
 * se hará con middleware en el paso 4.)
 */
export default async function Home() {
  const session = await auth();
  if (!session?.user) {
    redirect("/login");
  }

  return (
    <main className="flex min-h-screen items-center justify-center bg-gray-100 p-4">
      <div className="w-full max-w-md rounded-xl bg-white p-8 text-center shadow-md">
        <h1 className="mb-2 text-2xl font-bold text-gray-800">
          Bienvenido, {session.user.name}
        </h1>
        <p className="mb-1 text-gray-600">{session.user.email}</p>
        <p className="mb-6 text-sm text-gray-500">
          Perfil: <span className="font-medium">{session.user.perfil}</span>
        </p>

        <form
          action={async () => {
            "use server";
            await signOut({ redirectTo: "/login" });
          }}
        >
          <button className="rounded-md bg-gray-800 px-4 py-2 text-sm font-semibold text-white hover:bg-gray-900">
            Cerrar sesión
          </button>
        </form>
      </div>
    </main>
  );
}

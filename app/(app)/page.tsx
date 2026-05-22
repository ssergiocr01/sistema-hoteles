import { auth } from "@/auth";

/**
 * Página de inicio del área privada (dashboard).
 * El layout ya valida la sesión y muestra el menú.
 */
export default async function DashboardPage() {
  const session = await auth();

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800">
        Bienvenido, {session?.user?.name}
      </h1>
      <p className="mt-2 text-gray-600">
        Has iniciado sesión como{" "}
        <span className="font-medium">{session?.user?.perfil}</span>.
      </p>
      <p className="mt-6 text-gray-500">
        Selecciona una opción del menú para comenzar.
      </p>
    </div>
  );
}

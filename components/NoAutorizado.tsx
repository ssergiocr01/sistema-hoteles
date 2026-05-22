import Link from "next/link";

/**
 * Mensaje de "no autorizado" (403). Se renderiza dentro del área privada
 * (conserva el menú) cuando el perfil no tiene permiso sobre la sección.
 */
export default function NoAutorizado() {
  return (
    <div className="mx-auto max-w-md rounded-lg border border-red-200 bg-red-50 p-8 text-center">
      <p className="text-5xl font-bold text-red-300">403</p>
      <h1 className="mt-3 text-xl font-bold text-red-700">No autorizado</h1>
      <p className="mt-2 text-sm text-gray-600">
        No tienes permiso para ver esta sección. Si crees que es un error,
        contacta al administrador.
      </p>
      <Link
        href="/"
        className="mt-6 inline-block rounded-md bg-blue-600 px-4 py-2 text-sm font-semibold text-white hover:bg-blue-700"
      >
        Volver al inicio
      </Link>
    </div>
  );
}

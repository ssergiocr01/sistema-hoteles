import Link from "next/link";

/**
 * Página 404: se muestra cuando la ruta no existe.
 */
export default function NotFound() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center bg-gray-100 p-4 text-center">
      <p className="text-7xl font-bold text-gray-300">404</p>
      <h1 className="mt-4 text-2xl font-bold text-gray-800">
        Página no encontrada
      </h1>
      <p className="mt-2 text-gray-600">
        La página que buscas no existe o fue movida.
      </p>
      <Link
        href="/"
        className="mt-6 rounded-md bg-blue-600 px-4 py-2 text-sm font-semibold text-white hover:bg-blue-700"
      >
        Volver al inicio
      </Link>
    </main>
  );
}

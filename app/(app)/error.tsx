"use client";

import { useEffect } from "react";

/**
 * Error boundary del área privada. Captura errores inesperados en las
 * páginas (p. ej. falla la base de datos o un procedimiento almacenado)
 * y muestra una pantalla amigable, conservando el menú lateral.
 * Debe ser Client Component.
 */
export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    // En un proyecto real, aquí se enviaría el error a un sistema de logs.
    console.error(error);
  }, [error]);

  return (
    <div className="mx-auto max-w-md rounded-lg border border-amber-200 bg-amber-50 p-8 text-center">
      <h1 className="text-xl font-bold text-amber-700">Algo salió mal</h1>
      <p className="mt-2 text-sm text-gray-600">
        Ocurrió un error al procesar tu solicitud. Intenta de nuevo.
      </p>
      <button
        onClick={reset}
        className="mt-6 rounded-md bg-amber-600 px-4 py-2 text-sm font-semibold text-white hover:bg-amber-700"
      >
        Reintentar
      </button>
    </div>
  );
}

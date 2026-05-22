"use client";

/**
 * Error global: captura fallos catastróficos, incluso en el layout raíz.
 * Reemplaza toda la página, por eso debe incluir <html> y <body>.
 * Usa estilos en línea porque se renderiza fuera del layout principal.
 */
export default function GlobalError({
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <html lang="es">
      <body
        style={{
          display: "flex",
          minHeight: "100vh",
          flexDirection: "column",
          alignItems: "center",
          justifyContent: "center",
          fontFamily: "system-ui, sans-serif",
          background: "#f3f4f6",
          margin: 0,
        }}
      >
        <h1 style={{ color: "#b91c1c", fontSize: "1.5rem" }}>
          Error inesperado
        </h1>
        <p style={{ color: "#4b5563", marginTop: "0.5rem" }}>
          Ocurrió un problema grave. Intenta recargar la aplicación.
        </p>
        <button
          onClick={reset}
          style={{
            marginTop: "1.5rem",
            background: "#dc2626",
            color: "white",
            border: "none",
            borderRadius: "0.375rem",
            padding: "0.5rem 1rem",
            fontWeight: 600,
            cursor: "pointer",
          }}
        >
          Reintentar
        </button>
      </body>
    </html>
  );
}

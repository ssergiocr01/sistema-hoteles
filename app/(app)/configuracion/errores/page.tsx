import { auth } from "@/auth";
import { puedeVer } from "@/services/permisos";
import { listarErrores } from "@/services/log";
import NoAutorizado from "@/components/NoAutorizado";

/**
 * Página de administración: lista los errores registrados del sistema.
 * Protegida por RBAC (solo perfiles con permiso sobre /configuracion/errores).
 */
export default async function ErroresPage() {
  const session = await auth();
  const perfilId = session?.user?.perfilId;

  if (!perfilId || !(await puedeVer(perfilId, "/configuracion/errores"))) {
    return <NoAutorizado />;
  }

  const errores = await listarErrores(100);

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800">Log de errores</h1>
      <p className="mt-1 text-sm text-gray-500">
        Últimos {errores.length} errores registrados.
      </p>

      {errores.length === 0 ? (
        <p className="mt-6 text-gray-500">No hay errores registrados. 🎉</p>
      ) : (
        <div className="mt-6 overflow-x-auto rounded-lg border border-gray-200 bg-white">
          <table className="w-full text-left text-sm">
            <thead className="bg-gray-50 text-gray-600">
              <tr>
                <th className="px-4 py-2">Fecha (UTC)</th>
                <th className="px-4 py-2">Mensaje</th>
                <th className="px-4 py-2">Ruta</th>
                <th className="px-4 py-2">Origen</th>
                <th className="px-4 py-2">Usuario</th>
                <th className="px-4 py-2">Detalle</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {errores.map((e) => (
                <tr key={e.id} className="align-top">
                  <td className="whitespace-nowrap px-4 py-2 text-gray-500">
                    {new Date(e.fecha_hora).toLocaleString("es-CR")}
                  </td>
                  <td className="px-4 py-2 text-gray-800">{e.mensaje}</td>
                  <td className="px-4 py-2 text-gray-600">{e.ruta ?? "—"}</td>
                  <td className="px-4 py-2 text-gray-600">{e.origen ?? "—"}</td>
                  <td className="px-4 py-2 text-gray-600">
                    {e.usuario_email ?? "—"}
                  </td>
                  <td className="px-4 py-2">
                    {e.detalle ? (
                      <details>
                        <summary className="cursor-pointer text-blue-600">
                          Ver
                        </summary>
                        <pre className="mt-2 max-w-md overflow-x-auto whitespace-pre-wrap text-xs text-gray-500">
                          {e.detalle}
                        </pre>
                      </details>
                    ) : (
                      "—"
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}

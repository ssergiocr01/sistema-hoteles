import { auth } from "@/auth";
import { puedeVer } from "@/services/permisos";
import NoAutorizado from "@/components/NoAutorizado";

/**
 * Página de Usuarios (placeholder). Demuestra el refuerzo de RBAC:
 * valida en el servidor que el perfil tenga permiso sobre esta ruta.
 */
export default async function UsuariosPage() {
  const session = await auth();
  const perfilId = session?.user?.perfilId;

  const permitido = perfilId
    ? await puedeVer(perfilId, "/configuracion/usuarios")
    : false;

  if (!permitido) {
    return <NoAutorizado />;
  }

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800">Usuarios</h1>
      <p className="mt-2 text-gray-600">Gestión de usuarios (en construcción).</p>
    </div>
  );
}

"use server";

import { signIn } from "@/auth";
import { AuthError } from "next-auth";

/**
 * Server Action que procesa el formulario de login.
 * Llama a signIn() de Auth.js, que a su vez ejecuta el authorize() de auth.ts.
 *
 * - Si el login es correcto, signIn lanza una redirección interna a "/".
 * - Si falla, lanza un AuthError y devolvemos un mensaje para mostrarlo.
 */
export async function authenticate(
  _prevState: string | undefined,
  formData: FormData
): Promise<string | undefined> {
  try {
    await signIn("credentials", {
      email: formData.get("email"),
      password: formData.get("password"),
      redirectTo: "/",
    });
  } catch (error) {
    if (error instanceof AuthError) {
      return "Correo o contraseña incorrectos.";
    }
    // Cualquier otro error (incluida la redirección de éxito) debe relanzarse.
    throw error;
  }
  return undefined;
}

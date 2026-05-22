import sql from "mssql";

/**
 * Configuración de conexión a SQL Server.
 * Los valores se leen de variables de entorno (.env.local), nunca se escriben aquí.
 */
const config: sql.config = {
  server: process.env.DB_SERVER ?? "localhost",
  port: Number(process.env.DB_PORT ?? 1433),
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  options: {
    // SQL Server 2008 local: sin cifrado y confiando en el certificado del servidor.
    encrypt: process.env.DB_ENCRYPT === "true",
    trustServerCertificate: true,
  },
  pool: {
    max: 10,
    min: 0,
    idleTimeoutMillis: 30000,
  },
};

/**
 * En desarrollo, Next.js recarga los módulos con frecuencia. Para no abrir
 * un pool nuevo en cada recarga, lo guardamos en el objeto global y lo reutilizamos.
 */
declare global {
  // eslint-disable-next-line no-var
  var _mssqlPool: Promise<sql.ConnectionPool> | undefined;
}

/**
 * Devuelve el pool de conexiones (lo crea la primera vez y luego lo reutiliza).
 */
export function getPool(): Promise<sql.ConnectionPool> {
  const pool = global._mssqlPool ?? new sql.ConnectionPool(config).connect();
  global._mssqlPool = pool;
  return pool;
}

export { sql };

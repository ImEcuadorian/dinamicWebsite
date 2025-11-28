package com.productos.datos;

import java.sql.Connection;

public class PruebaConexion {

    public static void main(String[] args) {
        // Crear una instancia de la clase Conexion
        Conexion conexion = new Conexion();

        // Obtener el objeto Connection
        Connection con = conexion.getConexion();

        // Verificar si la conexión fue exitosa
        if (con != null) {
            System.out.println("✅ Conexión exitosa a la base de datos PostgreSQL.");
        } else {
            System.out.println("❌ No se pudo establecer la conexión con la base de datos.");
        }

        // Cerrar la conexión (opcional, buena práctica)
        try {
            if (con != null && !con.isClosed()) {
                con.close();
                System.out.println("🔒 Conexión cerrada correctamente.");
            }
        } catch (Exception e) {
            System.out.println("⚠️ Error al cerrar la conexión: " + e.getMessage());
        }
    }
}

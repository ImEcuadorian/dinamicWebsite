package com.productos.negocio;

import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.regex.Pattern;

public class PagoTarjeta {

    // Detecta tipo de tarjeta basado en los primeros dígitos
    public String detectarTipo(String numero) {

        if (numero.startsWith("4")) {
            return "VISA";
        } else if (numero.matches("^5[1-5].*")) {
            return "MASTERCARD";
        } else if (numero.matches("^3[47].*")) {
            return "AMEX";
        }
        return "DESCONOCIDA";
    }

    public boolean validarNumero(String numero) {
        return numero.matches("\\d{16}");
    }

    public boolean validarNombre(String nombre) {
        return nombre != null && nombre.length() >= 3;
    }

    public boolean validarCVV(String cvv, String tipoTarjeta) {

        if (tipoTarjeta.equals("AMEX")) {
            return cvv.matches("\\d{4}");
        }

        return cvv.matches("\\d{3}");
    }

    public boolean validarFecha(String fecha) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/yy");
            YearMonth exp = YearMonth.parse(fecha, formatter);
            YearMonth now = YearMonth.now();

            return !exp.isBefore(now);

        } catch (Exception e) {
            return false;
        }
    }

    public String validarTodo(String numero, String nombre, String fecha, String cvv) {

        String tipo = detectarTipo(numero);

        if (tipo.equals("DESCONOCIDA"))
            return "❌ Tipo de tarjeta no reconocido";

        if (!validarNumero(numero))
            return "❌ El número debe tener 16 dígitos";

        if (!validarNombre(nombre))
            return "❌ Nombre inválido";

        if (!validarFecha(fecha))
            return "❌ La fecha de expiración es inválida o está vencida";

        if (!validarCVV(cvv, tipo))
            return "❌ CVV inválido";

        return "OK";
    }
}

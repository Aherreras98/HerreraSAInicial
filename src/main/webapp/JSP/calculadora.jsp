<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Calculadora JSP</title>
    </head>
    <body>

        <%
            if (request.getParameter("enviar") != null) {

                String num1Str = request.getParameter("num1");
                String num2Str = request.getParameter("num2");
                String operacion = request.getParameter("operacion");

                try {
                    int num1 = Integer.parseInt(num1Str);
                    int num2 = Integer.parseInt(num2Str);
                    int resultado = 0;
                    char simbolo = ' ';

                    if (operacion.equals("sumar")) {
                        resultado = num1 + num2;
                        simbolo = '+';
                    } else if (operacion.equals("restar")) {
                        resultado = num1 - num2;
                        simbolo = '-';
                    } else if (operacion.equals("multiplicar")) {
                        resultado = num1 * num2;
                        simbolo = '*';
                    } else if (operacion.equals("dividir")) {
                        if (num2 == 0) {
                            out.println("<h3 style='color:red;'>Error: Se está intentando dividir por 0.</h3>");
                            return;
                        }
                        resultado = num1 / num2;
                        simbolo = '/';
                    }

                    out.println("<h2>Resultado:</h2>");
                    out.println("<p>" + num1 + " " + simbolo + " " + num2 + " = " + resultado + "</p>");
                    out.println("<p><i>Fecha de la operaci&oacute;n: " + new Date() + "</i></p>");

                } catch (NumberFormatException e) {
                    out.println("<h3 style='color:red;'>Error: Alguno de los operandos no es válido.</h3>");
                }
            }
        %>
        
        <h1>Calculadora Básica</h1>

        <form method="post" action="calculadora.jsp">
            <p>
                <label>Número 1:</label>
                <input type="text" name="num1"">
            </p>
            <p>
                <label>Número 2:</label>
                <input type="text" name="num2"">
            </p>
            <p>
                <strong>Operación:</strong>
                <input type="radio" name="operacion" value="sumar" checked> Sumar
                <input type="radio" name="operacion" value="restar"> Restar
                <input type="radio" name="operacion" value="multiplicar"> Multiplicar
                <input type="radio" name="operacion" value="dividir"> Dividir
            </p>
            <p>
                <input type="submit" name="enviar" value="Calcular">
                <input type="reset" value="Limpiar">
            </p>
        </form>

        <hr>

        <a href="<%= request.getContextPath()%>">Volver al &iacute;ndice</a>

    </body>
</html>

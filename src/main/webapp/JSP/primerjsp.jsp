<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http‐equiv="Content‐Type" content="text/html; charset=UTF-8">
        <title>Calculadora</title>
    </head>
    <body>
        <%!
            public int sumar(int param1, int param2) {
                return param1 + param2;
            }
        %>
        <%
                    if(request.getParameter("switch") == null){
        %>
        <form method="post" action="./primerjsp.jsp" >
            <input type="hidden" name="switch" value="true">
            <table>
                <tr>
                </tr>
                <tr>
                    <td>Primer número:</td>
                    <td><input name="param1"></td>
                    <td>Segundo número:</td>
                    <td><input name="param2"></td>
                    Página: 6
                    <td><input type="submit" value="Sumar"></td>
                </tr>
                <tr>
                </tr>
            </table>
        </form>
        <%  } else {
        try {
                    int param1 = Integer.parseInt(request.getParameter("param1"));
                    int param2 = Integer.parseInt(request.getParameter("param2"));
                    int result = param1 + param2;
        %>
        <p>El resultado de la suma es: <%= sumar(param1, param2)%></p>
        <%  } catch (NumberFormatException ex) {
        %>

        <p>Alguno de los números no contenía dígitos válidos...</p>
        <%
            }
        %>
        <p><%= Calendar.getInstance().getTime()%></p>
        <a href="../index.html">Volver atrás...</a>
        <%
            }
        %>
    </body>
</html>
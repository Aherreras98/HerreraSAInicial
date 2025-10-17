<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Random" %>

<%
    int numeroSecreto;
    int intentos = 0;
    String historial = "";
    boolean acertado = false;
    String mensaje = "";
    String numeroStr = request.getParameter("numero");

    if (request.getParameter("numeroSecreto") == null) {
        Random aleatorio = new Random();
        numeroSecreto = aleatorio.nextInt(100) + 1;

    } else {    
        numeroSecreto = Integer.parseInt(request.getParameter("numeroSecreto"));
        intentos = Integer.parseInt(request.getParameter("intentos"));
        historial = request.getParameter("historial");

        if (numeroStr != null && !numeroStr.isEmpty()) {
            int numero = Integer.parseInt(numeroStr);
            intentos++;
            historial += numero + ";";

            if (numero < numeroSecreto) {
                mensaje = "El n&uacutemero es MAYOR.";
            } else if (numero > numeroSecreto) {
                mensaje = "El n&uacutemero es MENOR.";
            } else {
                acertado = true;
                mensaje = "¡Acertaste! Lo has conseguido en " + intentos + " intentos.";
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Adivina el N&uacutemero Secreto</title>
    <link href="<%= request.getContextPath()%>/CSS/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container">
    <h1 class="titulo-principal">Adivina el N&uacutemero Secreto</h1>
    <p>Este juego consiste en introducir un n&uacute;mero del 1 al 100 para intentar adivinar el n&uacute;mero que ha pensado el ordenador, despu&eacute;s
        de cada intento, recibir&aacute;s una pista diciendo si el n&uacute;mero es mayor o menos que el introducido.</p>

    <form method="post" action="numerosecreto.jsp">

        <input type="hidden" name="numeroSecreto" value="<%= numeroSecreto %>">
        <input type="hidden" name="intentos" value="<%= intentos %>">
        <input type="hidden" name="historial" value="<%= historial %>">

        <% if (!acertado) { %>
            <p>
                <label>Introduce un número (1-100):</label>
                <input type="number" name="numero" min="1" max="100" required>
            </p>
            <div class="button">
                <button type="submit">Comprobar</button>
            </div>
        <% } else { %>
            <div>
                <a href="<%= request.getContextPath()%>/index.html">Volver al inicio</a>
            </div>
        <% } %>
    </form>

    <% if (!mensaje.isEmpty()) { %>
        <h2><%= mensaje %></h2>
    <% } %>

    <% if (!historial.isEmpty()) { %>
        <h2>Historial de Intentos</h2>
        <table>
            <thead>
            <tr>
                <th>Intento</th>
                <th>Número</th>
                <th>Pista</th>
            </tr>
            </thead>
            <tbody>
            <%
                String[] numeros = historial.split(";");
                for (int i = 0; i < numeros.length; i++) {
                    int numero = Integer.parseInt(numeros[i]);
                    String pista = "";
                    if (numero < numeroSecreto) {
                        pista = "El n&uacutemero secreto es MAYOR";
                    } else if (numero > numeroSecreto) {
                        pista = "El n&uacutemero secreto es MENOR";
                    } else {
                        pista = "¡Acertaste!";
                    }
            %>
            <tr>
                <td><%= i + 1 %></td>
                <td><%= numero %></td>
                <td><%= pista %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    <% } %>

    <% if (!acertado) { %>

    <p style="text-align: center; margin-top: 20px;">
        <a href="<%= request.getContextPath()%>">Volver al &iacute;ndice</a>
    </p>
    <% } %>
</div>
</body>
</html>
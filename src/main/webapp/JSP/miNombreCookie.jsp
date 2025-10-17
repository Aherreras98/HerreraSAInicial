<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder" %>
<%@page import="java.net.URLDecoder" %>

<%
    String miNombre = null;
    String mensaje;

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        int i = 0;
        boolean encontrada = false;
        while (i < cookies.length && !encontrada) {
            if (cookies[i].getName().equals("nombreApellidos")) {
                miNombre = URLDecoder.decode(cookies[i].getValue(), "UTF-8");
                encontrada = true;
            }
            i++;
        }
    }

    if (miNombre == null) {
        mensaje = "No se encuentran tus datos";

        String nombreCompleto = "Adrián Herrera Sosa";
        String valorCodificado = URLEncoder.encode(nombreCompleto, "UTF-8");
        Cookie nuevaCookie = new Cookie("nombreApellidos", valorCodificado);

        nuevaCookie.setMaxAge(3600);

        response.addCookie(nuevaCookie);

    } else {
        mensaje = "Hola " + miNombre + ".";
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mi nombre con cookie</title>
        <link href="<%= request.getContextPath()%>/CSS/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="container">
            <h1 class="titulo-principal">Mi nombre con cookie</h1>

            <h2><%= mensaje%></h2>
            <form action="miNombreCookie.jsp" method="GET">
                <div class="button-container">
                    <button type="submit">Recargar</button>
                </div>
            </form>
            <p style="text-align: center; margin-top: 20px;">
                <a href="<%= request.getContextPath()%>/index.html">Volver al &iacute;ndice</a>
            </p>
        </div>
    </body>
</html>
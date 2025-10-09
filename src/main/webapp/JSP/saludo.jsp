<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.LocalTime"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Saludo desde JSP</title>
        <link href="../CSS/style.css" rel="stylesheet" type="text/css"/>
    </head>

    <%
        request.setCharacterEncoding("UTF-8");
        String nombre = request.getParameter("nombre");
        String genero = request.getParameter("genero");

        LocalTime actual = LocalTime.now();
        int hora = actual.getHour();

        String saludo;
        if (hora >= 8 && hora <= 13) {
            saludo = "Buenos d&iacute;s";
        } else if (hora > 13 && hora <= 21) {
            saludo = "Buenas tardes";
        } else {
            saludo = "Buenas noches";
        }

        String tratamiento = "hombre".equals(genero) ? "Don" : "Doña";
    %>
    <h1 class="titulo-principal"><%= saludo%>, <%= tratamiento%> <%= nombre%></h1>
    <p style="text-align: center; margin-top: 20px;">
        <a href="../index.html">Volver al &iacute;ndice</a>
    </p>
</div>
</body>
</html>
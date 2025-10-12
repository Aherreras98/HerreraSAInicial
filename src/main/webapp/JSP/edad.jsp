<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.Period"
        import="java.time.LocalDate"
        import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Saludo desde JSP</title>
        <link href="<%= request.getContextPath()%>/CSS/style.css" rel="stylesheet" type="text/css"/>
    </head>

    <%
        request.setCharacterEncoding("UTF-8");

        String nacimientoStr = request.getParameter("fechaNacimiento");
        String nombre = request.getParameter("nombre");
        LocalDate hoy = LocalDate.now();
        LocalDate nacimiento = LocalDate.parse(nacimientoStr);
        String mensaje;

        if (nacimiento.isAfter(hoy)) {
            mensaje = "Hola " + nombre + ", a&uacute;n no has nacido.";
        } else if (nacimiento.isEqual(hoy)) {
            mensaje = "Hola " + nombre + ", has nacido hoy.";
        } else {
            Period periodo = Period.between(nacimiento, hoy);
            int anios = periodo.getYears();
            int meses = periodo.getMonths();
            int dias = periodo.getDays();

            if (meses == 0 && dias == 0) {
                mensaje = "Hola " + nombre + ", tienes " + anios + " años.";
            } else if (anios == 0 && meses != 0 && dias != 0) {
                mensaje = "Hola " + nombre + ", tienes " + meses + " meses y " + dias + " dias.";
            } else if (anios == 0 && meses != 0 && dias == 0) {
                mensaje = "Hola " + nombre + ", tienes " + meses + " meses.";
            } else if (anios == 0 && meses == 0 && dias != 0) {
                mensaje = "Hola " + nombre + ", tienes " + dias + " dias.";
            } else if (meses == 0 && dias != 0) {
                mensaje = "Hola " + nombre + ", tienes " + anios + " años y " + dias + " d&iacute;as.";
            } else {
                mensaje = "Hola " + nombre + ", tienes " + anios + " años, " + meses + " meses y " + dias + " dias.";
            }
        }


    %>
    <h1 class="titulo-principal"><%= mensaje%> </h1>
    <p style="text-align: center; margin-top: 20px;">
        <a href="<%= request.getContextPath()%>">Volver al &iacute;ndice</a>
    </p>
</div>
</body>
</html>
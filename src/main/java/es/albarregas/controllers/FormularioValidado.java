package es.albarregas.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Enumeration;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "FormularioValidado", urlPatterns = {"/FormularioValidado"})
public class FormularioValidado extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println(pintarFormulario(request));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String nombre = request.getParameter("nombre");
        String fechaNacimientoStr = request.getParameter("fechaNacimiento");
        String salario = request.getParameter("salario");
        String hijos = request.getParameter("hijos");

        if (nombre == null || nombre.trim().isEmpty()
                || fechaNacimientoStr == null || fechaNacimientoStr.trim().isEmpty()
                || salario == null || salario.trim().isEmpty()
                || hijos == null || hijos.trim().isEmpty()) {

            request.setAttribute("error", "Los campos con asterisco (*) son obligatorios.");
            doGet(request, response);

        } else {
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Datos del Formulario</title>");
                out.println("<link rel='stylesheet' href='CSS/style.css' type='text/css'>");
                out.println("</head>");
                out.println("<body>");
                out.println("<div class='container'>");
                out.println("<h1 class='titulo-principal'>Datos Recibidos</h1>");
                out.println("<ul>");

                Map<String, String[]> parameterMap = request.getParameterMap();
                Enumeration<String> parameterNames = request.getParameterNames();

                while (parameterNames.hasMoreElements()) {
                    String paramName = parameterNames.nextElement();
                    String[] paramValues = parameterMap.get(paramName);

                    if (paramName.equals("fechaNacimiento")) {
                        LocalDate fecha = LocalDate.parse(paramValues[0]);
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                        out.println("<li>Fecha de Nacimiento: " + fecha.format(formatter) + "</li>");
                    } else if (paramName.equals("preferencias")) {
                        if (paramValues != null && paramValues.length > 0) {
                            out.println("<li>Preferencias: " + String.join(", ", paramValues) + "</li>");
                        }
                    } else if (paramName.equals("salario")) {
                        out.println("<li>Salario: " + paramValues[0] + " €</li>");
                    } else {
                        out.println("<li>" + mayus(paramName) + ": " + paramValues[0] + "</li>");
                    }
                }
                if (!parameterMap.containsKey("preferencias")) {
                    out.println("<li>Preferencias: No se seleccionó ninguna.</li>");
                }

                out.println("</ul>");
                out.println("<br>");
                out.println("<a href='index.html'>Volver al &iacute;ndice</a>");
                out.println("</div>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }

    private String pintarFormulario(HttpServletRequest request) {
        StringBuilder sb = new StringBuilder();

        String nombre = request.getParameter("nombre") != null ? request.getParameter("nombre") : "";
        String fechaNacimiento = request.getParameter("fechaNacimiento") != null ? request.getParameter("fechaNacimiento") : "";
        String salario = request.getParameter("salario") != null ? request.getParameter("salario") : "";
        String hijos = request.getParameter("hijos") != null ? request.getParameter("hijos") : "";
        String[] preferencias = request.getParameterValues("preferencias");

        sb.append("<!DOCTYPE html>");
        sb.append("<html lang='es'>");
        sb.append("<head>");
        sb.append("<meta charset='UTF-8'>");
        sb.append("<title>Formulario de Datos Personales</title>");
        sb.append("<link href='CSS/style.css' rel='stylesheet' type='text/css'/>");
        sb.append("<link href='CSS/formulario.css' rel='stylesheet' type='text/css'/>");
        sb.append("</head>");
        sb.append("<body>");
        sb.append("<div class='container'>");
        sb.append("<h1 class='titulo-principal'>Formulario de Datos</h1>");

        if (request.getAttribute("error") != null) {
            sb.append("<p style='color: red; text-align: center;'>").append(request.getAttribute("error")).append("</p>");
        }

        sb.append("<div class='container'>");
        sb.append("<form action='FormularioValidado' method='post'>");
        sb.append("<div><label for='nombre'>Nombre: *</label><input type='text' id='nombre' name='nombre' placeholder='Juan' value='").append(nombre).append("'></div>");
        sb.append("<div><label for='fechaNacimiento'>Fecha de Nacimiento: *</label><input type='date' id='fechaNacimiento' name='fechaNacimiento' value='").append(fechaNacimiento).append("'></div>");
        sb.append("<div><label for='salario'>Salario: *</label><input type='number' id='salario' name='salario' placeholder='1300' min='0' step='0.01' value='").append(salario).append("'></div>");
        sb.append("<div><label for='hijos'>N&uacute;mero de Hijos: *</label><input type='number' id='hijos' name='hijos' placeholder='3' min='0' value='").append(hijos).append("'></div>");
        sb.append("<div><label for='preferencias'>Preferencias:</label>");
        sb.append("<select id='preferencias' name='preferencias' multiple size='5'>");
        sb.append(marcarPreferencia("Videojuegos", preferencias));
        sb.append(marcarPreferencia("Cine", preferencias));
        sb.append(marcarPreferencia("Deporte", preferencias));
        sb.append(marcarPreferencia("Música", preferencias));
        sb.append(marcarPreferencia("Cocinar", preferencias));
        sb.append("</select></div>");
        sb.append("<div class='button'><button type='submit'>Enviar Datos</button></div>");
        sb.append("</form>");
        sb.append("</div>");
        sb.append("<p style='text-align: center; margin-top: 20px;'><a href='index.html'>Volver al &iacute;ndice</a></p>");
        sb.append("</div>");
        sb.append("</body>");
        sb.append("</html>");

        return sb.toString();
    }

    private String marcarPreferencia(String value, String[] seleccionado) {
        boolean estaSeleccionado = false;
        if (seleccionado != null) {
            for (String s : seleccionado) {
                if (s.equals(value)) {
                    estaSeleccionado = true;
                    break;
                }
            }
        }
        return "<option value='" + value + "'" + (estaSeleccionado ? " selected" : "") + ">" + value + "</option>";
    }

    private String mayus(String str) {
        if (str == null || str.isEmpty()) {
            return str;
        }
        return str.substring(0, 1).toUpperCase() + str.substring(1);
    }

    @Override
    public String getServletInfo() {
        return "Servlet con validaciones de formulario del lado del servidor.";
    }
}

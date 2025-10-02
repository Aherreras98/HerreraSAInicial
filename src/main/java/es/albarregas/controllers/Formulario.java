package es.albarregas.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author elavi
 */
@WebServlet(name = "Formulario", urlPatterns = {"/Formulario"})
public class Formulario extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            String nombre = request.getParameter("nombre");
            String fechaNacimientoStr = request.getParameter("fechaNacimiento");
            String salario = request.getParameter("salario");
            String hijos = request.getParameter("hijos");

            String[] preferencias = request.getParameterValues("preferencias");
            LocalDate fechaNacimiento = LocalDate.parse(fechaNacimientoStr);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            String fechaFormateada = fechaNacimiento.format(formatter);
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
            out.println("<li>Nombre: " + nombre + "</li>");
            out.println("<li>Fecha de Nacimiento: " + fechaFormateada + "</li>");
            out.println("<li>Salario: " + salario + " &euro;</li>");
            out.println("<li>N&uacute;mero de Hijos: " + hijos + "</li>");

            if (preferencias != null && preferencias.length > 0) {
                out.println("<li>Preferencias: " + String.join(", ", preferencias) + "</li>");
            } else {
                out.println("<li>Preferencias: No se seleccion&oacute; ninguna.</li>");
            }

            out.println("</ul>");
            out.println("<br>");
            out.println("<a href='index.html'>Volver al &iacute;ndice</a>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet para procesar los datos del formulario";
    }
}

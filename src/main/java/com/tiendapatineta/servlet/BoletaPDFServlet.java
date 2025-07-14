package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.BoletaDAO;
import com.tiendapatineta.dao.VentaDAO;
import com.tiendapatineta.model.Boleta;
import com.tiendapatineta.model.DetalleVenta;
import com.tiendapatineta.model.Venta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import java.awt.Color;

@WebServlet("/boleta/descargar")
public class BoletaPDFServlet extends HttpServlet {
    private BoletaDAO boletaDAO;
    private VentaDAO ventaDAO;

    @Override
    public void init() throws ServletException {
        boletaDAO = new BoletaDAO();
        ventaDAO = new VentaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            Boleta boleta = boletaDAO.obtenerPorId(id);
            Venta venta = ventaDAO.obtenerPorId(boleta.getVenta().getId());
            List<DetalleVenta> detalles = ventaDAO.obtenerDetallesPorVenta(venta.getId());

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=boleta-" + boleta.getNumero() + ".pdf");

            Document document = new Document();
            try {
                PdfWriter.getInstance(document, response.getOutputStream());
                document.open();

                // Logo personalizado
                try {
                    String logoPath = getServletContext().getRealPath("/uploads/logo_1.png");
                    Image logo = Image.getInstance(logoPath);
                    logo.scaleToFit(80, 80);
                    logo.setAlignment(Image.ALIGN_LEFT);
                    document.add(logo);
                } catch (Exception ex) {
                    // Si no hay logo, no pasa nada
                }

                Font fontTitulo = new Font(Font.HELVETICA, 18, Font.BOLD, new Color(102, 126, 234));
                Font fontEmpresa = new Font(Font.HELVETICA, 12, Font.BOLD);
                Font fontNormal = new Font(Font.HELVETICA, 10, Font.NORMAL);

                Paragraph empresa = new Paragraph("House of Stake", fontTitulo);
                empresa.setAlignment(Element.ALIGN_LEFT);
                document.add(empresa);
                document.add(new Paragraph("RUC: 4596875236981", fontEmpresa));
                document.add(new Paragraph("Mz. A Lt. 10 Asoc. de Propietrarios Hijos de Huaraz, Puente Piedra", fontNormal));
                document.add(new Paragraph("Tel: 926970283 | houseofstake@gmail.com", fontNormal));
                document.add(new Paragraph(" "));

                Paragraph titulo = new Paragraph("BOLETA DE VENTA N° " + boleta.getNumero(), fontEmpresa);
                titulo.setAlignment(Element.ALIGN_CENTER);
                document.add(titulo);
                document.add(new Paragraph(" "));
                document.add(new Paragraph("Cliente: " + venta.getUsuario().getNombre()));
                document.add(new Paragraph("Fecha: " + boleta.getFecha()));
                document.add(new Paragraph("Forma de Pago: " + boleta.getFormaPago()));
                document.add(new Paragraph(" "));
                PdfPTable table = new PdfPTable(4);
                table.addCell("Producto");
                table.addCell("Precio Unitario");
                table.addCell("Cantidad");
                table.addCell("Subtotal");
                for (DetalleVenta detalle : detalles) {
                    table.addCell(detalle.getProducto().getNombre());
                    table.addCell("S/. " + detalle.getProducto().getPrecio());
                    table.addCell(String.valueOf(detalle.getCantidad()));
                    table.addCell("S/. " + detalle.getSubtotal());
                }
                document.add(table);
                document.add(new Paragraph(" "));
                document.add(new Paragraph("Subtotal: S/. " + boleta.getSubtotal()));
                document.add(new Paragraph("IGV: S/. " + boleta.getIgv()));
                document.add(new Paragraph("Total: S/. " + boleta.getTotal()));
               
                document.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
} 
package com.tiendapatineta.util;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {
    public static void enviarCodigoVerificacion(String destinatario, String codigo) throws MessagingException {
        final String remitente = "hcarloslflahoz@gmail.com";
        final String password = "xsdu pdsl htvm aayg";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(remitente, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(remitente));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        message.setSubject("Código de verificación - Tienda de Patinetas");
        message.setText("Tu código de verificación es: " + codigo);

        Transport.send(message);
    }

    public static void enviarCorreo(String destinatario, String asunto, String cuerpo) throws MessagingException {
        final String remitente = "hcarloslflahoz@gmail.com";
        final String password = "xsdu pdsl htvm aayg";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(remitente, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(remitente));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        message.setSubject(asunto);
        message.setText(cuerpo);

        Transport.send(message);
    }
} 
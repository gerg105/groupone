package tw.eeit138.groupone.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class JavaMailUtil {

	public static void sendMail(String recepient, String emailName, String emailAddress, String emailSubject, String emailMessage) throws Exception{
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "587");
		
		String myAccountEmail = "eeit138g1.29@gmail.com";
		String password = "kofujiijcicmvvku";
		Session session = Session.getInstance(properties, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(myAccountEmail,password);
			}
		});
		
		Message message = prepareMessage(session, myAccountEmail, recepient, emailName, emailAddress, emailSubject, emailMessage);
		Transport.send(message);
		System.out.println("email sent success!");
	}

	private static Message prepareMessage(Session session, String myAccountEmail,String recepient, String emailName, String emailAddress, String emailSubject, String emailMessage) {
	
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(myAccountEmail,"天食地栗留言系統"));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(recepient));
			message.setSubject(emailSubject);
			String htmlCode = "姓名：" + emailName + "<br>" +
							  "Email：" + emailAddress + "<br>" +
							  "留言：" + emailMessage;
			message.setContent(htmlCode, "text/html; charset=utf-8");
			return message;
		} catch (Exception e) {
			
		}
		return null;
	}
}

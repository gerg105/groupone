package tw.eeit138.groupone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import tw.eeit138.groupone.dto.MessageDto;
import tw.eeit138.groupone.util.JavaMailUtil;

@Controller
public class MessageController {
	
	//ajax傳送javamail
	@ResponseBody
	@PostMapping("/contact/sendMessage")
	public void home(@RequestBody MessageDto messageDto) {
		String emailName = messageDto.getEmailName();
		String emailAddress = messageDto.getEmailAddress();
		String emailSubject = messageDto.getEmailSubject();
		String emailMessage = messageDto.getEmailMessage();
		try {
			JavaMailUtil.sendMail("eeit138g1@gmail.com", emailName, emailAddress, emailSubject, emailMessage);
		} catch (Exception e) {
		}
	}
}

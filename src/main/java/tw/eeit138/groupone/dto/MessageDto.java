package tw.eeit138.groupone.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

public class MessageDto implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@JsonProperty(value = "emailName")
	private String emailName;
	
	@JsonProperty(value = "emailAddress")
	private String emailAddress;
	
	@JsonProperty(value = "emailSubject")
	private String emailSubject;
	
	@JsonProperty(value = "emailMessage")
	private String emailMessage;

	public String getEmailName() {
		return emailName;
	}

	public void setEmailName(String emailName) {
		this.emailName = emailName;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getEmailSubject() {
		return emailSubject;
	}

	public void setEmailSubject(String emailSubject) {
		this.emailSubject = emailSubject;
	}

	public String getEmailMessage() {
		return emailMessage;
	}

	public void setEmailMessage(String emailMessage) {
		this.emailMessage = emailMessage;
	}
}

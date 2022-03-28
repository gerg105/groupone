package tw.eeit138.groupone.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

public class MemberPwdDto implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@JsonProperty(value = "newPwd")
	private String newPwd;
	
	@JsonProperty(value = "recheckPwd")
	private String recheckPwd;

	public String getNewPwd() {
		return newPwd;
	}

	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}

	public String getRecheckPwd() {
		return recheckPwd;
	}

	public void setRecheckPwd(String recheckPwd) {
		this.recheckPwd = recheckPwd;
	}
	
	
}

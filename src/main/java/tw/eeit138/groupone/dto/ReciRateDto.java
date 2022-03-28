package tw.eeit138.groupone.dto;

import java.io.Serializable;
import com.fasterxml.jackson.annotation.JsonProperty;

public class ReciRateDto implements Serializable {

	private static final long serialVersionUID = 1L;

	public ReciRateDto() {
	}

	@JsonProperty(value = "uid")
	private Integer uid;

	@JsonProperty(value = "rid")
	private Integer rid;

	@JsonProperty(value = "rate")
	private Integer rate;

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public Integer getRid() {
		return rid;
	}

	public void setRid(Integer rid) {
		this.rid = rid;
	}

	public Integer getRate() {
		return rate;
	}

	public void setRate(Integer rate) {
		this.rate = rate;
	}

}
package tw.eeit138.groupone.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ReciFavRecDto implements Serializable {

	private static final long serialVersionUID = 1L;

	public ReciFavRecDto() {
	}

	@JsonProperty(value = "uid")
	private Integer uid;

	@JsonProperty(value = "rid")
	private Integer rid;

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
}
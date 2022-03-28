package tw.eeit138.groupone.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ProductFavRecDto implements Serializable {

	private static final long serialVersionUID = 1L;

	public ProductFavRecDto() {
	}

	@JsonProperty(value = "uid")
	private Integer uid;

	@JsonProperty(value = "pid")
	private Integer pid;

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

}
package tw.eeit138.groupone.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

// 傳送JSON資料
public class LevelDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@JsonProperty("memID")
	private int id;
	
	@JsonProperty("memVIP")
	private int vip;
	
	@JsonProperty("memBlacklist")
	private int list;
	
	public LevelDTO() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getVip() {
		return vip;
	}

	public void setVip(int vip) {
		this.vip = vip;
	}

	public int getList() {
		return list;
	}

	public void setList(int list) {
		this.list = list;
	}
	
}

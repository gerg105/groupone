package tw.eeit138.groupone.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "VIP")
public class VIP implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "v_ID")
	private int vipID;
	
	@Column(name = "v_title")
	private String vipTitle;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "vip")
	private List<Member> member;
	

	public VIP() {
	}
	
	public int getVipID() {
		return vipID;
	}
	public void setVipID(int vipID) {
		this.vipID = vipID;
	}

	public String getVipTitle() {
		return vipTitle;
	}
	public void setVipTitle(String vipTitle) {
		this.vipTitle = vipTitle;
	}
	
	@JsonIgnore
	public List<Member> getMember() {
		return member;
	}
	public void setMember(List<Member> member) {
		this.member = member;
	}
}

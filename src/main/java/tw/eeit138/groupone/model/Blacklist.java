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
@Table(name = "Blacklist")
public class Blacklist implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "b_ID")
	private int listID;
	
	@Column(name = "b_title")
	private String listTitle;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "blacklist")
	private List<Member> member;

	public Blacklist() {
	}

	public int getListID() {
		return listID;
	}
	public void setListID(int listID) {
		this.listID = listID;
	}

	public String getListTitle() {
		return listTitle;
	}
	public void setListTitle(String listTitle) {
		this.listTitle = listTitle;
	}
	
	@JsonIgnore
	public List<Member> getMember() {
		return member;
	}
	public void setMember(List<Member> member) {
		this.member = member;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Blacklist [listID=");
		builder.append(listID);
		builder.append(", listTitle=");
		builder.append(listTitle);
		builder.append(", member=");
		builder.append(member);
		builder.append("]");
		return builder.toString();
	}

	
}

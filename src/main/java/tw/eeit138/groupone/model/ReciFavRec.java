package tw.eeit138.groupone.model;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
@Entity
@Table(name = "reci_favrec")
public class ReciFavRec implements Serializable {
  private static final long serialVersionUID = 1L;
  
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Integer favrid;
  
  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "rid")
  private RcpBean rb;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "userid")
  private Member member;
  
  public ReciFavRec(){}
  
  public ReciFavRec(RcpBean rb, Member member) {
  	this.rb = rb;
  	this.member = member;
  }

	public Integer getFavrid() {
		return favrid;
	}

	public void setFavrid(Integer favrid) {
		this.favrid = favrid;
	}

	public RcpBean getRb() {
		return rb;
	}

	public void setRb(RcpBean rb) {
		this.rb = rb;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
}
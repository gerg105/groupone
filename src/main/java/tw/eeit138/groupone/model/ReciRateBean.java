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
@Table(name = "rate")
public class ReciRateBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer rateid;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "rid")
	private RcpBean rb;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "userid")
	private Member member;

	private Integer rate;

	public ReciRateBean() {
	}

	public Integer getRateid() {
		return rateid;
	}

	public void setRateid(Integer rateid) {
		this.rateid = rateid;
	}

	public RcpBean getRb() {
		return rb;
	}

	public void setRb(RcpBean rb) {
		this.rb = rb;
	}

	public Integer getRate() {
		return rate;
	}

	public void setRate(Integer rate) {
		this.rate = rate;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

}
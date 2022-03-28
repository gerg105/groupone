package tw.eeit138.groupone.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "cumulativeConsumption")
public class CumulativeConsumptionBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private int id;

	@Column(name = "memberID")
	private int memberID;

	@Column(name = "cumulativeConsumption")
	private int cumulativeConsumption;

	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy/MM/dd HH:mm:ss", timezone = "GMT+8")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "consumptionDate")
	private Date consumptionDate;

	@PrePersist // 沒打的話時間會 null //當 Entity 狀態要變成 Persistent 的時候，做以下方法
	public void onCreate() {
		if (consumptionDate == null) {
			consumptionDate = new Date();
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMemberID() {
		return memberID;
	}

	public void setMemberID(int memberID) {
		this.memberID = memberID;
	}

	public int getCumulativeConsumption() {
		return cumulativeConsumption;
	}

	public void setCumulativeConsumption(int cumulativeConsumption) {
		this.cumulativeConsumption = cumulativeConsumption;
	}

	public Date getConsumptionDate() {
		return consumptionDate;
	}

	public void setConsumptionDate(Date consumptionDate) {
		this.consumptionDate = consumptionDate;
	}

	public CumulativeConsumptionBean() {
		// TODO Auto-generated constructor stub
	}

}

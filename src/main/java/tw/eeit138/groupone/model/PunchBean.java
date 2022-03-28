package tw.eeit138.groupone.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "punch")
public class PunchBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;
	
	@Column(name = "empId")
	private Integer empId;
	
	@Column(name = "punchYear")
	private String punchYear;
	
	@Column(name = "punchMonth")
	private String punchMonth;
	
	@Column(name = "punchDate")
	private String punchDate;
	
	@Column(name = "onWorkTime")
	private String onWorkTime;
	
	@Column(name = "offWorkTime")
	private String offWorkTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getEmpId() {
		return empId;
	}

	public void setEmpId(Integer empId) {
		this.empId = empId;
	}

	public String getPunchYear() {
		return punchYear;
	}

	public void setPunchYear(String punchYear) {
		this.punchYear = punchYear;
	}

	public String getPunchMonth() {
		return punchMonth;
	}

	public void setPunchMonth(String punchMonth) {
		this.punchMonth = punchMonth;
	}

	public String getPunchDate() {
		return punchDate;
	}

	public void setPunchDate(String punchDate) {
		this.punchDate = punchDate;
	}

	public String getOnWorkTime() {
		return onWorkTime;
	}

	public void setOnWorkTime(String onWorkTime) {
		this.onWorkTime = onWorkTime;
	}

	public String getOffWorkTime() {
		return offWorkTime;
	}

	public void setOffWorkTime(String offWorkTime) {
		this.offWorkTime = offWorkTime;
	}

	
	
	
	
}

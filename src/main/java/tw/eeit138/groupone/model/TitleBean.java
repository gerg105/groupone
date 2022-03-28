package tw.eeit138.groupone.model;

import java.io.Serializable;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity @Table(name = "title")
public class TitleBean implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "titleId")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer titleId;
	
	@Column(name = "titleName")
	private String titleName;

	@OneToMany(fetch = FetchType.LAZY,mappedBy = "fkTitleId")
	private Set<EmployeeBean> employees = new LinkedHashSet<EmployeeBean>();

	public Integer getTitleId() {
		return titleId;
	}

	public void setTitleId(Integer titleId) {
		this.titleId = titleId;
	}

	public String getTitleName() {
		return titleName;
	}

	public void setTitleName(String titleName) {
		this.titleName = titleName;
	}
	
	@JsonIgnore
	public Set<EmployeeBean> getEmployees() {
		return employees;
	}

	public void setEmployees(Set<EmployeeBean> employees) {
		this.employees = employees;
	}

	
	
}

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

@Entity
@Table(name = "department")
public class DepartmentBean implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "deptno")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer deptno;
	
	@Column(name = "dname")
	private String dname;
	
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "fkDeptno")
	private Set<EmployeeBean> employees = new LinkedHashSet<EmployeeBean>();

	public Integer getDeptno() {
		return deptno;
	}

	public void setDeptno(Integer deptno) {
		this.deptno = deptno;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}
	
	@JsonIgnore
	public Set<EmployeeBean> getEmployees() {
		return employees;
	}

	public void setEmployees(Set<EmployeeBean> employees) {
		this.employees = employees;
	}

	

	
	
}

package tw.eeit138.groupone.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "employee")
public class EmployeeBean implements Serializable{
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "empId")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer empId;
	
	@Column(name = "username")
	private String username;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fkDepartmentDeptno")
	private DepartmentBean fkDeptno;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fkTitleId")
	private TitleBean fkTitleId;
	
	@Column(name = "superiorName")
	private String superiorName;
	
	@Column(name = "id")
	private String id;
	
	@Column(name = "password")
	private String password;
	
	@Column(name = "sex")
	private String sex;
	
	@Column(name = "photo")
	private String photo;
	
	@Column(name = "birthday")
	private String birthday;
	
	@Column(name = "phone")
	private String phone;
	
	@Column(name = "highEdu")
	private String highEdu;
	
	@Column(name = "highLevel")
	private String highLevel;
	
	@Column(name = "highMajor")
	private String highMajor;
	
	@Column(name = "email")
	private String email;
	
	@Column(name = "address")
	private String address;
	
	@Column(name = "boardDate")
	private String boardDate;
	
	@Column(name = "emergencyContact")
	private String emergencyContact;
	
	@Column(name = "contactPhone")
	private String contactPhone;
	
	@Column(name = "contactRelationship")
	private String contactRelationship;
	
	@Column(name = "idCode")
	private String idCode;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fkStateId")
	private StateBean fkStateId;
	
	@Column(name = "qrcode")
	private String qrcode;
	
	public Integer getEmpId() {
		return empId;
	}

	public void setEmpId(Integer empId) {
		this.empId = empId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public DepartmentBean getFkDeptno() {
		return fkDeptno;
	}

	public void setFkDeptno(DepartmentBean fkDeptno) {
		this.fkDeptno = fkDeptno;
	}

	public TitleBean getFkTitleId() {
		return fkTitleId;
	}

	public void setFkTitleId(TitleBean fkTitleId) {
		this.fkTitleId = fkTitleId;
	}

	public String getSuperiorName() {
		return superiorName;
	}

	public void setSuperiorName(String superiorName) {
		this.superiorName = superiorName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getHighEdu() {
		return highEdu;
	}

	public void setHighEdu(String highEdu) {
		this.highEdu = highEdu;
	}

	public String getHighLevel() {
		return highLevel;
	}

	public void setHighLevel(String highLevel) {
		this.highLevel = highLevel;
	}

	public String getHighMajor() {
		return highMajor;
	}

	public void setHighMajor(String highMajor) {
		this.highMajor = highMajor;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}

	public String getEmergencyContact() {
		return emergencyContact;
	}

	public void setEmergencyContact(String emergencyContact) {
		this.emergencyContact = emergencyContact;
	}

	public String getContactPhone() {
		return contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	public String getContactRelationship() {
		return contactRelationship;
	}

	public void setContactRelationship(String contactRelationship) {
		this.contactRelationship = contactRelationship;
	}

	public String getIdCode() {
		return idCode;
	}

	public void setIdCode(String idCode) {
		this.idCode = idCode;
	}

	public StateBean getFkStateId() {
		return fkStateId;
	}

	public void setFkStateId(StateBean fkStateId) {
		this.fkStateId = fkStateId;
	}

	public String getQrcode() {
		return qrcode;
	}

	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}
}

package tw.eeit138.groupone.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "member")
public class Member implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_ID")
	private int ID;
	
	@Column(name = "m_name")
	private String name;
	
	@Column(name = "m_account")
	private String account;
	
	@Column(name = "m_password")
	private String pwd;
	
	@Column(name = "m_gender")
	private String gender;
	
	@Column(name = "m_birth")
	private String birth;
	
	@Column(name = "m_tel")
	private String tel;
	
	@Column(name = "m_email")
	private String email;
	
	@Column(name = "m_pic")
	private String pic;
	
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss") // Java 看的 Date
	@JsonFormat(pattern = "yyyy/MM/dd HH:mm:ss", timezone = "GMT+8")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "m_regdate")
	private Date regdate;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "m_VIP")
	private VIP vip;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "m_blacklist")
	private Blacklist blacklist;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "member")
	private List<ReciFavRec> reciFavRec;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "member")
	private List<ProductFavRec> productFavRec;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "member")
	private List<ReciRateBean> reciRate;
	
	@Column(name = "edit_email")
	private String editEmail;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "memberID")
	private List<ShoppingCartBean> shoppingCartBean;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "member")
	private List<OrderInformationBean> orderInformationBean;
	
	
	public Member() {
	}

	@PrePersist
	public void onCreate() {
		if(regdate == null) {
			regdate = new Date();
		}
	}

	public int getID() {
		return ID;
	}
	public void setID(int id) {
		ID = id;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}

	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}

	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public VIP getVip() {
		return vip;
	}
	public void setVip(VIP vip) {
		this.vip = vip;
	}

	public Blacklist getBlacklist() {
		return blacklist;
	}
	public void setBlacklist(Blacklist blacklist) {
		this.blacklist = blacklist;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Member [ID=");
		builder.append(ID);
		builder.append(", name=");
		builder.append(name);
		builder.append(", account=");
		builder.append(account);
		builder.append(", pwd=");
		builder.append(pwd);
		builder.append(", gender=");
		builder.append(gender);
		builder.append(", birth=");
		builder.append(birth);
		builder.append(", tel=");
		builder.append(tel);
		builder.append(", email=");
		builder.append(email);
		builder.append(", pic=");
		builder.append(pic);
		builder.append(", regdate=");
		builder.append(regdate);
		builder.append(", vip=");
		builder.append(vip);
		builder.append(", blacklist=");
		builder.append(blacklist);
		builder.append("]");
		return builder.toString();
	}

	@JsonIgnore
	public List<ReciFavRec> getReciFavRec() {
		return reciFavRec;
	}

	public void setReciFavRec(List<ReciFavRec> reciFavRec) {
		this.reciFavRec = reciFavRec;
	}
	
	@JsonIgnore
	public List<ProductFavRec> getProductFavRec() {
		return productFavRec;
	}

	public void setProductFavRec(List<ProductFavRec> productFavRec) {
		this.productFavRec = productFavRec;
	}

	@JsonIgnore
	public List<ReciRateBean> getReciRate() {
		return reciRate;
	}

	public void setReciRate(List<ReciRateBean> reciRate) {
		this.reciRate = reciRate;
	}

	public String getEditEmail() {
		return editEmail;
	}

	public void setEditEmail(String editEmail) {
		this.editEmail = editEmail;
	}

	@JsonIgnore
	public List<ShoppingCartBean> getShoppingCartBean() {
		return shoppingCartBean;
	}

	public void setShoppingCartBean(List<ShoppingCartBean> shoppingCartBean) {
		this.shoppingCartBean = shoppingCartBean;
	}

	@JsonIgnore
	public List<OrderInformationBean> getOrderInformationBean() {
		return orderInformationBean;
	}

	public void setOrderInformationBean(List<OrderInformationBean> orderInformationBean) {
		this.orderInformationBean = orderInformationBean;
	}

	
}

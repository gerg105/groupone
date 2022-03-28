package tw.eeit138.groupone.model;

import java.io.Serializable;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

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
@Table(name = "orderInformation")
public class OrderInformationBean implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "orderNumber")
	private int orderNumber;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "memberID")
	private Member member;

	@Column(name = "beforeDiscount")
	private int beforeDiscount;
	
	@Column(name = "totalAmount")
	private int totalAmount;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "orderStats")
	private OrderStatsBean orderStats;

	
	@Column(name = "coupon")
	private String coupon;

	@Column(name = "storename")
	private String storename;

	@Column(name = "storeaddress")
	private String storeaddress;


	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy/MM/dd HH:mm:ss", timezone = "GMT+8")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "orderDate")
	private Date orderDate;

	@Column(name = "Remark")
	private String Remark;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "orderNumber")
	private Set<OrderDetailBean> orderDetailBean = new LinkedHashSet<OrderDetailBean>();

	@PrePersist //沒打的話時間會 null  //當 Entity 狀態要變成 Persistent 的時候，做以下方法
	public void onCreate() {
		if(orderDate==null) {
			orderDate=new Date();
		}
	}
	
	public OrderInformationBean() {
		// TODO Auto-generated constructor stub
	}

	public int getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(int orderNumber) {
		this.orderNumber = orderNumber;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public int getBeforeDiscount() {
		return beforeDiscount;
	}

	public void setBeforeDiscount(int beforeDiscount) {
		this.beforeDiscount = beforeDiscount;
	}

	public int getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}

	public OrderStatsBean getOrderStats() {
		return orderStats;
	}

	public void setOrderStats(OrderStatsBean orderStats) {
		this.orderStats = orderStats;
	}


	public String getCoupon() {
		return coupon;
	}

	public void setCoupon(String coupon) {
		this.coupon = coupon;
	}

	public String getStorename() {
		return storename;
	}

	public void setStorename(String storename) {
		this.storename = storename;
	}

	public String getStoreaddress() {
		return storeaddress;
	}

	public void setStoreaddress(String storeaddress) {
		this.storeaddress = storeaddress;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getRemark() {
		return Remark;
	}

	public void setRemark(String remark) {
		Remark = remark;
	}

	@JsonIgnore
	public Set<OrderDetailBean> getOrderDetailBean() {
		return orderDetailBean;
	}

	public void setOrderDetailBean(Set<OrderDetailBean> orderDetailBean) {
		this.orderDetailBean = orderDetailBean;
	}


}

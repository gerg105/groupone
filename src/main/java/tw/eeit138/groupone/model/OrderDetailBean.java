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
@Table(name = "orderDetail")
public class OrderDetailBean implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "orderDetailID")
	private int orderDetailID;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "orderNumber")
	private OrderInformationBean orderNumber;
	
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "productID")	
	private ProductBean product;

	@Column(name = "amount")
	private int amount;
	
	@Column(name = "totalPrice")
	private int totalPrice;
		
	public OrderDetailBean() {
		// TODO Auto-generated constructor stub
	}

	public int getOrderDetailID() {
		return orderDetailID;
	}

	public void setOrderDetailID(int orderDetailID) {
		this.orderDetailID = orderDetailID;
	}

	public OrderInformationBean getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(OrderInformationBean orderNumber) {
		this.orderNumber = orderNumber;
	}

	public ProductBean getProduct() {
		return product;
	}

	public void setProduct(ProductBean product) {
		this.product = product;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	
}

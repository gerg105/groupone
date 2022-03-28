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
@Table(name = "shoppingCart")
public class ShoppingCartBean implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "cartID")
	private int cartID;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "memberID")
	private Member memberID;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "productID")
	private ProductBean product;

	@Column(name = "amount")
	private int amount;

	public int getCartID() {
		return cartID;
	}

	public void setCartID(int cartID) {
		this.cartID = cartID;
	}

	public Member getMemberID() {
		return memberID;
	}

	public void setMemberID(Member memberID) {
		this.memberID = memberID;
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

	

	

}

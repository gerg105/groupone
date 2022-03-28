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
@Table(name = "product_favrec")
public class ProductFavRec implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer favpid;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "pid")
	private ProductBean product;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "userid")
	private Member member;

	public ProductFavRec() {
	}

	public ProductFavRec(ProductBean product, Member member) {
		this.product = product;
		this.member = member;
	}

	public Integer getFavpid() {
		return favpid;
	}

	public void setFavpid(Integer favpid) {
		this.favpid = favpid;
	}

	public ProductBean getProduct() {
		return product;
	}

	public void setProduct(ProductBean product) {
		this.product = product;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
}
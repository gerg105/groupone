package tw.eeit138.groupone.model;

import java.io.Serializable;
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
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "product")
@Component
public class ProductBean implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="productID")
	private int productID;
	
	@Column(name="productName")
	private String productName;
	
	@Column(name="productPrice")
	private int productPrice;
	
	@Column(name="productSpecs")
	private String productSpecs;
	
	@Column(name="productPicUrl")
	private String productPicUrl;
	
	@Column(name="productDescription")
	private String productDes;
	
	@Transient
	private int productTypeId;
	@Transient
	private int productCountryId;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="productType")
	private ProductTypeBean productType;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="productCountry")
	private ProductCountryBean productCountry;

	@Column(name="productAvailable")
	private String productAvailable;
	
	@Column(name="productCreateTime")
	private String productCreateTime;
	
	@Column(name="lastModifiedTime")
	private String lastModifiedTime;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
	private List<ProductFavRec> productFavRec;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
	private List<ShoppingCartBean> shoppingCartBean;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
	private List<OrderDetailBean> orderDetailBean;

	public ProductBean() {
	}

	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public String getProductSpecs() {
		return productSpecs;
	}

	public void setProductSpecs(String productSpecs) {
		this.productSpecs = productSpecs;
	}

	public String getProductPicUrl() {
		return productPicUrl;
	}

	public void setProductPicUrl(String productPicUrl) {
		this.productPicUrl = productPicUrl;
	}

	public String getProductDes() {
		return productDes;
	}

	public void setProductDes(String productDes) {
		this.productDes = productDes;
	}

	public String getProductAvailable() {
		return productAvailable;
	}

	public void setProductAvailable(String productAvailable) {
		this.productAvailable = productAvailable;
	}

	public String getProductCreateTime() {
		return productCreateTime;
	}

	public void setProductCreateTime(String productCreateTime) {
		this.productCreateTime = productCreateTime;
	}

	public String getLastModifiedTime() {
		return lastModifiedTime;
	}

	public void setLastModifiedTime(String lastModifiedTime) {
		this.lastModifiedTime = lastModifiedTime;
	}

	public ProductTypeBean getProductType() {
		return productType;
	}

	public void setProductType(ProductTypeBean productType) {
		this.productType = productType;
	}

	public ProductCountryBean getProductCountry() {
		return productCountry;
	}

	public void setProductCountry(ProductCountryBean productCountry) {
		this.productCountry = productCountry;
	}

	public int getProductTypeId() {
		return productTypeId;
	}

	public void setProductTypeId(int productTypeId) {
		this.productTypeId = productTypeId;
	}

	public int getProductCountryId() {
		return productCountryId;
	}

	public void setProductCountryId(int productCountryId) {
		this.productCountryId = productCountryId;
	}

	@JsonIgnore
	public List<ProductFavRec> getProductFavRec() {
		return productFavRec;
	}

	public void setProductFavRec(List<ProductFavRec> productFavRec) {
		this.productFavRec = productFavRec;
	}

	@JsonIgnore
	public List<ShoppingCartBean> getShoppingCartBean() {
		return shoppingCartBean;
	}

	public void setShoppingCartBean(List<ShoppingCartBean> shoppingCartBean) {
		this.shoppingCartBean = shoppingCartBean;
	}

	@JsonIgnore
	public List<OrderDetailBean> getOrderDetailBean() {
		return orderDetailBean;
	}

	public void setOrderDetailBean(List<OrderDetailBean> orderDetailBean) {
		this.orderDetailBean = orderDetailBean;
	}
	
	
}

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

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "productCountry")
@Component
public class ProductCountryBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "countryNo")
	private int countryNo;

	@Column(name = "countryName")
	private String countryName;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "productCountry")
	private Set<ProductBean> products = new LinkedHashSet<ProductBean>();

	public int getCountryNo() {
		return countryNo;
	}

	public void setCountryNo(int countryNo) {
		this.countryNo = countryNo;
	}

	public String getCountryName() {
		return countryName;
	}

	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}

	public ProductCountryBean() {
	}

	@JsonIgnore
	public Set<ProductBean> getProducts() {
		return products;
	}

	public void setProducts(Set<ProductBean> products) {
		this.products = products;
	}
}

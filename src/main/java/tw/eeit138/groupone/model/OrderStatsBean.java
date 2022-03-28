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
@Table(name = "orderStats")
public class OrderStatsBean implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "orderStatsID")
	private int orderStatsID;

	@Column(name = "orderStats")
	private String orderStats;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "orderStats")
	private Set<OrderInformationBean> OrderInformations = new LinkedHashSet<OrderInformationBean>();

	public OrderStatsBean() {
		// TODO Auto-generated constructor stub
	}

	public int getOrderStatsID() {
		return orderStatsID;
	}

	public void setOrderStatsID(int orderStatsID) {
		this.orderStatsID = orderStatsID;
	}

	public String getOrderStats() {
		return orderStats;
	}
 
	public void setOrderStats(String orderStats) {
		this.orderStats = orderStats;
	}

	@JsonIgnore
	public Set<OrderInformationBean> getOrderInformations() {
		return OrderInformations;
	}

	public void setOrderInformations(Set<OrderInformationBean> orderInformations) {
		OrderInformations = orderInformations;
	}

}

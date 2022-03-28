package tw.eeit138.groupone.model;

import java.io.Serializable;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "reci_type")
public class RcpTypeBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer rtype_id;

	private String rtype;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "rtp")
	private Set<RcpBean> rcp = new LinkedHashSet<>();

	public RcpTypeBean(Integer rtype_id, String rtype) {
		this.rtype_id = rtype_id;
		this.rtype = rtype;
	}

	public RcpTypeBean() {
	}

	public Integer getRtype_id() {
		return rtype_id;
	}

	public String getRtype() {
		return rtype;
	}
	
	@JsonIgnore
	public Set<RcpBean> getRcps() {
		return rcp;
	}

	public void setRtype_id(Integer rtype_id) {
		this.rtype_id = rtype_id;
	}

	public void setRtype(String rtype) {
		this.rtype = rtype;
	}

	public void setRcps(Set<RcpBean> rcps) {
		this.rcp = rcps;
	}

}
package tw.eeit138.groupone.model;

import java.io.Serializable;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "reci")
public class RcpBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer rid;

	@NotEmpty(message = "不可空白")
	@Size(min = 3, max = 40, message = "請輸入 3 至 40 個字")
	private String title;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "rtype_id")
	private RcpTypeBean rtp;

	private Integer rtime;

	private Integer serve;

	@NotEmpty(message = "不可空白")
	private String ing;

	@NotEmpty(message = "不可空白")
	private String con;

	private String img;

	private String video;

	@JsonFormat(pattern = "yyyy/MM/dd HH:mm", timezone = "GMT+8")
	@Temporal(TemporalType.TIMESTAMP)
	private Date added;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "member")
	private List<ReciFavRec> reciFavRec;

	private float rates;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "rate")
	@JsonIgnore
	private Set<ReciRateBean> rb_rate = new LinkedHashSet<>();

	@PrePersist
	public void onCreate() {
		if (added == null)
			added = new Date();
	}

	@PreUpdate
	public void onUpdate() {
		if (added == null)
			added = new Date();
	}

	public RcpBean() {
	}

	public Integer getRid() {
		return rid;
	}

	public String getTitle() {
		return title;
	}

	public RcpTypeBean getRtp() {
		return rtp;
	}

	public Integer getRtime() {
		return rtime;
	}

	public Integer getServe() {
		return serve;
	}

	public String getIng() {
		return ing;
	}

	public String getCon() {
		return con;
	}

	public String getImg() {
		return img;
	}

	public String getVideo() {
		return video;
	}

	public void setRid(Integer rid) {
		this.rid = rid;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setRtp(RcpTypeBean rtp) {
		this.rtp = rtp;
	}

	public void setRtime(Integer rtime) {
		this.rtime = rtime;
	}

	public void setServe(Integer serve) {
		this.serve = serve;
	}

	public void setIng(String ing) {
		this.ing = ing;
	}

	public void setCon(String con) {
		this.con = con;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	public Date getAdded() {
		return added;
	}

	public void setAdded(Date added) {
		this.added = added;
	}

	@JsonIgnore
	public List<ReciFavRec> getReciFavRec() {
		return reciFavRec;
	}

	public void setReciFavRec(List<ReciFavRec> reciFavRec) {
		this.reciFavRec = reciFavRec;
	}

	public float getRates() {
		return rates;
	}

	public void setRates(float rates) {
		this.rates = rates;
	}

}
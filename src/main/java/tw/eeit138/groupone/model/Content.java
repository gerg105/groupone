package tw.eeit138.groupone.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "content")
public class Content implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Size(min = 5  ,message = "請輸入3至20個字")
	@NotEmpty(message = "請輸入內容")
	@Column(name = "content")
	private String content;
	
	@OneToOne(mappedBy = "content")
	private Events evens;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	@JsonIgnore
	public Events getEvens() {
		return evens;
	}
	public void setEvens(Events evens) {
		this.evens = evens;
	}

	@Transient
	private MultipartFile  eventImage;

	public MultipartFile getEventImage() {
	    return eventImage;
	}

	public void setEventImage(MultipartFile eventImage) {
	    this.eventImage = eventImage;
	}
}

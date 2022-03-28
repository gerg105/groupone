package tw.eeit138.groupone;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan
public class GrouponeApplication {

	public static void main(String[] args) {
		SpringApplication.run(GrouponeApplication.class, args);
		System.out.println("Initialized!");
	}

}

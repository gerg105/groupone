package tw.eeit138.groupone.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestController {
	@PostMapping("/test")
	public ModelAndView home(ModelAndView mav, HttpServletRequest request) {
		String storename = request.getParameter("storename");
		String storeaddress = request.getParameter("storeaddress");
		mav.getModel().put("storename", storename);
		mav.getModel().put("storeaddress", storeaddress);
		mav.setViewName("test");
		return mav;
	}
}

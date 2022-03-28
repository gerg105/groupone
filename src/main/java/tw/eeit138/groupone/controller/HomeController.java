package tw.eeit138.groupone.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import tw.eeit138.groupone.model.CheckShoppingCartBean;
import tw.eeit138.groupone.model.CumulativeConsumptionBean;
import tw.eeit138.groupone.model.Events;
import tw.eeit138.groupone.model.Member;
import tw.eeit138.groupone.model.OrderInformationBean;
import tw.eeit138.groupone.model.ProductBean;
import tw.eeit138.groupone.model.ProductTypeBean;
import tw.eeit138.groupone.model.RcpBean;
import tw.eeit138.groupone.service.BillService;
import tw.eeit138.groupone.service.CumulativeConsumptionService;
import tw.eeit138.groupone.service.EventService;
import tw.eeit138.groupone.service.MemberService;
import tw.eeit138.groupone.service.ProductService;
import tw.eeit138.groupone.service.RcpService;
import tw.eeit138.groupone.service.ShoppingCartService;

@Controller
public class HomeController {

	@Autowired
	private ProductService productService;

	@Autowired
	private EventService eventService;

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private RcpService rcpService;
	
	@Autowired
	private ShoppingCartService shoppingCartService;
	
	@Autowired
	private BillService billService;
	
	@Autowired
	private CumulativeConsumptionService cumulativeConsumptionService;
	

	@GetMapping("/")
	public ModelAndView home(ModelAndView mav) {
		Page<ProductBean> productPage = productService.indexProduct();
		Page<RcpBean> rcpPage = rcpService.findByPageIndex();
		mav.getModel().put("productPage", productPage);
		mav.getModel().put("rcpPage", rcpPage);
		Page<Events> eventPage = eventService.indexEvent();
		mav.getModel().put("eventPage", eventPage);
		mav.setViewName("index");
		return mav;
	}

	// 商品頁
	@GetMapping("/product")
	public ModelAndView product(ModelAndView mav, @RequestParam(value = "p", defaultValue = "1") int pageNumber,
			@RequestParam(value = "type", defaultValue = "0") int productType) {
		Page<ProductBean> page = productService.findByPage(pageNumber, productType);
		List<ProductTypeBean> productTypes = productService.findAllType();
		mav.getModel().put("page", page);
		mav.getModel().put("productTypes", productTypes);
		mav.getModel().put("currentType", productType);
		mav.setViewName("product");
		return mav;
	}

	// 聯絡頁
	@GetMapping("/contact")
	public ModelAndView contact(ModelAndView mav) {
		mav.setViewName("contact");
		return mav;
	}

	// 食譜頁
	@GetMapping("/recipe")
	public ModelAndView recipe(ModelAndView mav, @RequestParam(value = "p", defaultValue = "1") int pageNumber) {
		Page<RcpBean> page = rcpService.findByPage(pageNumber);
		mav.getModel().put("page", page);
		mav.setViewName("recipe");
		return mav;
	}

	// 活動頁
	@GetMapping("/event")
	public ModelAndView event(ModelAndView mav, @RequestParam(value = "p", defaultValue = "1") int pageNumber) {
		Page<Events> page = eventService.findByPage(pageNumber);
		mav.getModel().put("page", page);
		mav.setViewName("event");
		return mav;
	}

	// 會員專區
	@GetMapping("/account")
	public ModelAndView account(ModelAndView mav, HttpServletRequest request) {
		Member user = (Member) request.getSession().getAttribute("user");
		int id = user.getID();
		
		Member userEdit = memberService.personalData(id);
		List<RcpBean> rcps = rcpService.findReciFavRec(id);
		
		List<ProductBean> products = productService.findProductFavRec(id);
		mav.getModel().put("userEdit", userEdit);
		mav.getModel().put("rcps", rcps);
		mav.getModel().put("products", products);
		
		CumulativeConsumptionBean cumulativeData = cumulativeConsumptionService.getCumulativeDataByMemberId(id);
		mav.getModel().put("cumulative", cumulativeData);
		
		List<OrderInformationBean> orderInformationList = billService.getInformationOrderByMemberId(id);
		mav.getModel().put("orderInformationList", orderInformationList);
		mav.setViewName("account");
		
		return mav;
	}

	// 登入
	@GetMapping("/login")
	public ModelAndView login(ModelAndView mav) {
		mav.setViewName("login");
		return mav;
	}

	// 登出
	@ResponseBody
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().removeAttribute("user");
		return "logout success";
	}

	// 註冊頁面
	@GetMapping("/register")
	public ModelAndView registerPage(ModelAndView mav, @RequestParam(value = "email", defaultValue = "") String email) {
		mav.getModel().put("email", email);
		mav.setViewName("register");
		return mav;
	}
	
	//進購物車
	@GetMapping("/shoppingCart")
	public ModelAndView findAllbyMemberID(ModelAndView mav, HttpServletRequest request, RedirectAttributes redirectAttr) {
		mav.setViewName("shoppingCart");
		Member user = (Member) request.getSession().getAttribute("user");
		if(user == null) {
			redirectAttr.addFlashAttribute("msg","請先登入!");
			mav.setViewName("redirect:/login");
			return mav;
		}
		int id = user.getID();
		List<CheckShoppingCartBean> list = shoppingCartService.memberChekShoppingCartList(id);
		mav.getModel().put("cartDetailPut", list);
		return mav;
	}

}

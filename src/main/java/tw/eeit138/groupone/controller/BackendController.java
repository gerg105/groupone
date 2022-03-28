package tw.eeit138.groupone.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import tw.eeit138.groupone.model.Blacklist;
import tw.eeit138.groupone.model.Coupons;
import tw.eeit138.groupone.model.DepartmentBean;
import tw.eeit138.groupone.model.EmployeeBean;
import tw.eeit138.groupone.model.Events;
import tw.eeit138.groupone.model.Member;
import tw.eeit138.groupone.model.OrderInformationBean;
import tw.eeit138.groupone.model.OrderStatsBean;
import tw.eeit138.groupone.model.ProductBean;
import tw.eeit138.groupone.model.ProductCountryBean;
import tw.eeit138.groupone.model.ProductTypeBean;
import tw.eeit138.groupone.model.RcpBean;
import tw.eeit138.groupone.model.RcpTypeBean;
import tw.eeit138.groupone.model.StateBean;
import tw.eeit138.groupone.model.TitleBean;
import tw.eeit138.groupone.model.VIP;
import tw.eeit138.groupone.service.BackendSystemService;
import tw.eeit138.groupone.service.BillService;
import tw.eeit138.groupone.service.CouponService;
import tw.eeit138.groupone.service.EventService;
import tw.eeit138.groupone.service.MemberService;
import tw.eeit138.groupone.service.ProductService;
import tw.eeit138.groupone.service.RcpService;

@Controller
public class BackendController {

	@Autowired
	ProductService productService;

	@Autowired
	EventService eventService;

	@Autowired
	MemberService memberService;

	@Autowired
	BackendSystemService employeeService;

	@Autowired
	RcpService rcpService;

	@Autowired
	CouponService couponService;

	@Autowired
	BillService billService;

	// 後臺首頁
	@GetMapping("/admin/index")
	public String adminIndex() {
		return "/admin/backend_index";
	}

	// 後臺商品首頁
	@GetMapping("/admin/product")
	public ModelAndView adminProduct(ModelAndView mav) {
		Page<ProductBean> page = productService.findAllByPage(1);
		List<ProductTypeBean> types = productService.findAllType();
		List<ProductCountryBean> countries = productService.findAllCountry();
		mav.getModel().put("products", page);
		mav.getModel().put("types", types);
		mav.getModel().put("countries", countries);
		mav.setViewName("/admin/backend_product");
		return mav;
	}

	// 後臺活動首頁
	@GetMapping("/admin/event")
	public ModelAndView adminEvent(ModelAndView mav) {

		Page<Events> page = eventService.findByPage(1);
		mav.getModel().put("events", page);
		Events evn = new Events();
		mav.getModel().put("addEvent", evn); // for model attribute
		Events evn2 = new Events();
		mav.getModel().put("editEvent", evn2);
		mav.setViewName("/admin/backend_event");
		return mav;
	}

	// 後臺會員首頁
	@GetMapping("/admin/member")
	public ModelAndView memberIndex(ModelAndView mav) {
		mav.setViewName("/admin/backend_member");
		Page<Member> mems = memberService.queryAllMember(1);
		mav.getModel().put("mems", mems);
		List<VIP> vips = memberService.allVIPLevel();
		mav.getModel().put("vips", vips);
		List<Blacklist> blackLists = memberService.allBlackList();
		mav.getModel().put("blackLists", blackLists);
		return mav;
	}

	// 後臺食譜首頁
	@GetMapping("/admin/recipe")
	public ModelAndView recipeIndex(ModelAndView mav) {
		mav.setViewName("/admin/backend_recipe");
		Page<RcpBean> rcps = rcpService.findByPage(1);
		List<RcpTypeBean> types = rcpService.getAllType();
		mav.getModel().put("rcps", rcps);
		mav.getModel().put("types", types);
		return mav;
	}

	// 員工資料(自己的)
	@GetMapping("admin/account")
	public ModelAndView getPersonalInformation(ModelAndView mav, HttpServletRequest request) {
		HttpSession session = request.getSession();
		EmployeeBean admin = (EmployeeBean) session.getAttribute("admin");
		int empId = admin.getEmpId();
		EmployeeBean employeeBean = employeeService.findById(empId);
		mav.getModel().put("emp", employeeBean);
		mav.setViewName("admin/backend_account");
		return mav;
	}

	// 優惠券管理
	@GetMapping("admin/coupon")
	public ModelAndView couponIndex(ModelAndView mav) {
		mav.setViewName("/admin/backend_coupon");
		Page<Coupons> couponPage = couponService.findByPage(1);
		mav.getModel().put("couponPage", couponPage);
		return mav;
	}

	// 訂單管理
	@GetMapping("admin/order")
	public ModelAndView orderIndex(ModelAndView mav) {
		mav.setViewName("/admin/backend_order");
		Page<OrderInformationBean> page = billService.getOrderInformationAllPage(1);
		List<OrderStatsBean> list = billService.findAllOrderStats();
		mav.getModel().put("orderPage", page);
		mav.getModel().put("orderStats", list);
		return mav;
	}

	// 所有員工管理(管理員)
	@GetMapping("admin/employee")
	public ModelAndView employeeIndex(ModelAndView mav) {
		mav.setViewName("/admin/backend_employee");
		Page<EmployeeBean> empPage = employeeService.findAllByPage(1);
		mav.getModel().put("empPage", empPage);
		List<DepartmentBean> dpartmentBean = employeeService.selectAllDname();
		mav.getModel().put("dNames", dpartmentBean);
		List<TitleBean> titleBean = employeeService.selectAllTitName();
		mav.getModelMap().put("tNames", titleBean);
		List<StateBean> state = employeeService.selectAllStateName();
		mav.getModelMap().put("states", state);
		return mav;
	}

	// 所有員工打卡管理
	@GetMapping("admin/punch")
	public ModelAndView punchIndex(ModelAndView mav) {
		mav.setViewName("/admin/backend_punch");
		List<EmployeeBean> list = employeeService.selectAllEmployee();
		mav.getModel().put("emps", list);
		return mav;
	}

	// 後臺登出
	@GetMapping("/adminLogOut")
	public String singOut(HttpSession httpSession) {
		httpSession.removeAttribute("admin");
		return "redirect:/adminLogin";
	}

	// 後臺登出(ajax)
	@ResponseBody
	@GetMapping("/adminLogOut2")
	public void singOut2(HttpSession httpSession) {
		httpSession.removeAttribute("admin");
	}
}

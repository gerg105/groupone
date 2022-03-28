package tw.eeit138.groupone.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import tw.eeit138.groupone.model.Coupons;
import tw.eeit138.groupone.service.CouponService;

@Controller
public class CouponController {

	@Autowired
	CouponService couponService;

	//新增
	@PostMapping("/admin/createCoupon")
	public ModelAndView createCoupon(ModelAndView mav, HttpServletRequest request) {

		String type = request.getParameter("type");
		int dis = Integer.parseInt(request.getParameter("discount"));
		int low = Integer.parseInt(request.getParameter("lowest"));
		String date = request.getParameter("endDate") + " 23:59:59";
		SimpleDateFormat dateParser = new SimpleDateFormat("yy/MM/dd HH:mm:ss");
		try {
			Date endDate = dateParser.parse(date);
			Coupons coupon = new Coupons();
			String code = request.getParameter("code");
			coupon.setCode(code);
			coupon.setType(type);
			coupon.setEndDate(endDate);
			coupon.setLowest(low);
			coupon.setDiscount(dis);
			couponService.insert(coupon);

		} catch (Exception e) {
			e.printStackTrace();
		}
		mav.setViewName("redirect:/admin/coupon");
		return mav;
	}
	
	//編輯
	@PostMapping("/admin/editCoupon")
	public ModelAndView editCoupon(ModelAndView mav, HttpServletRequest request ,@RequestParam(name = "id") int id) {
		Coupons cp = couponService.findById(id);
		cp.setType(request.getParameter("type"));
		int dis = Integer.parseInt(request.getParameter("discount"));
		cp.setDiscount(dis);
		int low = Integer.parseInt(request.getParameter("lowest"));
		cp.setLowest(low);

		String date = request.getParameter("endDate") + " 23:59:59";
		SimpleDateFormat dateParser = new SimpleDateFormat("yy/MM/dd HH:mm:ss");
		try {
			Date endDate = dateParser.parse(date);
			cp.setEndDate(endDate);
			couponService.insert(cp);

		} catch (Exception e) {
			e.printStackTrace();
		}
		mav.setViewName("redirect:/admin/coupon");
		return mav;
	}

	// 隨機產生
	@ResponseBody
	@GetMapping("/admin/randomCoupon")
	public String randomCoupon() {
		return couponService.createCoupon();
	}

	// 後台查詢(ajax/page)
	@ResponseBody
	@GetMapping("/admin/coupon/find")
	public HashMap<String, Object> couponfindByName(@RequestParam(name = "search") String search,
			@RequestParam(value = "p", defaultValue = "1") int pageNumber) {
		HashMap<String, Object> map = couponService.findByNameLikePage(search, pageNumber);
		return map;
	}

	// 後台刪除(ajax)
	@ResponseBody
	@DeleteMapping("admin/deleteCoupon/{id}")
	public HashMap<String, Object> productDelete(@PathVariable(name = "id") int id) {
		couponService.delete(id);
		return couponService.findByNameLikePage("", 1);
	}

	// 後台查詢單一商品(ajax抓資料for修改)
	@ResponseBody
	@GetMapping("admin/coupon/getjson")
	public Coupons productfindByNme(@RequestParam(name = "id") int id) {
		return couponService.findById(id);
	}

}

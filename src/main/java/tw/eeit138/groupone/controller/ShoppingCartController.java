package tw.eeit138.groupone.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import tw.eeit138.groupone.model.CheckShoppingCartBean;
import tw.eeit138.groupone.model.Coupons;
import tw.eeit138.groupone.model.Member;
import tw.eeit138.groupone.service.ShoppingCartService;

@Controller
public class ShoppingCartController {

	@Autowired
	public ShoppingCartService shoppingCartService;

	// 改量 (ajax)
	@ResponseBody
	@PostMapping("/shoppingCart/edit")
	public List<CheckShoppingCartBean> editCart(HttpServletRequest request, @RequestParam("cartId") int cartId,
			@RequestParam("amount") int amount) {
		shoppingCartService.editCart(cartId, amount);
		Member user = (Member) request.getSession().getAttribute("user");
		int id = user.getID();
		List<CheckShoppingCartBean> list = shoppingCartService.memberChekShoppingCartList(id);
		return list;
	}

	// 新增 (ajax)
	@ResponseBody
	@PostMapping("/shoppingCart/add")
	public String addShoppingCart(HttpServletRequest request, @RequestParam("productId") int pId,
			@RequestParam("amount") int amount) {
		Member user = (Member) request.getSession().getAttribute("user");
		int memberId = user.getID();
		shoppingCartService.addCart(memberId, pId, amount);
		return "added";
	}

	// 刪除(ajax)
	@ResponseBody
	@DeleteMapping("/shoppingCart/delete")
	public List<CheckShoppingCartBean> delteByid(HttpServletRequest request, @RequestParam(name = "id") int id) {
		shoppingCartService.delteById(id);
		Member user = (Member) request.getSession().getAttribute("user");
		int uid = user.getID();
		List<CheckShoppingCartBean> list = shoppingCartService.memberChekShoppingCartList(uid);
		return list;
	}
	
	//進購物車
		@GetMapping("/shoppingCartCheck")
		public ModelAndView findAllbyMemberID(ModelAndView mav, HttpServletRequest request, RedirectAttributes redirectAttr) {
			mav.setViewName("shoppingCartCheck");
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
	
	
	

	@PostMapping("storelist")
	public ModelAndView marketdetail(ModelAndView mav, HttpServletRequest requset,
			@RequestParam("storename") String storename, @RequestParam("storeaddress") String storeaddress,
			RedirectAttributes redirectAttr) {
		redirectAttr.addFlashAttribute("storename", storename);
		redirectAttr.addFlashAttribute("storeaddress", storeaddress);
		mav.setViewName("redirect:/shoppingCartCheck");
		return mav;

	}

	// 優惠卷驗證
	@ResponseBody
	@PostMapping("coupons/check")
	public Coupons checkCouponsCode(ModelAndView mav, HttpServletRequest request,
									@RequestParam("couponCode") String couponCode) {

		Coupons checkCode = shoppingCartService.checkGetByCuponsCod(couponCode);
		if (checkCode != null) {
			return checkCode;
		} else {
			return null;
		}
	}

}

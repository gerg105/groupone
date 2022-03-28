package tw.eeit138.groupone.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import tw.eeit138.groupone.model.CumulativeConsumptionBean;
import tw.eeit138.groupone.model.Member;
import tw.eeit138.groupone.model.OrderDetailBean;
import tw.eeit138.groupone.model.OrderInformationBean;
import tw.eeit138.groupone.model.ShoppingCartBean;
import tw.eeit138.groupone.service.BillService;
import tw.eeit138.groupone.service.CumulativeConsumptionService;
import tw.eeit138.groupone.service.MailService;
import tw.eeit138.groupone.service.MemberService;
import tw.eeit138.groupone.service.ShoppingCartService;

@Controller
public class BillController {

	@Autowired
	private BillService billService;

	@Autowired
	private ShoppingCartService shoppingCartService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CumulativeConsumptionService cumulativeConsumptionService;
	
	@Autowired
	private MailService mailService;

	@PostMapping("/createBill")
	public ModelAndView bill(ModelAndView mav, HttpServletRequest request, @RequestParam("total") int total, // 扣錢前金額
			@RequestParam("deliveryFee") int deliveryFee, // 運費
			@RequestParam("allTotal") int allTotal, // 總付款金額
			@RequestParam("couponTypeText") String couText, // coupon分類明細
			@RequestParam("storeName") String stoName, // 商店名
			@RequestParam("storeAddress") String stoAdd, // 商店地址
			@RequestParam("textarea") String text, // 留言
			RedirectAttributes redirectAttr) {

		int beforeDiscount = total + deliveryFee;

		OrderInformationBean OrderInformation = new OrderInformationBean();
		Member user = (Member) request.getSession().getAttribute("user");
		int userId = user.getID();
		OrderInformation.setMember(user);
		OrderInformation.setBeforeDiscount(beforeDiscount);
		OrderInformation.setTotalAmount(allTotal);
		OrderInformation.setOrderStats(billService.findOrderStatsId(0));
		OrderInformation.setCoupon(couText);
		OrderInformation.setStorename(stoName);
		OrderInformation.setStoreaddress(stoAdd);
		OrderInformation.setRemark(text);

		// 產生訂單
		billService.insertOrderInformation(OrderInformation);

		// 產生明細
		List<ShoppingCartBean> shoppingCartList = shoppingCartService.getByMemberId(userId);
		List<OrderDetailBean> orderDetailList = new ArrayList<>();

		if (shoppingCartList != null) {
			for (ShoppingCartBean shoppingCart : shoppingCartList) {
				OrderDetailBean OrderDetail = new OrderDetailBean();

				int amount = shoppingCart.getAmount();
				int price = shoppingCart.getProduct().getProductPrice();
				int totalPrice = amount * price;

				OrderDetail.setOrderNumber(OrderInformation);
				OrderDetail.setProduct(shoppingCart.getProduct());
				OrderDetail.setAmount(shoppingCart.getAmount());
				OrderDetail.setTotalPrice(totalPrice);

				orderDetailList.add(OrderDetail);
				billService.insertOrderDetail(OrderDetail);
			}
		}

		// 產生完後刪除購物車
		billService.deleteCartByMemberId(userId);

		
		// 累積消費
				CumulativeConsumptionBean consumption = new CumulativeConsumptionBean();
				consumption.setMemberID(userId);
				consumption.setCumulativeConsumption(beforeDiscount);

				cumulativeConsumptionService.addConsumption(consumption, userId, beforeDiscount);

				// VIP升級
				int dbCumulative = cumulativeConsumptionService.getCumulativeByMemberId(userId);
				int oldVip = memberService.queryByID(userId).getVip().getVipID();

				int gold = 10000;
				int platinum = 50000;
				int diamond = 100000;
				
				int goldLevel = 1;
				int platinumLevel = 2;
				int diamondLevel = 3;
				// 累積點數達到鑽石的條件時
				if (dbCumulative >= diamond) {
					memberService.vipUpdateByMemberId(diamondLevel, userId);
					int vip = memberService.queryByID(userId).getVip().getVipID();
					// 當前等級是否升級為鑽石
					if (diamondLevel != vip) {
						try {
							int couponId =16;
							String vipName = "鑽石會員";
							mailService.sendVipUpgradeEmail(vipName, couponId,userId);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					// 累積點數達到白金的條件時
				} else if (dbCumulative >= platinum) {
					memberService.vipUpdateByMemberId(platinumLevel, userId);
					int vip = memberService.queryByID(userId).getVip().getVipID();
					// 當前等級是否升級為白金
					if (platinumLevel != vip) {
						try {
							int couponId =15;
							String vipName = "白金會員";
							mailService.sendVipUpgradeEmail(vipName, couponId,userId);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					// 累積點數達到黃金的條件時
				} else if (dbCumulative >= gold) {
					memberService.vipUpdateByMemberId(goldLevel, userId);
					int vip = memberService.queryByID(userId).getVip().getVipID();
					// 當前等級是否升級為黃金
					if (goldLevel != vip) {
						try {
							int couponId =14;
							String vipName = "黃金會員";
							mailService.sendVipUpgradeEmail(vipName, couponId,userId);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
		
		
		
		
		
		
		
		
		
		
		// 結帳後跳轉
		redirectAttr.addFlashAttribute("isOrder", 1);
		mav.setViewName("redirect:/account");
		return mav;
	}

	// 會員專區(獲得明細)
	@ResponseBody
	@GetMapping("/orderDetail")
	public HashMap<String, Object> getOrderDetail(@RequestParam("id") int id) {
		HashMap<String, Object> map = new HashMap<>();
		List<OrderDetailBean> orderDetailList = billService.getOrderDetailByOrderNumber(id);
		OrderInformationBean orderInformation = billService.findOrderInformation(id);
		map.put("orderInformation", orderInformation);
		map.put("orderDetailList", orderDetailList);
		return map;
	}

	// 編輯(只改狀態)
	@PostMapping("/admin/editOrder")
	public ModelAndView editMessage(ModelAndView mav, HttpServletRequest requset,
			@RequestParam("orderStats") int orderStat, @RequestParam("orderNumber") int orderNumber) {
		billService.editStats(orderStat, orderNumber);
		mav.setViewName("redirect:/admin/order");
		return mav;
	}

	// 分頁(ajax/page)
	@ResponseBody
	@GetMapping("admin/order/find")
	public HashMap<String, Object> orderfindByPage(@RequestParam(value = "p", defaultValue = "1") int pageNumber) {
		return billService.getOrderPage(pageNumber);
	}

	// 模糊查詢(list)
	@ResponseBody
	@GetMapping("/admin/order/findlist")
	public List<OrderInformationBean> orderFindBySearch(@RequestParam("search") String search) {
		List<OrderInformationBean> list = billService.getOrderInformationSearch(search);
		return list;
	}

}

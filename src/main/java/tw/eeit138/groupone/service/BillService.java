package tw.eeit138.groupone.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import tw.eeit138.groupone.dao.CouponRepository;
import tw.eeit138.groupone.dao.OrderDetailBeanRepository;
import tw.eeit138.groupone.dao.OrderInformationRepository;
import tw.eeit138.groupone.dao.OrderStatsRepository;
import tw.eeit138.groupone.dao.ProductBeanRepository;
import tw.eeit138.groupone.dao.ShoppingCartRepository;
import tw.eeit138.groupone.model.Coupons;
import tw.eeit138.groupone.model.Member;
import tw.eeit138.groupone.model.OrderDetailBean;
import tw.eeit138.groupone.model.OrderInformationBean;
import tw.eeit138.groupone.model.OrderStatsBean;
import tw.eeit138.groupone.model.ProductBean;

@Service
public class BillService {

	
	@Autowired
	CouponRepository couponDao;
	
	@Autowired
	OrderStatsRepository orderStatsDao;
	
	@Autowired
	OrderInformationRepository orderInformationDao;
	
	@Autowired
	OrderDetailBeanRepository orderDetailDao;
	
	@Autowired
	ProductBeanRepository productDao;
	
	@Autowired	
	ShoppingCartRepository shoppingCartDao;
	
	@Autowired
	MemberService memberService;

//	@Autowired
//	cumulativeConsumption;
	
	public OrderStatsBean findOrderStatsId(Integer id) {		
		return orderStatsDao.getById(id);		
	}
	
	public List<OrderStatsBean> findAllOrderStats() {
		return orderStatsDao.findAll();
	}
	
	public ProductBean findProductId(Integer id) {		
		return productDao.getById(id);		
	}
	
	public OrderInformationBean findOrderInformation(Integer id) {		
		return orderInformationDao.getById(id);		
	}

	

	public void insertOrderInformation(OrderInformationBean addOrderInformation) {
		orderInformationDao.save(addOrderInformation);
	}
	
	public void insertOrderDetail(OrderDetailBean addOrderDetail) {
		orderDetailDao.save(addOrderDetail);
	}
	
	public void deleteCartByMemberId(int id) {
		shoppingCartDao.deleteCart(id);
	}
	
	public List<OrderInformationBean> getInformationOrderByMemberId(int id) {
		 List<OrderInformationBean> findInformationOrderByMemberId = orderInformationDao.getInformationOrderByMemberId(id);
		return findInformationOrderByMemberId;
	}
	
	public List<OrderDetailBean> getOrderDetailByMemberId(int id) {
		 List<OrderDetailBean> findOrderDetailBymemberId = orderDetailDao.getOrderDetailByMemberId(id);
		return findOrderDetailBymemberId;
	}
	
	public List<OrderDetailBean> getOrderDetailByOrderNumber(int id) {
		 List<OrderDetailBean> findOrderDetailByOrderNumber = orderDetailDao.getOrderDetailByOrderNumber(id);
		return findOrderDetailByOrderNumber;
	}
	
	public List<OrderDetailBean> getBillInformation(int memberID,int orderNumber) {
		 List<OrderDetailBean> findBillInformation = orderDetailDao.getBillInformation(memberID, orderNumber);
		return findBillInformation;
	}
	
	
	public void deleteOrderInformation(Integer orderNumber) {
		orderInformationDao.deleteById(orderNumber);
	}
	
	public void editStats(int orderStats ,int orderNumber) {
		orderInformationDao.editOrderStats(orderStats, orderNumber);
	}
	
	
	public Coupons checkGetByCuponsCod(String code) {
		Coupons codeCheck = couponDao.findCoupon(code);
		
		 if(codeCheck !=null) {
			 return codeCheck;
		 }
		return null;
	
	}
	
	public void addCumulativeConsumption(int memberid,int cumulativeConsumption) {
		
	}
	
	//後臺首頁
	public Page<OrderInformationBean> getOrderInformationAllPage(Integer pagenumber){
		PageRequest findallpage = PageRequest.of(pagenumber-1, 5, Sort.Direction.DESC, "orderNumber");
		return orderInformationDao.findAll(findallpage);
	}
	
	//後臺分頁
	public HashMap<String, Object> getOrderPage(Integer pagenumber){
		Page<OrderInformationBean> page = getOrderInformationAllPage(pagenumber);
		HashMap<String, Object> map = new HashMap<>();
		int totalPages = page.getTotalPages();
		int currentPage = page.getNumber();
		List<OrderInformationBean> list = page.getContent();
		map.put("pages", totalPages);
		map.put("currentPage", currentPage);
		map.put("orders", list);
		return map;
	}
	
	
	public List<OrderInformationBean> getOrderInformationSearch(String search) {
		List<Member> memberList = memberService.queryByNameLikeList(search);
		List<OrderInformationBean> orderlist = new ArrayList<>();
		for(Member member : memberList) {
			int memID = member.getID();
			List<OrderInformationBean> templist = getInformationOrderByMemberId(memID);
			orderlist.addAll(templist);
		}
		return orderlist;
	}

}

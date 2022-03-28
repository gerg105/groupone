package tw.eeit138.groupone.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import tw.eeit138.groupone.dao.CouponRepository;
import tw.eeit138.groupone.dao.ShoppingCartRepository;
import tw.eeit138.groupone.model.CheckShoppingCartBean;
import tw.eeit138.groupone.model.Coupons;
import tw.eeit138.groupone.model.ProductBean;
import tw.eeit138.groupone.model.ShoppingCartBean;

@Service
public class ShoppingCartService {

	@Autowired
	public ShoppingCartRepository dao;

	@Autowired
	CouponRepository couponDao;

	// 改數量
	public void editCart(int cartID, int amount) {
		dao.editAmount(cartID, amount);
	}

	// 新增 (判斷有無加過)
	public void addCart(int memberId, int productId, int amount) {
		List<ShoppingCartBean> dbBean = dao.getRepeatProductId(productId, memberId);
		if (!CollectionUtils.isEmpty(dbBean)) {
			int cartID = dbBean.get(0).getCartID();
			int resultAmount = dbBean.get(0).getAmount() + amount;
			dao.editAmount(cartID, resultAmount);
		} else {
			dao.addCart(memberId, productId, amount);
		}

	}

	// 抓單獨一筆
	public ShoppingCartBean getById(int id) {
		Optional<ShoppingCartBean> findById = dao.findById(id);
		if (findById.isPresent()) {
			return findById.get();
		}
		return null;
	}

	// 根據ID列購物車
	public List<ShoppingCartBean> getByMemberId(int id) {
		List<ShoppingCartBean> findbyMemberID = dao.getByMemberId(id);
		return findbyMemberID;
	}

	// 刪除某筆
	public void delteById(Integer id) {
		dao.deleteById(id);
	}

	// 轉換為有總價的購物車物件
	public List<CheckShoppingCartBean> memberChekShoppingCartList(int userId) {
		List<ShoppingCartBean> shoppingCartList = getByMemberId(userId);
		List<CheckShoppingCartBean> chekShoppingCartList = new ArrayList<>();
		for (ShoppingCartBean shoppingCart : shoppingCartList) {
			int amount = shoppingCart.getAmount();
			int price = shoppingCart.getProduct().getProductPrice();
			int totalPrice = amount * price;
			ProductBean product = shoppingCart.getProduct();

			CheckShoppingCartBean checkShoppingCart = new CheckShoppingCartBean();
			checkShoppingCart.setCartID(shoppingCart.getCartID());
			checkShoppingCart.setProductID(product.getProductID());
			checkShoppingCart.setProductPicUrl(product.getProductPicUrl());
			checkShoppingCart.setProductName(product.getProductName());
			checkShoppingCart.setAmount(amount);
			checkShoppingCart.setProductPrice(price);
			checkShoppingCart.setTotalPrice(totalPrice);
			chekShoppingCartList.add(checkShoppingCart);

		}
		return chekShoppingCartList;
	}

	// 驗證優惠碼
	public Coupons checkGetByCuponsCod(String code) {
		Coupons codeCheck = couponDao.findCoupon(code);
		if (codeCheck != null) {
			return codeCheck;
		}
		return null;

	}

}

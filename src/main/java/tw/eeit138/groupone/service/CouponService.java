package tw.eeit138.groupone.service;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import tw.eeit138.groupone.dao.CouponRepository;
import tw.eeit138.groupone.model.Coupons;

@Service
public class CouponService {

	@Autowired
	private CouponRepository dao;

	public List<Coupons> findAllCoupuns() {
		List<Coupons> coupons = dao.findAll();
		return coupons;
	}

	public Page<Coupons> findByPage(int pageNumber) {
		Pageable pgb = PageRequest.of(pageNumber - 1, 5, Sort.Direction.DESC, "createDate");
		return dao.findAll(pgb);
	}
	
	public HashMap<String, Object> findByNameLikePage(String search,int pageNumber) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Pageable pgb = PageRequest.of(pageNumber - 1, 5, Sort.Direction.DESC, "create_date");
		Page<Coupons> page = dao.findByNameLikePage(search, pgb);
		int totalPages = page.getTotalPages();
		int currentPage = page.getNumber();
		List<Coupons> coupons = page.getContent();
		map.put("pages", totalPages);
		map.put("currentPage", currentPage);
		map.put("coupons", coupons);
		return map;		
	}

	public Coupons findById(int id) {

		Optional<Coupons> op = dao.findById(id);

		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}

	public void insert(Coupons coupon) {
		dao.save(coupon);

	}

	public void delete(int id) {
		dao.deleteById(id);

	}

	public String createCoupon() {

		String abc = "ABCDEFGHJKLMNPQRSTUVWXYZIOabcdefghijklmnopqrstuvwxyz0123456789";
		String code = "";
		String[] ab = abc.split("");

		for (int i = 1; i <= 15; i++) {
			int r = (int) (Math.random() * (62 - 1));
			code += ab[r];
		}
		return code;
	}

//	public List<Coupons> findByCode(@RequestParam String code) {
//
//		return dao.findCoupon(code);
//	}
}

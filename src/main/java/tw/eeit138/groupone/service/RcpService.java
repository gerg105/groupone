package tw.eeit138.groupone.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import tw.eeit138.groupone.dao.MemberRepository;
import tw.eeit138.groupone.dao.RcpRepo;
import tw.eeit138.groupone.dao.RcpTypeRepo;
import tw.eeit138.groupone.dao.ReciFavRecRepo;
import tw.eeit138.groupone.dao.ReciRateRepo;
import tw.eeit138.groupone.model.RcpBean;
import tw.eeit138.groupone.model.RcpTypeBean;
import tw.eeit138.groupone.model.ReciFavRec;
import tw.eeit138.groupone.model.ReciRateBean;

@Service
public class RcpService {
	@Autowired
	private RcpRepo rr;

	@Autowired
	private RcpTypeRepo rtr;

	@Autowired
	private ReciRateRepo reciRateDao;

	@Autowired
	private ReciFavRecRepo rfrr;

	@Autowired
	private MemberRepository memberDao;

	public void insert(RcpBean rcp) {
		rr.save(rcp);
	}

	// 按下後判斷
	public Integer recipeFavRec(ReciFavRec rfr) {
		Integer fid = rfrr.findRate(rfr.getMember().getID(), rfr.getRb().getRid());
		if (fid != null) {
			ReciFavRec fr1 = rfrr.getById(fid);
			rfrr.delete(fr1);
			return fid;
		} else {
			rfrr.save(rfr);
			return 0;
		}
	}

	// 載入時判斷
	public Integer checkReciFavRec(ReciFavRec rfr) {
		Integer fid = rfrr.findRate(rfr.getMember().getID(), rfr.getRb().getRid());
		if (fid != null)
			return fid;
		else
			return 0;
	}
	
	//找Rate
	public void findRate(Integer uid, Integer rid, Integer rate) {
		if (rate != 0) {
			Integer rtid = reciRateDao.findRate(uid, rid);
			if (rtid != null) {
				ReciRateBean ratb = reciRateDao.getById(rtid);
				ratb.setRate(rate);
				reciRateDao.save(ratb);
			} else {
				ReciRateBean rtb = new ReciRateBean();
				rtb.setRate(rate);
				rtb.setRb(rr.getById(rid));
				rtb.setMember(memberDao.getById(uid));
				reciRateDao.save(rtb);
			}
			;
		} else {
			Integer rtid = reciRateDao.findRate(uid, rid);
			ReciRateBean rb = reciRateDao.getById(rtid);
			reciRateDao.delete(rb);
		}
		;
		reciRateDao.updateRate();
	}

	public RcpBean findRcpById(Integer id) {
		Optional<RcpBean> op = rr.findById(id);
		if (op.isPresent())
			return op.get();
		return null;
	}

	public RcpTypeBean findTypeById(Integer id) {
		Optional<RcpTypeBean> op = rtr.findById(id);
		if (op.isPresent())
			return op.get();
		return null;
	}

	public void delete(Integer id) {
		rr.deleteById(id);
	}

	public List<RcpBean> findByType(Integer tid) {
		return rr.findByType(tid);
	}

	public List<RcpBean> findAllRcp() {
		List<RcpBean> rcps = rr.findAll();
		return rcps;
	}

	// 後台(6筆)
	public Page<RcpBean> findByPage(Integer pageNumber) {
		Pageable pgb = PageRequest.of(pageNumber - 1, 6, Sort.Direction.DESC, "added");
		return rr.findAll(pgb);
	}

	// 首頁(4筆)
	public Page<RcpBean> findByPageIndex() {
		Pageable pgb = PageRequest.of(0, 4, Sort.Direction.DESC, "added");
		return rr.findAll(pgb);
	}

	public Page<RcpBean> pageByType(Integer tid, Integer pageNumber) {
		Pageable pgb = PageRequest.of(pageNumber - 1, 6, Sort.Direction.DESC, "added");
		return rr.pageByType(tid, pgb);
	}

	public List<RcpBean> findReciFavRec(Integer uid) {
		List<ReciFavRec> fr = rfrr.uidFav(uid);
		List<RcpBean> rbl = new ArrayList<>();
		for (ReciFavRec f : fr) {
			RcpBean rb = rr.getById(f.getRb().getRid());
			rbl.add(rb);
		}
		return rbl;
	}

	public List<RcpTypeBean> getAllType() {
		return rtr.findAll();
	}

	// 模糊查詢page
	public HashMap<String, Object> recipefindByNamePage(String search, int pageNumber) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Pageable pgb = PageRequest.of(pageNumber - 1, 6, Sort.Direction.DESC, "added");
		Page<RcpBean> page = rr.findByNameLikePage(search, pgb);
		int totalPages = page.getTotalPages();
		int currentPage = page.getNumber();
		List<RcpBean> rcps = page.getContent();
		map.put("pages", totalPages);
		map.put("currentPage", currentPage);
		map.put("rcps", rcps);
		return map;
	}
	
	//查詢有無評分過
	public Integer myRate(Integer rid, Integer uid) {
		  return reciRateDao.myRate(rid, uid);
	}

}
package tw.eeit138.groupone.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import tw.eeit138.groupone.dao.PunchRepository;
import tw.eeit138.groupone.model.PunchBean;

@Service
public class PunchService {
	
	@Autowired
	private PunchRepository punchDao;
	
	
	public PunchBean findById(Integer empId){
		Optional<PunchBean> op = punchDao.findById(empId);
		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}
	
	
	public List<PunchBean> selectAllEmpsPunchDate(){
	List<PunchBean> allPunchBean = punchDao.findAll();
	return allPunchBean;
	}
	
	
	public List<PunchBean> empFindAllPunchData(Integer empId){
	List<PunchBean> empFindAllPunchData = punchDao.empFindAllPunchData(empId);
	return empFindAllPunchData;
	}
	
	public List<PunchBean> empFindAllPunchDataOrderBy(Integer empId){
		List<PunchBean> empFindAllPunchDataOrderBy = punchDao.empFindAllPunchDataOrderBy(empId);
		return empFindAllPunchDataOrderBy;
		}
	
	
	
	//員工打卡
	public PunchBean empPunchDay(Integer empId) {
		Date date = new Date();
		SimpleDateFormat punchYear = new SimpleDateFormat("yyyy");
		SimpleDateFormat punchMonth = new SimpleDateFormat("MM");
		SimpleDateFormat punchDate = new SimpleDateFormat("dd");
		SimpleDateFormat onWorkPunchTime = new SimpleDateFormat("HH:mm:ss");
		SimpleDateFormat offWorkPunchTime = new SimpleDateFormat("HH:mm:ss");
		String onWorkYear = punchYear.format(date);
		String onWorkMonth = punchMonth.format(date);
		String onWorkDate = punchDate.format(date);
		String onWorkTime = onWorkPunchTime.format(date);
		String offWorkTime = offWorkPunchTime.format(date);
		
		System.out.println("onWorkYear+onWorkMonth+onWorkDate:"+onWorkYear+"-"+onWorkMonth+"-"+onWorkDate);
		
		PunchBean punchBean = punchDao.empFindPunchDay(empId,onWorkYear,onWorkMonth,onWorkDate);
		System.out.println("punchBean:"+punchBean);
		if(punchBean == null) {
			PunchBean newPunch = new PunchBean();
			newPunch.setEmpId(empId);
			newPunch.setPunchYear(onWorkYear);
			newPunch.setPunchMonth(onWorkMonth);
			newPunch.setPunchDate(onWorkDate);
			newPunch.setOnWorkTime(onWorkTime);
			PunchBean onWork = punchDao.save(newPunch);
			return onWork;
		}else {
			punchBean.setOffWorkTime(offWorkTime);
			PunchBean offWork = punchDao.save(punchBean);
			return offWork;
		}
	}
	
	
	public List<PunchBean> getEmpPunch(Integer empId,String year,String month){
		List<PunchBean> empPunch = punchDao.getEmpPunchDateLike(empId, year, month);
		return empPunch;
	}
	
	
	//當月遲到次數
	public Integer getEmpPunchLate(Integer empId,String year,String month) {
		Integer count = punchDao.getEmpPunchLate(empId, year, month);
		return count;
	}
	
	//當月準時次數
	public Integer getEmpPunchOnTime(Integer empId,String year,String month) {
		Integer count = punchDao.getEmpPunchOnTime(empId, year, month);
		return count;
	}
	
	public HashMap<String, Object> getSelfPunchDataPage(Integer empId,String year,String month,int pagenumber){
		HashMap<String, Object> map = new HashMap<>();
		Pageable pgb = PageRequest.of(pagenumber - 1, 10, Sort.Direction.DESC, "punchDate");
		Page<PunchBean> page = punchDao.getSelfPunchDataPage(empId, year, month, pgb);
		int totalPages = page.getTotalPages();
		int currentPage = page.getNumber();
		List<PunchBean> punches = page.getContent();
		map.put("pages", totalPages);
		map.put("currentPage", currentPage);
		map.put("punches", punches);
		return map;
	}
	
}

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

import tw.eeit138.groupone.dao.EventRepository;
import tw.eeit138.groupone.model.Events;


@Service
public class EventService {

	@Autowired
	private EventRepository dao;
	
	//所有活動
	public List<Events> findAllEvents(){
		List<Events> events = dao.findAll();
		return events;
	}
	
	//首頁輪播
	public Page<Events> indexEvent(){
		Pageable pgb = PageRequest.of(0, 3, Sort.Direction.DESC, "editDate");
		return dao.findAll(pgb);
	}
	
	//活動分頁
	public Page<Events> findByPage(int pageNumber){
		Pageable pgb = PageRequest.of(pageNumber-1,5,Sort.Direction.DESC, "editDate");
		
		return dao.findAll(pgb);
	}
	
	//單一活動
	public Events findById(int id) {
		Optional<Events> op = dao.findById(id);
		if(op.isPresent()) {
			return op.get();
		}
		return null;
	}
	
	//新增
	public void insert(Events evn) {
		dao.save(evn);
	}
	
	//刪除
	public void deleteEvent(int id) {
		dao.deleteById(id);
	}
	
	// 模糊查詢page(for ajax)
	public HashMap<String, Object> eventFindByTitlePage(String title, int pageNumber) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			Pageable pgb = PageRequest.of(pageNumber - 1, 6, Sort.Direction.DESC, "edit_date");
			Page<Events> page = dao.findByTitleLikePage(title, pgb);
			int totalPages = page.getTotalPages();
			int currentPage = page.getNumber();
			List<Events> events = page.getContent();
			map.put("pages", totalPages);
			map.put("currentPage", currentPage);
			map.put("events", events);
			return map;
		}
}

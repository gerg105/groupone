package tw.eeit138.groupone.controller;

import java.io.File;
import java.util.Date;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import tw.eeit138.groupone.model.Events;
import tw.eeit138.groupone.service.EventService;

@Controller
public class EventController {
	@Autowired
	EventService eventService;
	
	//活動內容
	@GetMapping("/event/{eventId}")
	public ModelAndView findEventById(ModelAndView mav,@PathVariable int eventId) {
		Events event = eventService.findById(eventId);
		mav.getModel().put("event", event);	
		mav.setViewName("event_detail");
		return mav;
	}

	// 新增
	@PostMapping("/admin/addEvent")
	public ModelAndView productInsert(ModelAndView mav, @ModelAttribute(name = "addEvent") Events evn) {
		String st = evn.getStartDate() + "T" + evn.getStartTime();
		String end = evn.getEndDate() + "T" + evn.getEndTime();

		evn.setStartDate(st);
		evn.setEndDate(end);
		eventService.insert(evn);

		if (!evn.getContent().getEventImage().isEmpty()) {
			MultipartFile eventImage = evn.getContent().getEventImage();
			String originalFilename = eventImage.getOriginalFilename();
			String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
			try {
				File file = new File("");
				String path = file.getAbsolutePath();

				path += "\\src\\main\\webapp\\src\\eventImages\\";
				path += evn.getId();
				path += ext;

				File file1 = new File(path);
				eventImage.transferTo(file1);
				String path1 = "eventImages/" + evn.getId() + ext;
				evn.setImagePath(path1);
				eventService.insert(evn);

			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
			}
		}
		mav.setViewName("redirect:/admin/event");
		return mav;
	}

	// 刪除(ajax)
	@ResponseBody
	@DeleteMapping("/admin/deleteEvent/{id}")
	public HashMap<String, Object> deleteEvent(@PathVariable(name = "id") int id) {
		eventService.deleteEvent(id);
		return eventService.eventFindByTitlePage("", 1);

	}

	// 後台查詢單一商品(ajax抓資料for修改)
	@ResponseBody
	@GetMapping("admin/event/getjson")
	public Events eventfindByNme(@RequestParam(name = "id") int id) {
		return eventService.findById(id);
	}
	
	//後臺搜尋(page)
	@ResponseBody
	@GetMapping("admin/event/find")
	public HashMap<String, Object> eventfindByName(@RequestParam(name = "eName") String eName,@RequestParam(value = "p", defaultValue = "1") int pageNumber) {
		HashMap<String, Object> map = eventService.eventFindByTitlePage(eName, pageNumber);
		return map;
	}

	//修改
	@PostMapping("admin/editEvent")
	public ModelAndView postEditEvent(ModelAndView mav, @ModelAttribute(name = "editEvent") Events evn) {
		evn.setEditDate(new Date());

		String st = evn.getStartDate() + "T" + evn.getStartTime();
		String end = evn.getEndDate() + "T" + evn.getEndTime();

		evn.setStartDate(st);
		evn.setEndDate(end);

		eventService.insert(evn);

		if (!evn.getContent().getEventImage().isEmpty()) {
			MultipartFile eventImage = evn.getContent().getEventImage();
			String originalFilename = eventImage.getOriginalFilename();
			String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
			try {
				File file = new File("");
				String path = file.getAbsolutePath();

				path += "\\src\\main\\webapp\\src\\eventImages\\";
				path += evn.getId();
				path += ext;

				File file1 = new File(path);
				eventImage.transferTo(file1);
				String path1 = "eventImages/" + evn.getId() + ext;
				evn.setImagePath(path1);
				eventService.insert(evn);

			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
			}
		}
		mav.setViewName("redirect:/admin/event");
		return mav;
	}

}

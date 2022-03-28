package tw.eeit138.groupone.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import tw.eeit138.groupone.dto.ReciFavRecDto;
import tw.eeit138.groupone.dto.ReciRateDto;
import tw.eeit138.groupone.model.Member;
import tw.eeit138.groupone.model.RcpBean;
import tw.eeit138.groupone.model.RcpTypeBean;
import tw.eeit138.groupone.model.ReciFavRec;
import tw.eeit138.groupone.service.MemberService;
import tw.eeit138.groupone.service.RcpService;

@Controller
public class RecipeController {

	@Autowired
	RcpService rcpService;

	@Autowired
	MemberService memberService;

	// 食譜內容
	@GetMapping("/recipe/{rcpId}")
	public ModelAndView findRcpById(ModelAndView mav, @PathVariable int rcpId, HttpServletRequest request) {
		RcpBean rcp = rcpService.findRcpById(rcpId);
		
		if(rcp == null) { //查無食譜回主頁
			mav.setViewName("redirect:/");
			return mav;
		}
		
		Member member = (Member) request.getSession().getAttribute("user");
		if(member != null) {
			Integer mr = rcpService.myRate(rcpId, member.getID());
			if(mr != null) {
				mav.getModel().put("myRate", mr);
			}else {
				mav.getModel().put("myRate", 0);
			}
			ReciFavRec fr = new ReciFavRec(rcp, member);
			int favId = rcpService.checkReciFavRec(fr);
			mav.getModel().put("favId", favId);
		}else {
			mav.getModel().put("favId", 0);
			mav.getModel().put("myRate", 0);
		}
		mav.getModel().put("rec", rcp);
		mav.setViewName("recipe_detail");
		return mav;
	}

	// 新增
	@PostMapping("/admin/NewRec")
	public ModelAndView newRec(ModelAndView mav, MultipartHttpServletRequest request, @RequestParam("type") int type) {
		RcpBean rb = new RcpBean();
		rb.setTitle(request.getParameter("title"));
		RcpTypeBean rt = rcpService.findTypeById(type);
		rb.setRtp(rt);
		rb.setRtime(Integer.valueOf(request.getParameter("time")));
		rb.setServe(Integer.valueOf(request.getParameter("serve")));
		rb.setIng(request.getParameter("ing"));
		rb.setCon(request.getParameter("con"));
		rb.setVideo(request.getParameter("video"));
		if (!request.getFile("img").isEmpty()) {
			rcpService.insert(rb);
			MultipartFile part = request.getFile("img");
			String filename = part.getOriginalFilename();
			String ext = filename.substring(filename.lastIndexOf("."));
			File f = new File("");
			String path = f.getAbsolutePath() + "\\src\\main\\webapp\\src\\rec-img\\" + rb.getRid() + ext;
			File f1 = new File(path);
			try {
				part.transferTo(f1);
				String path1 = "src/rec-img/" + rb.getRid() + ext;
				rb.setImg(path1);
				rcpService.insert(rb);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else
			rcpService.insert(rb);
		mav.setViewName("redirect:/admin/recipe");
		return mav;
	}

	@PostMapping("/admin/updateRec")
	public ModelAndView editRcp(ModelAndView mav, MultipartHttpServletRequest request, @RequestParam("type") int type)
			throws IOException {
		Integer rid = Integer.valueOf(request.getParameter("rid"));
		RcpBean rb = rcpService.findRcpById(rid);
		rb.setTitle(request.getParameter("title"));
		RcpTypeBean rt = rcpService.findTypeById(type);
		rb.setRtp(rt);
		rb.setRtime(Integer.valueOf(request.getParameter("time")));
		rb.setServe(Integer.valueOf(request.getParameter("serve")));
		rb.setIng(request.getParameter("ing"));
		rb.setCon(request.getParameter("con"));
		rb.setVideo(request.getParameter("video"));
		if (!request.getFile("img").isEmpty()) {
			MultipartFile part = request.getFile("img");
			String filename = part.getOriginalFilename();
			String ext = filename.substring(filename.lastIndexOf("."));
			File f = new File("");
			String path = f.getAbsolutePath() + "\\src\\main\\webapp\\src\\rec-img\\" + rb.getRid() + ext;
			File f1 = new File(path);
			part.transferTo(f1);
			String path1 = "src/rec-img/" + rb.getRid() + ext;
			rb.setImg(path1);
			rcpService.insert(rb);
		} else
			rcpService.insert(rb);
		mav.setViewName("redirect:/admin/recipe");
		return mav;
	}

	// 後台查詢(ajax/page)
	@ResponseBody
	@GetMapping("admin/recipe/find")
	public HashMap<String, Object> recipefindByName(@RequestParam(name = "search") String search,
			@RequestParam(value = "p", defaultValue = "1") int pageNumber) {
		HashMap<String, Object> map = rcpService.recipefindByNamePage(search, pageNumber);
		return map;
	}

	// 後台刪除(ajax/page)
	@ResponseBody
	@DeleteMapping("admin/deleteRecipe/{id}")
	public HashMap<String, Object> recipeDelete(@PathVariable(name = "id") int id) {
//		File f = new File("\\src\\main\\webapp\\" + rcpService.findRcpById(id).getImg());
//		f.delete();
		rcpService.delete(id);
		return rcpService.recipefindByNamePage("", 1);
	}

	// 後台查詢單一商品(ajax抓資料for修改)
	@ResponseBody
	@GetMapping("admin/recipe/getjson")
	public RcpBean recipefindByID(@RequestParam(name = "ID") int ID) {
		return rcpService.findRcpById(ID);
	}

	// 按下收藏鈕
	@ResponseBody
	@PostMapping("recipe/favrec")
	public Integer favRec(@RequestBody ReciFavRecDto fto) {
		ReciFavRec fr = new ReciFavRec(rcpService.findRcpById(fto.getRid()), memberService.queryByID(fto.getUid()));
		return rcpService.recipeFavRec(fr);
	}
	
	@ResponseBody
	@PostMapping("/rate")
	public String rate(@RequestBody ReciRateDto rto){
		rcpService.findRate(rto.getUid(), rto.getRid(), rto.getRate());
		return "success";
	}
}

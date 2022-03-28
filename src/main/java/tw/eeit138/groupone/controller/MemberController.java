package tw.eeit138.groupone.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.security.GeneralSecurityException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import tw.eeit138.groupone.dto.MemberPwdDto;
import tw.eeit138.groupone.model.Member;
import tw.eeit138.groupone.service.CumulativeConsumptionService;
import tw.eeit138.groupone.service.MailService;
import tw.eeit138.groupone.service.MemberService;
import tw.eeit138.groupone.util.EncryptAES;
import tw.eeit138.groupone.util.EncryptSHA256;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	
	@Autowired
	private MailService mail;
	
	@Autowired
	private CumulativeConsumptionService cumulativeConsumptionService;
	
	//後臺修改會員等級
	@PostMapping("admin/updateMember")
	public ModelAndView updateData(ModelAndView mav, @RequestParam("mID_e") int id, @RequestParam("memVIP") int vip,
			@RequestParam("memBlacklist") int list) {
		service.editData(id, vip, list);
		mav.setViewName("redirect:/admin/member");
		return mav;
	}

	//後台取單一資料ajax
	@ResponseBody
	@GetMapping("admin/member/getjson")
	public Member showEditData(@RequestParam("id") int id) {
		return service.queryByID(id);
	}

	//後台模糊查詢
	@ResponseBody
	@GetMapping("admin/member/find")
	public HashMap<String, Object> showEditData(@RequestParam("search") String search,
			@RequestParam(value = "p", defaultValue = "1") int pageNumber) {
		return service.queryByNameLikePage(search, pageNumber);
	}

	//後台刪除
	@ResponseBody
	@DeleteMapping("admin/deleteMember/{id}")
	public HashMap<String, Object> deleteMember(@PathVariable(name = "id") int id) {
		service.deleteMember(id);
		return service.queryByNameLikePage("", 1);
	}

	//前台登入
	@PostMapping("/loginCheck")
	public ModelAndView loginCheck(ModelAndView mav, @RequestParam("memAccount") String account,
			@RequestParam("memPwd") String pwd, HttpServletRequest request, RedirectAttributes redirectAttrs) throws Exception {
		HttpSession session = request.getSession();
		String pwdCode = EncryptSHA256.encryptor(pwd);
		Member user = service.loginCheck(account, pwdCode);
		if (user != null) {
			if(user.getBlacklist().getListID() == 1) {
				String error = "帳號鎖定中，若有疑慮請來信客服";
				redirectAttrs.addFlashAttribute("msg", error);
				mav.setViewName("redirect:/login");
				return mav;
			}else {
				session.setAttribute("user", user);
				cumulativeConsumptionService.getSixMonth(user.getID()); //登入時，若六個月內沒消費清除累計
				mav.setViewName("redirect:/");
				return mav;
			}
			
		} else {
			String error = "登入失敗，請重新輸入";
			redirectAttrs.addFlashAttribute("msg", error);
			mav.setViewName("redirect:/login");
			return mav;
		}
	}
	
	//前台註冊，並寄驗證信
	@PostMapping("/register")
	public ModelAndView regisration(ModelAndView mav, RedirectAttributes redirectAttrs,
									@RequestParam("memName") String name, @RequestParam("memAccount") String account, 
									@RequestParam("memPwd") String pwd,	@RequestParam("memGender") String gender, 
									@RequestParam("memBirth") String birth,	@RequestParam("memTel") String tel,
									@RequestParam("memEmail") String email,	@RequestParam("memPic") Part mPic) throws Exception {
		
		Member mem = new Member();
		mem.setName(name);
		mem.setAccount(account);
		
		String pwdCode = EncryptSHA256.encryptor(pwd);
		mem.setPwd(pwdCode);
		
		mem.setGender(gender);
		mem.setBirth(birth);
		mem.setTel(tel);
		mem.setEmail(email);
		
		int ID = service.getCurrentID() + 1;
		
		File file = new File("");
		String absolutePath = file.getAbsolutePath();
		String fileName = absolutePath + "\\src\\main\\webapp\\src\\memberPic\\icon" + ID + ".jpg";
		String defaultImg = absolutePath + "\\src\\main\\webapp\\src\\memberPic\\icon.jpg";
		
		if (mPic.getSubmittedFileName() != "") {
			try {
				InputStream in = mPic.getInputStream();
				OutputStream out = new FileOutputStream(fileName);
				byte[] pic = new byte[256];
				while (in.read(pic) != -1) {
					out.write(pic);
				}
				in.close();
				out.close();
			}catch(IOException e){
				e.printStackTrace();
			}
			
		} else {
			// 如果沒有上傳照片
			File source = new File(defaultImg);
			File origin = new File(fileName);
			try {
				Files.copy(source.toPath(), origin.toPath());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		String chrome = "memberPic/icon" + ID + ".jpg";
		mem.setPic(chrome); // 放入Member物件中
		service.regBeforeVerify(mem);
		try {
			String code = EncryptAES.encode(String.valueOf(ID)); // 驗證信明文加密
			mail.accountVerification(code, name, email); // 寄送驗證信
		} catch (Exception e) {
			e.printStackTrace();
		}
		String msg = "已寄送會員帳號驗證信，請查看信箱";
		redirectAttrs.addFlashAttribute("msg", msg);
		mav.setViewName("redirect:/login");
		return mav;
	}
	
	//前台修改會員密碼
	@ResponseBody
	@PostMapping("account/changePwd")
	public HashMap<String, Object> changePwd(HttpServletRequest request, @RequestBody MemberPwdDto memberPwdDto) throws Exception {
		
		Member user = (Member) request.getSession().getAttribute("user");
		int id = user.getID();
		String newPwd = memberPwdDto.getNewPwd();
		String realPwd = memberPwdDto.getRecheckPwd();
		
		int errorTimes = 0;
		HashMap<String, Object> errors = new HashMap<String, Object>();
		
		if (newPwd == null || "".equals(newPwd)) {
			errors.put("newPassword", "新密碼不能為空白!");
			errorTimes +=1;
		}

		if (realPwd == null || "".equals(realPwd)) {
			errors.put("newPassword2", "確認新密碼不能為空白!");
			errorTimes +=1;
		}

		if (!newPwd.equals(realPwd)) {
			errors.put("passwordError", "兩次輸入密碼不一致!");
			errorTimes +=1;
		}
		
		errors.put("errorTimes", errorTimes);
		
		if(errorTimes ==0) {
			String realPwdCode = EncryptSHA256.encryptor(realPwd); // 兩密碼相符則新密碼加密
			service.changePwd(id, realPwdCode); //更新
			String name = service.queryByID(id).getName();
			String email = service.queryByID(id).getEmail();
			mail.changePwd(name, email);
			
		}
		
		return errors;
	}
	
	//修改資料
	@PostMapping("account/editUserData")
	public ModelAndView editUserData(ModelAndView mav, @RequestParam("userName") String name,
									@RequestParam("userAccount") String account,
									@RequestParam("userGender") String gender,
									@RequestParam("userBirth") String birth,
									@RequestParam("userTel") String tel,
									@RequestParam("userEmail") String editEmail,
			HttpServletRequest request, RedirectAttributes redirectAttributes){
		
		Member userNow = (Member) request.getSession().getAttribute("user");
		int id = userNow.getID();
		try {
			Part photo = request.getPart("userphoto");
			File file = new File("");
			String absolutePath = file.getAbsolutePath();
			String fileName = absolutePath + "\\src\\main\\webapp\\src\\memberPic\\icon" + id + ".jpg";
			if(photo.getSubmittedFileName() != "") {
				InputStream in = photo.getInputStream();
				OutputStream out = new FileOutputStream(fileName);
				byte[] pic = new byte[256];
				while (in.read(pic) != -1) {
					out.write(pic);
				}
				in.close();
				out.close();
			}
			
			String chrome = "memberPic/icon" + id + ".jpg";
			service.editUserData(id, name, account, gender, birth, tel, chrome, editEmail); //修改
			
			String oldEmail = service.userEmail(id);
			if(!oldEmail.equals(editEmail)) {
				String text = service.emailCode(id, editEmail); // 驗證信明文
				String code = EncryptAES.encode(text); // 明文加密
				mail.emailVerification(code, name, oldEmail, editEmail); // 寄驗證信
				String msg = "已寄送email修改驗證信，請查看信箱";
				redirectAttributes.addFlashAttribute("msg", msg);
			}	
			
			Member user = service.queryByID(id); //修改後抓資料
			request.getSession().setAttribute("user", user);
			System.out.println("Controller -- Edit User Data");
			mav.setViewName("redirect:/account");
			return mav;
		} catch (Exception e) {
			mav.setViewName("redirect:/account");
			return mav;
		} 
		
	}
	
	// 驗證後開通帳號(鎖→無)
	@GetMapping("/verify/account")
	public ModelAndView openAccountVerified(ModelAndView mav,
			@RequestParam("code") String urlcode,
			RedirectAttributes redirectAttributes) {
		try {
			String code = urlcode.replaceAll(" ", "+");
			String decText = EncryptAES.decode(code);
			int id = Integer.parseInt(decText);
			if(service.queryByID(id) != null) {
				service.editData(id, 0, 0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String msg = "會員帳號已開通，請登入";
		redirectAttributes.addFlashAttribute("msg", msg);
		mav.setViewName("redirect:/login");
		System.out.println("Controller -- Open Account Success");
		return mav;
	}
	
//	驗證後修改email
	@GetMapping("/verify/editEmail")
	public ModelAndView editEmailVerified(ModelAndView mav,
										  @RequestParam("code") String urlcode,
										  RedirectAttributes redirectAttributes) {
		try {
			String code = urlcode.replaceAll(" ", "+");
			String decText = EncryptAES.decode(code);
			String[] array = decText.split("\\*");
			int id = Integer.parseInt(array[0]);
			String editEmail = array[2];
			service.editEmail(id, editEmail);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String msg = "您的email已修改，請重新登入";
		redirectAttributes.addFlashAttribute("msg", msg);
		mav.setViewName("redirect:/login");
		System.out.println("Controller -- Edit New Email Success");
		return mav;
	}
	
//	忘記密碼--寄送郵件
	@ResponseBody
	@PostMapping("/forgetPwd")
	public HashMap<String, String> forgetPwdMail(@RequestParam("userEmail") String email) throws Exception {
			Member user = service.getByEmail(email);
			HashMap<String,String> map = new HashMap<>();
			if(user != null) {
				int id = user.getID();
				String tempPwd = service.pwdReplacement();
				String tempPwdcode = EncryptSHA256.encryptor(tempPwd);
				service.tempPwdChange(id, tempPwdcode);
				String text = tempPwd + "*" + email;
				String code = EncryptAES.encode(text);
				mail.forgetPwd(code, email);
				String msg = "已寄送忘記密碼郵件，請查看信箱";
				map.put("stat", "1");
				map.put("result", msg);
				return map;
			}else {
				String msg = "查無此email，請重新輸入";
				map.put("stat", "0");
				map.put("result", msg);
				return map;
			}
	}
	
	// 忘記密碼--登入導向
	@GetMapping("/relogin")
	public ModelAndView relogin(ModelAndView mav,
				@RequestParam("code") String urlcode,
				RedirectAttributes redirectAttributes) {
		try {
			String code = urlcode.replaceAll(" ", "+"); // Base64加密後有+，網址傳輸時會轉成空格，因此要轉換字符
			String decText = EncryptAES.decode(code); // 密文解密
			String[] array = decText.split("\\*");
			String tempPwd = array[0];
			String msg = "已獲取臨時密碼，再次登入後請修改您的密碼";
			redirectAttributes.addFlashAttribute("msg", msg);
			redirectAttributes.addFlashAttribute("tempPwd", tempPwd); // 導回login頁面時
			mav.setViewName("redirect:/login");
			System.out.println("Controller -- Relogin");
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return null;
	}
	

	// Google登入
	@ResponseBody
	@PostMapping("googleLoginCheck")
	public HashMap<String, Object> googleLoginCheck(@RequestParam("token") String token, HttpServletRequest request) throws GeneralSecurityException, IOException {
		HashMap<String, Object> map = new HashMap<>();
		Member user = service.googleLoginCheck(token);
		if(user != null) {
			request.getSession().setAttribute("user", user);
			cumulativeConsumptionService.getSixMonth(user.getID()); //登入時，若六個月內沒消費清除累計
			map.put("stat", "OK");
		}else {
			map.put("stat", "error");
		}
		return map;
	}
	
}

package tw.eeit138.groupone.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import tw.eeit138.groupone.model.DepartmentBean;
import tw.eeit138.groupone.model.EmployeeBean;
import tw.eeit138.groupone.model.StateBean;
import tw.eeit138.groupone.model.TitleBean;
import tw.eeit138.groupone.service.BackendSystemService;
import tw.eeit138.groupone.service.MailService;
import tw.eeit138.groupone.service.PunchService;
import tw.eeit138.groupone.util.QRCodeTool;
import tw.eeit138.groupone.util.SHA256Utils;

@Controller
public class EmployeeController {

	@Autowired
	private BackendSystemService service;

	@Autowired
	private MailService mailService;

	@Autowired
	private PunchService punchService;

	// 登入頁面
	@GetMapping("/adminLogin")
	public String home() {
		return "adminLogin";
	}

	// 忘記密碼
	@GetMapping("/adminForgotPassword")
	public String forgotPasswordPage() {
		return "adminForgotPassword";
	}

	// 登入ajax
	@ResponseBody
	@PostMapping("/api/getEmployee")
	public EmployeeBean getEmployeeApi(@RequestParam(value = "empId") Integer empId,
			@RequestParam(value = "password") String password, HttpSession session) {
		EmployeeBean emp = service.findById(empId);
		if (emp.getId() != null) {
			String salt = "eeit138_" + emp.getBoardDate() + "_07_" + password + emp.getId();
			String pass = SHA256Utils.getSHA256StrJava(salt);
			if (pass.equals(emp.getPassword())) {
				session.setAttribute("admin", emp);
				punchService.empPunchDay(empId); // 打卡
				return emp;
			}
			return new EmployeeBean();
		}
		return new EmployeeBean();
	}

	// 員工忘記密碼
	@PostMapping("/adminForgotPwd")
	public ModelAndView adminForgotPwd(ModelAndView mav, @RequestParam("empEmail") String empEmail,
			HttpSession httpSession, RedirectAttributes redirectAttr) {
		EmployeeBean empBean = service.findByEmail(empEmail);
		if (empBean == null) {
			redirectAttr.addFlashAttribute("errorMsg", empEmail + "不存在!");
			mav.setViewName("redirect:/adminForgotPassword");
		} else {
			try {
				System.out.println("mail前名字:" + empBean.getUsername());
				mailService.sendResetPasswordEmail(empBean, httpSession);
				mav.getModel().put("sendMailMsg", "您的申請提交成功,請查看您的" + empEmail + "信箱");
				mav.setViewName("adminPwdSendMail");
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return mav;
	}

	// 重設密碼連結
	@GetMapping("/adminResetPassword")
	public ModelAndView resetPassword(ModelAndView mav, @RequestParam(value = "empId") Integer empId,
			@RequestParam String idCode) {
		EmployeeBean emp = service.checkIdCode(empId, idCode);

		if (emp.getId() == null) {
			mav.setViewName("redirect:/adminLogin");
		} else {
			mav.getModel().put("emp", emp);
			mav.setViewName("adminResetPassword");
		}

		return mav;
	}

	// 忘記密碼重設頁面送出
	@PostMapping("/adminCheckNewPassword")
	public ModelAndView adminCheckNewPassword(ModelAndView mav, HttpSession httpSession, HttpServletRequest request,
			RedirectAttributes redirectAttributes, @RequestParam Integer empId, @RequestParam String idCode,
			@RequestParam(value = "newPassword") String newPassword, @RequestParam String newPassword2,
			@RequestParam String checkCode) throws WriterException, IOException {
		HashMap<String, String> errors = new HashMap<String, String>();
		if (newPassword == null || "".equals(newPassword)) {
			errors.put("newPassword", "新密碼不能為空白!");
		}

		if (newPassword2 == null || "".equals(newPassword2)) {
			errors.put("newPassword2", "確認新密碼不能為空白!");
		}

		if (!newPassword.equals(newPassword2)) {
			errors.put("passwordError", "兩次輸入密碼不一致!");
		}

		String httpSessionCode = (String) httpSession.getAttribute("sessionCode");
		System.out.println("httpSessionCode:" + httpSessionCode);
		if (!checkCode.equals(httpSessionCode)) {
			errors.put("codeError", "驗證碼錯誤!");
		}

		if (!errors.isEmpty()) {
			redirectAttributes.addFlashAttribute("errors", errors);
			mav.setViewName("redirect:/adminResetPassword?empId=" + empId + "&" + "idCode=" + idCode);
			return mav;
		}

		EmployeeBean empBean = service.findById(empId);

		// 新密碼加鹽寫入資料庫
		String newSalt = "eeit138_" + empBean.getBoardDate() + "_07_" + newPassword2 + empBean.getId();
		String newPassSHA256 = SHA256Utils.getSHA256StrJava(newSalt);
		service.updatePass(empId, newPassSHA256);

		// QR code 內容
		String qrCodeData = "http://localhost:8080/GroupOne/qrpunch?x=" + empId + "&c=" + newPassSHA256;
		System.out.println("qrCodeData:" + qrCodeData);
		// QR code寫入位置
		File file = new File("");
		String filePath = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\EmpImg\\" + empBean.getEmpId() + "\\"
				+ empBean.getEmpId() + "_QR.jpg";
		// 字元編碼
		String charset = "UTF-8"; // "ISO-8859-1"
		Map hintMap = new HashMap();
		hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
		QRCodeTool.createQRCode(qrCodeData, filePath, charset, hintMap, 400, 400);

		EmployeeBean emp = service.findById(empId);
		mav.getModel().put("emp", emp);
		mav.setViewName("adminResetPasswordSuccess");
		return mav;
	}

	// 自己修改基本資料
	@PostMapping("admin/updatePersonalInformation")
	public ModelAndView updatePersonalInformation(ModelAndView mav, HttpServletRequest request,
			@RequestParam(value = "fkDepartmentDeptn") String fkDepartmentDeptno,
			@RequestParam(value = "fkTitleId") String fkTitleId, @RequestParam(value = "contact") String sex,
			@RequestParam(value = "orphoto") String orphoto, @RequestParam(value = "empId") Integer empId,
			@RequestParam(value = "username") String username, @RequestParam(value = "birthday") String birthday,
			@RequestParam(value = "superiorName") String superiorName, @RequestParam(value = "id") String id,
			@RequestParam(value = "phone") String phone, @RequestParam(value = "highEdu") String highEdu,
			@RequestParam(value = "highLevel") String highLevel, @RequestParam(value = "highMajor") String highMajor,
			@RequestParam(value = "emergencyContact") String emergencyContact,
			@RequestParam(value = "contactRelationship") String contactRelationship,
			@RequestParam(value = "contactPhone") String contactPhone, @RequestParam(value = "address") String address,
			@RequestParam(value = "email") String email, @RequestParam(value = "fkStatId") String fkStatId)
			throws IOException, ServletException {
		Part part = request.getPart("photo");
		long dataname = part.getSize();
		String photo = null;
		if (dataname != 0) {
			File file = new File("");
			String path = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\EmpImg\\" + empId + "\\";
			String filename = empId + ".jpg";
			InputStream in = part.getInputStream();
			OutputStream out = new FileOutputStream(path + filename);
			byte[] buf = new byte[256];
			while (in.read(buf) != -1) {
				out.write(buf);
			}
			in.close();
			out.close();
			photo = empId + "\\" + empId + ".jpg";
		} else {
			photo = orphoto;
		}

		EmployeeBean employeeBean = service.updateInformation(empId, photo, username, birthday, fkDepartmentDeptno,
				fkTitleId, sex, superiorName, id, phone, highEdu, highLevel, highMajor, emergencyContact,
				contactRelationship, contactPhone, address, email, fkStatId);

		mav.getModel().put("emp", employeeBean);
		request.getSession().setAttribute("admin", employeeBean);

		mav.setViewName("redirect:/admin/account");
		return mav;
	}

	// 驗證密碼欄位並更新密碼(ajax，後續會登出使用者)
	@ResponseBody
	@PostMapping("admin/changePassword")
	public HashMap<String, Object> changePass(HttpServletRequest request, @RequestParam("newPass") String newPassword,
			@RequestParam("newPass2") String newPassword2, @RequestParam("oldPass") String oldPass)
			throws WriterException, IOException {

		EmployeeBean empBean = (EmployeeBean) request.getSession().getAttribute("admin");
		Integer empId = empBean.getEmpId();

		HashMap<String, Object> errors = new HashMap<String, Object>();

		int errorTime = 0;
		if (newPassword == null || "".equals(newPassword)) {
			errors.put("error", "新密碼不能為空白!");
			errorTime += 1;
		} else {
			errors.put("error", null);
		}

		if (newPassword2 == null || "".equals(newPassword2)) {
			errors.put("newPassword2", "確認新密碼不能為空白!");
			errorTime += 1;
		} else {
			errors.put("newPassword2", null);
		}

		if (!newPassword.equals(newPassword2)) {
			errors.put("passwordError", "兩次輸入密碼不一致!");
			errorTime += 1;
		} else {
			errors.put("passwordError", null);
		}

		String salt = "eeit138_" + empBean.getBoardDate() + "_07_" + oldPass + empBean.getId();
		String oldPassSHA256 = SHA256Utils.getSHA256StrJava(salt);

		if (!oldPassSHA256.equals(empBean.getPassword())) {
			errors.put("oldPassError", "舊密碼錯誤!");
			errorTime += 1;
		} else {
			errors.put("oldPassError", null);
		}

		errors.put("errorTime", errorTime);

		if (errorTime == 0) { // 驗證皆正確
			String newSalt = "eeit138_" + empBean.getBoardDate() + "_07_" + newPassword2 + empBean.getId();
			String newPassSHA256 = SHA256Utils.getSHA256StrJava(newSalt);
			service.updatePass(empId, newPassSHA256);

			// QR code 內容
			String qrCodeData = "http://localhost:8080/GroupOne/qrpunch?x=" + empId + "&c=" + newPassSHA256;

			// QR code寫入位置
			File file = new File("");
			String filePath = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\EmpImg\\" + empBean.getEmpId() + "\\"
					+ empBean.getEmpId() + "_QR.jpg";
			// 字元編碼
			String charset = "UTF-8"; // "ISO-8859-1"
			Map hintMap = new HashMap();
			hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
			QRCodeTool.createQRCode(qrCodeData, filePath, charset, hintMap, 400, 400);
		}

		return errors;
	}

	// 新增員工
	@PostMapping("/admin/addEmp")
	public ModelAndView addEmpInformation(ModelAndView mav, HttpServletRequest request,
			@RequestParam(value = "fkDepartmentDeptn") String fkDepartmentDeptno,
			@RequestParam(value = "fkTitleId") String fkTitleId, @RequestParam(value = "contact") String sex,
			@RequestParam(value = "username") String username, @RequestParam(value = "date") String birthday,
			@RequestParam(value = "superiorName") String superiorName, @RequestParam(value = "id") String id,
			@RequestParam(value = "phone") String phone, @RequestParam(value = "highEdu") String highEdu,
			@RequestParam(value = "highLevel") String highLevel, @RequestParam(value = "highMajor") String highMajor,
			@RequestParam(value = "emergencyContact") String emergencyContact,
			@RequestParam(value = "contactRelationship") String contactRelationship,
			@RequestParam(value = "contactPhone") String contactPhone, @RequestParam(value = "address") String address,
			@RequestParam(value = "email") String email) throws IOException, ServletException, WriterException {
		Date date = new Date();
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		String bDate = ft.format(date);

		EmployeeBean emp = new EmployeeBean();
		DepartmentBean dep = new DepartmentBean();
		TitleBean tit = new TitleBean();
		StateBean stat = new StateBean();

		emp.setUsername(username);
		dep.setDeptno(Integer.valueOf(fkDepartmentDeptno));
		emp.setFkDeptno(dep);
		tit.setTitleId(Integer.valueOf(fkTitleId));
		emp.setFkTitleId(tit);
		emp.setSuperiorName(superiorName);
		emp.setId(id.toUpperCase());

		// 密碼使用SHA256及自己設定的"鹽"來加密
		String salt = "eeit138_" + bDate + "_07_" + id.toUpperCase() + id.toUpperCase();
		String password = SHA256Utils.getSHA256StrJava(salt);

		emp.setPassword(password);
		emp.setSex(sex);

		emp.setBirthday(birthday);
		emp.setPhone(phone);
		emp.setHighEdu(highEdu);
		emp.setHighLevel(highLevel);
		emp.setHighMajor(highMajor);
		emp.setEmail(email);
		emp.setAddress(address);
		emp.setBoardDate(bDate);
		emp.setEmergencyContact(emergencyContact);
		emp.setContactPhone(contactPhone);
		emp.setContactRelationship(contactRelationship);
		stat.setId(1);
		EmployeeBean empInserted = service.addEmpInformation(emp);
		int empId = empInserted.getEmpId();

		File file = new File("");
		String path = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\EmpImg\\" + empId + "\\";
		File folder = new File(path);
		if (!folder.exists()) {
			folder.mkdir(); // create folder
		}
		Part part = request.getPart("photo");
		long dataname = part.getSize();
		String photo = null;
		if (dataname != 0) {
			String path1 = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\EmpImg\\" + empId + "\\";
			String filename = empId + ".jpg";
			InputStream in = part.getInputStream();
			OutputStream out = new FileOutputStream(path1 + filename);
			byte[] buf = new byte[256];
			while (in.read(buf) != -1) {
				out.write(buf);
			}
			in.close();
			out.close();
			photo = empId + "/" + empId + ".jpg";
		} else {
			photo = "Nopic/No-picture.png";
		}

		// QR code 內容
		String qrCodeData = "http://localhost:8080/GroupOne/qrpunch?x=" + empId + "&c=" + password;
		System.out.println("qrCodeData:" + qrCodeData);
		// QR code寫入位置
		String filePath = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\EmpImg\\" + empId + "\\" + empId
				+ "_QR.jpg";
		// 字元編碼
		String charset = "UTF-8"; // "ISO-8859-1"
		Map hintMap = new HashMap();
		hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
		QRCodeTool.createQRCode(qrCodeData, filePath, charset, hintMap, 400, 400);
		// QR code照片路徑寫入資料庫
		String Qrcode = empId + "/" + empId + "_QR.jpg";

		empInserted.setQrcode(Qrcode);
		empInserted.setPhoto(photo);
		service.addEmpInformation(empInserted);

		try {
			mailService.sendAccountOpeningEmail(empInserted);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mav.setViewName("redirect:/admin/employee");

		return mav;
	}

	// 修改員工資訊(管理員)
	@PostMapping("/admin/updateEmp")
	public ModelAndView updateEmpInformation(ModelAndView mav, HttpServletRequest request,
			@RequestParam(value = "fkDepartmentDeptn") String fkDepartmentDeptno,
			@RequestParam(value = "fkTitleId") String fkTitleId, @RequestParam(value = "contact") String sex,
			@RequestParam(value = "orphoto") String orphoto, @RequestParam(value = "empId") Integer empId,
			@RequestParam(value = "username") String username, @RequestParam(value = "birthday") String birthday,
			@RequestParam(value = "superiorName") String superiorName, @RequestParam(value = "id") String id,
			@RequestParam(value = "phone") String phone, @RequestParam(value = "highEdu") String highEdu,
			@RequestParam(value = "highLevel") String highLevel, @RequestParam(value = "highMajor") String highMajor,
			@RequestParam(value = "emergencyContact") String emergencyContact,
			@RequestParam(value = "contactRelationship") String contactRelationship,
			@RequestParam(value = "contactPhone") String contactPhone, @RequestParam(value = "address") String address,
			@RequestParam(value = "email") String email, @RequestParam(value = "fkStateId") String fkStateId)
			throws IOException, ServletException {
		Part part = request.getPart("photo");
		long dataname = part.getSize();
		String photo = null;
		if (dataname != 0) {
			File file = new File("");
			String path = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\EmpImg\\" + empId + "\\";
			String filename = empId + ".jpg";
			InputStream in = part.getInputStream();
			OutputStream out = new FileOutputStream(path + filename);
			byte[] buf = new byte[256];
			while (in.read(buf) != -1) {
				out.write(buf);
			}
			in.close();
			out.close();
			photo = empId + "\\" + empId + ".jpg";
		} else {
			photo = orphoto;
		}

		EmployeeBean employeeBean = service.updateInformation(empId, photo, username, birthday, fkDepartmentDeptno,
				fkTitleId, sex, superiorName, id, phone, highEdu, highLevel, highMajor, emergencyContact,
				contactRelationship, contactPhone, address, email, fkStateId);

		mav.getModel().put("emp", employeeBean);

		mav.setViewName("redirect:/admin/employee");
		return mav;
	}

	// ajax改變主管名稱(修改)
	@ResponseBody
	@GetMapping("/api/getSupervisorEdit")
	public List<EmployeeBean> getSupervisorApiEdit(@RequestParam(value = "empId") Integer empId,
			@RequestParam(value = "departId") String departId, @RequestParam(value = "titleId") int titleId) {

		List<EmployeeBean> superiorNames = service.selectSuperiorNameEdit(empId, departId, titleId + 10);
		System.out.println("superiorNames.size():" + superiorNames.size());
		if (superiorNames.size() == 0) {
			Integer adminEmpId = 1000;
			String adminDepartId = "400";
			int adminTitleId = 40;
			List<EmployeeBean> adminNames = service.selectSuperiorNameEdit(adminEmpId, adminDepartId, adminTitleId);
			return adminNames;
		} else {
			return superiorNames;
		}

	}

	// ajax改變主管名稱(新增)
	@ResponseBody
	@GetMapping("/api/getSupervisorInsert")
	public List<EmployeeBean> getSupervisorApiInsert(@RequestParam(value = "departId") String departId,
			@RequestParam(value = "titleId") int titleId) {

		List<EmployeeBean> superiorNames = service.selectSuperiorNameInsert(departId, titleId + 10);
		System.out.println("superiorNames.size():" + superiorNames.size());
		if (superiorNames.size() == 0) {
			Integer adminEmpId = 1000;
			String adminDepartId = "400";
			int adminTitleId = 40;
			List<EmployeeBean> adminNames = service.selectSuperiorNameEdit(adminEmpId, adminDepartId, adminTitleId);
			return adminNames;
		} else {
			return superiorNames;
		}

	}

	// 員工開通信
	@GetMapping("/adminAccountOpening")
	public ModelAndView accountOpening(ModelAndView mav, @RequestParam(value = "empId") Integer empId,
			@RequestParam String idCode) {
		EmployeeBean emp = service.checkIdCode(empId, idCode);

		if (emp.getId() == null) {
			mav.setViewName("redirect:/adminLogin");
		} else {
			service.updateStateId(empId, "2");
			mav.getModel().put("emp", emp);
			mav.setViewName("adminAccountOpening");
		}

		return mav;
	}

	// 後台查詢(ajax/page)
	@ResponseBody
	@GetMapping("admin/employee/find")
	public HashMap<String, Object> productfindByName(@RequestParam(name = "search") String search,
			@RequestParam(value = "p", defaultValue = "1") int pageNumber) {
		HashMap<String, Object> map = service.employeefindByNamePage(search, pageNumber);
		return map;
	}

	// 後台刪除(ajax)
	@ResponseBody
	@DeleteMapping("admin/deleteEmployee/{id}")
	public HashMap<String, Object> productDelete(@PathVariable(name = "id") int id) {
		service.deleteEmp(id);
		return service.employeefindByNamePage("", 1);
	}

	// 後台查詢單一員工(ajax抓資料for修改)
	@ResponseBody
	@GetMapping("admin/employee/getjson")
	public EmployeeBean employeefindByID(@RequestParam(name = "ID") int ID) {
		return service.findById(ID);
	}

}

package tw.eeit138.groupone.service;

import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import tw.eeit138.groupone.dao.EmployeeRepository;
import tw.eeit138.groupone.model.EmployeeBean;
import tw.eeit138.groupone.model.Member;
import tw.eeit138.groupone.util.SHA256Utils;

@Service
public class MailService {

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	freemarker.template.Configuration freemarkerConfig;

	@Autowired
	private EmployeeRepository empDao;

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CouponService couponService;

	// 管理員帳號
	private static final String FROM = "eeit138g1@gmail.com";

	public void prepareAndSend(String recipient, String message) {
		MimeMessagePreparator messagePreparator = mimeMessage -> {
			MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage);
//             messageHelper.setFrom("wsspeter.sw@gmail.com");
			messageHelper.setTo(recipient);
			messageHelper.setSubject(message + "主旨：Hello J.J.Huang");
			messageHelper.setText(message + "內容：這是一封測試信件，恭喜您成功發送了唷");
		};
		try {
			mailSender.send(messagePreparator);
			// System.out.println("sent");
		} catch (MailException e) {
			// System.out.println(e);
			// runtime exception; compiler will not force you to handle it
		}
	}

	public void sendSimpleMail() throws Exception {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("wsspeter.sw@gmail.com");
		message.setTo("amy99588@gmail.com");
		message.setSubject("主旨：Hello J.J.Huang");
		message.setText("內容：這是一封測試信件，恭喜您成功發送了唷");
		mailSender.send(message);
	}

	private static final String ID_CODE = "idCode";

	// 生成重設密碼連結
	@Transactional
	public String generateResetpwdLink(EmployeeBean emp) {
		Integer empId = emp.getEmpId();
		String idCode = SHA256Utils.generateCheckcode(emp);
		empDao.updateIdCode(empId, idCode);
		return "http://localhost:8080/GroupOne/adminResetPassword?empId=" + emp.getEmpId() + "&" + ID_CODE + "="
				+ idCode;
	}

	// 生成啟用帳號連結(員工)
	@Transactional
	public String accountOpeningLink(EmployeeBean emp) {
		Integer empId = emp.getEmpId();
		String idCode = SHA256Utils.generateCheckcode(emp);
		empDao.updateIdCode(empId, idCode);
		String stateId = "1";
		empDao.updateStateId(empId, stateId);
		return "http://localhost:8080/GroupOne/adminAccountOpening?empId=" + emp.getEmpId() + "&" + ID_CODE + "="
				+ idCode;
	}

	// 生成驗證帳戶的MD5驗證碼
	// 要激活的emp帳戶
	// return將用戶名和密碼組合後,通過md5加密後的16進位制格式的字串
	public static String generateCheckcode(EmployeeBean emp) {
		String username = emp.getUsername();
		String boardDate = emp.getBoardDate();
		StringBuilder str = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < 6; i++) {
			str.append(random.nextInt(10));
		}
		String ran = str.toString();
		return md5(username + ":" + boardDate + ":" + ran);
	}

	// md5編碼
	private static String md5(String string) {
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("md5");
			md.update(string.getBytes());
			byte[] md5Bytes = md.digest();
			return bytes2Hex(md5Bytes);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}

	// md5要使用到編碼方法
	private static String bytes2Hex(byte[] byteArray) {
		StringBuffer strBuf = new StringBuffer();
		for (int i = 0; i < byteArray.length; i++) {
			if (byteArray[i] >= 0 && byteArray[i] < 16) {
				strBuf.append("0");
			}
			strBuf.append(Integer.toHexString(byteArray[i] & 0xFF));
		}
		return strBuf.toString();
	}

	// 隨機產生6位數
	public String randomCode() {
		StringBuilder str = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < 6; i++) {
			str.append(random.nextInt(10));
		}
		return str.toString();
	}

	// 管理員寄送啟用帳號連結給員工
	public void sendAccountOpeningEmail(EmployeeBean emp) throws Exception {

		MimeMessage mimeMessage = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
			helper.setSubject("天食地栗系統：開通帳號");
			helper.setSentDate(new Date());
			helper.setFrom(FROM, "天食地栗 管理員");
			helper.setTo(new InternetAddress(emp.getEmail()));

			// template.html的EL數據
			Map<String, Object> model = new HashMap<String, Object>();
			model.put("empUsername", emp.getUsername());
			model.put("empId", emp.getEmpId());
			model.put("link", accountOpeningLink(emp));
			model.put("imgTitleName", emp.getEmpId());

			// email的HTML內容
			String attachment = FreeMarkerTemplateUtils
					.processTemplateIntoString(freemarkerConfig.getTemplate("accountOpen.html"), model);
			helper.setText(attachment, true);
			// email的HTML內容中的圖片
			File file = new File("");
			String image = file.getAbsolutePath() + "/src/main/webapp/src/webimg/backend/other/logo.png";
			String qrcode = file.getAbsolutePath() + "/src/main/webapp/src/EmpImg/" + emp.getEmpId() + "/"
					+ emp.getEmpId() + "_QR.jpg";
			FileSystemResource img = new FileSystemResource(new File(image));
			FileSystemResource qrcodeImg = new FileSystemResource(new File(qrcode));
			helper.addInline("aaa", img);
			helper.addInline("code", qrcodeImg);
			mailSender.send(mimeMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}

	// 管理員寄送驗證碼及連結給員工
	public void sendResetPasswordEmail(EmployeeBean emp, HttpSession session) throws Exception {

		MimeMessage mimeMessage = mailSender.createMimeMessage();
		// 生成亂數
		String code = SHA256Utils.randomCode();
		session.setAttribute("sessionCode", code);
		try {
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
			helper.setSubject("天食地栗系統：忘記密碼");
			helper.setSentDate(new Date());
			helper.setFrom(FROM, "天食地栗 管理員");
			helper.setTo(new InternetAddress(emp.getEmail()));
			// template.html的EL數據
			Map<String, Object> model = new HashMap<String, Object>();
			model.put("empUsername", emp.getUsername());
			model.put("link", generateResetpwdLink(emp));
			model.put("code", code);
			// email的HTML內容
			String attachment = FreeMarkerTemplateUtils
					.processTemplateIntoString(freemarkerConfig.getTemplate("adminForgotPasswordMail.html"), model);
			helper.setText(attachment, true);
			// email的HTML內容中的圖片
			File file = new File("");
			String image = file.getAbsolutePath() + "/src/main/webapp/src/webimg/backend/other/logo.png";
			FileSystemResource img = new FileSystemResource(new File(image));
			helper.addInline("aaa", img);
			mailSender.send(mimeMessage);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

//	會員開通帳號驗證信
	public void accountVerification(String code, String name, String email) throws Exception {
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
		helper.setFrom(FROM, "天食地栗 管理員");
		helper.setTo(email);
		helper.setSubject("主旨：天食地栗會員帳號驗證信");

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("userName", name);
		model.put("code", code);

		String account = FreeMarkerTemplateUtils
				.processTemplateIntoString(freemarkerConfig.getTemplate("OpenAccountVerification.html"), model);
		helper.setText(account, true);

		File file = new File("");
		FileSystemResource img = new FileSystemResource(
				new File(file.getAbsolutePath() + "/src/main/webapp/src/mailImg/pureskyco.jpg"));
		helper.addInline("pureskyco", img);

		mailSender.send(mimeMessage);
	}

//	會員修改email更新驗證信
	public void emailVerification(String code, String name, String userEmail, String editEmail) throws Exception {
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
		helper.setFrom(FROM, "天食地栗 管理員");
		helper.setTo(editEmail);
		helper.setSubject("主旨：天食地栗會員修改Email驗證信");

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("code", code);
		model.put("userName", name);
		model.put("userEmail", userEmail);
		model.put("editEmail", editEmail);

		String mail = FreeMarkerTemplateUtils
				.processTemplateIntoString(freemarkerConfig.getTemplate("ChangeEmailVerification.html"), model);
		helper.setText(mail, true);

		File file = new File("");
		FileSystemResource img = new FileSystemResource(
				new File(file.getAbsolutePath() + "/src/main/webapp/src/mailImg/pureskyco.jpg"));
		helper.addInline("pureskyco", img);

		mailSender.send(mimeMessage);
	}

//	會員忘記密碼登入信
	public void forgetPwd(String code, String email) throws Exception {
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
		helper.setFrom(FROM, "天食地栗 管理員");
		helper.setTo(email);
		helper.setSubject("主旨：天食地栗會員忘記密碼重新登入信");

		String name = memberService.getByEmail(email).getName();

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("userName", name);
		model.put("code", code);

		String forget = FreeMarkerTemplateUtils
				.processTemplateIntoString(freemarkerConfig.getTemplate("ForgetPwd.html"), model);
		helper.setText(forget, true);

		File file = new File("");
		FileSystemResource img = new FileSystemResource(
				new File(file.getAbsolutePath() + "/src/main/webapp/src/mailImg/pureskyco.jpg"));
		helper.addInline("pureskyco", img);

		mailSender.send(mimeMessage);
	}

	// 會員修改密碼通知信
	public void changePwd(String name, String email) throws Exception {
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
		helper.setFrom(FROM, "天食地栗 管理員");
		helper.setTo(email);
		helper.setSubject("主旨：天食地栗會員密碼修改通知信");

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("userName", name);

		String change = FreeMarkerTemplateUtils
				.processTemplateIntoString(freemarkerConfig.getTemplate("ChangePwd.html"), model);
		helper.setText(change, true);

		File file = new File("");
		FileSystemResource img = new FileSystemResource(
				new File(file.getAbsolutePath() + "/src/main/webapp/src/mailImg/pureskyco.jpg"));
		helper.addInline("pureskyco", img);

		mailSender.send(mimeMessage);
	}
	
//	會員VIP升級通知
	public void sendVipUpgradeEmail(String vipName, int couponId, int memberId) throws Exception {
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
		Member user = memberService.queryByID(memberId);
		helper.setFrom(FROM, "天食地栗 管理員");
		helper.setTo(user.getEmail());
		helper.setSubject("主旨：天食地栗會員VIP升級通知");

		// template.html的EL數據
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("customerName", user.getName());
		model.put("vip", vipName);
		model.put("code", couponService.findById(couponId).getCode());
		model.put("lowest", couponService.findById(couponId).getLowest());
		model.put("discount", couponService.findById(couponId).getDiscount());
		// email的HTML內容
		String attachment = FreeMarkerTemplateUtils
				.processTemplateIntoString(freemarkerConfig.getTemplate("vipUpgradeEmail.html"), model);
		helper.setText(attachment, true);
		// email的HTML內容中的簽名圖片
		File file = new File("");
		String image = file.getAbsolutePath() + "/src/main/webapp/src/mailImg/pureskyco.jpg";
		FileSystemResource img = new FileSystemResource(new File(image));
		helper.addInline("group1", img);

		mailSender.send(mimeMessage);
	}

}

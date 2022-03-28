package tw.eeit138.groupone.service;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;

import tw.eeit138.groupone.dao.BlacklistRepository;
import tw.eeit138.groupone.dao.MemberRepository;
import tw.eeit138.groupone.dao.VipRepository;
import tw.eeit138.groupone.model.Blacklist;
import tw.eeit138.groupone.model.Member;
import tw.eeit138.groupone.model.VIP;

@Service
public class MemberService {

	@Autowired
	private MemberRepository mdao;

	@Autowired
	private BlacklistRepository bdao;

	@Autowired
	private VipRepository vdao;

//	查詢全部會員(page)
	public Page<Member> queryAllMember(int pageNumber) {
		Pageable pgb = PageRequest.of(pageNumber - 1, 6, Sort.Direction.DESC, "ID");
		Page<Member> mems = mdao.findAll(pgb);
		System.out.println("Service -- Get All Member Data!!");
		return mems;
	}

//	查詢單一會員(back)
	public Member queryByID(@RequestParam("memID") int id) {
		Optional<Member> option = mdao.findById(id);
		if (option.isPresent()) {
			System.out.println("Service -- Get One Member By ID!!");
			return option.get();
		}
		return null;
	}

//	修改會員等級(back)
	public void editData(int id, int vip, int list) {
		mdao.editData(id, vip, list);
		System.out.println("Service -- Editing vip and list level!!");
	}

	// 單獨更新VIP
	public void vipUpdateByMemberId(int vip, int id) {
		mdao.editVIP(vip, id);
	}

//  全VIP等級
	public List<VIP> allVIPLevel() {
		return vdao.findAll();
	}

//  全黑名單等級
	public List<Blacklist> allBlackList() {
		return bdao.findAll();
	}

//  模糊查詢(page)
	public HashMap<String, Object> queryByNameLikePage(String search, int pageNumber) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Pageable pgb = PageRequest.of(pageNumber - 1, 6, Sort.Direction.DESC, "m_ID");
		Page<Member> page = mdao.findByNameLikePage(search, pgb);
		int totalPages = page.getTotalPages();
		int currentPage = page.getNumber();
		List<Member> members = page.getContent();
		map.put("pages", totalPages);
		map.put("currentPage", currentPage);
		map.put("members", members);
		return map;
	}

//	模糊查詢(list)
	public List<Member> queryByNameLikeList(String search) {
		return mdao.findByNameLikeList(search);
	}

//	刪除會員(back)
	public void deleteMember(int id) {
		mdao.deleteById(id);
		System.out.println("Service -- Delete Member Complete!!");
	}

//	取得目前DB中最新的ID(front，註冊圖片檔名用)
	public int getCurrentID() {
		return mdao.getCurrentID();
	}

//	會員個人資料(front)
	public Member personalData(int id) {
		Optional<Member> person = mdao.findById(id);
		if (person.isPresent()) {
			return person.get();
		}
		return null;
	}

//	修改會員密碼(front)
	public void changePwd(int id, String pwd) {
		mdao.changePwd(id, pwd);
		System.out.println("Servcie -- Change Pwd");
	}

//	修改會員資料--無email(front)
	public void editUserData(int id, String name, String account, String gender, String birth, String tel, String pic,
			String editEmail) {
		mdao.editUserData(id, name, account, gender, birth, tel, pic, editEmail);
	}

// 新增會員--需要開通驗證(front)
	public void regBeforeVerify(Member user) {
		Optional<Blacklist> optionB = bdao.findById(1);
		Optional<VIP> optionV = vdao.findById(0);
		if (optionB.isPresent() && optionV.isPresent()) {
			Blacklist list = optionB.get();
			VIP vip = optionV.get();
			user.setBlacklist(list);
			user.setVip(vip);
			mdao.save(user);
		}
		System.out.println("Servcie -- Register Complete!!");
	}

// 取得會員原始email
	public String userEmail(int id) {
		return mdao.userEmail(id);
	}

// 會員修改email驗證後更新email
	public void editEmail(int id, String newEmail) {
		mdao.editEmail(id, newEmail);
	}

//	會員登入驗證(SHA256後)
	public Member loginCheck(String account, String pwdcode) {
		Member check = mdao.loginCheck(account, pwdcode);
		System.out.println("Service -- Login Check");
		return check;
	}

//	取得會員註冊日期
	public String userRegDate(int id) {
		System.out.println("Service -- Get User RegDate");
		return mdao.userRegDate(id);
	}

//	忘記密碼--產生臨時密碼
	public String pwdReplacement() {
		int i = 16;
		String AlphaNumeric = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789" + "abcdefghijklmnopqrstuvwxyz";
		StringBuilder builder = new StringBuilder(i);
		for (int p = 0; p < i; p++) {
			int index = (int) (AlphaNumeric.length() * Math.random());
			builder.append(AlphaNumeric.charAt(index));
		}
		String replace = builder.toString();
		System.out.println("Service -- Generate Temporary Pwd");
		return replace;
	}

//	驗證email加密字串
	public String emailCode(int id, String editEmail) {
		String idstr = String.valueOf(id);
		String date = mdao.userRegDate(id).substring(0, 19);
		String text = idstr + "*" + date + "*" + editEmail;
		System.out.println("Service -- Email Verified Text Need Encrypt");
		return text;
	}

//	忘記密碼--由email取得會員資料
	public Member getByEmail(String email) {
		System.out.println("Service -- Get By Email");
		return mdao.getByEmail(email);
	}

//	忘記密碼--臨時密碼更新
	public void tempPwdChange(int id, String tempPwd) {
		mdao.changePwd(id, tempPwd);
		System.out.println("Service -- Change to Temporary Pwd");
	}

//	Google登入_查詢有無資料
	public Member googleLoginCheck(String token) throws GeneralSecurityException, IOException {
		final String oauthClientId = "301620154399-3mr94uqtcdahcjtph799e3c01hdhm0eh.apps.googleusercontent.com";
		NetHttpTransport transport = GoogleNetHttpTransport.newTrustedTransport();
		JsonFactory jsonFactory = GsonFactory.getDefaultInstance();
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
				.setAudience(Collections.singletonList(oauthClientId)).build();
		
		GoogleIdToken idToken = verifier.verify(token);
		
		if (idToken != null) {
			Payload payload = idToken.getPayload();
			String email = payload.getEmail();
			Member user = mdao.getByEmail(email);
			return user;
		} 
		return null;
	}

}

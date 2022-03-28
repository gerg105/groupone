package tw.eeit138.groupone.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import tw.eeit138.groupone.model.Member;

@Repository
public interface MemberRepository extends JpaRepository<Member, Integer> {

//	修改VIP等級與Blacklist等級(back)
	@Transactional
	@Modifying
	@Query(value = "update member set m_VIP = :vip, m_blacklist = :list where m_ID = :id", nativeQuery = true)
	public void editData(@Param("id") int id, @Param("vip") int vip, @Param("list") int list);
	
	//單獨修改VIP等級
	@Transactional
	@Modifying
	@Query(value = "update member set m_VIP = :vip where m_ID = :id", nativeQuery = true)
	public void editVIP(@Param("vip") int vip, @Param("id") int id);
	

//	取得目前DB中最新的ID(front，註冊圖片檔名用)
	@Query(value = "select ident_current ('member') as currentID", nativeQuery = true)
	public int getCurrentID();

	//模糊查詢(page)
	@Query(value = "select * from member where m_name like %:search% or m_tel like %:search% or m_email like %:search%", nativeQuery = true)
	public Page<Member> findByNameLikePage(@Param("search") String search, Pageable pgb);
	
	//模糊查詢(list)
	@Query(value = "select * from member where m_name like %:search% or m_tel like %:search% or m_email like %:search%", nativeQuery = true)
	public List<Member> findByNameLikeList(@Param("search") String search);

//	會員登入驗證(front)
	@Query("from Member m where m.account = :acc and m.pwd = :pwd")
	public Member loginCheck(@Param("acc") String account, @Param("pwd") String pwd);

//	修改會員密碼(front)
	@Transactional
	@Modifying
	@Query("update Member m set m.pwd = :pwd where m.ID = :id")
	public void changePwd(@Param("id") int id, @Param("pwd") String pwd);

	// 修改會員資料--更新editEmail(front)
	@Transactional
	@Modifying
	@Query("update Member m set m.name = :name, m.account = :acc, m.gender = :gender, m.birth = :birth, m.tel = :tel, m.pic = :pic, m.editEmail = :editEmail where m.ID = :id")
	public void editUserData(@Param("id") int id, @Param("name") String name, @Param("acc") String account,
			@Param("gender") String gender, @Param("birth") String birth, @Param("tel") String tel,
			@Param("pic") String pic, @Param("editEmail") String editEmail);
	
	//取得會員原始email
	@Query(value="select m_email from member where m_ID = :id", nativeQuery = true)
	public String userEmail(@Param("id") int id);
	
	//會員修改email驗證後更新email
	@Transactional
	@Modifying
	@Query("update Member m set m.email = :email where m.ID = :id")
	public void editEmail(@Param("id") int id, @Param("email") String email);
	
//	取得會員註冊日期
	@Query(value="select m_regdate from member where m_ID = :id", nativeQuery = true)
	public String userRegDate(@Param("id") int id);
	
//	由email找會員資料 (忘記密碼、google登入)
	@Query("from Member m where m.email = :email")
	public Member getByEmail(@Param("email") String email);
	
//	忘記密碼--寄送郵件時，先更改會員密碼，以方便登入
	@Transactional
	@Modifying
	@Query("update Member m set m.pwd = :pwd where m.ID = :id")
	public void tempPwdChange(@Param("id") int id, @Param("pwd") String pwd);

}

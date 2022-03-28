package tw.eeit138.groupone.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import tw.eeit138.groupone.model.EmployeeBean;

@Repository
public interface EmployeeRepository extends JpaRepository<EmployeeBean, Integer> {

	// 找員工帳號及密碼(登入用)
	@Query(value = "select * from employee where empId=:empId and password=:pass", nativeQuery = true)
	public List<EmployeeBean> login(@Param(value = "empId") Integer empId, @Param(value = "pass") String pass);

	// 找員工Email
	@Query(value = "select * from employee where email=:email", nativeQuery = true)
	public EmployeeBean findByEmail(@Param(value = "email") String email);

	//找員工編號及驗證碼(忘記密碼寄送mail用)
	@Query(value = "select * from employee where empId=:empId and idCode=:idCode",nativeQuery = true)
	public List<EmployeeBean> checkIdCode(@Param(value = "empId") Integer empId, @Param(value = "idCode") String idCode);

	// 找部門編號及職稱編號(下拉式改變部門，主管欄位也會根據不同部門而改變主管名) (修改)
	@Query(value = "select * from employee where empId!=:empId and fkDepartmentDeptno=:departId and fkTitleId=:titleId ", nativeQuery = true)
	public List<EmployeeBean> selectSuperiorNameEdit(@Param(value = "empId") Integer empId,
			@Param(value = "departId") String departId, @Param(value = "titleId") int titleId);

	// 找部門編號及職稱編號(下拉式改變部門，主管欄位也會根據不同部門而改變主管名) (新增)
	@Query(value = "select * from employee where fkDepartmentDeptno=:departId and fkTitleId=:titleId ", nativeQuery = true)
	public List<EmployeeBean> selectSuperiorNameInsert(@Param(value = "departId") String departId,
			@Param(value = "titleId") int titleId);

	// 更新密碼
	@Modifying
	@Query(value = "update employee set password=:newPass where empId=:empId", nativeQuery = true)
	public void updatePass(@Param(value = "empId") Integer empId, @Param(value = "newPass") String newPassword);

	// 啟用帳號時所產生新驗證碼(idCode)，用於更新資料庫狀態碼(fkStateId)欄位，用於寄送mail所需連結內容(?empId=1011&fkStateId=2)
	@Transactional
	@Modifying
	@Query(value = "update employee set fkStateId=:fkStateId where empId=:empId", nativeQuery = true)
	public void updateStateId(@Param(value = "empId") Integer empId, @Param(value = "fkStateId") String fkStateId);

	// 忘記密碼時所產生新驗證碼(idCode)，用於更新資料庫驗證碼(idCode)欄位，用於寄送mail所需連結內容(?empId=1001&idCode=12nuhp3ur2rg24gt870)
	@Transactional
	@Modifying
	@Query(value = "update employee set idCode=:idCode where empId=:empId", nativeQuery = true)
	public void updateIdCode(@Param(value = "empId") Integer empId, @Param(value = "idCode") String idCode);

	// 更新資料
	@Modifying
	@Query(value = "update employee set photo=:photo,birthday=:birthday,username=:username,fkDepartmentDeptno=:deptno,sex=:contact,fkTitleId=:titleId,superiorName=:superiorName,id=:id,phone=:phone,highEdu=:highEdu,highLevel=:highLevel,highMajor=:highMajor,emergencyContact=:emergencyContact,contactRelationship=:contactRelationship,contactPhone=:contactPhone,address=:address,email=:email,fkStateId=:fkStateId where empId=:empId", nativeQuery = true)
	public void updateInformation(@Param(value = "empId") Integer empId, @Param(value = "photo") String photo,
			@Param(value = "username") String username, @Param(value = "birthday") String birthday,
			@Param(value = "deptno") String fkDepartmentDeptno, @Param(value = "titleId") String fkTitleId,
			@Param(value = "contact") String sex, @Param(value = "superiorName") String superiorName,
			@Param(value = "id") String id, @Param(value = "phone") String phone,
			@Param(value = "highEdu") String highEdu, @Param(value = "highLevel") String highLevel,
			@Param(value = "highMajor") String highMajor, @Param(value = "emergencyContact") String emergencyContact,
			@Param(value = "contactRelationship") String contactRelationship,
			@Param(value = "contactPhone") String contactPhone, @Param(value = "address") String address,
			@Param(value = "email") String email, @Param(value = "fkStateId") String fkStateId);

	// 模糊查詢
	@Query(value = "select * from employee where username like %:search% or phone like %:search%  or email like %:search% or empId like %:search%", nativeQuery = true)
	public Page<EmployeeBean> findByNameLikePage(@Param(value = "search") String search, Pageable pgb);

}

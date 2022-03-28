package tw.eeit138.groupone.service;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import tw.eeit138.groupone.dao.DepartmentRepository;
import tw.eeit138.groupone.dao.EmployeeRepository;
import tw.eeit138.groupone.dao.StateRepository;
import tw.eeit138.groupone.dao.TitleBeanRepository;
import tw.eeit138.groupone.model.DepartmentBean;
import tw.eeit138.groupone.model.EmployeeBean;
import tw.eeit138.groupone.model.StateBean;
import tw.eeit138.groupone.model.TitleBean;

@Service
public class BackendSystemService {

	@Autowired
	private EmployeeRepository empDao;

	@Autowired
	private DepartmentRepository depDao;

	@Autowired
	private TitleBeanRepository titDao;

	@Autowired
	private StateRepository statDao;

	// 登入驗證
	public EmployeeBean login(Integer empId, String pass) {
		List<EmployeeBean> employeeBean = empDao.login(empId, pass);
		try {
			if (employeeBean.get(0) != null) {
				return employeeBean.get(0);
			}
		} catch (Exception e) {
			System.out.println("no data!");
		}
		return new EmployeeBean();
	};

	//
	public EmployeeBean findById(Integer empId) {
		Optional<EmployeeBean> op = empDao.findById(empId);

		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}

	// 確認驗證碼，如果沒有找到就回傳空的EmployeeBean
	public EmployeeBean checkIdCode(Integer empId, String idCode) {
		List<EmployeeBean> employeeBean = empDao.checkIdCode(empId, idCode);
		try {
			if (employeeBean.get(0) != null) {
				return employeeBean.get(0);
			}
		} catch (Exception e) {
			System.out.println("no data!");
		}

		return new EmployeeBean();
	}

	// 找部門編號及職稱編號 (修改)
	public List<EmployeeBean> selectSuperiorNameEdit(Integer empId, String departId, int titleId) {
		List<EmployeeBean> superiorName = empDao.selectSuperiorNameEdit(empId, departId, titleId);
		return superiorName;
	}

	// 找部門編號及職稱編號 (新增)
	public List<EmployeeBean> selectSuperiorNameInsert(String departId, int titleId) {
		List<EmployeeBean> superiorName = empDao.selectSuperiorNameInsert(departId, titleId);
		return superiorName;
	}

	// 找資料庫所有員工mail
	public EmployeeBean findEmpEmail(String empEmail) {
		List<EmployeeBean> allEmp = empDao.findAll();
		EmployeeBean empBean = new EmployeeBean();
		for (EmployeeBean employeeBean : allEmp) {
			if (employeeBean.getEmail().equals(empEmail)) {
				empBean.setEmpId(employeeBean.getEmpId());
				empBean.setEmail(empEmail);
				empBean.setUsername(employeeBean.getUsername());
				return empBean;
			}
		}
		return null;
	}

	// 找有無符合的Email(忘記密碼)
	public EmployeeBean findByEmail(String empEmail) {
		return empDao.findByEmail(empEmail);
	}

	// 找所有部門
	public List<DepartmentBean> selectAllDname() {
		List<DepartmentBean> departmentBean = depDao.findAll();
		return departmentBean;
	}

	// 找所有職稱
	public List<TitleBean> selectAllTitName() {
		List<TitleBean> titleBean = titDao.findAll();
		return titleBean;
	}

	// 找所有員工狀態
	public List<StateBean> selectAllStateName() {
		List<StateBean> stateBean = statDao.findAll();
		return stateBean;
	}

	// 找所有員工
	public List<EmployeeBean> selectAllEmployee() {
		List<EmployeeBean> employeeBeans = empDao.findAll();
		return employeeBeans;
	}

	// 修改員工基本資料 (員工跟管理者共同)
	@Transactional
	public EmployeeBean updateInformation(Integer empId, String photo, String username, String birthday,
			String fkDeptno, String fkTitleId, String sex, String superiorName, String id, String phone, String highEdu,
			String highLevel, String highMajor, String emergencyContact, String contactRelationship,
			String contactPhone, String address, String email, String fkStateId) {
		empDao.updateInformation(empId, photo, username, birthday, fkDeptno, fkTitleId, sex, superiorName, id, phone,
				highEdu, highLevel, highMajor, emergencyContact, contactRelationship, contactPhone, address, email,
				fkStateId);
		Optional<EmployeeBean> op = empDao.findById(empId);

		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}

	// 修改密碼
	@Transactional
	public EmployeeBean updatePass(Integer empId, String password) {
		empDao.updatePass(empId, password);
		Optional<EmployeeBean> op = empDao.findById(Integer.valueOf(empId));

		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}

	public void updateStateId(Integer empId, String fkStateId) {
		empDao.updateStateId(empId, fkStateId);
	}

	// 新增員工
	public EmployeeBean addEmpInformation(EmployeeBean emp) {
		return empDao.save(emp);
	}

	// 刪除員工
	public void deleteEmp(Integer empId) {
		empDao.deleteById(empId);
	}

	// 員工(後台分頁)
	public Page<EmployeeBean> findAllByPage(int pageNumber) {
		Pageable pgb = PageRequest.of(pageNumber - 1, 6, Sort.Direction.DESC, "empId");
		return empDao.findAll(pgb);
	}

	// 模糊查詢page
	public HashMap<String, Object> employeefindByNamePage(String search, int pageNumber) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Pageable pgb = PageRequest.of(pageNumber - 1, 6, Sort.Direction.DESC, "empId");
		Page<EmployeeBean> page = empDao.findByNameLikePage(search, pgb);
		int totalPages = page.getTotalPages();
		int currentPage = page.getNumber();
		List<EmployeeBean> employees = page.getContent();
		map.put("pages", totalPages);
		map.put("currentPage", currentPage);
		map.put("employees", employees);
		return map;
	}

}

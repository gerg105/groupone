package tw.eeit138.groupone.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import tw.eeit138.groupone.model.PunchBean;

@Repository
public interface PunchRepository extends JpaRepository<PunchBean, Integer> {

	// 員工找自己的打卡紀錄
	@Query(value = "select * from punch where empId=:empId ORDER BY punchDate", nativeQuery = true)
	public List<PunchBean> empFindAllPunchData(@Param(value = "empId") Integer empId);

	// 員工找當天有無的打卡紀錄
	@Query(value = "select * from punch where empId=:empId and punchYear=:punchYear and punchMonth=:punchMonth and punchDate=:punchDate", nativeQuery = true)
	public PunchBean empFindPunchDay(@Param(value = "empId") Integer empId, String punchYear, String punchMonth,
			String punchDate);

	@Query(value = "select * from punch where empId=:empId ORDER BY punchDate", nativeQuery = true)
	public List<PunchBean> empFindAllPunchDataOrderBy(@Param(value = "empId") Integer empId);

	// 月份
	// SELECT * FROM punch WHERE punchDay BETWEEN '2022/02/01' AND '2022/03/01' and
	// empId='1002' order by punchDay
	// SELECT * FROM punch WHERE punchDay LIKE '2022-02%'and empId='1002' and time1
	// > '09:45:00' order by punchDay
	@Query(value = "select * from punch where punchYear LIKE CONCAT('%',:year,'%') and punchMonth LIKE CONCAT('%',:month,'%') and empId=:empId ORDER BY punchDate DESC", nativeQuery = true)
	public List<PunchBean> getEmpPunchDateLike(@Param(value = "empId") Integer empId,
			@Param(value = "year") String year, @Param(value = "month") String month);

	// SELECT COUNT(punchDate) FROM punch WHERE punchYear LIKE '%2022%'and
	// punchMonth LIKE '%3%' and empId=1002 and onWorkTime <= '09:35:00';
	// 當月遲到次數
	@Query(value = "select COUNT(punchDate) from punch where punchYear LIKE CONCAT('%',:year,'%') and punchMonth LIKE CONCAT('%',:month,'%') and empId=:empId and onWorkTime > '09:35:30'", nativeQuery = true)
	public Integer getEmpPunchLate(@Param(value = "empId") Integer empId, @Param(value = "year") String year,
			@Param(value = "month") String month);

	// 當月準時次數
	@Query(value = "select COUNT(punchDate) from punch where punchYear LIKE CONCAT('%',:year,'%') and punchMonth LIKE CONCAT('%',:month,'%') and empId=:empId and onWorkTime <= '09:35:30'", nativeQuery = true)
	public Integer getEmpPunchOnTime(@Param(value = "empId") Integer empId, @Param(value = "year") String year,
			@Param(value = "month") String month);

	// 月份
	// SELECT * FROM punch WHERE punchDay BETWEEN '2022/02/01' AND '2022/03/01' and
	// empId='1002' order by punchDay
	// SELECT * FROM punch WHERE punchDay LIKE '2022-02%'and empId='1002' and time1
	// > '09:45:00' order by punchDay
	@Query(value = "select * from punch where punchYear LIKE CONCAT('%',:year,'%') and punchMonth LIKE CONCAT('%',:month,'%') and empId=:empId", nativeQuery = true)
	public Page<PunchBean> getSelfPunchDataPage(@Param(value = "empId") Integer empId,
			@Param(value = "year") String year, @Param(value = "month") String month, Pageable pgb);
}

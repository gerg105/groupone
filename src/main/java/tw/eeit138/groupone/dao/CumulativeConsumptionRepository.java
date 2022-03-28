package tw.eeit138.groupone.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import tw.eeit138.groupone.model.CumulativeConsumptionBean;

public interface CumulativeConsumptionRepository extends JpaRepository<CumulativeConsumptionBean, Integer> {

//用	MemberId找累積消費紀錄(判斷是否曾經有消費紀錄,有的話做累加)
@Query(value="SELECT * FROM cumulativeConsumption WHERE  memberID=:memberID", nativeQuery = true)
public List <CumulativeConsumptionBean> getByMemberId(@Param("memberID") int memberId);

//用	MemberId找累積消費金額
@Query(value="SELECT cumulativeConsumption FROM cumulativeConsumption WHERE memberID=:memberID", nativeQuery = true)
public int getCumulativeByMemberId(@Param("memberID") int memberID);

//用	MemberId找累積消費紀錄
@Query(value="SELECT * FROM cumulativeConsumption WHERE memberID=:memberID", nativeQuery = true)
public CumulativeConsumptionBean getCumulativeDataByMemberId(@Param("memberID") int memberID);

//變更累積消費
@Transactional
@Modifying
@Query(value = "UPDATE cumulativeConsumption SET consumptionDate=GETDATE() ,cumulativeConsumption = :cumulativeConsumption WHERE memberID = :memberID", nativeQuery = true)
public void updateCumulativeConsumptionDate(@Param("cumulativeConsumption") int cumulativeConsumption ,@Param("memberID") int memberID);

//是否超過6個月
@Query(value="select * from cumulativeConsumption where memberID=:id and DateDiff(dd,consumptionDate,getdate())>=180", nativeQuery = true)
public CumulativeConsumptionBean getSixMonth(@Param("id") int id);

//變更累積消費為0,byId
@Transactional
@Modifying
@Query(value = "UPDATE cumulativeConsumption SET cumulativeConsumption = :cumulativeConsumption WHERE ID = :ID", nativeQuery = true)
public void editCumulativeConsumptionById(@Param("cumulativeConsumption") int cumulativeConsumption ,@Param("ID") int id);


}

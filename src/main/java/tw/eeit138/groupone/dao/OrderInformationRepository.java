package tw.eeit138.groupone.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import tw.eeit138.groupone.model.OrderInformationBean;

@Repository
public interface OrderInformationRepository extends JpaRepository<OrderInformationBean, Integer> {

	//根據ID找所有訂單
	@Query(value = "SELECT * FROM orderInformation WHERE memberID = :memberID order by orderDate DESC", nativeQuery = true)
	public List<OrderInformationBean> getInformationOrderByMemberId(@Param("memberID") int memberId);

	//刪除 (應可原生?)
//	@Transactional
//	@Modifying
//	@Query(value = "delete from orderDetail where orderNumber = :orderNumber", nativeQuery = true)
//	public void deleteorderDetail(@Param("orderNumber") int orderNumber);
	
	//更新出貨狀態
	@Transactional
	@Modifying
	@Query(value = "UPDATE orderInformation set orderStats = :orderStats where orderNumber = :orderNumber", nativeQuery = true)
	public void editOrderStats(@Param("orderStats") int orderStats,@Param("orderNumber") int orderNumber);

}

package tw.eeit138.groupone.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import tw.eeit138.groupone.model.OrderDetailBean;

public interface OrderDetailBeanRepository extends JpaRepository<OrderDetailBean, Integer> {

	//根據memID找所有明細
	@Query(value = "SELECT * FROM orderdetail WHERE memberID = :memberID", nativeQuery = true)
	public List<OrderDetailBean> getOrderDetailByMemberId(@Param("memberID") int memberId);

	//根據order找所有明細
	@Query(value = "SELECT * FROM orderdetail WHERE orderNumber = :orderNumber", nativeQuery = true)
	public List<OrderDetailBean> getOrderDetailByOrderNumber(@Param("orderNumber") int orderNumber);

	//根據memID跟order (測試)
	@Query(value = "SELECT * FROM orderdetail WHERE memberID = :memberID AND orderNumber = :orderNumber;", nativeQuery = true)
	public List<OrderDetailBean> getBillInformation(@Param("memberID") int memberID,
			@Param("orderNumber") int orderNumber);
}

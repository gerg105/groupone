package tw.eeit138.groupone.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import tw.eeit138.groupone.model.ShoppingCartBean;
@Repository
public interface ShoppingCartRepository extends JpaRepository<ShoppingCartBean, Integer> {

    
	//根據ID找所有購物車資料
	@Query(value = "SELECT* from shoppingCart where memberID = :memberID", nativeQuery = true)
	public List <ShoppingCartBean> getByMemberId(@Param("memberID") int memberId ); 
	
	//確認有無重複
	@Query(value = "SELECT* from shoppingCart where productID = :productID AND memberID = :memberID", nativeQuery = true)
	public List <ShoppingCartBean> getRepeatProductId(@Param("productID") int productId ,@Param("memberID") int memberId ); 
	
//	@Transactional
//	@Modifying
//	@Query(value = "UPDATE shoppingCart set amount = :amount where productID = :productID AND memberID = :memberID", nativeQuery = true)
//	public void updateAmount(@Param("amount") int amount ,@Param("productID") int productId ,@Param("memberID") int memberId);
		
	//更新數量
	@Transactional
	@Modifying
	@Query(value = "UPDATE shoppingCart set amount = :amount where cartID = :cartID", nativeQuery = true)
	public void editAmount(@Param("cartID") int cartId, @Param("amount") int amount);
	
	
	//新增
	@Transactional
	@Modifying
	@Query(value = "INSERT INTO shoppingCart(memberID,productID,amount)VALUES(:memberID,:productID,:amount)", nativeQuery = true)
	public void addCart(@Param("memberID") int memberId, @Param("productID") int productId,@Param("amount") int amount);
	
	//刪除
	@Transactional
	@Modifying
	@Query(value = "DELETE from shoppingCart WHERE memberID = :memberID", nativeQuery = true)
	public void deleteCart(@Param("memberID") int memberId);
	
}
 

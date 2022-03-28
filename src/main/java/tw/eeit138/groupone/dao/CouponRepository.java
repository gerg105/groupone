package tw.eeit138.groupone.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import tw.eeit138.groupone.model.Coupons;

@Repository
public interface CouponRepository extends JpaRepository<Coupons, Integer> {
	
	@Query("from Coupons where code = :code")
	public Coupons findCoupon(@Param(value = "code")String code);
		
	@Query(value = "SELECT  event_class FROM coupon ",nativeQuery = true)	
	public List<String> findClass();
	
	@Query(value="from Coupons c where c.type = :type")
	public List<Coupons> findCouponByClass(@Param(value = "type")String type);
	
	@Query(value = "select * from coupon where code like %:search% or event_class like %:search%" , nativeQuery = true)
	public Page<Coupons> findByNameLikePage(@Param("search") String search, Pageable pgb);
}

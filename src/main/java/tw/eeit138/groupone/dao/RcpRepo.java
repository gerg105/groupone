package tw.eeit138.groupone.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import tw.eeit138.groupone.model.RcpBean;

@Repository
public interface RcpRepo extends JpaRepository<RcpBean, Integer> {

	// 所有Type
	@Query(value = "Select * from reci WHERE rtype_id = :tid", nativeQuery = true)
	public List<RcpBean> findByType(@Param(value = "tid") Integer tid);

	// 依據Type分頁
	@Query(value = "Select * from reci WHERE rtype_id = :tid", nativeQuery = true)
	Page<RcpBean> pageByType(@Param(value = "tid") Integer tid, Pageable pgb);

	//後台模糊查詢(page)
	@Query(value = "select * from reci where title like %:search%", nativeQuery = true)
	public Page<RcpBean> findByNameLikePage(@Param("search") String search, Pageable pgb);

}
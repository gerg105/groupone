package tw.eeit138.groupone.dao;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import tw.eeit138.groupone.model.ReciRateBean;

@Repository
public interface ReciRateRepo extends JpaRepository<ReciRateBean, Integer> {
	@Query(value = "SELECT rateid FROM rate WHERE userid = :uid AND rid = :rid", nativeQuery = true)
	public Integer findRate(@Param(value = "uid") Integer uid, @Param(value = "rid") Integer rid);

	// 更新平均
	@Transactional
	@Modifying
	@Query(value = "with feedback_grouped AS(SELECT rt.rid, " + "ROUND(AVG(CAST(rt.rate AS DECIMAL(3,2))), 2) "
			+ "AS avg_rating FROM rate rt GROUP BY rt.rid) " + "UPDATE reci SET rates = avg_rating FROM reci r "
			+ "INNER JOIN feedback_grouped ON " + "r.rid = feedback_grouped.rid", nativeQuery = true)
	public void updateRate();

	//查詢有無評分過
	@Query(value = "SELECT rate FROM rate WHERE rid = :rid AND userid " + "= :uid", nativeQuery = true)
	public Integer myRate(@Param(value = "rid") Integer rid, @Param(value = "uid") Integer uid);
}
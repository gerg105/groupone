package tw.eeit138.groupone.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import tw.eeit138.groupone.model.ProductFavRec;

@Repository
public interface ProductFavRecRepo extends JpaRepository<ProductFavRec, Integer> {
	@Query(value = "SELECT * FROM product_favrec WHERE userid = :uid order by favpid desc", nativeQuery = true)
	List<ProductFavRec> uidFav(@Param(value = "uid") Integer uid);

	@Query(value = "SELECT favpid FROM product_favrec WHERE userid = :uid " + "AND pid = :pid", nativeQuery = true)
	public Integer findRate(@Param(value = "uid") Integer uid, @Param(value = "pid") Integer pid);
}
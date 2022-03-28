package tw.eeit138.groupone.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import tw.eeit138.groupone.model.ReciFavRec;

@Repository
public interface ReciFavRecRepo extends JpaRepository<ReciFavRec, Integer> {
	@Query(value = "SELECT * FROM reci_favrec WHERE userid = :uid order by favrid desc", nativeQuery = true)
	List<ReciFavRec> uidFav(@Param(value = "uid") Integer uid);

	@Query(value = "SELECT favrid FROM reci_favrec WHERE userid = :uid " + "AND rid = :rid", nativeQuery = true)
	public Integer findRate(@Param(value = "uid") Integer uid, @Param(value = "rid") Integer rid);
}
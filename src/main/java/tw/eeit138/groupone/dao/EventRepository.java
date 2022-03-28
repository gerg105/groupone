package tw.eeit138.groupone.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import tw.eeit138.groupone.model.Events;

@Repository
public interface EventRepository extends JpaRepository<Events, Integer> {
	// 後台模糊查詢(page)
		@Query(value = "select * from events where title like %:title%", nativeQuery = true)
		public Page<Events> findByTitleLikePage(@Param("title") String title, Pageable pgb);
}

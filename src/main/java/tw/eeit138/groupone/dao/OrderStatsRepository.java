package tw.eeit138.groupone.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import tw.eeit138.groupone.model.OrderStatsBean;

public interface OrderStatsRepository extends JpaRepository<OrderStatsBean, Integer> {

}

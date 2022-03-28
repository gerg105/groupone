package tw.eeit138.groupone.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import tw.eeit138.groupone.model.StateBean;

public interface StateRepository extends JpaRepository<StateBean, Integer> {

}

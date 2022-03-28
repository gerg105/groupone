package tw.eeit138.groupone.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import tw.eeit138.groupone.model.Blacklist;

public interface BlacklistRepository extends JpaRepository<Blacklist, Integer> {

}

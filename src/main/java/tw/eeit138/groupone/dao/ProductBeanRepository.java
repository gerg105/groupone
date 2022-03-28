package tw.eeit138.groupone.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import tw.eeit138.groupone.model.ProductBean;

@Repository
public interface ProductBeanRepository extends JpaRepository<ProductBean, Integer> {

	// 前台所有商品(分頁)
	@Query(value = "select * from product WHERE productAvailable=1", nativeQuery = true)
	public Page<ProductBean> findAllAvailable(Pageable pgb);

	// 前台商品(分頁、類別查詢)
	@Query(value = "select * from product WHERE productAvailable=1 and productType=:pType", nativeQuery = true)
	public Page<ProductBean> findAvailableByType(@Param("pType") int pType, Pageable pgb);

	// 更新
	@Transactional
	@Modifying
	@Query(value = "update product set productName=:pName, productPrice=:pPrice, "
			+ "productSpecs=:pSpecs, productDescription=:pDes, productType=:pType, "
			+ "productCountry=:pCountry, productAvailable=:pAvailable, "
			+ "lastModifiedTime=:strDate where productID=:pID", nativeQuery = true)
	public void updateProduct(@Param("pName") String pName, @Param("pPrice") int pPrice, @Param("pSpecs") String pSpecs,
			@Param("pDes") String pDes, @Param("pType") int pType, @Param("pCountry") int pCountry,
			@Param("pAvailable") String pAvailable, @Param("strDate") String strDate, @Param("pID") int pID);

	// 新增資料時的更新圖片
	@Transactional
	@Modifying
	@Query(value = "update ProductBean set productPicUrl=:pPicUrl WHERE productID=:pID")
	public void updatePic(@Param("pPicUrl") String pPicUrl, @Param("pID") int pID);

	// 後台模糊查詢
	@Query(value = "select * from product where productName like %:pName% order by lastModifiedTime DESC", nativeQuery = true)
	public List<ProductBean> findByNameLike(@Param("pName") String pName);

	// 後台模糊查詢(page)
	@Query(value = "select * from product where productName like %:pName%", nativeQuery = true)
	public Page<ProductBean> findByNameLikePage(@Param("pName") String pName, Pageable pgb);

	// 前台同類商品推薦
	@Query(value = "select top (4)  * from product where productType = :pType  and productAvailable = 1  and productID != :pID order by NEWID()", nativeQuery = true)
	public List<ProductBean> suggestProduct(@Param("pType") int pType, @Param("pID") int pID);

}

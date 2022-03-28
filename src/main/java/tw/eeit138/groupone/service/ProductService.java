package tw.eeit138.groupone.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import tw.eeit138.groupone.dao.ProductBeanRepository;
import tw.eeit138.groupone.dao.ProductCountryBeanRepository;
import tw.eeit138.groupone.dao.ProductFavRecRepo;
import tw.eeit138.groupone.dao.ProductTypeBeanRepository;
import tw.eeit138.groupone.model.ProductBean;
import tw.eeit138.groupone.model.ProductCountryBean;
import tw.eeit138.groupone.model.ProductFavRec;
import tw.eeit138.groupone.model.ProductTypeBean;

@Service
public class ProductService {
	@Autowired
	ProductBeanRepository productDao;

	@Autowired
	ProductCountryBeanRepository productCountryDao;

	@Autowired
	ProductTypeBeanRepository productTypeDao;

	@Autowired
	ProductFavRecRepo productFavDao;

	// 全商品
	public List<ProductBean> findAllProduct() {
		return productDao.findAll(Sort.by(Sort.Direction.DESC, "lastModifiedTime"));
	}

	// 新增商品
	public void insertProduct(String pName, int pPrice, String pSpecs, int pType, int pCountry,
			String pAvailable, String pDes, Part part) {
		ProductBean product = new ProductBean();
		product.setProductName(pName);
		product.setProductPrice(pPrice);
		product.setProductSpecs(pSpecs);

		Optional<ProductTypeBean> opType = productTypeDao.findById(pType);
		ProductTypeBean pTypeBean = opType.get();
		product.setProductType(pTypeBean);

		Optional<ProductCountryBean> opCountry = productCountryDao.findById(pCountry);
		ProductCountryBean pCountryBean = opCountry.get();
		product.setProductCountry(pCountryBean);

		product.setProductAvailable(pAvailable);

		product.setProductDes(pDes);

		// 建立時間
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		Date date = new Date();
		String createdTime = sdFormat.format(date);

		product.setLastModifiedTime(createdTime);
		product.setProductCreateTime(createdTime);

		ProductBean productInserted = productDao.save(product);
		int id = productInserted.getProductID();

		try {
			File file = new File("");
			String absolutePath = file.getAbsolutePath();
			String path = absolutePath + "\\src\\main\\webapp\\src\\productimg\\" + id + "\\";
			File folder = new File(path);
			if (!folder.exists()) {
				folder.mkdir(); // create folder
			}
			String filename = "main.jpg";

			if (part.getSubmittedFileName() != "") {
				InputStream in = part.getInputStream();
				OutputStream out = new FileOutputStream(path + filename);
				byte[] buf = new byte[256];
				while (in.read(buf) != -1)
					out.write(buf);
				out.close();
				in.close();

			} else { // if no image
				File source = new File(absolutePath + "\\src\\main\\webapp\\src\\productimg\\default\\not-upload.jpg");
				File dest = new File(path + filename);
				try {
					Files.copy(source.toPath(), dest.toPath());
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		} catch (Exception e) {
		}
		String picUrl = "src/productimg/" + id + "/main.jpg";
		productDao.updatePic(picUrl, id);
	}

	// 修改商品
	public void updateProduct(String pName, int pPrice, String pSpecs, String pDes, int pType, int pCountry,
			String pAvailable, int pID, Part part) {

		try {
			File file = new File("");
			String absolutePath = file.getAbsolutePath();
			String path = absolutePath + "\\src\\main\\webapp\\src\\productimg\\" + pID + "\\";
			String filename = "main.jpg";
			// 有無上傳圖檔判斷是否寫入
			if (part.getSubmittedFileName() != "") {
				InputStream in = part.getInputStream();
				OutputStream out = new FileOutputStream(path + filename);
				byte[] buf = new byte[256];
				while (in.read(buf) != -1)
					out.write(buf);
				out.close();
				in.close();
			}
		} catch (Exception e) {

		}
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		Date date = new Date();
		String strDate = sdFormat.format(date);
		productDao.updateProduct(pName, pPrice, pSpecs, pDes, pType, pCountry, pAvailable, strDate, pID);
	}

	// 刪除商品
	public void deleteProduct(int id) {
		productDao.deleteById(id);
	}

	// 單一商品
	public ProductBean findById(int id) {
		Optional<ProductBean> op = productDao.findById(id);
		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}

	// 同類商品推薦
	public List<ProductBean> suggestProducts(int pType, int pID) {
		return productDao.suggestProduct(pType, pID);
	}

	// 全商品(前台分頁)
	public Page<ProductBean> findByPage(int pageNumber, int pType) {
		Pageable pgb = PageRequest.of(pageNumber - 1, 8, Sort.Direction.DESC, "productCreateTime");
		if (pType == 0) {
			return productDao.findAllAvailable(pgb);
		} else {
			return productDao.findAvailableByType(pType, pgb);
		}

	}

	// 商品(首頁前8筆)
	public Page<ProductBean> indexProduct() {
		Pageable pgb = PageRequest.of(0, 8, Sort.Direction.DESC, "productCreateTime");
		return productDao.findAllAvailable(pgb);
	}

	// 商品(後台分頁)
	public Page<ProductBean> findAllByPage(int pageNumber) {
		Pageable pgb = PageRequest.of(pageNumber - 1, 6, Sort.Direction.DESC, "lastModifiedTime");
		return productDao.findAll(pgb);
	}

	// 模糊查詢page
	public HashMap<String, Object> productfindByNamePage(String pName, int pageNumber) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Pageable pgb = PageRequest.of(pageNumber - 1, 6, Sort.Direction.DESC, "lastModifiedTime");
		Page<ProductBean> page = productDao.findByNameLikePage(pName, pgb);
		int totalPages = page.getTotalPages();
		int currentPage = page.getNumber();
		List<ProductBean> products = page.getContent();
		map.put("pages", totalPages);
		map.put("currentPage", currentPage);
		map.put("products", products);
		return map;
	}

	// 商品(種類)
	public List<ProductTypeBean> findAllType() {
		return productTypeDao.findAll();
	}

	// 商品(產地)
	public List<ProductCountryBean> findAllCountry() {
		return productCountryDao.findAll();
	}

	// 按下後判斷收藏
	public Integer productFavRec(ProductFavRec productFav) {
		Integer fid = productFavDao.findRate(productFav.getMember().getID(), productFav.getProduct().getProductID());
		if (fid != null) {
			ProductFavRec fr1 = productFavDao.getById(fid);
			productFavDao.delete(fr1);
			return fid;
		} else {
			productFavDao.save(productFav);
			return 0;
		}
	}

	//載入時判斷收藏
	public Integer checkReciFavRec(ProductFavRec productFav) {
		Integer fid = productFavDao.findRate(productFav.getMember().getID(), productFav.getProduct().getProductID());
		if(fid != null) 
			return fid;
		else 
			return 0;
	}
	//
	public List<ProductBean> findProductFavRec(Integer uid) {
		List<ProductFavRec> fr = productFavDao.uidFav(uid);
		List<ProductBean> favs = new ArrayList<>();
		for (ProductFavRec p : fr) {
			ProductBean favP = productDao.getById(p.getProduct().getProductID());
			favs.add(favP);
		}
		return favs;
	}
	
	
}

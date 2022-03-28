package tw.eeit138.groupone.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import tw.eeit138.groupone.dto.ProductFavRecDto;
import tw.eeit138.groupone.model.Member;
import tw.eeit138.groupone.model.ProductBean;
import tw.eeit138.groupone.model.ProductFavRec;
import tw.eeit138.groupone.service.MemberService;
import tw.eeit138.groupone.service.ProductService;

@Controller
public class ProductController {

	@Autowired
	ProductService productService;

	@Autowired
	MemberService memberService;

	// 前台顯示單筆商品
	@GetMapping("/product/{pID}")
	public ModelAndView home(ModelAndView mav, @PathVariable int pID,HttpServletRequest request) {
		ProductBean product = productService.findById(pID);

		if (product == null) { // 除錯重導向首頁
			mav.setViewName("redirect:/");
			return mav;
		}
		Member member = (Member) request.getSession().getAttribute("user");
		if(member != null) {
			ProductFavRec fr = new ProductFavRec(product,member);
			int favId = productService.checkReciFavRec(fr);
			mav.getModel().put("favId", favId);
		}else {
			mav.getModel().put("favId", 0);
		}
		int pType = product.getProductType().getTypeNo();
		List<ProductBean> suggestProducts = productService.suggestProducts(pType, pID);
		mav.getModel().put("product", product);
		mav.getModel().put("suggestProducts", suggestProducts);
		mav.setViewName("product_detail");
		return mav;
	}

	// 新增
	@PostMapping("/admin/insertProduct")
	public ModelAndView productInsert(ModelAndView mav, @RequestParam(name = "pName") String pName,
			@RequestParam(name = "pPrice") int pPrice, @RequestParam(name = "pSpecs") String pSpecs,
			@RequestParam(name = "pType") int pType, @RequestParam(name = "pCountry") int pCountry, 
			@RequestParam(name = "pAvailable") String pAvailable, @RequestParam(name = "pDes") String pDes, @RequestParam(name = "pPic") Part part) {
		productService.insertProduct(pName, pPrice, pSpecs, pType, pCountry, pAvailable, pDes, part);
		mav.setViewName("redirect:/admin/product");
		return mav;
	}

	// 後台刪除(ajax)
	@ResponseBody
	@DeleteMapping("admin/deleteProduct/{pid}")
	public HashMap<String, Object> productDelete(@PathVariable(name = "pid") int id) {
		productService.deleteProduct(id);
		return productService.productfindByNamePage("", 1);
	}

	// 後台查詢(ajax/page)
	@ResponseBody
	@GetMapping("admin/product/find")
	public HashMap<String, Object> productfindByName(@RequestParam(name = "pName") String pName,
			@RequestParam(value = "p", defaultValue = "1") int pageNumber) {
		HashMap<String, Object> map = productService.productfindByNamePage(pName, pageNumber);
		return map;
	}

	// 後台查詢單一商品(ajax抓資料for修改)
	@ResponseBody
	@GetMapping("admin/product/getjson")
	public ProductBean productfindByNme(@RequestParam(name = "pID") int pID) {
		return productService.findById(pID);
	}

	// 修改
	@PostMapping("admin/product/edit")
	public ModelAndView productfindByName(ModelAndView mav, @RequestParam(name = "pID_e") int pID,
			@RequestParam(name = "pName_e") String pName, @RequestParam(name = "pPrice_e") int pPrice,
			@RequestParam(name = "pSpecs_e") String pSpecs,	@RequestParam(name = "pType_e") int pType, 
			@RequestParam(name = "pCountry_e") int pCountry, @RequestParam(name = "pAvailable_e") String pAvailable, 
			@RequestParam(name = "pDes_e") String pDes,	@RequestParam(name = "pPic_e") Part part) {
		productService.updateProduct(pName, pPrice, pSpecs, pDes, pType, pCountry, pAvailable, pID, part);
		mav.setViewName("redirect:/admin/product");
		return mav;

	}

	// 按下收藏鈕
	@ResponseBody
	@PostMapping("product/favrec")
	public Integer favRec(@RequestBody ProductFavRecDto fto) {
		ProductFavRec fr = new ProductFavRec(productService.findById(fto.getPid()),
				memberService.queryByID(fto.getUid()));
		return productService.productFavRec(fr);
	}

}

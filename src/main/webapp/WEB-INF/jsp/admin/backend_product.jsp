<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>天食地栗 | 後臺系統</title>
<!-- jQuery & BootStrap -->
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>

<!-- Font awesome -->
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css">

<!-- summer note -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script src="${contextRoot}/js/summernote-zh-TW.min.js"></script>

<!-- sweet alert -->
<link rel="stylesheet" href="${contextRoot}/css/sweetalert2.min.css">
<script src="${contextRoot}/js/sweetalert2.min.js"></script>

<!-- 自有 -->
<link rel="stylesheet" href="${contextRoot}/css/backend_style.css" />

<!-- ico -->
<link rel="shortcut icon" href="${contextRoot}/src/webimg/icon_round.ico">
</head>
<body>

	<section id="menu">
		<div class="logo">
			<a href="${contextRoot}/admin/index"><img src="${contextRoot}/src/webimg/backend/logo.png"></a>
			<h2>天食地栗</h2>
		</div>

		<div class="items">
			<ul>
				<a href="${contextRoot}/admin/account"><li><i class="fa fa-info-circle"></i>員工個人資料</li></a>
				<c:if test="${admin.fkDeptno.deptno == 100 || admin.fkDeptno.deptno == 400 }">
				<a href="${contextRoot}/admin/product"><li class="active"><i class="fab fad fa-sack"></i>商品管理</li></a>
				<a href="${contextRoot}/admin/member"><li><i class="fa fa-users"></i>會員管理</li></a>
				<a href="${contextRoot}/admin/order"><li><i class="far fa-file-invoice-dollar"></i>訂單管理</li></a>
				</c:if>
				<c:if test="${admin.fkDeptno.deptno == 200 || admin.fkDeptno.deptno == 400 }">
				<a href="${contextRoot}/admin/event"><li><i class="far fa-calendar-check"></i>活動管理</li></a>
				<a href="${contextRoot}/admin/recipe"><li><i class="fa fa-book"></i>食譜管理</li></a>
				<a href="${contextRoot}/admin/coupon"><li><i class="fal fa-badge-percent"></i>優惠券管理</li></a>
				</c:if>
				<c:if test="${admin.fkDeptno.deptno == 300 || admin.fkDeptno.deptno == 400 }">
				<a href="${contextRoot}/admin/employee"><li><i class="fas fa-user-cog"></i>員工管理</li></a>
				<a href="${contextRoot}/admin/punch"><li><i class="fas fa-clock"></i>員工打卡紀錄</li></a>
				</c:if>
			</ul>
		</div>
	</section>

	<section id="interface">
		<!--nav -->
		<div class="navigation">
			<div class="n1">
				<div class="search" style="visibility: hidden;">
					<i class="far fa-search"></i> <input type="text"
						placeholder="Search">
				</div>
			</div>

			<div class="profile">
				<img src="${contextRoot}/src/EmpImg/${admin.photo}" alt="">
				<p>${admin.username}</p>
				<button type="button" class="btn btn-primary btn-sm" style="margin-left:10px;" id="punchDown">下班</button>
				<a href="${contextRoot}/adminLogOut"><i class="fa fa-sign-out"></i></a>
			</div>
		</div>
		<!--end of nav-->


		<section>
			<!--right section-->
			<div class="title">
				<h3 class="i-name">商品管理</h3>
				<!-- Button trigger modal -->
				<button type="button" class="btn btn-primary" data-toggle="modal"
					data-target="#insertModal">新增商品</button>
			</div>
			<div class="search">
				<i class="far fa-search"></i> <input type="text"
					placeholder="輸入商品名稱..." id="searchbar">
			</div>
			<div class="board">
				<table style="width: 100%;">
					<thead>
						<tr>
							<td width='8%'>編號</td>
							<td>商品名稱</td>
							<td>價錢</td>
							<td>商品狀態</td>
							<td>最後修改時間</td>
							<td></td>
							<td></td>
						</tr>
					</thead>
					<tbody id="tbody">
						<c:forEach items='${products.content}' var='product'>

							<tr>
								<td>
									<p>${product.productID}</p>
								</td>

								<td class="product"><img
									src="${contextRoot}/${product.productPicUrl}">
									<div class="product-de">
										<h5>${product.productName}</h5>
										<p>${product.productCountry.countryName}/${product.productType.typeName}</p>
									</div></td>

								<td class="product-des">
									<h5>$ ${product.productPrice}</h5>
									<p>${product.productSpecs}</p>
								</td>

								<c:choose>
									<c:when test="${product.productAvailable == '1'}">
										<td class="active">
											<p>上架中</p>
										</td>
									</c:when>
									<c:otherwise>
										<td class="not-active">
											<p>未上架</p>
										</td>
									</c:otherwise>
								</c:choose>
								<td class="product-des">
									<p>${fn:substring(product.lastModifiedTime, 0, 19)}</p>
								</td>
								<td><button type="button" class="btn btn-info" name='edit'
										data-toggle="modal" data-target="#editModal">修改</button></td>
								<td>
									<button type="button" class="btn btn-danger" name="delete">刪除</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<!-- 分頁 -->
			<div id="pagination" class="left">
				<c:forEach var="pageNumber" begin="1" end="${products.totalPages}">
					<button class="btn btn-secondary btn-sm">${pageNumber}</button>
				</c:forEach>
			</div>

			<!-- 新增商品Modal -->
			<div class="modal fade" id="insertModal" tabindex="-1"
				aria-labelledby="insertModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable modal-lg">
					<div class="modal-content ">

						<div class="modal-header">
							<h5 class="modal-title" id="insertModalLabel">新增商品</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<!-- form -->
							<form method="post" action="${contextRoot}/admin/insertProduct"
								enctype="multipart/form-data">
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="pName">商品名稱</label>
									</div>
									<input type="text" class="form-control" id="pName" name="pName"
										aria-describedby="pName" autocomplete="off"><br>
								</div>
								<div class="input-group mb-3">
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="pPic"
											name="pPic" accept="image/gif, image/jpeg, image/png"
											data-target="preview_img"> <label
											class="custom-file-label" for="pPic" aria-describedby="pPic">商品圖片</label>

									</div>
									<div class="input-group-append">
										<span class="input-group-text" style="display: none">商品圖片</span>
									</div>

								</div>

								<!-- 預覽 -->
								<div class="preview-img">
									<img id="preview_img"
										src="${contextRoot}/src/webimg/backend/preview_img_550.jpg"
										style="max-width: 200px;" />
								</div>
								<!-- 預覽 -->
								<br>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="pPrice">商品價格</label>
									</div>
									<input type="number" class="form-control" min="0" max="10000"
										aria-describedby="pPrice" name="pPrice" id="pPrice"
										autocomplete="off"><br>
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="pSpecs">商品規格</label>
									</div>
									<input type="text" class="form-control"
										aria-describedby="pSpecs" name="pSpecs" id="pSpecs"
										autocomplete="off"><br>
								</div>

								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="pType">商品種類</label>
									</div>
									<select class="custom-select" aria-describedby="pType"
										name="pType" id="pType">
										<option value="" style="display: none">請選擇種類</option>
										<c:forEach items="${types}" var="type">
											<option value="${type.typeNo}">${type.typeName}</option>
										</c:forEach>
									</select>
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="pCountry">商品產地</label>
									</div>
									<select class="custom-select" aria-describedby="pCountry"
										name="pCountry" id="pCountry">
										<option value="" style="display: none">請選擇產地</option>
										<c:forEach items="${countries}" var="country">
											<option value="${country.countryNo}">${country.countryName}</option>
										</c:forEach>
									</select>
								</div>
								<div class="input-group mb-3">
									<label class="input-group-text" for="pSpecs">上架中</label>
									<div class="radio">
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio"
												name="pAvailable" id="inlineRadio1" value="true" required>
											<label class="form-check-label" for="inlineRadio1">是</label>
										</div>
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio"
												name="pAvailable" id="inlineRadio2" value="false"> <label
												class="form-check-label" for="inlineRadio2">否</label>
										</div>
									</div>
								</div>

								<div class="text">
									<textarea id="summernote" name="pDes"></textarea>
								</div>

								<br>
								<div class="modal-footer">
									<button type="button" class="btn btn-success" id="smartInput">快速輸入</button>
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">關閉</button>
									<input type="submit" class="btn btn-primary" value="送出" />
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- end of modal -->




			<!-- 修改商品Modal -->
			<div class="modal fade" id="editModal" tabindex="-1"
				aria-labelledby="editModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable modal-lg">
					<div class="modal-content ">

						<div class="modal-header">
							<h5 class="modal-title" id="editModalLabel">商品編輯</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<!-- form -->
							<form method="post" action="${contextRoot}/admin/product/edit"
								enctype="multipart/form-data">
								<input type="text" id="pID_e" name="pID_e"
									style="display:none;" />
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="pName_e">商品名稱</label>
									</div>
									<input type="text" class="form-control" id="pName_e"
										name="pName_e" aria-describedby="pName_e" autocomplete="off"><br>
								</div>
								<div class="input-group mb-3">
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="pPic_e"
											name="pPic_e" accept="image/gif, image/jpeg, image/png"
											data-target="preview_img"> <label
											class="custom-file-label" for="pPic_e"
											aria-describedby="pPic_e">商品圖片</label>

									</div>
									<div class="input-group-append">
										<span class="input-group-text" style="display: none">商品圖片</span>
									</div>

								</div>

								<!-- 預覽 -->
								<div class="preview-img">
									<img id="preview_img_e" src="#" style="max-width: 200px;" />
								</div>
								<!-- 預覽 -->
								<br>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="pPrice_e">商品價格</label>
									</div>
									<input type="number" class="form-control" min="0" max="10000"
										aria-describedby="pPrice_e" name="pPrice_e" id="pPrice_e"
										autocomplete="off"><br>
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="pSpecs_e">商品規格</label>
									</div>
									<input type="text" class="form-control"
										aria-describedby="pSpecs_e" name="pSpecs_e" id="pSpecs_e"
										autocomplete="off"><br>
								</div>

								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="pType_e">商品種類</label>
									</div>
									<select class="custom-select" aria-describedby="pType_e"
										name="pType_e" id="pType_e">
										<option value="" style="display: none">請選擇種類</option>
										<c:forEach items="${types}" var="type">
											<option value="${type.typeNo}">${type.typeName}</option>
										</c:forEach>
									</select>
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="pCountry_e">商品產地</label>
									</div>
									<select class="custom-select" aria-describedby="pCountry_e"
										name="pCountry_e" id="pCountry_e">
										<option value="" style="display: none">請選擇產地</option>
										<c:forEach items="${countries}" var="country">
											<option value="${country.countryNo}">${country.countryName}</option>
										</c:forEach>
									</select>
								</div>
								<div class="input-group mb-3">
									<label class="input-group-text" for="pSpecs_e">上架中</label>
									<div class="radio">
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio"
												name="pAvailable_e" id="inlineRadio1_e" value="true"
												required> <label class="form-check-label"
												for="inlineRadio1">是</label>
										</div>
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio"
												name="pAvailable_e" id="inlineRadio2_e" value="false">
											<label class="form-check-label" for="inlineRadio2">否</label>
										</div>
									</div>
								</div>

								<div class="text">
									<textarea id="summernote_e" name="pDes_e"></textarea>
								</div>

								<br>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">關閉</button>
									<input type="submit" class="btn btn-primary" value="修改" />
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- end of modal -->
		</section>
	</section>

	<script>
	<!--圖片預覽-->
		//新增
		$("#pPic").change(function() {
			readURL(this);
		});
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$("#preview_img").attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		
		//修改
		$("#pPic_e").change(function() {
			readURL2(this);
		});
		function readURL2(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$("#preview_img_e").attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}

	<!--summer note-->
	//新增
	$('#summernote').summernote({
        placeholder: '請輸入商品描述',
        tabsize: 2,
        width: 600,
        height: 400,
        toolbar: [
            ['style', ['style']],
            ['font', ['bold', 'underline', 'clear']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['table', ['table']],
            ['insert', ['link', 'picture', 'video']],
            ['view', ['codeview']]
          ],
        lang: 'zh-TW'
      });
	//修改
	$('#summernote_e').summernote({
        placeholder: '請輸入商品描述',
        tabsize: 2,
        width: 600,
        height: 400,
        toolbar: [
            ['style', ['style']],
            ['font', ['bold', 'underline', 'clear']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['table', ['table']],
            ['insert', ['link', 'picture', 'video']],
            ['view', ['codeview']]
          ],
        lang: 'zh-TW'
      });
	
	<!--快速輸入-->
	$('#smartInput').click(function(){
		$('#pName').val("La Baleine Kosher Salt 鯨魚牌猶太鹽");
		$('#pPrice').val("300");
		$('#pSpecs').val("950g");
		$('#pType').val("6");
		$('#pCountry').val("4");
		$('#inlineRadio1').prop('checked', true);
		
		<!--summer note需先destory方可重新輸入文字-->
		$('#summernote').summernote('destroy');
		$('#summernote').val("<p><b>商品介紹</b><br>猶太鹽是根據猶太人的飲食需要而做成的一種鹽， 只有很少的添加劑，而比平常的料理鹽有更重的鹽味。<br>" + 
							 "鹽味濃而不會過鹹，較溫和也無刺鼻的味道，味道能快速溶解開來，真實呈現食物原味，專業廚師的最愛<br>"+
							 "適用於醃漬魚.肉等料理，作為一般料理鹽也相當合適。<br><br><b>品牌介紹</b><br>"+
							 "法國鯨魚牌La Baleine海鹽充滿了海洋的礦物質風味，含有自然來源的天然鉀、鈣、鎂、銅和碘，味道也別於一般鹽的死鹹口味。<br>"+
							 "無論是搭配沙拉、麵包沾醬、海鮮料理、地中海、義大利料理都非常適合，為法國當地家喻戶曉之品牌。<br><br>" +
							 "保存方式：請放置於乾燥涼爽處<br>最佳賞味期：標示於外包裝營養標示<br></p>");
		$('#summernote').summernote({
	        tabsize: 2,
	        width: 600,
	        height: 400,
	        toolbar: [
	            ['style', ['style']],
	            ['font', ['bold', 'underline', 'clear']],
	            ['color', ['color']],
	            ['para', ['ul', 'ol', 'paragraph']],
	            ['table', ['table']],
	            ['insert', ['link', 'picture', 'video']],
	            ['view', ['codeview']]
	          ],
	        lang: 'zh-TW'
	      });
	});
	
	
	<!--刪除-->
	$('body').on('click','button[name="delete"]',function(){
		let id = $(this).parent().parent().find("p").html();
			
		Swal.fire({
			  title: '確定要刪除嗎?',
			  text: "注意：資料刪除後無法恢復!",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#dc3545',
			  cancelButtonColor: '#6c757d',
			  confirmButtonText: '確認刪除',
			  cancelButtonText: '取消'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
						url:"deleteProduct/" + id,
						method:"delete",
						success: function(data){
							ajaxTable(data);
						}
					});
				  Swal.fire(
			      '刪除成功',
			      '該商品已被刪除',
			      'success'
			    );
			  }
			});
	});
	
	<!--模糊查詢-->
	$('#searchbar').keyup(function(){
		let pName = $(this).val();
		$.ajax({
			url:"product/find?pName=" + pName,
			method:"get",
			success: function(data){
				ajaxTable(data);
			}
		})
	})
	
	
	<!--修改-->
	$('body').on('click','button[name="edit"]',function(){
		let id = $(this).parent().parent().find("p").html();
		$.ajax({
			url:"product/getjson?pID=" + id,
			method:"get",
			success: function(data){
				$('#pID_e').val(data.productID);
				$('#pName_e').val(data.productName);
				$('#preview_img_e').attr('src', '/GroupOne/' + data.productPicUrl);
				$('#pPrice_e').val(data.productPrice);
				$('#pSpecs_e').val(data.productSpecs);
				$('#pType_e').val(data.productType.typeNo);
				$('#pCountry_e').val(data.productCountry.countryNo);
				if(data.productAvailable > 0){
					$('#inlineRadio1_e').prop('checked', true);
					$('#inlineRadio2_e').prop('checked', false);
				}else{
					$('#inlineRadio1_e').prop('checked', false);
					$('#inlineRadio2_e').prop('checked', true);
				}
				$('#summernote_e').summernote('destroy');
				$('#summernote_e').val(data.productDes);
				$('#summernote_e').summernote({
			        tabsize: 2,
			        width: 600,
			        height: 400,
			        toolbar: [
			            ['style', ['style']],
			            ['font', ['bold', 'underline', 'clear']],
			            ['color', ['color']],
			            ['para', ['ul', 'ol', 'paragraph']],
			            ['table', ['table']],
			            ['insert', ['link', 'picture', 'video']],
			            ['view', ['codeview']]
			          ],
			        lang: 'zh-TW'
			      });
				
			}
		});
	});
	
	<!--分頁按鈕-->
	$('body').on('click','button.btn-sm',function(){
		let p = $(this).html();
		let pName = $('#searchbar').val();
		$.ajax({
			url:"product/find?pName=" + pName + "&p=" + p,
			method:"get",
			dataType:"json",
			success: function(data){
				ajaxTable(data);
			}
		})
	})
	
	<!--ajax產table-->
	function ajaxTable(data){
		$("#tbody").html("");
		for(i=0;i<data.products.length;i++){
			$("#tbody").append(
					"<tr><td><p>" + data.products[i].productID + "</p></td>" +
					"<td class='product'><img src='http://localhost:8080/GroupOne/" + data.products[i].productPicUrl+ "'>" +
					"<div class='product-de'><h5>" + data.products[i].productName + "</h5>" + 
					"<p>" + data.products[i].productCountry.countryName + "/" + data.products[i].productType.typeName + "</p></div></td>" + 
					"<td class='product-des'><h5>$ " +data.products[i].productPrice + "</h5><p>" + data.products[i].productSpecs + "</p></td>" +
					(data.products[i].productAvailable > 0 ? "<td class='active'><p>上架中</p></td>": "<td class='not-active'><p>未上架</p></td>") +
					"<td class='product-des'><p>" +data.products[i].lastModifiedTime.substring(0, 19) + "</p></td>" + 
					"<td><button type='button' class='btn btn-info' name='edit' data-toggle='modal'	data-target='#editModal'>修改</button></td>" + 
					"<td><button type='button' class='btn btn-danger' name='delete'>刪除</button></td></tr>");
	
		}
		$("#pagination").html("");
		for(i=1;i<=data.pages;i++){
			$("#pagination").append("<button class='btn btn-secondary btn-sm'>" + i +"</button>");
		}
	}
	<!--下班打卡-->
	$("#punchDown").click(function(){
		$.ajax({
			url:"http://localhost:8080/GroupOne/admin/punchDown",
			method:"get",
			success: function(data){
				Swal.fire(
					      '已打下班卡!',
					      '現在時間:' + data,
					      'success'
					    );
			}
		})
	})
	</script>
</body>
</html>
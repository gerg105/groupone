<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="google-signin-client_id"
	content="301620154399-3mr94uqtcdahcjtph799e3c01hdhm0eh.apps.googleusercontent.com">
<title>天食地栗 | 網路商城</title>
<!-- jQuery & BootStrap -->
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>

<!-- fontawesome -->
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />

<!-- 前端共有 -->
<link rel="stylesheet" href="${contextRoot}/css/frontend_style.css" />

<!-- 本頁css -->
<link rel="stylesheet" href="${contextRoot}/css/frontend_account.css" />

<!-- Google 平台庫 (第三方登入) -->
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async
	defer></script>
<script src="${contextRoot}/js/google-login.js"></script>

<!-- bootstrap-datetimepicker -->
<script src="${contextRoot}/js/bootstrap-datepicker.js"></script>
<link rel="stylesheet"
	href="${contextRoot}/css/bootstrap-datepicker.min.css">
<script src="${contextRoot}/js/bootstrap-datepicker.zh-TW.min.js"></script>

<!-- sweet alert -->
<link rel="stylesheet" href="${contextRoot}/css/sweetalert2.min.css">
<script src="${contextRoot}/js/sweetalert2.min.js"></script>

<!-- ico -->
<link rel="shortcut icon" href="${contextRoot}/src/webimg/icon_round.ico">

<style>
</style>
</head>

<body>

	<section id="header">
		<a href="${contextRoot}"><img
			src="${contextRoot}/src/webimg/frontend/logo.png" class="logo"></a>
		<div>
			<ul id="navbar">
				<li><a href="${contextRoot}">首頁</a></li>
				<li><a href="${contextRoot}/product">商品</a></li>
				<li><a href="${contextRoot}/recipe">食譜</a></li>
				<li><a href="${contextRoot}/event">活動</a></li>
				<li><a href="${contextRoot}/contact">聯絡我們</a></li>

				<c:choose>
					<c:when test="${user.ID != null}">
						<li><a class="active" href="${contextRoot}/account">會員專區</a></li>
						<li><a href="#" onclick="signOut();">登出</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${contextRoot}/login">登入</a></li>
					</c:otherwise>
				</c:choose>
				<li><a href="${contextRoot}/shoppingCart"><i
						class="far fa-shopping-bag"></i></a></li>
			</ul>
		</div>
	</section>

	<section id="profile" class="py-5 my-5">
		<div class="container">
			<div class="bg-white shadow rounded-lg d-block d-sm-flex">
				<div class="profile-tab-nav border-right">
					<div class="p-4">
						<div class="img-circle text-center mb-3">
							<img src="${contextRoot}/src/${userEdit.pic}" alt="Image"
								class="shadow" id="preview_img" style="max-width: 100px;">
						</div>
						<h4 class="text-center">${userEdit.name}</h4>
						<div class="vip">
							<span><i class="far fa-diamond lv-${userEdit.vip.vipID}"></i>
								${userEdit.vip.vipTitle}</span>
						</div>
					</div>
					<div class="nav flex-column nav-pills" id="v-pills-tab"
						role="tablist" aria-orientation="vertical">
						<a class="nav-link active" id="account-tab" data-toggle="pill"
							href="#account" role="tab" aria-controls="account"
							aria-selected="true"> <i class="fa fa-home text-center mr-1"></i>
							個人資料
						</a> <a class="nav-link" id="password-tab" data-toggle="pill"
							href="#password" role="tab" aria-controls="password"
							aria-selected="false"> <i class="fa fa-key text-center mr-1"></i>
							修改密碼
						</a> <a class="nav-link" id="myorder-tab" data-toggle="pill"
							href="#myorder" role="tab" aria-controls="myorder"
							aria-selected="false"> <i
							class="fa fa-ballot text-center mr-1"></i> 我的訂單
						</a> <a class="nav-link" id="productfav-tab" data-toggle="pill"
							href="#productfav" role="tab" aria-controls="productfav"
							aria-selected="false"> <i
							class="fa fa-box-heart text-center mr-1"></i> 商品收藏
						</a> <a class="nav-link" id="recipefav-tab" data-toggle="pill"
							href="#recipefav" role="tab" aria-controls="recipefav"
							aria-selected="false"> <i
							class="fa fa-book-heart text-center mr-1"></i> 食譜收藏
						</a>
					</div>
				</div>
				<div class="tab-content p-4 p-md-5" id="v-pills-tabContent">
					<div class="tab-pane fade show active" id="account" role="tabpanel"
						aria-labelledby="account-tab">
						<form method="post" action="${contextRoot}/account/editUserData"
							enctype="multipart/form-data">
							<c:if test="${msg != null}">
								<span style="color: red">${msg}</span>
							</c:if>
							<h3 class="mb-4">個人資料</h3>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label>姓名</label> <input type="text" class="form-control"
											id="userName" name="userName" value="${userEdit.name}"
											autocomplete="off">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>會員帳號</label> <input type="text" class="form-control"
											id="userAccount" name="userAccount"
											value="${userEdit.account}" readonly>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Email</label> <input type="text" class="form-control"
											id="userEmail" name="userEmail" value="${userEdit.email}"
											autocomplete="off">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>手機號碼</label> <input type="text" class="form-control"
											id="userTel" name="userTel" value="${userEdit.tel}"
											autocomplete="off">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>性別</label> <select id="userGender" name="userGender"
											class="form-control">
											<c:choose>
												<c:when test="${userEdit.gender == 'male'}">
													<option value="male" selected>男</option>
													<option value="female">女</option>
												</c:when>
												<c:otherwise>
													<option value="male">男</option>
													<option value="female" selected>女</option>
												</c:otherwise>
											</c:choose>
										</select>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>生日</label> <input type="text" class="form-control"
											id="userBirth" name="userBirth" value="${userEdit.birth}"
											autocomplete="off">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>照片更換</label> <br>
										<div class="custom-file">
											<input type="file" class="custom-file-input" id="userphoto"
												name="userphoto"> <label class="custom-file-label"
												for="userphoto">請上傳200*200以上的圖片</label>
										</div>
									</div>
								</div>
							</div>
							<div>
								<span style="font-size: 14px; color: gray;">記得按下更新才是更新完成喔！</span><br>
								<br> <input id="editDataBtn" type="submit"
									class="btn btn-primary" value="更新"> <input
									id="editSmartInput" type="button" class="btn btn-success"
									value="一鍵輸入">
							</div>
						</form>
					</div>
					<div class="tab-pane fade" id="password" role="tabpanel"
						aria-labelledby="password-tab">

						<h3 class="mb-4">修改密碼</h3>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>新密碼</label> <input type="password" id="newPwd"
										name="newPwd" class="form-control">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>再次輸入新密碼</label> <input type="password" id="recheckPwd"
										name="recheckPwd" class="form-control">
								</div>
							</div>
						</div>
						<div>
							<h6 id="error1" style="color: red"></h6>
							<h6 id="error2" style="color: red"></h6>
							<h6 id="error3" style="color: red"></h6>
							<button id="changePwd" type="button" class="btn btn-primary">更新</button>
							<button id="changePwdSmartInput" type="button"
								class="btn btn-success">一鍵輸入</button>
						</div>
					</div>



					<div class="tab-pane fade" id="myorder" role="tabpanel"
						aria-labelledby="myorder-tab">
						<h3 class="mb-4">
							我的訂單
							<button class="btn btn-info" data-toggle="modal"
								data-target="#cumulativeModal" style="margin-left: 10px;">累積消費</button>
						</h3>
						<input type="text" id="isOrder" hidden="" value="${isOrder}">
						<c:forEach items="${orderInformationList}" var="orderInformation">
							<div class="card">
								<div class="card-body">
									<h5 class="card-title">訂單編號：${orderInformation.orderNumber}</h5>
									<h6 class="card-subtitle mb-2 text-muted">${fn:substring(orderInformation.orderDate, 0, 19)}</h6>
									<p class="card-text">訂單金額：$ ${orderInformation.totalAmount}</p>
									<p class="card-text">取貨地址：${orderInformation.storename}/${orderInformation.storeaddress}</p>
									<p class="card-text">出貨狀況：${orderInformation.orderStats.orderStats}</p>
									<button class="btn btn-primary detail-btn" data-toggle="modal"
										data-target="#detailModal">訂單明細</button>
									<input type="text" class="orderNumber" hidden=""
										value="${orderInformation.orderNumber}">
								</div>
							</div>
							<br>
						</c:forEach>



					</div>




					<div class="tab-pane fade" id="productfav" role="tabpanel"
						aria-labelledby="productfav-tab">
						<h3 class="mb-4">商品收藏</h3>
						<div class="pro-container">
							<c:forEach items="${products}" var="product">
								<div class="pro"
									onclick="window.location.href='${contextRoot}/product/${product.productID}'">
									<img src="${contextRoot}/${product.productPicUrl}">
									<div class="des">
										<span>${product.productCountry.countryName}/${product.productType.typeName}</span>
										<h5>${product.productName}</h5>
										<span class='spec'>${product.productSpecs}</span>
										<h4>$ ${product.productPrice}</h4>
									</div>
								</div>

							</c:forEach>
						</div>
					</div>



					<div class="tab-pane fade" id="recipefav" role="tabpanel"
						aria-labelledby="recipefav-tab">
						<h3 class="mb-4">食譜收藏</h3>
						<div class="pro-container">
							<c:forEach items="${rcps}" var="rcp">
								<div class="pro"
									onclick="window.location.href='${contextRoot}/recipe/${rcp.rid}'">
									<img src="${contextRoot}/${rcp.img}">
									<div class="des">
										<span>${rcp.rtp.rtype}</span>
										<h5>${rcp.title}</h5>
										<span class='spec'>${rcp.serve}人份</span>
										<h4>${rcp.rtime}分鐘</h4>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


	<!-- 累計消費Modal -->
	<div class="modal fade" id="cumulativeModal" tabindex="-1"
		role="dialog" aria-labelledby="cumulativeModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="cumulativeModalLabel">累計消費</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<h3>消費與會員升等制度如下：</h3>
						<table class="table">
							<tr>
								<th>累計消費</th>
								<th>會員等級</th>
							</tr>
							<tr>
								<td>10000</td>
								<td>黃金會員</td>
							</tr>
							<tr>
								<td>50000</td>
								<td>白金會員</td>
							</tr>
							<tr>
								<td>100000</td>
								<td>鑽石會員</td>
							</tr>
						</table>
					<c:choose>
						<c:when test="${cumulative.id != null}">
							<p>您目前的累計消費金額：$ ${cumulative.cumulativeConsumption}</p>
							<p>您最後一筆消費時間：${fn:substring(cumulative.consumptionDate, 0, 19)}</p>
						</c:when>
						<c:otherwise>
							<p>您目前的累計消費金額：未有消費紀錄</p>
							<p>您最後一筆消費時間：未有消費紀錄</p>
						</c:otherwise>
					</c:choose>
					<span style="color: red">提醒您，超過6個月未消費將會歸零您的累計消費金額!</span>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">關閉</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 訂單明細Modal -->
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog"
		aria-labelledby="detailModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="detailModalLabel">訂單明細</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<table class="table">
						<thead>
							<tr>
								<th></th>
								<th>品名</th>
								<th>數量</th>
							</tr>
						</thead>
						<tbody id="tbody">
						</tbody>
					</table>
					<p>
						備註：<span id="remark"></span>
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">關閉</button>
				</div>
			</div>
		</div>
	</div>

	<footer class="section-p1">
		<div class="col">
			<img class="logo" src="${contextRoot}/src/webimg/frontend/logo.png">
			<h4>聯絡資訊</h4>
			<p>
				<strong>地址：</strong>台北市信義區基隆路二段33號
			</p>
			<p>
				<strong>電話：</strong>02 - 27385385
			</p>
			<p>
				<strong>營業時間：</strong> 12:00 - 21:00, Sun - Sat
			</p>
		</div>

		<div class="col">
			<h4>關於我們</h4>
			<a href="${contextRoot}/contact">關於天食地栗</a> <a
				href="${contextRoot}/contact#form-details">聯絡我們</a>
		</div>

		<div class="col">
			<h4>社群媒體</h4>
			<div class="icon">
				<a href="https://www.facebook.com/puresky.co/"><i
					class="fab fa-facebook-f"></i></a> <a
					href="https://www.instagram.com/pureskyco/"><i
					class="fab fa-instagram"></i></a> <a
					href="https://www.youtube.com/channel/UCyxdluGUeVI9hhM-kIAfCjQ"><i
					class="fab fa-youtube"></i></a>
			</div>
		</div>

		<div class="copyright">
			<p>
				<a href="${contextRoot}/adminLogin">© 2022, EEIT138期Java跨域工程師養成班
					第一組</a>
			</p>
		</div>
	</footer>
	<script>
	<!--生日Datepicker-->
		$("#userBirth").datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			language : 'zh-TW',
		});

		<!--照片更換前端預覽-->
		$("#userphoto").change(function() {
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

		<!--修改個資一鍵輸入-->
		$("#editSmartInput").click(function(){
			$("#userBirth").val("1996-07-24");
			$("#userEmail").val("eeit138g1.15@gmail.com");
		})
		<!--修改密碼一鍵輸入-->
		$("#changePwdSmartInput").click(function(){
			$("#newPwd").val("Passw0rd123@");
			$("#recheckPwd").val("Passw0rd123@");
		})
		<!--更改密碼-->
		$('#changePwd').click(function() {
			let newPass = $('#newPwd').val();
			let newPass2 = $('#recheckPwd').val();
			$("#error1").html("");
			$("#error2").html("");
			$("#error3").html("");
			if(newPass!="" && newPass2!="" && newPass ==newPass2){
				Swal.fire({
					title: '處理中...',
					didOpen: () => {
						Swal.showLoading();
						},
				})
			}
			let dtoObject = {
					"newPwd" : newPass,
					"recheckPwd" : newPass2
					}
			let dtoJSONString = JSON.stringify(dtoObject);
			$.ajax({
				url : "http://localhost:8080/GroupOne/account/changePwd",
				method : "post",
				contentType:"application/json; charset=UTF-8",
				data: dtoJSONString,
				success : function(data) {
					Swal.close();
					$("#error1").append(data.error);
					$("#error2").append(data.newPassword2);
					$("#error3").append(data.passwordError);
					if (data.errorTimes == 0) {
						Swal.fire('更新成功!',
								  '未來請使用新密碼登入',
								  'success')
						$('#newPwd').val("");
						$('#recheckPwd').val("");
					}
				}
			})
		})

		<!--是否跳我的訂單頁-->
		$(document).ready(function() {
			let order = $("#isOrder").val();
			if (order == "" || order == null) {
			} else {
				$("#account-tab").removeClass("active");
				$("#account").removeClass("show").removeClass("active");
				$("#myorder-tab").addClass("active");
				$("#myorder").addClass("show").addClass("active");
			}
		})
		
		
		<!--訂單明細-->
		$(".detail-btn").click(function(){
			let orderNumber = $(this).parent().find(".orderNumber").val();
			$.ajax({
				url:"http://localhost:8080/GroupOne/orderDetail?id=" + orderNumber,
				method:"get",
				dataType:"json",
				success: function(data){
					$("#tbody").html("")
					for(i=0;i<data.orderDetailList.length;i++){
						$("#tbody").append("<tr><td><img width='100px' src='http://localhost:8080/GroupOne/" + data.orderDetailList[i].product.productPicUrl + "'></td>" + 
										   "<td><a href='http://localhost:8080/GroupOne/product/" + data.orderDetailList[i].product.productID + "'>" + data.orderDetailList[i].product.productName + "</a></td>"+
										   "<td>" + data.orderDetailList[i].amount + "</td></tr>")
					}
					$("#remark").text(data.orderInformation.remark)
				}
			})
		})
		
		$("#editDataBtn").click(function(){
			Swal.fire({
				  title: '處理中...',
				  didOpen: () => {
				    Swal.showLoading();
				  },
				})
		})
	</script>
</body>

</html>
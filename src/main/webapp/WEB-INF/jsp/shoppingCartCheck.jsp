<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<!-- fontawesome -->
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />

<!-- 前端共有 -->
<link rel="stylesheet" href="${contextRoot}/css/frontend_style.css" />

<!-- Google 平台庫 (第三方登入) -->
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async
	defer></script>
<script src="${contextRoot}/js/google-login.js"></script>

<!-- sweet alert -->
<link rel="stylesheet" href="${contextRoot}/css/sweetalert2.min.css">
<script src="${contextRoot}/js/sweetalert2.min.js"></script>

<!-- ico -->
<link rel="shortcut icon" href="${contextRoot}/src/webimg/icon_round.ico">

<style>
#googleMap {
	display: none;
}

.main {
	width: 1700px;
	border-radius: 15px;
	margin: 20px auto;
	/* 至中 */
	padding: 30px 80px;
	background-color: rgb(255, 255, 255);
	/*             Box-shadow: 15px 15px 12px rgb(161, 125, 95); */
	align-self: center;
}
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
						<li><a href="${contextRoot}/account">會員專區</a></li>
						<li><a href="#" onclick="signOut();">登出</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${contextRoot}/login">登入</a></li>
					</c:otherwise>
				</c:choose>
				<li><a class="active" href="${contextRoot}/shoppingCart"><i
						class="far fa-shopping-bag"></i></a></li>
			</ul>
		</div>
	</section>

	<section id="page-header" class="about-header">
		<h2>#購物車</h2>
	</section>

	<section id="cart" class="section-p1">
		<table width="100%">
			<thead>
				<tr>
					<td></td>
					<td>產品名</td>
					<td>單價</td>
					<td>數量</td>
					<td>總價</td>
				</tr>
			</thead>

			<!--foreach cart-->
			<tbody id="tbody">
				<c:forEach items="${cartDetailPut}" var="cart">
					<tr>
						<td><img src="${contextRoot}/${cart.productPicUrl}"></td>
						<td>${cart.productName}</td>
						<td>$ ${cart.productPrice}</td>
						<td><strong>${cart.amount}</strong></td>
						<td>$ <span class="totalPrice">${cart.totalPrice}</span></td>
						<td hidden=""><input class="cartID" type="text"
							value="${cart.cartID}"></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</section>

<section id="cart-store" class="section-p1">
			<div id="store">
				<h3>寄送資訊</h3>
				<a
					href="https://emap.presco.com.tw/c2cemap.ashx?eshopid=870&&servicetype=1&url=http://localhost:8080/GroupOne/storelist/">
					<button type="button" id="sendInformationButton"
						name="sendInformationButton" class="btn btn-primary"
						style="margin: 0px 0px 5px 0px">選擇門市</button>
				</a>
				<button type="button" id="storeSmartInput" class="btn btn-success"
						style="margin: 0px 0px 5px 0px">一鍵輸入</button>
				<p>
					超商名稱：<input id="storeName" name="storeName"
						style="border: none; outline: none;" value="${storename}" readonly>
				</p>
				<p>
					超商地址：<input id="storeAddress" name="storeAddress"
						style="border: none; outline: none; width: 500px"
						value="${storeaddress}" readonly>
				</p>
				<div id="googleMap">
					<iframe width="1050" height="350" id="gmapFrame" frameborder="0" style="border: 0"
						src="https://www.google.com/maps/embed/v1/place?key=AIzaSyBnFeVRUwqXMfy9CoS7EQrNWu82ljhjImc&q=${storename}"
						allowfullscreen=""></iframe>
				</div>
			</div>
		</section>
		<section id="cart-add" class="section-p1">
			<div id="coupon">
				<h3>使用優惠券<button type="button" id="couponSmartInput" class="btn btn-success btn-sm"
						style="margin-left: 10px">一鍵輸入</button></h3> 
				<div>
					<input type="text" placeholder="請輸入優惠碼" id="couponCode" name="couponCode"> 
					<input type="hidden" id="couponId" name="couponId" class="form-control" value="0"> 
					<input type="hidden" id="lowestMsg" name="lowestMsg" class="form-control" value="0"> 
					<br>
					<input id="couponType" style="border: none; outline: none; width: 500px; color: blue;" readonly>
					<input id="couponTypeText" name="couponTypeText" value="無" hidden="">
				</div>
			</div>

			<div id="subtotal">
				<h3>總金額</h3>
				<table>
					<tr>
						<td>購物車總金額</td>
						<td>$ <span class="calculate" id="cartTotal"></span></td>
					</tr>
					<tr>
						<td>運費</td>
						<td>$ <span class="calculate" id="shipping">0</span></td>
					</tr>
					<tr>
						<td>折價</td>
						<td>$ <span class="calculate" id="discount">0</span></td>
					</tr>
					<tr>
						<td><strong>總計</strong></td>
						<td><strong>$ <span id="sum"></span></strong></td>
					</tr>
				</table>
				<div class="mb-3">
					<label for="validationTextarea">備註<input type="button" id="commentSmartInput" value="一鍵輸入" class="btn btn-success btn-sm" style="margin-left:10px"></label>
					<textarea class="form-control" id="textarea" name="textarea"
						placeholder="若有相關備註，可於此留言"></textarea>
				</div>
				<button class="normal" id="billbtn">結帳去</button>
			</div>
		</section>
		
		<form id="billform" action="${contextRoot}/createBill" method="post">
		<input type="text" hidden="" name="total" id="form_total">
		<input type="text" hidden="" name="deliveryFee" id="form_deliveryFee">
		<input type="text" hidden="" name="allTotal" id="form_allTotal">
		<input type="text" hidden="" name="couponTypeText" id="form_couponTypeText">
		<input type="text" hidden="" name="storeName" id="form_storeName">
		<input type="text" hidden="" name="storeAddress" id="form_storeAddress">
		<input type="text" hidden="" name="textarea" id="form_textarea">
		</form>



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
			<a href="${contextRoot}/contact">關於天食地栗</a> 
			<a href="${contextRoot}/contact#form-details">聯絡我們</a>
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
			<p><a href="${contextRoot}/adminLogin">© 2022, EEIT138期Java跨域工程師養成班 第一組</a></p>
		</div>
	</footer>

	<script>
	$(document).ready(function(){
		cartTotal();
		storeMap();
	})

	<!--googleMap顯示 / 超商-->
			function storeMap() {
				if ($("#storeName").val() != "") {
					$("#googleMap").css("display", "block");
				}
			}
			
			<!--優惠卷Check-->
			$("#couponCode").blur(function() {
				ajaxCheckCoupon();
			})
			
			function ajaxCheckCoupon(){
				let code = $("input[name='couponCode']").val();
				$.ajax({
					url : 'http://localhost:8080/GroupOne/coupons/check',
					type : 'POST',
					data : {
						couponCode : code
					},
					success : function(status) {
						$("#couponId").val(status.id);
						$("#couponType").val(status.type);
						$("#discount").text(status.discount);
						$("#lowestMsg").val(status.lowest);
						
						let discount = Number($("#discount").text());
						let total = Number($("#cartTotal").text());
						let lowest = Number($("#lowestMsg").val());
						let nowTotal = Number($("#cartTotal").text());
										
						if (total > lowest) {			
							let all_total02 =nowTotal - discount;
							$("#sum").text(all_total02);
							$("#couponTypeText").val(status.type);
						}else{
							$("#discount").text(0);
							$("#couponType").val("不滿條件無法折扣");
							$("#couponTypeText").val("無");
						}
						if (status.code == null) {
							$("#couponType").val("無此優惠碼，請再確認一次");
							$("#couponTypeText").val("無");
							$("#discount").text(0);
							deliveryFee =Number( $("#shipping").text());											
							let total =Number($("#cartTotal").text());	
							sTotal= total + deliveryFee
							$("#sum").text(sTotal);
							if(code == "" || code == null){
								$("#couponType").val("")
							}
						}
					},
				})
			}
			
			
			
			<!--送表單-->
			$("#billbtn").click(function(){
				let form_total = $("#cartTotal").text();
				$("#form_total").val(form_total);
				
				$("#form_deliveryFee").val("0");
				
				let form_allTotal = $("#sum").text();
				$("#form_allTotal").val(form_allTotal);
				
				let form_couponTypeText = $("#couponTypeText").val();
				$("#form_couponTypeText").val(form_couponTypeText);
				
				let form_storeName = $("#storeName").val();
				$("#form_storeName").val(form_storeName);
				
				let form_storeAddress = $("#storeAddress").val();
				$("#form_storeAddress").val(form_storeAddress);
				
				let form_textarea = $("#textarea").val();
				$("#form_textarea").val(form_textarea);
				
				
				
				if($("#storeName").val() == ""){	
					Swal.fire({
						  icon: 'error',
						  title: 'Oops...',
						  text: '請填寫寄送資訊!',
						})
					return false;
				}
				Swal.fire({
					  title: '處理中...',
					  didOpen: () => {
					    Swal.showLoading();
					  },
					})
				$("#billform").submit();
			})
			
			function cartTotal(){
				var x = 0;
				$(".totalPrice").each(function() {
					let totalPrice = $(this).text();
					x += Number(totalPrice);
				})
				$("#cartTotal").text(x);
				var y = 0;
				$(".calculate").each(function() {
					let dollar = $(this).text();
					y += Number(dollar);
				})
				$("#sum").text(y);
			}
			
		<!--超商一鍵輸入(防網路不穩)-->
		$("#storeSmartInput").click(function(){
			$("#storeName").val("民族西門市");
			$("#storeAddress").val("台北市大同區民族西路151號153號155號")
			$("#gmapFrame").attr("src","https://www.google.com/maps/embed/v1/place?key=AIzaSyBnFeVRUwqXMfy9CoS7EQrNWu82ljhjImc&q=民族西門市")
			setTimeout(function (){
				$("#googleMap").css("display", "block");
			}, 500);
		})
		<!--留言一鍵輸入-->
		$("#commentSmartInput").click(function(){
			$("#textarea").val("請幫我多塞一些包材，以免碎裂，謝謝!")
		})
		
		<!--優惠券一鍵輸入-->
		$("#couponSmartInput").click(function(){
			$("#couponCode").val("ywDSnO4crs60KOD");
			ajaxCheckCoupon();
		})
	</script>
</body>

</html>
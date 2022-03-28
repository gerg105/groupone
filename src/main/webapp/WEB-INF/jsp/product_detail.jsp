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

<!-- sweet alert -->
<link rel="stylesheet" href="${contextRoot}/css/sweetalert2.min.css">
<script src="${contextRoot}/js/sweetalert2.min.js"></script>

<!-- 前端共有 -->
<link rel="stylesheet" href="${contextRoot}/css/frontend_style.css" />

<!-- Google 平台庫 (第三方登入) -->
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async
	defer></script>
<script src="${contextRoot}/js/google-login.js"></script>
<!-- ico -->
<link rel="shortcut icon" href="${contextRoot}/src/webimg/icon_round.ico">
</head>
<body>

	<section id="header">
		<a href="${contextRoot}"><img
			src="${contextRoot}/src/webimg/frontend/logo.png" class="logo"></a>
		<div>
			<ul id="navbar">
				<li><a href="${contextRoot}">首頁</a></li>
				<li><a class="active" href="${contextRoot}/product">商品</a></li>
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
				<li><a href="${contextRoot}/shoppingCart"><i
						class="far fa-shopping-bag"></i></a></li>
			</ul>
		</div>
	</section>

	<input id="userNow" type="text" value="${user.ID}" hidden="">
	<input id="productNow" type="text" value="${product.productID}"
		hidden="">

	<section id="prodetails" class="section-p1">
		<div class="single-pro-image">
			<img src="${contextRoot}/${product.productPicUrl}" width="100%"
				id="mainImg">
		</div>
		<div class="single-pro-details">
			<div>
				<h6>首頁 / ${product.productType.typeName}</h6>
				<c:choose>
					<c:when test="${favId == 0}">
						<button id="fav"
							class="btn btn-outline-danger btn-circle btn-circle-sm m-1">
							<i class="fa fa-heart"></i>
						</button>
					</c:when>
					<c:otherwise>
						<button id="fav"
							class="btn btn-danger btn-circle btn-circle-sm m-1">
							<i class="fa fa-heart"></i>
						</button>
					</c:otherwise>
				</c:choose>
			</div>
			
			<h4>${product.productName}</h4>
			<h2>
				$ ${product.productPrice}<span> /${product.productSpecs}</span>
			</h2>	
			<c:choose>
			<c:when test="${product.productAvailable =='0'}">
			<h4 style="color:red">此商品目前下架中</h4>
			</c:when>
			<c:otherwise>

			<c:choose>
				<c:when test="${user.ID != null}">
					<input type="number" value="1" min="1" max="10" id="quantity">
					<button id="addToCart" class="normal cart">加入購物車</button>
				</c:when>
				<c:otherwise>
					<a href="${contextRoot}/login"><button class="normal cart">請先登入</button></a>
				</c:otherwise>
			</c:choose>

			</c:otherwise>
			</c:choose>
			
			

			<h4>商品內容</h4>
			<span>${product.productDes}</span>
		</div>
	</section>

	<section id="product1" class="section-p1">
		<h2>為您推薦</h2>
		<p>不要錯過這些優質商品!</p>
		<div class="pro-container">
			<c:forEach items="${suggestProducts}" var="suggestProduct">
				<div class="pro"
					onclick="window.location.href='${contextRoot}/product/${suggestProduct.productID}'">
					<img src="${contextRoot}/${suggestProduct.productPicUrl}">
					<div class="des">
						<span>${suggestProduct.productCountry.countryName}/${suggestProduct.productType.typeName}</span>
						<h5>${suggestProduct.productName}</h5>
						<span class='spec'>${suggestProduct.productSpecs}</span>
						<h4>$ ${suggestProduct.productPrice}</h4>
					</div>
				</div>

			</c:forEach>
		</div>
	</section>

	<c:if test="${user.ID == null}">
		<section id="newsletter" class="section-p1 section-m1">
			<div class="newstext">
				<h4>還不是會員嗎？</h4>
				<p>
					在右方輸入您的Email信箱以利獲得我們的<span>最新優惠</span>。
				</p>
			</div>
			<form method="get" action="${contextRoot}/register">
				<input type="text" placeholder="您的Email信箱" name="email"
					autocomplete="off">
				<button class="normal" type="submit">註冊</button>
			</form>
		</section>
	</c:if>

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
	$("#addToCart").click(function(){
		let quantity = $("#quantity").val();
		let pID = $("#productNow").val();
		$.ajax({
			url:"http://localhost:8080/GroupOne/shoppingCart/add?productId=" + pID + "&amount=" + quantity,
			method: 'post',
			success: function(data){
				Swal.fire({
					  position: 'top-end',
					  icon: 'success',
					  title: '已加入購物車!',
					  showConfirmButton: false,
					  timer: 1000
					})
			}
		})
	})
	
	
	<!--收藏-->
	$("#fav").click(function(){
		let uid = $("#userNow").val();
		if(uid == ""){
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: '請先登入喔!',
				})
		}else{
			let ftoObject = {
					"uid": uid,
					"pid": ${product.productID}
			};
			let fto = JSON.stringify(ftoObject);
			$.ajax({
				url: 'http://localhost:8080/GroupOne/product/favrec',
		        contentType: 'application/json; charset=UTF-8',
		        dataType: 'json',
		        method: 'post',
		        data: fto,
		        success:function (msg){
		        	if ($("#fav").hasClass('btn-outline-danger')) {
		        		Swal.fire({
							  icon: 'success',
							  title: '已加入收藏!',
							  showConfirmButton: false,
							  timer: 1000
							})
		                $("#fav").removeClass("btn-outline-danger").addClass("btn-danger");
		            } else{
		            	$("#fav").removeClass("btn-danger").addClass("btn-outline-danger");
		            }
		        }
			})
		}
	});
	
	</script>
</body>

</html>
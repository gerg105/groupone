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
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>

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
				<li><a href="${contextRoot}/shoppingCart"><i class="far fa-shopping-bag"></i></a></li>
			</ul>
		</div>
	</section>

	<section id="page-header" class="shop-header">
		<h2>#商品</h2>
		<p>眾多優質商品等您挑選！</p>
	</section>

	<section id="product1" class="section-p1">
		<!-- 分類按鈕 -->
		<c:choose>
			<c:when test="${currentType == 0}">
				<button type="button" class="btn btn-success btn-sm">所有商品</button>
			</c:when>
			<c:otherwise>
				<button type="button" class="btn btn-outline-success btn-sm"
					onclick="window.location.href='${contextRoot}/product'">所有商品</button>
			</c:otherwise>
		</c:choose>
		<c:forEach items="${productTypes}" var="productType">
			<c:choose>
				<c:when test="${currentType == productType.typeNo}">
					<button type="button" class="btn btn-success btn-sm">${productType.typeName}</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-outline-success btn-sm"
						onclick="window.location.href='${contextRoot}/product?type=${productType.typeNo}'">${productType.typeName}</button>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<!-- end of 分類按鈕 -->

		<div class="pro-container">
			<c:forEach items="${page.content}" var="product">

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
	</section>





	<section id="pagination" class="section-p1">
		<c:forEach var="pageNumber" begin="1" end="${page.totalPages}">
			<c:choose>
				<c:when test="${page.number+1 != pageNumber}">
					<a
						href="${contextRoot}/product?p=${pageNumber}&type=${currentType}">${pageNumber}</a>
				</c:when>
				<c:otherwise>
					<a>${pageNumber}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
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
</body>
</html>
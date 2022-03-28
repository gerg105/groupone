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
				<li><a class="active" href="${contextRoot}">首頁</a></li>
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
				<li><a href="${contextRoot}/shoppingCart"><i class="far fa-shopping-bag"></i></a></li>
			</ul>
		</div>
	</section>

	<section id="hero">
		<div class="hero-div">
			<h2>慶祝網站上線</h2>
			<h1>4/30前，全品項免運</h1>
			<p>快來成為我們的會員!</p>
			<a href="${contextRoot}/product"><button>來去購物</button></a>
		</div>
	</section>

	<section id="bscarousel">
		<div id="indexcarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#indexcarousel" data-slide-to="0" class="active"></li>
				<li data-target="#indexcarousel" data-slide-to="1"></li>
				<li data-target="#indexcarousel" data-slide-to="2"></li>
			</ol>
			<c:set var="event" value="${eventPage.content}" />
			<div class="carousel-inner">
				<div class="carousel-item active">
					<a href="${contextRoot}/event/${event[0].id}"> <img
						class="d-block w-100"
						src="${contextRoot}/src/${event[0].imagePath}"
						style="max-height: 300px">
					</a>
				</div>
				<div class="carousel-item">
					<a href="${contextRoot}/event/${event[1].id}"> <img
						class="d-block w-100"
						src="${contextRoot}/src/${event[1].imagePath}"
						style="max-height: 300px">
					</a>
				</div>
				<div class="carousel-item">
					<a href="${contextRoot}/event/${event[2].id}"> <img
						class="d-block w-100"
						src="${contextRoot}/src/${event[2].imagePath}"
						style="max-height: 300px">
					</a>
				</div>
			</div>
			<a class="carousel-control-prev" href="#indexcarousel" role="button"
				data-slide="prev"> <span class="carousel-control-prev-icon"
				aria-hidden="true"></span> <span class="sr-only">Previous</span>
			</a> <a class="carousel-control-next" href="#indexcarousel" role="button"
				data-slide="next"> <span class="carousel-control-next-icon"
				aria-hidden="true"></span> <span class="sr-only">Next</span>
			</a>
		</div>
	</section>

	<section id="product1" class="section-p1">
		<h2>最新商品</h2>
		<p>熱騰騰的最新商品等您挑選！</p>
		<div class="pro-container">
			<c:forEach items="${productPage.content}" var="product">

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

	<section id="banner" class="section-m1">
		<h2>不只會買，還要會做</h2>
		<div>
			<a href="${contextRoot}/recipe"><button class="normal">探索食譜</button></a>
		</div>
	</section>

	<section id="product1" class="section-p1">
		<h2>最新食譜</h2>
		<p>各式東西料理等您來嘗試！</p>
		<div class="pro-container">
		<c:forEach items="${rcpPage.content}" var="rcp">
		<div class="pro" onclick="window.location.href='${contextRoot}/recipe/${rcp.rid}'">
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
	<!--活動輪撥間隔-->
		$('.carousel').carousel({
			interval : 2000
		})
	</script>

</body>
</html>
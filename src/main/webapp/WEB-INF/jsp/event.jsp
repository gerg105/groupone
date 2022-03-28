<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
				<li><a href="${contextRoot}/product">商品</a></li>
				<li><a href="${contextRoot}/recipe">食譜</a></li>
				<li><a class="active" href="${contextRoot}/event">活動</a></li>
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


	<section id="page-header" class="event-header">
		<h2>#活動</h2>
	</section>

	<section id="blog">
	<c:forEach items="${page.content}" var="event">
		<div class="blog-box">
			<div class="blog-img">
				<a href="${contextRoot}/event/${event.id}"><img src="${contextRoot}/src/${event.imagePath}"></a>
			</div>
			<div class="blog-details">
				<h4>${event.title}</h4>
				<br>
				<br> <a href="${contextRoot}/event/${event.id}">繼續閱讀</a>
			</div>
			<h1>${fn:substring(event.createDate, 5, 10)}</h1>
		</div>
	</c:forEach>
	</section>

	<section id="pagination" class="section-p1">
		<c:forEach var="pageNumber" begin="1" end="${page.totalPages}">
			<c:choose>
				<c:when test="${page.number+1 != pageNumber}">
					<a
						href="${contextRoot}/event?p=${pageNumber}">${pageNumber}</a>
				</c:when>
				<c:otherwise>
					<a>${pageNumber}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</section>




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
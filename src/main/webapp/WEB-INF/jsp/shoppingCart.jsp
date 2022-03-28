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
	<c:choose>
		<c:when test="${cartDetailPut.size() == 0}">
			<h1 style="text-align: center">唉呀，你的購物車是空的喔</h1>
			<div style="display: flex; justify-content: center; margin: 10px;">
				<a href="${contextRoot}/product"><button type="button"
						class="btn btn-success">快去購物</button></a>
			</div>
		</c:when>
		<c:otherwise>
			<section id="cart" class="section-p1">
				<table width="100%">
					<thead>
						<tr>
							<td>移除</td>
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
								<td><i class="far fa-times-circle delbtn"></i></td>
								<!--ajax-->
								<td><img src="${contextRoot}/${cart.productPicUrl}"></td>
								<td>${cart.productName}</td>
								<td>$ ${cart.productPrice}</td>
								<td><input class="cartAmount" type="number"
									value="${cart.amount}" min="1" max="20"></td>
								<td>$ <span class="totalPrice">${cart.totalPrice}</span></td>
								<td hidden=""><input class="cartID" type="text"
									value="${cart.cartID}"></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot style="border-top: 1px solid black; margin-top: 5px">
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td><a href="${contextRoot}/shoppingCartCheck"><button
										type="button" class="btn btn-outline-success"
										style="margin-top: 5px">去買單</button></a></td>
							<td><strong>$<span id="sum"></span></strong></td>
						</tr>
					</tfoot>

				</table>
			</section>
		</c:otherwise>
	</c:choose>
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
		$(document).ready(function() {
			cartTotal();
		})

		<!--改量-->
		$('body').on('change','.cartAmount',function() {
			let amount = $(this).val();
			let cartID = $(this).parent().parent().find(".cartID").val();
			$.ajax({
				url : "http://localhost:8080/GroupOne/shoppingCart/edit?cartId="+ cartID + "&amount=" + amount,
				method : "post",
				success : function(data) {
					ajaxTable(data);
				}
			})
		})

		<!--刪除-->
		$('body').on("click",'.delbtn',	function() {
			let cartID = $(this).parent().parent().find(".cartID").val();
			$.ajax({
				url : "http://localhost:8080/GroupOne/shoppingCart/delete?id="+ cartID,
				method : "delete",
				success : function(data) {
					ajaxTable(data);
				}
			})
		})

		<!--ajaxTable-->
		function ajaxTable(data) {
			$("#tbody").html("");
			for (i = 0; i < data.length; i++) {
				$("#tbody")
						.append(
								"<tr><td><i class='far fa-times-circle delbtn'></i></td>"
										+ "<td><img src='http://localhost:8080/GroupOne/" + data[i].productPicUrl + "'></td>"
										+ "<td>"
										+ data[i].productName
										+ "</td>"
										+ "<td>$ "
										+ data[i].productPrice
										+ "</td>"
										+ "<td><input class='cartAmount' type='number' value='" + data[i].amount + "' min='1' max='20'></td>"
										+ "<td>$ <span class='totalPrice'>"
										+ data[i].totalPrice
										+ "</span></td>"
										+ "<td hidden=''><input class='cartID' type='text' value='" + data[i].cartID + "'></td></tr>")
			}
			cartTotal();
		}

		<!--顯示總價-->
		function cartTotal() {
			var x = 0;
			$(".totalPrice").each(function() {
				let totalPrice = $(this).text();
				x += Number(totalPrice);
			})
			$("#sum").text(x);
		}
	</script>
</body>

</html>
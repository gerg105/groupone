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
				<li><a class="active" href="${contextRoot}/contact">聯絡我們</a></li>

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

	<section id="page-header" class="about-header">
		<h2>#關於我們</h2>
	</section>

	<section id="about-head" class="section-p1">
		<img src="${contextRoot}/src/webimg/frontend/about.jpg">
		<div>
			<h2>Who We Are?</h2>
			<p>天食地栗讓食材回歸到最真實的一面，在食的領域裡簡單享樂，重新發現食物的力量，推廣各地好食材與各式百分之百未精煉油品落實在飲食生活，讓食以天然的本質呈現。</p>
			<p>在這裡您不但可以選購許多來自歐洲及台灣的精選食材之外，我們也會定期舉辦許多分享會或是關於烹飪箱關的拓展活動，歡迎您來共襄盛舉！</p>
			<p>★買家小提醒：</p>
			<p>★食品類不適用7天鑑賞期規範，一經拆封無法退換，請各買家知悉</p>
			<p>★愛護地球，我們會使用二次包材清潔後外箱寄送喔！</p>
			<br> <br>
			<marquee bgcolor="#ccc" loop="-1" scrollamount="5" width="100%">
				提醒您，疫情期間記得戴口罩、勤洗手，保持安全社交距離。若來店亦請配合相關防疫措施！ </marquee>
		</div>
	</section>


	<section id="contact-details" class="section-p1">
		<div class="details">
			<span>歡迎您的到來</span>
			<h2>若有機會，歡迎您到我們的店舖參觀！</h2>
			<h3>總部</h3>
			<div>
				<ul>
					<li><i class="fal fa-map"></i>
						<p>台北市信義區基隆路二段33號</p></li>
					<li><i class="far fa-envelope"></i>
						<p>eeit138g1@gmail.com</p></li>
					<li><i class="fas fa-phone-alt"></i>
						<p>02 - 27385385</p></li>
					<li><i class="far fa-clock"></i>
						<p>12:00 - 21:00, 週一 - 週六</p></li>
				</ul>
			</div>
		</div>
		<div class="map">
			<iframe
				src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3615.0749693430025!2d121.5567123154469!3d25.031529744543615!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3442abca6ce3f9af%3A0x2841414be411d251!2z5aSp6aOf5Zyw5qCX!5e0!3m2!1szh-TW!2stw!4v1645343680685!5m2!1szh-TW!2stw"
				width="600" height="450" style="border: 0;" allowfullscreen=""
				loading="lazy"></iframe>
		</div>
	</section>

	<section id="form-details">
		<div class="form-no-btn">
			<form>
				<h2>若有任何商業合作、意見反映，都歡迎您的來信！</h2>
				<input type="text" placeholder="您的大名" id="emailName"
					autocomplete=off value="${user.name}"> 
				<input type="text" placeholder="E-mail信箱"
					id="emailAddress" autocomplete=off value="${user.email}"> 
				<input type="text"
					placeholder="主旨" id="emailSubject" autocomplete=off>
				<textarea name="" id="emailMessage" cols="30" rows="10"
					placeholder="信件內容"></textarea>
			</form>
			<button class="normal" id="sendEmail">送出</button>
			<input type="button" id="contactSmartInput" class="btn btn-success" value="一鍵輸入">
		</div>
		<div class="people">
			<h4>社群媒體</h4>
			<br>
			<div>
				<a href="https://www.facebook.com/puresky.co/"><img
					src="${contextRoot}/src/webimg/frontend/fb_icon.png"></a> <span>FaceBook</span>
			</div>
			<br>
			<div>
				<a href="https://www.instagram.com/pureskyco/"><img
					src="${contextRoot}/src/webimg/frontend/ig_icon.png"></a> <span>Instagram</span>
			</div>
			<br>
			<div>
				<a href="https://www.youtube.com/channel/UCyxdluGUeVI9hhM-kIAfCjQ"><img
					src="${contextRoot}/src/webimg/frontend/yt_icon.png" alt=""></a>
				<span>Youtube</span>
			</div>
			<br>
			<div>
			<a href="https://line.me/ti/p/@puresky">
				<img src="${contextRoot}/src/webimg/frontend/line_icon.png" alt=""></a>
				<span>Line</span>
			</div>
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
	$("#contactSmartInput").click(function(){
		$('#emailSubject').val("請問大量訂購有優惠嗎？");
		$('#emailMessage').val("您好，我這邊想要大量訂購100瓶的Chateldon 夏特丹氣泡礦泉水，請問有團購優惠嗎？");
	})
	
	
	$('#sendEmail').click(function(){
		let emailName = $('#emailName').val();
		let emailAddress = $('#emailAddress').val();
		let emailSubject = $('#emailSubject').val();
		let emailMessage = $('#emailMessage').val();
		if(emailName == "" || emailAddress=="" || emailSubject=="" || emailMessage==""){
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: '請填寫所有欄位以利後續與您回覆喔!',
				})
		}else{
			
		
		let dtoObject = { "emailName" : emailName,
						  "emailAddress" : emailAddress,
						  "emailSubject" : emailSubject,
						  "emailMessage" : emailMessage
						}
		let dtoJSONString = JSON.stringify(dtoObject);
		Swal.fire({
			  title: '謝謝您的來信！',
			  html: '正在寄送信件中...',
			  didOpen: () => {
			    Swal.showLoading();
			  },
			})
		$.ajax({
			url:"http://localhost:8080/GroupOne/contact/sendMessage",
			method:"post",
			contentType:"application/json; charset=UTF-8",
			data: dtoJSONString,
			success: function(){
				$('#emailSubject').val("");
				$('#emailMessage').val("");
				Swal.hideLoading();
				Swal.fire(
					      '寄送成功！',
					      '我們將盡速回覆您！',
					      'success'
					    );
			}
		})
		
		}
	});
	</script>
</body>

</html>
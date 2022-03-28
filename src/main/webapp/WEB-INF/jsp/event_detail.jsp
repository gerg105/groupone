<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

<!-- ico -->
<link rel="shortcut icon" href="${contextRoot}/src/webimg/icon_round.ico">

<style>
body{
background-image: url('${contextRoot}/src/webimg/frontend/body.jpeg');
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



	<c:set var="start" value="${event.startDate} " />
	<c:set var="end" value="${event.endDate} " />
	<c:set var="start1" value="${fn:substring(start, 0, 10)}" />
	<c:set var="end1" value="${fn:substring(end, 0, 10)}" />
	<c:set var="end2" value="${fn:substring(end, 11, 13)}" />
	<c:set var="start2" value="${fn:substring(start, 11, 13)}" />
	<section id="profile" class="py-5 my-5">
		<div class="container">
			<div class="bg-white shadow rounded-lg d-block d-sm-flex">
				<div class="tab-content p-4 p-md-5" id="v-pills-tabContent">
					<div class="tab-pane fade show active" id="account" role="tabpanel"
						aria-labelledby="account-tab">

						<article class="mb-4">
							<div class="container px-4 px-lg-5">
								<div class="row gx-4 gx-lg-5 justify-content-center">
									<div>
										<br>
										<h2 class="section-heading">${event.title}</h2>
										<img class="img-fluid"
											src="${contextRoot}/src/${event.imagePath}" width="800"
											height="300"> <br><span style="color: gray;"> 活動時間：
											${start1} ${start2} : 00 ~ ${end1} ${end2} :00 <br> <fmt:formatDate
												pattern="yyyy-MM-dd HH:mm (最後編輯時間)"
												value="${event.editDate}" />
										</span>
										<div class="content" id="LoginBlock">
											<button class="btn btn-primary" id="authorize_button"
												style="display: none;">若要加入Google行事曆，請先登入Google</button>
											<button class="btn btn-primary" id="insert_button"
												onclick="insertEvents()" style="display: none;">將本活動加入Google行事曆</button>

										</div>
										<div>${event.content.content}</div>

									</div>
								</div>
							</div>
						</article>
					</div>




				</div>
			</div>
		</div>
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
	<script type="text/javascript">
		// Client ID and API key from the Developer Console
		var CLIENT_ID = '301620154399-3mr94uqtcdahcjtph799e3c01hdhm0eh.apps.googleusercontent.com';
		var API_KEY = 'AIzaSyA7IdL65q7Msk5BBASSdi1duL8yEQRBNM0';

		// Array of API discovery doc URLs for APIs used by the quickstart
		var DISCOVERY_DOCS = [ "https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest" ];

		// Authorization scopes required by the API; multiple scopes can be
		// included, separated by spaces.
		var SCOPES = "https://www.googleapis.com/auth/calendar";

		var authorizeButton = document.getElementById('authorize_button');
		var insertButton = document.getElementById('insert_button');

		/**
		 *  On load, called to load the auth2 library and API client library.
		 */
		function handleClientLoad() {
			gapi.load('client:auth2', initClient);
		}

		/**
		 *  Initializes the API client library and sets up sign-in state
		 *  listeners.
		 */
		function initClient() {
			gapi.client
					.init({
						apiKey : API_KEY,
						clientId : CLIENT_ID,
						discoveryDocs : DISCOVERY_DOCS,
						scope : SCOPES
					})
					.then(
							function() {
								// Listen for sign-in state changes.
								gapi.auth2.getAuthInstance().isSignedIn
										.listen(updateSigninStatus);

								// Handle the initial sign-in state.
								updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn
										.get());
								authorizeButton.onclick = handleAuthClick;
							}, function(error) {
								appendPre(JSON.stringify(error, null, 2));
							});
		}

		/**
		 *  Called when the signed in status changes, to update the UI
		 *  appropriately. After a sign-in, the API is called.
		 */
		function updateSigninStatus(isSignedIn) {
			if (isSignedIn) {
				authorizeButton.style.display = 'none';
				insertButton.style.display = 'block';
			} else {
				authorizeButton.style.display = 'block';
				insertButton.style.display = 'none';
			}
		}

		/**
		 *  Sign in the user upon button click.
		 */
		function handleAuthClick(event) {
			gapi.auth2.getAuthInstance().signIn();
		}

		function insertEvents(event) {

			var event = {
				"summary" : '${event.title}',
				"location" : "Taipei",
				'description' : '${event.content.content}',
				'start' : {
					'dateTime' : '${event.startDate}' + ':00:00+08:00',
					'timeZone' : 'Asia/Taipei'
				},
				'end' : {
					'dateTime' : '${event.endDate}' + ':00:00+08:00',
					'timeZone' : 'Asia/Taipei'
				},
				'reminders' : {
					'useDefault' : false,
					'overrides' : [ {
						'method' : 'email',
						'minutes' : 24 * 60
					}, {
						'method' : 'popup',
						'minutes' : 10
					} ]
				}
			};
			var request = gapi.client.calendar.events.insert({
				'calendarId' : 'primary',
				'resource' : event
			});
			request.execute(function(event) {
				console.log(event);
			});

			window.open("https://calendar.google.com/calendar/u/0/r?tab=rc");
		}

		function signOut() {
			var auth2 = gapi.auth2.getAuthInstance();
			auth2.signOut().then(function() {
				auth2.disconnect();
			});
			$.ajax({
				url : "http://localhost:8080/GroupOne/logout",
				method : "get",
				success : function(data) {
					window.location.href = "/GroupOne/";
				}
			})
		}
	</script>
	<script async defer src="https://apis.google.com/js/api.js"
		onload="this.onload=function(){};handleClientLoad()"
		onreadystatechange="if (this.readyState === 'complete') this.onload()">
	</script>
</body>

</html>
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

<!-- 本頁css -->
<link rel="stylesheet" href="${contextRoot}/css/frontend_login.css" />

<!-- Google 平台庫 (第三方登入) -->
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async
	defer></script>
<script src="${contextRoot}/js/google-login.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton"
	async defer></script>

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
				<li><a href="${contextRoot}/contact">聯絡我們</a></li>

				<c:choose>
					<c:when test="${user.ID != null}">
						<li><a href="${contextRoot}/account">會員專區</a></li>
						<li><a href="#" onclick="signOut();">登出</a></li>
					</c:when>
					<c:otherwise>
						<li><a class="active" href="${contextRoot}/login">登入</a></li>
					</c:otherwise>
				</c:choose>
				<li><a href="${contextRoot}/shoppingCart"><i
						class="far fa-shopping-bag"></i></a></li>
			</ul>
		</div>
	</section>


	<section class="main-content">
		<div class="container">

			<div class="login-card rounded-lg overflow-hidden bg-white mx-auto">
				<div class="login-head bg-dark text-light p-4">
					<h3 class="text-center text-uppercase m-0">會員登入</h3>
				</div>
				<div class="login-body p-4 p-md-5">
					<div class="login-body-wrapper mx-auto">
						<c:if test="${msg != null}">
							<span style="color: red">${msg}</span>
						</c:if>
						<form method="post" action="${contextRoot}/loginCheck">
							<div class="form-group">
								<label for="memAccount">帳號</label> <input type="text"
									class="form-control form-control-lg" name="memAccount"
									id="memAccount" aria-describedby="helpId"
									placeholder="請輸入帳號..." autocomplete="off" required>
							</div>
							<div class="form-group">
								<label for="memPwd">密碼</label> <input type="password"
									class="form-control form-control-lg" name="memPwd" id="memPwd"
									aria-describedby="helpId" placeholder="請輸入密碼..."
									autocomplete="off" value="${tempPwd}" required> <a href="#"
									data-toggle="modal" data-target="#forgotPwdModal">忘記密碼了嗎?</a>
							</div>
							<input type="submit" class="btn btn-primary btn-block btn-lg"
								value="登入">
						</form>
						<br>
						<button id="chao" class="btn btn-success btn-circle btn-circle-sm m-1">
							趙
						</button>
						<button id="chao2" class="btn btn-info btn-circle btn-circle-sm m-1">
							趙
						</button>
						<p class="text-muted text-center">
							還沒成為會員嗎? <a href="${contextRoot}/register">點我註冊</a>
						</p>
						<div
							class="or-divider rounded-circle bg-white shadow d-flex justify-content-center align-items-center mx-auto mb-3">Or</div>
						<div style="display: flex; justify-content: center;">
							<div id="my-signin2"></div>
						</div>
						<!-- 
						<div class="row">
								<button class="g-signin2" >Google</button>
						</div>
						 -->
					</div>

				</div>
			</div>

		</div>
	</section>


	<!-- 忘記密碼彈窗 -->
	<div class="modal fade" id="forgotPwdModal" tabindex="-1"
		aria-labelledby="forgotPwdModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content ">

				<div class="modal-header">
					<h5 class="modal-title" id="forgotPwdModalLabel">忘記密碼</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label>請輸入您的Email</label> <input type="text" id="forgetPwdEmail"
									name="forgetPwdEmail" class="form-control"
									placeholder="Example@example.com">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-success" id="emailSmartInput">快速輸入</button>
						<input type="button" class="btn btn-primary" id="forgetbtn" value="送出" />
					</div>
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
	<!--登入一鍵輸入-->
	$("#chao").click(function(){
		$("#memAccount").val("meowG1");
		$("#memPwd").val("z@f9*Xze");
	})
	
	$("#chao2").click(function(){
		$("#memAccount").val("meowG1");
		$("#memPwd").val("Passw0rd123@");
	})
	
	<!--google登入-->
		function renderButton() {
			gapi.signin2.render('my-signin2',{
								'scope' : 'profile email https://www.google.com/calendar/feeds',
								'width' : 240,
								'height' : 50,
								'longtitle' : true,
								'theme' : 'dark',
								'onsuccess' : onSuccess
								});
		}
		
		<!--忘記密碼Email一鍵輸入-->
		$("#emailSmartInput").click(function(){
			$("#forgetPwdEmail").val("eeit138g1.15@gmail.com")
		})
		
		
		$("#forgetbtn").click(function(){
			let email = $("#forgetPwdEmail").val();
			Swal.fire({
				  title: '處理中...',
				  didOpen: () => {
				    Swal.showLoading();
				  },
				})
			$.ajax({
				url:"http://localhost:8080/GroupOne/forgetPwd?userEmail="+ email,
				method:"post",
				success: function(data){
					if(data.stat=="1"){
						Swal.hideLoading();
						Swal.fire(
							      '寄送成功！',
							      data.result,
							      'success'
							    );
					}else{
						Swal.hideLoading();
						Swal.fire(
							      '寄送失敗！',
							      data.result,
							      'error'
							    );
					}
				},
				error: function(){
					Swal.hideLoading();
					Swal.fire(
						      '寄送失敗！',
						      '請重新確認信箱',
						      'error'
						    );
				}
			})
		})
	</script>

</body>

</html>
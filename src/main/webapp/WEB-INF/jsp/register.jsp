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

<!-- bootstrap-datetimepicker -->
<script src="${contextRoot}/js/bootstrap-datepicker.js"></script>
<link rel="stylesheet"
	href="${contextRoot}/css/bootstrap-datepicker.min.css">
<script src="${contextRoot}/js/bootstrap-datepicker.zh-TW.min.js"></script>
<!-- ico -->
<link rel="shortcut icon" href="${contextRoot}/src/webimg/icon_round.ico">

<!-- sweet alert -->
<link rel="stylesheet" href="${contextRoot}/css/sweetalert2.min.css">
<script src="${contextRoot}/js/sweetalert2.min.js"></script>

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
				<li><a href="${contextRoot}/shoppingCart"><i class="far fa-shopping-bag"></i></a></li>
			</ul>
		</div>
	</section>


	<section class="main-content">
		<div class="container">

			<div class="login-card rounded-lg overflow-hidden bg-white mx-auto">
				<div class="login-head bg-dark text-light p-4">
					<h3 class="text-center text-uppercase m-0">會員註冊</h3>
				</div>
				<div class="login-body p-4 p-md-5">
					<div class="login-body-wrapper mx-auto">
						<form method="post" action="${contextRoot}/register"
							enctype="multipart/form-data">
							<div class="form-group">
								<input type="button" class="btn btn-success btn-sm" value="快速輸入"
									id="smartInput"> <br> <br> <label
									for="memAccount">帳號</label> <input type="text"
									class="form-control form-control-lg" name="memAccount"
									id="memAccount" aria-describedby="helpId" placeholder="請輸入帳號">
							</div>
							<div class="form-group">
								<label for="memName">姓名</label> <input type="text"
									class="form-control form-control-lg" name="memName"
									id="memName" aria-describedby="helpId" placeholder="例:王小明">
							</div>
							<div class="form-group">
								<label for="memPwd">密碼</label> <input type="password"
									class="form-control form-control-lg" name="memPwd" id="memPwd"
									aria-describedby="helpId" placeholder="請輸入密碼">
							</div>
							<div class="form-group">
								<label for="memGender">性別</label>
								<div class="form-check form-check-inline"
									style="margin-left: 20px;">
									<input class="form-check-input" type="radio" name="memGender"
										id="inlineRadio1" value="male"> <label
										class="form-check-label" for="inlineRadio1">男</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="memGender"
										id="inlineRadio2" value="female"> <label
										class="form-check-label" for="inlineRadio2">女</label>
								</div>
							</div>
							<div class="form-group" style="margin-top: 5px;">
								<label for="memBirth">生日</label> <input type="text"
									class="form-control form-control-lg" name="memBirth"
									id="memBirth" aria-describedby="helpId"
									placeholder="例:1980-01-01">
							</div>
							<div class="form-group">
								<label for="memTel">電話</label> <input type="text"
									class="form-control form-control-lg" name="memTel" id="memTel"
									aria-describedby="helpId" placeholder="例:0912345678">
							</div>
							<div class="form-group">
								<label for="memEmail">Email</label> <input type="text"
									class="form-control form-control-lg" name="memEmail"
									id="memEmail" aria-describedby="helpId"
									placeholder="例:example@test.com" value="${email}">
							</div>
							<div class="form-group">
								<label for="memPic">會員照片</label>
								<div class="custom-file">
									<input type="file" class="custom-file-input" id="memPic"
										name="memPic" data-target="preview_img"> <label
										class="custom-file-label" for="memPic"
										aria-describedby="memPic">請上傳200*200圖片</label>

								</div>
								<div class="input-group-append">
									<span class="input-group-text" style="display: none"></span>
								</div>
								<div
									style="display: flex; justify-content: center; margin-top: 5px">
									<img id="preview_img"
										src="${contextRoot}/src/webimg/backend/preview_img_200.jpg"
										style="max-width: 200px;" />
								</div>
							</div>
							<input id="subBtn" type="submit" class="btn btn-primary btn-block btn-lg"
								value="註冊">
						</form>
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
	<script>
	<!--圖片預覽-->
		$("#memPic").change(function() {
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

		<!--生日Datepicker-->
		$("#memBirth").datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			language : 'zh-TW',
		});

		<!--快速輸入-->
		$('#smartInput').click(function() {
			$('#memAccount').val("meowG1");
			$('#memName').val("趙若茵");
			$('#memPwd').val("z@f9*Xze");
			$('#inlineRadio2').prop('checked', true);
			$('#memBirth').val("1998-05-05");
			$('#memTel').val("0911027350");
			$('#memEmail').val("inna723@gmail.com");
		});
		
		<!--註冊時寄信-->
		$("#subBtn").click(function(){
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
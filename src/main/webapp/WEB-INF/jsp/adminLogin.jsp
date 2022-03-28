<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<link href="${contextRoot}/css/backend_system_style.css"
	rel="stylesheet" />
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>天食地栗 | 後台系統</title>
<!-- ico -->
<link rel="shortcut icon" href="${contextRoot}/src/webimg/icon_round.ico">

<!-- 鏡頭掃QR -->
<script type="text/javascript"
	src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="d-flex h-100 justify-content-center align-items-center">
		<div class="modal-dialog w-100 mx-auto">
			<div class="modal-content">
				<div class="modal-body">
					<div class="h5 modal-title text-center">
						<h4 class="mt-2">
							<div>
								<h2>員工後台系統</h2>
							</div>
							<span>請登入您的員工編號及密碼:</span>
							<h6 style="color: #8E8E8E">(首次啟用密碼為身分證)</h6>
						</h4>
					</div>
					<div class="form-row">
						<div class="col-md-12">
							<div>
								<input name="empId" id="id" placeholder="員工編號" type="text"
									class="form-control">
							</div>
						</div>
						<div class="col-md-12">
							<div class="position-relative form-group">
								<input name="password" id="password" placeholder="密碼"
									type="password" class="form-control">
							</div>
						</div>
						<div id="noCheckMail"></div>
					</div>
					<div class="modal-footer clearfix">
						<div class="float-left">
							<a href="${contextRoot}/adminForgotPassword"
								class="btn-lg btn btn-link">忘記密碼</a>
						</div>
						<div class="float-right">
							<button class="btn btn-primary" id="logIn">登入</button>
						</div>
						<!-- Button trigger modal -->
						<button type="button" class="btn btn-primary"
							data-bs-toggle="modal" data-bs-target="#exampleModal"
							id="qrButton">QR code</button>
					</div>
					<div>
					<button id="saleAcc" type="button" class="btn btn-warning">業務部</button>
					<button id="marketAcc" type="button" class="btn btn-success">行銷部</button>
					<button id="hrAcc" type="button" class="btn btn-info">人事部</button>
					<button id="adminAcc" type="button" class="btn btn-danger">管理員</button>
					<button id="newEmp" type="button" class="btn btn-dark">新員工</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">請掃描您的QR code</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div align="center">
						<!-- 開啟相機 -->
						<div class="preview-container">
							<video id="preview"></video>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		$("#logIn")
				.click(
						function() {
							let id = $("#id").val();
							let pwd = $("#password").val();
							$
									.ajax({
										url : 'http://localhost:8080/GroupOne/api/getEmployee?empId='
												+ id + '&password=' + pwd,
										dataType : 'json',
										method : 'post',
										success : function(data) {
											$('#noCheckMail span').remove();
											console.log(data.empId);
											console.log("" === "")
											var wrongMessage = '';
											if (data.empId == null) {
												wrongMessage = '<span style="color: red;">帳號密碼錯誤，請再重新輸入</span>'

											} else if (data.fkStateId.id == 3) {
												wrongMessage = '<span style="color: red;">帳號為離職員工用戶，有相關問題請聯絡管理員</span>'
											} else if (data.fkStateId.id == 1) {
												wrongMessage = '<span style="color: red;">帳號尚未啟用，請到信箱點擊連結啟用</span>'
											} else
												(window.location.href = "http://localhost:8080/GroupOne/admin/index")
											$('#noCheckMail').append(
													wrongMessage);
										}
									})

						})
	</script>
	<!-- 詢問是否允許開啟相機後，會顯示在這個元素裡 -->
	<!-- ---------- -->
	<!-- 以下程式面 -->
	<script type="text/javascript">
let scanner = new Instascan.Scanner({
	video: document.getElementById('preview')
});



$("#qrButton").click(function(){
	//開始偵聽掃描事件，若有偵聽到印出內容。
	
	Instascan.Camera.getCameras().then(function(cameras) {
	//取得設備的相機數目
		 if (cameras.length > 0) {
			///若設備相機數目大於0 則先開啟第0個相機(程式的世界是從第零個開始的)
				scanner.start(cameras[0]);
		} else {
			//若設備沒有相機數量則顯示"No cameras found";
			//這裡自行判斷要寫什麼
				console.error('No cameras found.');
		}
	}).catch(function(e) {
		console.error(e);
	});
})


// 開啟一個新的掃描
// 宣告變數scanner，在html<video>標籤id為preview的地方開啟相機預覽。
// Notice:這邊注意一定要用<video>的標籤才能使用，詳情請看他的github API的部分解釋。
scanner.addListener('scan', function(content) {
	console.log(content);
	window.open(content);
// 	window.location.reload();
	window.close(this);
});

						    
						
</script>
	<script src="${contextRoot}/js/LoginData.js"></script>

</body>
</html>
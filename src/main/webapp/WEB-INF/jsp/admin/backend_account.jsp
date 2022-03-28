<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>天食地栗 | 後臺系統</title>
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css">

<!-- 後台共有 -->
<link rel="stylesheet" href="${contextRoot}/css/backend_style.css" />

<!-- 後台account -->
<link rel="stylesheet" href="${contextRoot}/css/backend_account.css" />

<!-- bootstrap-datetimepicker -->
<script src="${contextRoot}/js/bootstrap-datepicker.js"></script>
<link rel="stylesheet"
	href="${contextRoot}/css/bootstrap-datepicker.min.css">
<script src="${contextRoot}/js/bootstrap-datepicker.zh-TW.min.js"></script>

<!-- sweet alert -->
<link rel="stylesheet" href="${contextRoot}/css/sweetalert2.min.css">
<script src="${contextRoot}/js/sweetalert2.min.js"></script>
<!-- ico -->
<link rel="shortcut icon" href="${contextRoot}/src/webimg/icon_round.ico">
</head>
<body>

	<section id="menu">
		<div class="logo">
			<a href="${contextRoot}/admin/index"><img src="${contextRoot}/src/webimg/backend/logo.png"></a>
			<h2>天食地栗</h2>
		</div>

		<div class="items">
			<ul>
				<a href="${contextRoot}/admin/account"><li class="active"><i class="fa fa-info-circle"></i>員工個人資料</li></a>
				<c:if test="${admin.fkDeptno.deptno == 100 || admin.fkDeptno.deptno == 400 }">
				<a href="${contextRoot}/admin/product"><li><i class="fab fad fa-sack"></i>商品管理</li></a>
				<a href="${contextRoot}/admin/member"><li><i class="fa fa-users"></i>會員管理</li></a>
				<a href="${contextRoot}/admin/order"><li><i class="far fa-file-invoice-dollar"></i>訂單管理</li></a>
				</c:if>
				<c:if test="${admin.fkDeptno.deptno == 200 || admin.fkDeptno.deptno == 400 }">
				<a href="${contextRoot}/admin/event"><li><i class="far fa-calendar-check"></i>活動管理</li></a>
				<a href="${contextRoot}/admin/recipe"><li><i class="fa fa-book"></i>食譜管理</li></a>
				<a href="${contextRoot}/admin/coupon"><li><i class="fal fa-badge-percent"></i>優惠券管理</li></a>
				</c:if>
				<c:if test="${admin.fkDeptno.deptno == 300 || admin.fkDeptno.deptno == 400 }">
				<a href="${contextRoot}/admin/employee"><li><i class="fas fa-user-cog"></i>員工管理</li></a>
				<a href="${contextRoot}/admin/punch"><li><i class="fas fa-clock"></i>員工打卡紀錄</li></a>
				</c:if>
			</ul>
		</div>
	</section>

	<section id="interface">
		<!--nav -->
		<div class="navigation">
			<div class="n1">
				<div class="search" style="visibility: hidden;">
					<i class="far fa-search"></i> <input type="text"
						placeholder="Search">
				</div>
			</div>

			<div class="profile">
				<img src="${contextRoot}/src/EmpImg/${admin.photo}" alt="">
				<p>${admin.username}</p>
				<button type="button" class="btn btn-primary btn-sm" style="margin-left:10px;" id="punchDown">下班</button>
				<a href="${contextRoot}/adminLogOut"><i class="fa fa-sign-out"></i></a>
			</div>
		</div>
		<!--end of nav-->
		<section class="py-5 my-5">
			<div class="container">
				<div class="bg-white shadow rounded-lg d-block d-sm-flex">
					<div class="profile-tab-nav border-right">
						<div class="p-4">
							<div class="img-circle text-center mb-3">
								<img src="${contextRoot}/src/EmpImg/${emp.photo}" alt="Image"
									class="shadow" id="preview_img" style="max-width: 100px;">
							</div>
							<h4 class="text-center">${emp.username}</h4>
						</div>
						<div class="nav flex-column nav-pills" id="v-pills-tab"
							role="tablist" aria-orientation="vertical">
							<a class="nav-link active" id="account-tab" data-toggle="pill"
								href="#account" role="tab" aria-controls="account"
								aria-selected="true"> <i class="fa fa-home text-center mr-1"></i>
								個人資料
							</a> <a class="nav-link" id="password-tab" data-toggle="pill"
								href="#password" role="tab" aria-controls="password"
								aria-selected="false"> <i class="fa fa-key text-center mr-1"></i>
								密碼修改
							</a> <a class="nav-link" id="security-tab" data-toggle="pill"
								href="#security" role="tab" aria-controls="security"
								aria-selected="false"> <i
								class="fa fa-clock text-center mr-1"></i> 打卡紀錄
							</a>
						</div>
					</div>
					<div class="tab-content p-4 p-md-5" id="v-pills-tabContent">
						<div class="tab-pane fade show active" id="account"
							role="tabpanel" aria-labelledby="account-tab">
							<h3 class="mb-4">個人資料</h3>
							<form method="post"
								action="${contextRoot}/admin/updatePersonalInformation"
								enctype="multipart/form-data">
								<input type="text" value="${emp.photo}" name="orphoto"
									style="display: none"> <input type="text"
									value="${emp.fkStateId.id}" name="fkStatId"
									style="display: none">

								<div class="row">
									<div class="col-md-2">
										<div class="form-group">
											<label>員工編號</label> <input type="text" class="form-control"
												readonly value="${emp.empId}" name="empId">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>到職日</label> <input type="text" class="form-control"
												value="${emp.boardDate}" readonly>
										</div>
									</div>
									<div class="col-md-2">
										<div class="form-group">
											<label>姓名</label> <input type="text" class="form-control"
												value="${emp.username}" name="username" autocomplete="off">
										</div>
									</div>
									<div class="col-md-2">
										<div class="form-group">
											<label>性別</label> <select class="form-control" name="contact">
												<c:choose>
													<c:when test="${emp.sex == '男'}">
														<option id="male" selected>男</option>
														<option id="female">女</option>
													</c:when>
													<c:otherwise>
														<option id="male">男</option>
														<option id="female" selected>女</option>
													</c:otherwise>
												</c:choose>

											</select>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>身分證字號</label> <input type="text" class="form-control"
												value="${emp.id}" name="id" readonly>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>出生年月日</label> <input type="text" class="form-control"
												value="${emp.birthday}" id="birthday" name="birthday"
												autocomplete="off">
										</div>
									</div>

									<div class="col-md-5">
										<div class="form-group">
											<label>Email</label> <input type="text" class="form-control"
												value="${emp.email}" name="email" autocomplete="off">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label>手機</label> <input type="text" class="form-control"
												value="${emp.phone}" name="phone" autocomplete="off">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label>地址</label> <input type="text" class="form-control"
												value="${emp.address}" name="address" autocomplete="off">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label>部門</label> <input type="text" class="form-control"
												value="${emp.fkDeptno.dname}" readonly> <input
												type="text" name="fkDepartmentDeptn"
												value="${emp.fkDeptno.deptno}" hidden="">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label>職稱</label> <input type="text" class="form-control"
												value="${emp.fkTitleId.titleName}" readonly> <input
												type="text" name="fkTitleId"
												value="${emp.fkTitleId.titleId}" hidden="">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label>主管</label> <input type="text" class="form-control"
												value="${emp.superiorName}" readonly name="superiorName">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label>最高學府</label> <input type="text" class="form-control"
												value="${emp.highEdu}" name="highEdu" autocomplete="off">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label>學歷</label> <input type="text" class="form-control"
												value="${emp.highLevel}" name="highLevel" autocomplete="off">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label>科系</label> <input type="text" class="form-control"
												value="${emp.highMajor}" name="highMajor" autocomplete="off">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label>緊急連絡人</label> <input type="text" class="form-control"
												value="${emp.emergencyContact}" name="emergencyContact"
												autocomplete="off">
										</div>
									</div>
									<div class="col-md-2">
										<div class="form-group">
											<label>關係</label> <input type="text" class="form-control"
												value="${emp.contactRelationship}"
												name="contactRelationship" autocomplete="off">
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label>聯絡人電話</label> <input type="text" class="form-control"
												value="${emp.contactPhone}" name="contactPhone"
												autocomplete="off">
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label>照片更換</label> <br>
											<div class="custom-file">
												<input type="file" class="custom-file-input" id="photo"
													name="photo"> <label class="custom-file-label"
													for="photo">請上傳圖片</label>
											</div>
										</div>
									</div>
								</div>
								<div>
									<span style="font-size: 14px; color: gray;">記得按下更新才是更新完成喔！</span><br>
									<br> <input type="submit" class="btn btn-primary"
										value="更新">
								</div>
							</form>
						</div>
						<div class="tab-pane fade" id="password" role="tabpanel"
							aria-labelledby="password-tab">
							<h3 class="mb-4">密碼修改</h3>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label>舊密碼</label> <input type="password" class="form-control"
											name="oldPass" id="oldPass">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label>新密碼</label> <input type="password" class="form-control"
											name="newPassword" id="newPassword">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>請重新輸入新密碼</label> <input type="password"
											class="form-control" name="newPassword2" id="newPassword2">
									</div>
								</div>
								<div class="col-md-6">
									<h6 id="error1" style="color: red"></h6>
									<h6 id="error2" style="color: red"></h6>
									<h6 id="error3" style="color: red"></h6>
									<h6 id="error4" style="color: red"></h6>
								</div>

							</div>
							<div>
								<button type="button" class="btn btn-primary" id="changePwd">修改</button>
								<button type="button" class="btn btn-success" id="pwdSmartInput">一鍵</button>
							</div>
						</div>
						<div class="tab-pane fade" id="security" role="tabpanel"
							aria-labelledby="security-tab">
							<div class="row">
								<div class="col-md-6">
									<h4>員工專屬QR Code</h4>
									<img width="200px"
										src="${contextRoot}/src/EmpImg/${admin.qrcode}"> <a
										href="${contextRoot}/api/dowQRcode"><button type="button"
											class="btn btn-success">下載QR Code</button></a>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<h4>打卡紀錄</h4>
									<div class="input-group mb-3 col-sm-6">
										<div class="input-group mb-3 col-sm-6">
										<select class="form-control" aria-describedby="punchYear"
											name="punchYear" id="punchYear" required>
											<option value="2022">2022</option>
										</select>
										<div class="input-group-append">
											<label class="input-group-text" for="punchYear">年</label>
										</div>
										</div>
										<div class="input-group mb-3 col-sm-6">
										<select class="form-control" aria-describedby="punchMonth"
											name="punchMonth" id="punchMonth" required>
											<option value="" style="display: none"></option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
										</select>
										<div class="input-group-append">
											<label class="input-group-text" for="punchMonth">月</label>
										</div>
										</div>
										
									</div>
									<div class="board">
										<table style="width: 100%;">
											<thead>
												<tr>
													<td>打卡日期</td>
													<td>上班時間</td>
													<td>下班時間</td>
												</tr>
											</thead>
											<tbody id="punchbody">
											</tbody>
										</table>
									</div>
									<!-- 分頁 -->
									<div id="pagination" class="left">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!--right section-->

	</section>

	<script>
	<!----->
		$("#photo").change(function() {
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

		<!--生日DatePicker-->
		$("#birthday").datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			language : 'zh-TW',
		});

		<!--修改密碼ajax-->
		$('#changePwd').click(function () {
				let oldPass = $('#oldPass').val();
				let newPass = $('#newPassword').val();
				let newPass2 = $('#newPassword2').val();
				$("#error1").html("");
				$("#error2").html("");
				$("#error3").html("");
				$("#error4").html("");
				$.ajax({
						url: "http://localhost:8080/GroupOne/admin/changePassword?oldPass="+ oldPass+ "&newPass="+ newPass+ "&newPass2="+ newPass2,
						method: "post",
						success: function (data) {
							$("#error1").append(data.error);
							$("#error2").append(
								data.newPassword2);
							$("#error3").append(
								data.passwordError);
							$("#error4").append(
								data.oldPassError);
							if (data.errorTime == 0) {
								Swal.fire(
										{
											title: '更新成功!',
											html: '請重新使用新密碼登入',
											timer: 2000,
											timerProgressBar: true
										})
									.then(function () {
											$.ajax({
													url: "http://localhost:8080/GroupOne/adminLogOut2",
													method: "get",
													success: function () {
														window.location.href = "http://localhost:8080/GroupOne/adminLogin";
													}
												})
										})
							}
						}
					})
			})
		<!--新密碼一鍵輸入-->
		$("#pwdSmartInput").click(function() {
			$("#oldPass").val("A121889968");
			$("#newPassword").val("Passw0rd123@");
			$("#newPassword2").val("Passw0rd123@");
		})
		
		<!--打卡紀錄-->
		$("#punchMonth").change(function(){
			let year = $("#punchYear").val();
			let month = $(this).val();
			if(year != "" && month !=""){
				$.ajax({
					url:'http://localhost:8080/GroupOne/admin/getPersonalPunchData?year=' + year + '&month=' + month,
					method:'get',
					success:function(data){
						ajaxTable(data);
					}
				})
				
			}
		})
		<!--分頁按鈕-->
		$('body').on('click','button.btn-sm',function(){
			let p = $(this).html();
			let year = $("#punchYear").val();
			let month = $("#punchMonth").val();
			$.ajax({
				url:"http://localhost:8080/GroupOne/admin/getPersonalPunchData?year=" + year + "&month=" + month + "&p=" + p,
				method:"get",
				success: function(data){
					ajaxTable(data);
				}
			})
		})
		
		<!--ajax產Table-->
		function ajaxTable(data){
			$("#punchbody").html("")
			let tableBody = "";
			for(i=0;i<data.punches.length;i++){
				tableBody+="<tr><td>" + data.punches[i].punchYear + "-" + data.punches[i].punchMonth + "-" + data.punches[i].punchDate + "</td>" +
				   "<td>" + data.punches[i].onWorkTime + "</td>";
				if(data.punches[i].offWorkTime == null || data.punches[i].offWorkTime ==""){
					tableBody+="<td>未有紀錄</td></tr>"
				}else{
					tableBody+="<td>" + data.punches[i].offWorkTime + "</td></tr>"
				}	
			}
			$("#punchbody").append(tableBody);
			
			$("#pagination").html("");
			for(i=1;i<=data.pages;i++){
				$("#pagination").append("<button class='btn btn-secondary btn-sm'>" + i +"</button>");
			}
		}
		<!--下班打卡-->
		$("#punchDown").click(function(){
			$.ajax({
				url:"http://localhost:8080/GroupOne/admin/punchDown",
				method:"get",
				success: function(data){
					Swal.fire(
						      '已打下班卡!',
						      '現在時間:' + data,
						      'success'
						    );
				}
			})
		})
	</script>
</body>
</html>
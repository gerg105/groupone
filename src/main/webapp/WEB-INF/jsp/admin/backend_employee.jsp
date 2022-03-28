<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>天食地栗 | 後臺系統</title>
<!-- jQuery & BootStrap -->
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>

<!-- Font awesome -->
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css">

<!-- sweet alert -->
<link rel="stylesheet" href="${contextRoot}/css/sweetalert2.min.css">
<script src="${contextRoot}/js/sweetalert2.min.js"></script>

<!-- 自有 -->
<link rel="stylesheet" href="${contextRoot}/css/backend_style.css" />

<!-- bootstrap-datetimepicker -->
<script src="${contextRoot}/js/bootstrap-datepicker.js"></script>
<link rel="stylesheet"
	href="${contextRoot}/css/bootstrap-datepicker.min.css">
<script src="${contextRoot}/js/bootstrap-datepicker.zh-TW.min.js"></script>

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
				<a href="${contextRoot}/admin/account"><li><i class="fa fa-info-circle"></i>員工個人資料</li></a>
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
				<a href="${contextRoot}/admin/employee"><li class="active"><i class="fas fa-user-cog"></i>員工管理</li></a>
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


		<section>
			<!--right section-->
			<div class="title">
				<h3 class="i-name">員工管理</h3>
				<!-- Button trigger modal -->
				<button type="button" class="btn btn-primary" data-toggle="modal"
					data-target="#insertModal">新增員工</button>
			</div>
			<div class="search">
				<i class="far fa-search"></i> <input type="text"
					placeholder="輸入員工名稱..." id="searchbar">
			</div>
			<div class="board">
				<table style="width: 100%;">
					<thead>
						<tr>
							<td width='8%'>員工編號</td>
							<td>員工姓名</td>
							<td>部門職稱</td>
							<td>狀態</td>
							<td>到職日</td>
							<td></td>
							<td></td>
						</tr>
					</thead>
					<tbody id="tbody">
						<c:forEach items='${empPage.content}' var='emp'>

							<tr>
								<td>
									<p>${emp.empId}</p>
								</td>

								<td class="product"><img
									src="${contextRoot}/src/EmpImg/${emp.photo}">
									<div class="product-de">
										<h5>${emp.username}</h5>
										<p>${emp.email}/${emp.phone}</p>
									</div></td>

								<td class="product-des">
									<h5>${emp.fkTitleId.titleName}</h5>
									<p>${emp.fkDeptno.dname}</p>
								</td>


								<td class="product-des employee-state-${emp.fkStateId.id}">
									<h5>${emp.fkStateId.stateName}</h5>
								</td>

								<td class="product-des">
									<p>${emp.boardDate}</p>
								</td>
								<td><button type="button" class="btn btn-info" name='edit'
										data-toggle="modal" data-target="#editModal">修改</button></td>
								<td>
									<button type="button" class="btn btn-danger" name="delete">刪除</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<!-- 分頁 -->
			<div id="pagination" class="left">
				<c:forEach var="pageNumber" begin="1" end="${empPage.totalPages}">
					<button class="btn btn-secondary btn-sm">${pageNumber}</button>
				</c:forEach>
			</div>

			<!-- 新增員工Modal -->
			<div class="modal fade" id="insertModal" tabindex="-1"
				aria-labelledby="insertModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable modal-lg">
					<div class="modal-content ">
						<div class="modal-header">
							<h5 class="modal-title" id="insertModalLabel">新增員工</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<!-- form -->
							<form id="addEmpForm" class="form-inline" method="post"
								action="${contextRoot}/admin/addEmp"
								enctype="multipart/form-data">
								<input type="text" value="" name="orphoto" hidden="">
								<div class="col-sm-11">
									<h3>基本資料</h3>
								</div>

								<!-- 預覽 -->
								<div class="col-sm-12">
									<div class="preview-img">
										<img id="preview_img"
											src="${contextRoot}/src/webimg/backend/preview_img_512.jpg"
											style="max-width: 200px;" />

									</div>
									<br>
								</div>
								<!-- 預覽 -->
								<div class="input-group mb-3 col-sm-12">
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="photo"
											name="photo" data-target="preview_img"> <label
											class="custom-file-label" for="photo"
											aria-describedby="photo">請上傳員工照片</label>
									</div>
								</div>

								<div class="input-group mb-3 col-sm-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="username"><span
											style="color: red">*</span>員工姓名</label>
									</div>
									<input type="text" class="form-control" id="username"
										name="username" size="10" aria-describedby="username"
										autocomplete="off" required><br>
								</div>
								<div class="input-group mb-3 col-sm-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="id"><span
											style="color: red">*</span>身分證(帳號)</label>
									</div>
									<input type="text" class="form-control" id="id" name="id"
										size="10" aria-describedby="id" autocomplete="off" required><br>
								</div>

								<div class="input-group mb-3 col-sm-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="contact"><span
											style="color: red">*</span>性別</label>
									</div>
									<select class="form-control" aria-describedby="contact"
										name="contact" id="contact" required>
										<option value="" style="display: none"></option>
										<option id="male">男</option>
										<option id="female">女</option>
									</select>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="date"><span
											style="color: red">*</span>生日</label>
									</div>
									<input type="text" class="form-control" id="date" name="date"
										aria-describedby="date" autocomplete="off" required><br>
								</div>

								<div class="input-group mb-3 col-sm-5">
									<div class="input-group-prepend">
										<label class="input-group-text" for="phone"><span
											style="color: red">*</span>手機</label>
									</div>
									<input type="text" class="form-control" id="phone" name="phone"
										size="10" aria-describedby="phone" autocomplete="off" required><br>
								</div>

								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="email"><span
											style="color: red">*</span>Email</label>
									</div>
									<input type="text" class="form-control" id="email" name="email"
										size="30" aria-describedby="email" autocomplete="off" required><br>
								</div>

								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="address"><span
											style="color: red">*</span>地址</label>
									</div>
									<input type="text" class="form-control" id="address"
										name="address" size="30" aria-describedby="address"
										autocomplete="off" required><br>
								</div>
								<div class="col-sm-11">
									<h3>部門資料</h3>
								</div>
								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="fkDepartment"><span
											style="color: red">*</span>部門</label>
									</div>
									<select class="form-control" aria-describedby="fkDepartment"
										name="fkDepartmentDeptn" id="fkDepartment" required>
										<option value="" style="display: none"></option>
										<c:forEach items="${dNames}" var="dName">
											<c:choose>
												<c:when test="${emp.fkDeptno.dname == dName.dname}">
													<option value="${dName.deptno}" selected="selected">${dName.dname}</option>
												</c:when>
												<c:otherwise>
													<option value="${dName.deptno}">${dName.dname}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="fkTitleId"><span
											style="color: red">*</span>職稱</label>
									</div>
									<select class="form-control" aria-describedby="fkTitleId"
										name="fkTitleId" id="fkTitleId" required>
										<option value="" style="display: none"></option>
										<c:forEach items="${tNames}" var="tName">
											<c:choose>
												<c:when test="${emp.fkTitleId.titleName == tName.titleName}">
													<option value="${tName.titleId}" selected="selected">${tName.titleName}</option>
												</c:when>
												<c:otherwise>
													<option value="${tName.titleId}">${tName.titleName}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="superiorName">主管</label>
									</div>
									<select class="form-control" aria-describedby="superiorName"
										name="superiorName" id="superiorName" required>
										<option value="" style="display: none"></option>
									</select>
								</div>

								<div class="col-sm-11">
									<h3>學歷 & 聯絡人</h3>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="highEdu">最高學府</label>
									</div>
									<input type="text" class="form-control" id="highEdu"
										name="highEdu" size="10" aria-describedby="highEdu"
										autocomplete="off"><br>
								</div>
								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="highLevel">學歷</label>
									</div>
									<input type="text" class="form-control" id="highLevel"
										name="highLevel" size="10" aria-describedby="highLevel"
										autocomplete="off"><br>
								</div>
								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="highMajor">科系</label>
									</div>
									<input type="text" class="form-control" id="highMajor"
										name="highMajor" size="10" aria-describedby=""
										autocomplete="off"><br>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="emergencyContact">緊急聯絡人</label>
									</div>
									<input type="text" class="form-control" id="emergencyContact"
										name="emergencyContact" size="10" aria-describedby="highEdu"
										autocomplete="off"><br>
								</div>
								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="contactRelationship">聯絡人關係</label>
									</div>
									<input type="text" class="form-control"
										id="contactRelationship" name="contactRelationship" size="10"
										aria-describedby="highLevel" autocomplete="off"><br>
								</div>
								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="contactPhone">聯絡電話</label>
									</div>
									<input type="text" class="form-control" id="contactPhone"
										name="contactPhone" size="10" aria-describedby=""
										autocomplete="off"><br>
								</div>
							</form>
							<div class="modal-footer">
								<button type="button" class="btn btn-success" id="smartInput">快速輸入</button>
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">關閉</button>
								<button id="addBtn" type="button" class="btn btn-primary">送出</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end of modal -->







			<!-- 修改員工Modal -->
			<div class="modal fade" id="editModal" tabindex="-1"
				aria-labelledby="editModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable modal-lg">
					<div class="modal-content ">
						<div class="modal-header">
							<h5 class="modal-title" id="editModalLabel">修改員工資料</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<!-- form -->
							<form id="editEmpForm" class="form-inline" method="post"
								action="${contextRoot}/admin/updateEmp"
								enctype="multipart/form-data">
								<div class="col-sm-11">
									<input type="text" id="orphoto" name="orphoto"
										hidden="">
									<h3>基本資料</h3>
								</div>

								<!-- 預覽 -->
								<div class="col-sm-12">
									<div class="preview-img">
										<img id="preview_img_e"
											src="${contextRoot}/src/webimg/backend/preview_img_512.jpg"
											style="max-width: 200px;" />

									</div>
									<br>
								</div>
								<!-- 預覽 -->
								<div class="input-group mb-3 col-sm-12">
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="photo_e"
											name="photo" data-target="preview_img"> <label
											class="custom-file-label" for="photo"
											aria-describedby="photo">請上傳員工照片</label>
									</div>
								</div>

								<div class="input-group mb-3 col-sm-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="empId"><span
											style="color: red">*</span>員工編號</label>
									</div>
									<input type="text" class="form-control" id="empId_e"
										name="empId" size="10" aria-describedby="empId"
										autocomplete="off" readonly><br>
								</div>

								<div class="input-group mb-3 col-sm-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="empId"><span
											style="color: red">*</span>狀態</label>
									</div>
									<select class="form-control" aria-describedby="fkStateId"
										name="fkStateId" id="fkStateId_e" required>
										<c:forEach items="${states}" var="sName">
											<c:choose>
												<c:when test="${emp.fkStateId.stateName == sName.stateName}">
													<option value="${sName.id}" selected="selected">${sName.stateName}</option>
												</c:when>
												<c:otherwise>
													<option value="${sName.id}">${sName.stateName}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>


								<div class="input-group mb-3 col-sm-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="username"><span
											style="color: red">*</span>員工姓名</label>
									</div>
									<input type="text" class="form-control" id="username_e"
										name="username" size="10" aria-describedby="username"
										autocomplete="off" required><br>
								</div>
								<div class="input-group mb-3 col-sm-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="id"><span
											style="color: red">*</span>身分證(帳號)</label>
									</div>
									<input type="text" class="form-control" id="id_e" name="id"
										size="10" aria-describedby="id" autocomplete="off" readonly><br>
								</div>

								<div class="input-group mb-3 col-sm-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="contact"><span
											style="color: red">*</span>性別</label>
									</div>
									<select class="form-control" aria-describedby="contact"
										name="contact" id="contact_e" required>
										<option value="" style="display: none"></option>
										<option id="male_e">男</option>
										<option id="female_e">女</option>
									</select>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="date"><span
											style="color: red">*</span>生日</label>
									</div>
									<input type="text" class="form-control" id="date_e" name="birthday"
										aria-describedby="date" autocomplete="off" required><br>
								</div>

								<div class="input-group mb-3 col-sm-5">
									<div class="input-group-prepend">
										<label class="input-group-text" for="phone"><span
											style="color: red">*</span>手機</label>
									</div>
									<input type="text" class="form-control" id="phone_e"
										name="phone" size="10" aria-describedby="phone"
										autocomplete="off" required><br>
								</div>

								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="email"><span
											style="color: red">*</span>Email</label>
									</div>
									<input type="text" class="form-control" id="email_e"
										name="email" size="30" aria-describedby="email"
										autocomplete="off" required><br>
								</div>

								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="address"><span
											style="color: red">*</span>地址</label>
									</div>
									<input type="text" class="form-control" id="address_e"
										name="address" size="30" aria-describedby="address"
										autocomplete="off" required><br>
								</div>
								<div class="col-sm-11">
									<h3>部門資料</h3>
								</div>
								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="fkDepartment"><span
											style="color: red">*</span>部門</label>
									</div>
									<select class="form-control" aria-describedby="fkDepartment"
										name="fkDepartmentDeptn" id="fkDepartment_e" required>
										<option value="" style="display: none"></option>
										<c:forEach items="${dNames}" var="dName">
											<c:choose>
												<c:when test="${emp.fkDeptno.dname == dName.dname}">
													<option value="${dName.deptno}" selected="selected">${dName.dname}</option>
												</c:when>
												<c:otherwise>
													<option value="${dName.deptno}">${dName.dname}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="fkTitleId"><span
											style="color: red">*</span>職稱</label>
									</div>
									<select class="form-control" aria-describedby="fkTitleId"
										name="fkTitleId" id="fkTitleId_e" required>
										<option value="" style="display: none"></option>
										<c:forEach items="${tNames}" var="tName">
											<c:choose>
												<c:when test="${emp.fkTitleId.titleName == tName.titleName}">
													<option value="${tName.titleId}" selected="selected">${tName.titleName}</option>
												</c:when>
												<c:otherwise>
													<option value="${tName.titleId}">${tName.titleName}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="superiorName">主管</label>
									</div>
									<select class="form-control" aria-describedby="superiorName"
										name="superiorName" id="superiorName_e" required>
										<option value="" style="display: none"></option>
									</select>
								</div>

								<div class="col-sm-11">
									<h3>學歷 & 聯絡人</h3>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="highEdu">最高學府</label>
									</div>
									<input type="text" class="form-control" id="highEdu_e"
										name="highEdu" size="10" aria-describedby="highEdu"
										autocomplete="off"><br>
								</div>
								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="highLevel">學歷</label>
									</div>
									<input type="text" class="form-control" id="highLevel_e"
										name="highLevel" size="10" aria-describedby="highLevel"
										autocomplete="off"><br>
								</div>
								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="highMajor">科系</label>
									</div>
									<input type="text" class="form-control" id="highMajor_e"
										name="highMajor" size="10" aria-describedby=""
										autocomplete="off"><br>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="emergencyContact">緊急聯絡人</label>
									</div>
									<input type="text" class="form-control" id="emergencyContact_e"
										name="emergencyContact" size="10" aria-describedby="highEdu"
										autocomplete="off"><br>
								</div>
								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="contactRelationship">聯絡人關係</label>
									</div>
									<input type="text" class="form-control"
										id="contactRelationship_e" name="contactRelationship"
										size="10" aria-describedby="highLevel" autocomplete="off"><br>
								</div>
								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="contactPhone">聯絡電話</label>
									</div>
									<input type="text" class="form-control" id="contactPhone_e"
										name="contactPhone" size="10" aria-describedby=""
										autocomplete="off"><br>
								</div>
							</form>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">關閉</button>
								<button id="editBtn" type="button" class="btn btn-primary">送出</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end of modal -->


		</section>
	</section>

	<script>
	<!--圖片預覽-->
	//新增
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
	//修改
	$("#photo_e").change(function() {
		readURL2(this);
	});
	function readURL2(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#preview_img_e").attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	<!--生日DatePicker-->
	$("#date").datepicker({
		format : "yyyy-mm-dd",
		autoclose : true,
		language : 'zh-TW',
	});
	
	$("#date_e").datepicker({
		format : "yyyy-mm-dd",
		autoclose : true,
		language : 'zh-TW',
	});
	
	<!--Ajax顯示主管選項-->
	$("#fkDepartment").change(function(){
		ajaxSupervisor();
	})
	
	$("#fkTitleId").change(function(){
		ajaxSupervisor();
	})
	
	$("#fkDepartment_e").change(function(){
		ajaxSupervisor2();
	})
	
	$("#fkTitleId_e").change(function(){
		ajaxSupervisor2();
	})
	
	<!--Ajax更新主管選項 (新增)-->
	function ajaxSupervisor(){
		let departId = $("#fkDepartment").val();
		let titleId = $("#fkTitleId").val();
		console.log(departId);
		console.log(titleId);
		if(departId!="" || titleId!=""){
			$.ajax({
				url:'http://localhost:8080/GroupOne/api/getSupervisorInsert?departId=' + departId + '&titleId=' + titleId,
				dataType:'json',
				method:'get',
				success:function(data){
					$('#superiorName').html("");
					let superiorOption = "";
					superiorOption += '<option value="" style="display: none"></option>';
					for(i=0; i<data.length;i++){
						if(i==0){
							superiorOption += '<option value= "'+ data[i].username + '" selected>' + data[i].username + '</option>';
						}else{
							superiorOption += '<option value= "'+ data[i].username + '">' + data[i].username + '</option>';
						}
					}
					$('#superiorName').append(superiorOption);
				},
				error:function(err){
					console.log(err)
					alert('發生錯誤1')
				}
			})
		} // end of if
	}
	
	<!--ajax更新主管選項 (修改)-->
	function ajaxSupervisor2(){
		let departId = $("#fkDepartment_e").val();
		let titleId = $("#fkTitleId_e").val();
		let empID = $("#empId_e").val();
		if(departId!="" || titleId!=""){
			$.ajax({
				url:'http://localhost:8080/GroupOne/api/getSupervisorEdit?departId=' + departId + '&titleId=' + titleId + '&empId=' + empID,
				dataType:'json',
				method:'get',
				success:function(data){
					$('#superiorName_e').html("");
					let superiorOption = "";
					superiorOption += '<option value="" style="display: none"></option>';
					for(i=0; i<data.length;i++){
						if(i==0){
							superiorOption += '<option value= "'+ data[i].username + '" selected>' + data[i].username + '</option>';
						}else{
							superiorOption += '<option value= "'+ data[i].username + '">' + data[i].username + '</option>';
						}
					}
					$('#superiorName_e').append(superiorOption);
				},
				error:function(err){
					console.log(err)
					alert('發生錯誤1')
				}
			})
		} // end of if
	}
	<!--驗證並送出表單-->
	$('#addBtn').click(function(){
		let form = $('#addEmpForm');
		let reportValidity = form[0].reportValidity();
		
		if(reportValidity){
			Swal.fire({
				  title: '寄送開通信件中...',
				  didOpen: () => {
				    Swal.showLoading();
				  },
				})
			$('#addEmpForm').submit();
		}
	});
	$('#editBtn').click(function(){
		let form = $('#editEmpForm');
		let reportValidity = form[0].reportValidity();
		
		if(reportValidity){
			$('#editEmpForm').submit();
		}
	});
	
	
	<!--快速輸入-->
	$('#smartInput').click(function(){
		$('#username').val("劉以豪");
		$('#id').val("A121889968");
		$('#male').prop('selected', true);
		$('#date').val("1986-08-12")
		$('#phone').val("0988168888")
		$('#email').val("eeit138g1.07@gmail.com")
		$('#address').val("10491台北市中山區民權東路二段109號");
		$('#fkDepartment').val("300");
		$('#fkTitleId').val("10");
		$('#highEdu').val("大葉大學");
		$('#highLevel').val("學士");
		$('#highMajor').val("視覺傳達設計學系");
		$('#emergencyContact').val("劉爸爸");
		$('#contactRelationship').val("父子");
		$('#contactPhone').val("0987653232");
		ajaxSupervisor();
	});
	<!--模糊查詢-->
	$('#searchbar').keyup(function(){
		let search = $(this).val();
		$.ajax({
			url:"employee/find?search=" + search,
			method:"get",
			success: function(data){
				ajaxTable(data);
			}
		})
	})
	
	<!--刪除-->
	$('body').on('click','button[name="delete"]',function(){
		let id = $(this).parent().parent().find("p").html();
			
		Swal.fire({
			  title: '確定要刪除嗎?',
			  text: "注意：資料刪除後無法恢復!",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#dc3545',
			  cancelButtonColor: '#6c757d',
			  confirmButtonText: '確認刪除',
			  cancelButtonText: '取消'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
						url:"deleteEmployee/" + id,
						method:"delete",
						success: function(data){
							ajaxTable(data);
						}
					});
				  Swal.fire(
			      '刪除成功',
			      '該員工已被刪除',
			      'success'
			    );
			  }
			});
	});
	
	<!--分頁按鈕-->
	$('body').on('click','button.btn-sm',function(){
		let p = $(this).html();
		let search = $('#searchbar').val();
		$.ajax({
			url:"employee/find?search=" + search + "&p=" + p,
			method:"get",
			success: function(data){
				ajaxTable(data);
			}
		})
	})
	
	<!--修改-->
	
	$('body').on('click','button[name="edit"]',function(){
		let id = $(this).parent().parent().find("p").html();
		$.ajax({
			url:"employee/getjson?ID=" + id,
			method:"get",
			success: function(data){
				$('#empId_e').val(data.empId);
				$('#fkStateId_e').val(data.fkStateId.id);
				$('#username_e').val(data.username);
				$('#id_e').val(data.id);
				if(data.sex =="男"){
					$('#male_e').attr('selected','selected');
				}else{
					$('#female_e').attr('selected','selected');
				}
				$('#date_e').val(data.birthday);
				$('#phone_e').val(data.phone);
				$('#email_e').val(data.email);
				$('#address_e').val(data.address);
				$('#fkDepartment_e').val(data.fkDeptno.deptno);
				$('#fkTitleId_e').val(data.fkTitleId.titleId);
				$('#superiorName_e').val(data.superiorName);
				$('#highEdu_e').val(data.highEdu);
				$('#highLevel_e').val(data.highLevel);
				$('#highMajor_e').val(data.highMajor);
				$('#emergencyContact_e').val(data.emergencyContact);
				$('#contactRelationship_e').val(data.contactRelationship);
				$('#contactPhone_e').val(data.contactPhone);
				$('#preview_img_e').attr('src', '/GroupOne/src/EmpImg/' + data.photo);
				$('#orphoto').val(data.photo);
				let empID = data.empId;
				let departId = data.fkDeptno.deptno;
				let titleId = data.fkTitleId.titleId;
				$.ajax({
					url:'http://localhost:8080/GroupOne/api/getSupervisorEdit?departId=' + departId + '&titleId=' + titleId + '&empId=' + empID,
					dataType:'json',
					method:'get',
					success:function(data2){
						$('#superiorName_e').html("");
						let superiorOption = "";
						for(i=0; i<data2.length;i++){
							if(data.superiorName == data2[i].username){
								superiorOption += '<option value= "'+ data2[i].username + '" selected>' + data2[i].username + '</option>';
							}else{
								superiorOption += '<option value= "'+ data2[i].username + '">' + data2[i].username + '</option>';
							}
						}
						$('#superiorName_e').append(superiorOption);
					}
				})
			}
		});
	});
	
	<!--Ajax產Table-->
	function ajaxTable(data){
		$("#tbody").html("");
		for(i=0;i<data.employees.length;i++){
			$("#tbody").append(
					"<tr><td><p>" + data.employees[i].empId + "</p></td>" +
					"<td class='product'><img src='http://localhost:8080/GroupOne/src/EmpImg/" + data.employees[i].photo+ "'>" +
					"<div class='product-de'><h5>" + data.employees[i].username + "</h5>" + 
					"<p>" + data.employees[i].email + "/" + data.employees[i].phone + "</p></div></td>" + 
					"<td class='product-des'><h5>" + data.employees[i].fkTitleId.titleName + "</h5><p>" + data.employees[i].fkDeptno.dname + "</p></td>" +
					"<td class='product-des employee-state-" + data.employees[i].fkStateId.id + "'><h5>" + data.employees[i].fkStateId.stateName + "</h5></td>" + 
					"<td class='product-des'><p>" + data.employees[i].boardDate + "</p></td>" +
					"<td><button type='button' class='btn btn-info' name='edit' data-toggle='modal'	data-target='#editModal'>修改</button></td>" + 
					"<td><button type='button' class='btn btn-danger' name='delete'>刪除</button></td></tr>");
	
		}
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
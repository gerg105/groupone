<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>天食地栗 | 後臺系統</title>
<!-- jQuery & BootStrap -->
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>

<!-- Font awesome -->
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css">

<!-- summer note -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script src="${contextRoot}/js/summernote-zh-TW.min.js"></script>

<!-- sweet alert -->
<link rel="stylesheet" href="${contextRoot}/css/sweetalert2.min.css">
<script src="${contextRoot}/js/sweetalert2.min.js"></script>

<!-- 自有 -->
<link rel="stylesheet" href="${contextRoot}/css/backend_style.css" />

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
				<a href="${contextRoot}/admin/member"><li class="active"><i class="fa fa-users"></i>會員管理</li></a>
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


		<section>
			<!--right section-->
			<div class="title">
				<h3 class="i-name">會員管理</h3>
			</div>
			<div class="search">
				<i class="far fa-search"></i> <input type="text"
					placeholder="輸入會員資訊..." id="searchbar">
			</div>
			<div class="board">
				<table style="width: 100%;">
					<thead>
						<tr>
							<td width='8%'>會員編號</td>
							<td>會員名稱</td>
							<td>性別</td>
							<td>VIP等級</td>
							<td>帳號狀態</td>
							<td></td>
							<td></td>
						</tr>
					</thead>
					<tbody id="tbody">
						<c:forEach items='${mems.content}' var='mem'>

							<tr>
								<td>
									<p>${mem.ID}</p>
								</td>

								<td class="product"><img
									src="${contextRoot}/src/${mem.pic}">
									<div class="product-de">
										<h5>${mem.name}</h5>
										<p>${mem.email}/ ${mem.tel}</p>
									</div></td>

								<td class="product-des">
									<h5>${mem.gender}</h5>
									<p>${mem.birth}</p>
								</td>

								<td class="active-${mem.vip.vipID}">
									<p>${mem.vip.vipTitle}</p>
								</td>

								<td class="status-${mem.blacklist.listID}">
									<p>${mem.blacklist.listTitle}</p>
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
				<c:forEach var="pageNumber" begin="1" end="${mems.totalPages}">
					<button class="btn btn-secondary btn-sm">${pageNumber}</button>
				</c:forEach>
			</div>

			<!-- 修改Modal -->
			<div class="modal fade" id="editModal" tabindex="-1"
				aria-labelledby="editModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable">
					<div class="modal-content ">

						<div class="modal-header">
							<h5 class="modal-title" id="editModalLabel">會員等級修改</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<!-- form -->
							<form method="post" action="${contextRoot}/admin/updateMember">
								<img src="#" class="rounded float-left" id="memPic" style="max-width:200px"> <input
									type="text" id="mID_e" name="mID_e" style="display: none;" />
								<div class="input-group mb-3 col-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="mName_e">會員名稱</label>
									</div>
									<input type="text" class="form-control" id="mName_e"
										name="mName_e" aria-describedby="mName_e" readonly><br>
								</div>
								<div class="input-group mb-3 col-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="mAcc_e">會員帳號</label>
									</div>
									<input type="text" class="form-control" id="mAcc_e"
										name="mAcc_e" aria-describedby="mAcc_e" readonly><br>
								</div>

								<div class="input-group mb-3 col-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="memVIP">VIP 等級</label>
									</div>
									<select class="form-control" aria-describedby="memVIP"
										name="memVIP" id="memVIP">
										<c:forEach items="${vips}" var="vip">
											<option value="${vip.vipID}">${vip.vipTitle}</option>
										</c:forEach>
									</select>
								</div>
								<div class="input-group mb-3 col-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="memBlacklist">黑名單</label>
									</div>
									<select class="form-control" aria-describedby="memBlacklist"
										name="memBlacklist" id="memBlacklist">
										<c:forEach items="${blackLists}" var="blacklist">
											<option value="${blacklist.listID}">${blacklist.listTitle}</option>
										</c:forEach>
									</select>
								</div>

								<br>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">關閉</button>
									<input type="submit" class="btn btn-primary" value="修改" />
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- end of modal -->
		</section>
	</section>
	<script>
	<!--模糊查詢-->
	$('#searchbar').keyup(function(){
		let search = $(this).val();
		$.ajax({
			url:"member/find?search=" + search,
			method:"get",
			success: function(data){
				ajaxTable(data);
			}
		})
	})
	<!--分頁按鈕-->
	$('body').on('click','button.btn-sm',function(){
		let p = $(this).html();
		let search = $('#searchbar').val();
		$.ajax({
			url:"member/find?search=" + search + "&p=" + p,
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
						url:"deleteMember/" + id,
						method:"delete",
						success: function(data){
							ajaxTable(data);
						}
					});
				  Swal.fire(
			      '刪除成功',
			      '該會員已被刪除',
			      'success'
			    );
			  }
			});
	});
	
	<!--修改-->
	$('body').on('click','button[name="edit"]',function(){
		let id = $(this).parent().parent().find("p").html();
		$.ajax({
			url:"member/getjson?id=" + id,
			method:"get",
			success: function(data){
				$('#mID_e').val(data.id);
				$('#mName_e').val(data.name);
				$('#mAcc_e').val(data.account);
				$('#memVIP').val(data.vip.vipID);
				$('#memBlacklist').val(data.blacklist.listID);
				$('#memPic').attr('src','/GroupOne/src/' + data.pic);
			}
		});
		
	})
		
	
	<!--ajax產table-->
	function ajaxTable(data){
		$("#tbody").html("");
		for(i=0;i<data.members.length;i++){
			$("#tbody").append("<tr><td><p>" + data.members[i].id + "</p></td>" +
					"<td class='product'><img src='http://localhost:8080/GroupOne/src/" + data.members[i].pic+ "'>" +
					"<div class='product-de'><h5>" + data.members[i].name + "</h5><p>" + data.members[i].email +"/" +data.members[i].tel +"</p></div></td>" + 
					"<td class='product-des'><h5>" + data.members[i].gender + "</h5><p>" + data.members[i].birth + "</p></td>" +
					"<td class='active-" + data.members[i].vip.vipID + "'><p>" + data.members[i].vip.vipTitle + "</p></td>" + 
					"<td class='status-" + data.members[i].blacklist.listID + "'><p>" + data.members[i].blacklist.listTitle + "</p></td>"+
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
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
				<a href="${contextRoot}/admin/coupon"><li class="active"><i class="fal fa-badge-percent"></i>優惠券管理</li></a>
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
				<h3 class="i-name">優惠券管理</h3>
				<!-- Button trigger modal -->
				<button type="button" class="btn btn-primary" data-toggle="modal"
					data-target="#insertModal">新增優惠</button>
			</div>
			<div class="search">
				<i class="far fa-search"></i> <input type="text"
					placeholder="輸入優惠名稱或折扣碼" id="searchbar">
			</div>
			<div class="board">
				<table style="width: 100%;">
					<thead>
						<tr>
							<td width='7%'>編號</td>
							<td>優惠名稱</td>
							<td>折扣金額</td>
							<td>到期日</td>
							<td></td>
							<td></td>
						</tr>
					</thead>
					<tbody id="tbody">
						<c:forEach items='${couponPage.content}' var='coupon'>

							<tr>
								<td>
									<p>${coupon.id}</p>
								</td>

								<td class="product">
									<div class="product-de">
										<h5>${coupon.type}</h5>
										<p>折扣碼: ${coupon.code}</p>
									</div>
								</td>

								<td class="product-des">
									<h5>折$ ${coupon.discount}</h5>
									<p>需滿$ ${coupon.lowest}</p>
								</td>


								<td class="product-des">
									<p>${coupon.endDate}</p>
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
				<c:forEach var="pageNumber" begin="1" end="${couponPage.totalPages}">
					<button class="btn btn-secondary btn-sm">${pageNumber}</button>
				</c:forEach>
			</div>

			
			
			<!-- 新增優惠Modal -->
			<div class="modal fade" id="insertModal" tabindex="-1"
				aria-labelledby="insertModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable modal-lg">
					<div class="modal-content ">
						<div class="modal-header">
							<h5 class="modal-title" id="insertModalLabel">新增優惠</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<!-- form -->
							<form id="addCouponForm" class="form-inline" method="post"
								action="${contextRoot}/admin/createCoupon"
								enctype="multipart/form-data">
								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="type">活動名稱</label>
									</div>
									<input type="text" class="form-control" size="20" id="type"
										name="type" aria-describedby="type" autocomplete="off"
										required><br>
								</div>
								<div class="input-group mb-3 col-sm-9">
									<div class="input-group-prepend">
										<label class="input-group-text" for="code">優惠券序號</label>
									</div>
									<input type="text" class="form-control" size="20" id="code" name="code"
										aria-describedby="code" autocomplete="off" required><br>
								</div>
								<div class="input-group mb-3 col-sm-3">
									<button type="button" class="btn btn-info" id="randombtn">隨機產生</button>
								</div>

								<div class="input-group mb-3 col-sm-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="dis">折扣</label>
									</div>
									<select class="form-control" aria-describedby="dis" name="dis"
										id="dis" required>
										<option value="" style="display: none"></option>
										<option value="50">50</option>
										<option value="100">100</option>
										<option value="200">200</option>
										<option value="500">500</option>
									</select>

								</div>
								<div class="input-group mb-3 col-sm-3">
									<input type="number" class="form-control" id="discount"
										name="discount" size="20" min="50" step="5"
										aria-describedby="discount" autocomplete="off" required><br>
								</div>
								<div class="input-group mb-3 col-sm-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="low">低消</label>
									</div>
									<select class="form-control" aria-describedby="low" name="low"
										id="low" required>
										<option value="" style="display: none"></option>
										<option value="100">100</option>
										<option value="200">200</option>
										<option value="500">500</option>
										<option value="1000">1000</option>
										<option value="2000">2000</option>
									</select>
								</div>
								<div class="input-group mb-3 col-sm-3">
									<input type="number" class="form-control" id="lowest"
										name="lowest" size="20" min="100" step="50"
										aria-describedby="lowest" autocomplete="off" required><br>
								</div>
								
								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="endDate">使用期限</label>
									</div>
									<input type="text" class="form-control" id="endDate" name="endDate"
										aria-describedby="endDate" autocomplete="off" required><br>
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



			<!-- 修改優惠Modal -->
			<div class="modal fade" id="editModal" tabindex="-1"
				aria-labelledby="editModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable modal-lg">
					<div class="modal-content ">
						<div class="modal-header">
							<h5 class="modal-title" id="editModalLabel">修改優惠</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<!-- form -->
							<form id="editCouponForm" class="form-inline" method="post"
								action="${contextRoot}/admin/editCoupon"
								enctype="multipart/form-data">
								<input type="text" id="couponId_e" name="id" hidden="">
								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="type">活動名稱</label>
									</div>
									<input type="text" class="form-control" size="20" id="type_e"
										name="type" aria-describedby="type" autocomplete="off"
										required><br>
								</div>
								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="code">優惠券序號</label>
									</div>
									<input type="text" class="form-control" size="20" id="code_e" name="code"
										aria-describedby="code" autocomplete="off" required readonly><br>
								</div>

								<div class="input-group mb-3 col-sm-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="discount">折扣</label>
									</div>
									<input type="number" class="form-control" id="discount_e"
										name="discount" size="20" min="50" step="5"
										aria-describedby="discount" autocomplete="off" required><br>
								</div>

								<div class="input-group mb-3 col-sm-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="lowest">低消</label>
									</div>
									<input type="number" class="form-control" id="lowest_e"
										name="lowest" size="20" min="100" step="50"
										aria-describedby="lowest" autocomplete="off" required><br>
								</div>
								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="endDate">使用期限</label>
									</div>
									<input type="text" class="form-control" id="endDate_e" name="endDate"
										aria-describedby="endDate" autocomplete="off" required><br>
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
	$("#dis").change(function() {
		$("#discount").val($(this).val());
	})
	$("#low").change(function() {
		$("#lowest").val($(this).val());
	})
	$("#endDate").datepicker({
		format : "yyyy/mm/dd",
		autoclose : true,
		language : 'zh-TW',
	});
	$("#endDate_e").datepicker({
		format : "yyyy/mm/dd",
		autoclose : true,
		language : 'zh-TW',
	});
	<!--隨機產生-->
	$("#randombtn").click(function(){
		$.ajax({
			url:'http://localhost:8080/GroupOne/admin/randomCoupon',
			method:'get',
			success:function(data){
				$("#code").val(data);
			}
		})
	});
	
	<!--分頁按鈕-->
	$('body').on('click','button.btn-sm',function(){
		let p = $(this).html();
		let search = $('#searchbar').val();
		$.ajax({
			url:"coupon/find?search=" + search + "&p=" + p,
			method:"get",
			success: function(data){
				ajaxTable(data);
			}
		})
	})
	
	<!--快速輸入-->
	$("#smartInput").click(function(){
		$("#type").val("春節野餐趣-滿兩百五折五十");
		$("#code").val("spring666");
		$("#dis").val("50");
		$("#discount").val("50");
		$("#low").val("200");
		$("#lowest").val("200");
		$("#endDate").val("2022/04/30");
	})
	
	<!--驗證並送出-->
	$('#addBtn').click(function(){
		let form = $('#addCouponForm');
		let reportValidity = form[0].reportValidity();
		
		if(reportValidity){
			$('#addCouponForm').submit();
		}
	});
	$('#editBtn').click(function(){
		let form = $('#editCouponForm');
		let reportValidity = form[0].reportValidity();
		
		if(reportValidity){
			$('#editCouponForm').submit();
		}
	});
	
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
						url:"deleteCoupon/" + id,
						method:"delete",
						success: function(data){
							ajaxTable(data);
						}
					});
				  Swal.fire(
			      '刪除成功',
			      '該優惠已被刪除',
			      'success'
			    );
			  }
			});
	});
	
	<!--修改-->
	$('body').on('click','button[name="edit"]',function(){
		let id = $(this).parent().parent().find("p").html();
		$.ajax({
			url:"coupon/getjson?id=" + id,
			method:"get",
			success: function(data){
				$("#couponId_e").val(data.id);
				$("#code_e").val(data.code);
				$("#discount_e").val(data.discount);
				$("#lowest_e").val(data.lowest);
				$("#type_e").val(data.type);
				$("#endDate_e").val(data.endDate.substring(0, 10));
			}
		});
	});
	
	$('#searchbar').keyup(function(){
		let search = $(this).val();
		$.ajax({
			url:"coupon/find?search=" + search,
			method:"get",
			success: function(data){
				ajaxTable(data);
			}
		})
	})
	
	<!--ajax產Table-->
	function ajaxTable(data){
		$("#tbody").html("");
		for(i=0;i<data.coupons.length;i++){
			$("#tbody").append("<tr><td><p>" + data.coupons[i].id + "</p></td>" + 
							   "<td class='product'><div class='product-de'><h5>"+ data.coupons[i].type +"</h5><p>折扣碼: " + data.coupons[i].code+"</p></div></td>"+
							   "<td class='product-des'><h5>折$ " + data.coupons[i].discount  +"</h5><p>需滿$ " + data.coupons[i].lowest + "</p></td>" + 
							   "<td class='product-des'><p>" + data.coupons[i].endDate + "</p></td>"+
							   "<td><button type='button' class='btn btn-info' name='edit' data-toggle='modal' data-target='#editModal'>修改</button></td>"+
							   "<td><button type='button' class='btn btn-danger' name='delete'>刪除</button></td>	</tr>")
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
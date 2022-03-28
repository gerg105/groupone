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
				<a href="${contextRoot}/admin/order"><li class="active"><i class="far fa-file-invoice-dollar"></i>訂單管理</li></a>
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
				<h3 class="i-name">訂單管理</h3>
			</div>
			<div class="search">
				<i class="far fa-search"></i> <input type="text"
					placeholder="輸入會員資訊..." id="searchbar">
			</div>
			<div class="board">
				<table style="width: 100%;">
					<thead>
						<tr>
							<td width='7%'>編號</td>
							<td>購買人</td>
							<td>訂單金額</td>
							<td>折扣</td>
							<td>日期</td>
							<td>訂單狀態</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="tbody">
						<c:forEach items='${orderPage.content}' var='order'>

							<tr>
								<td>
									<p>${order.orderNumber}</p>
								</td>

								<td class="product"><img
									src="${contextRoot}/src/${order.member.pic}">
									<div class="product-de">
										<h5>${order.member.name}</h5>
										<p>${order.member.email}/${order.member.tel}</p>
									</div></td>

								<td class="product-des">
									<div>
										<h5>$ ${order.totalAmount}</h5>
									</div>
								</td>

								<td class="product-des">
									<div>
										<p>${order.coupon}</p>
									</div>
								</td>

								<td class="product-des">
									<p>${fn:substring(order.orderDate, 0, 19)}</p>
								</td>

								<td class="active stat-${order.orderStats.orderStatsID}">
									<p>${order.orderStats.orderStats}</p>
								</td>
							
								<td><button type="button" class="btn btn-info" name='edit'
										data-toggle="modal" data-target="#editModal">明細</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<!-- 分頁 -->
			<div id="pagination" class="left">
				<c:forEach var="pageNumber" begin="1" end="${orderPage.totalPages}">
					<button class="btn btn-secondary btn-sm">${pageNumber}</button>
				</c:forEach>
			</div>

			<!-- 訂單明細Modal -->
			<div class="modal fade" id="editModal" tabindex="-1"
				aria-labelledby="editModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable modal-lg">
					<div class="modal-content ">
						<div class="modal-header">
							<h5 class="modal-title" id="editModalLabel">訂單明細</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<!-- form -->
							<form id="editForm" class="form-inline" method="post"
								action="${contextRoot}/admin/editOrder"
								enctype="multipart/form-data">
								<div class="input-group mb-3 col-sm-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="orderNumber">訂單編號</label>
									</div>
									<input type="text" class="form-control" size="20"
										id="orderNumber" name="orderNumber"
										aria-describedby="orderNumber" autocomplete="off" readonly><br>
								</div>

								<div class="input-group mb-3 col-sm-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="coupon">使用優惠</label>
									</div>
									<input type="text" class="form-control" size="20" id="coupon"
										name="coupon" aria-describedby="coupon" autocomplete="off"
										readonly><br>
								</div>


								<div class="input-group mb-3 col-sm-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="beforeDiscount">原訂單金額</label>
									</div>
									<input type="text" class="form-control" size="20"
										id="beforeDiscount" name="beforeDiscount"
										aria-describedby="beforeDiscount" autocomplete="off" readonly><br>
								</div>

								<div class="input-group mb-3 col-sm-6">
									<div class="input-group-prepend">
										<label class="input-group-text" for="totalAmount">折扣後金額</label>
									</div>
									<input type="text" class="form-control" size="20"
										id="totalAmount" name="totalAmount"
										aria-describedby="totalAmount" autocomplete="off" readonly><br>
								</div>

								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="store">取貨店家</label>
									</div>
									<input type="text" class="form-control" size="20" id="store"
										name="store" aria-describedby="store" autocomplete="off"
										required readonly><br>
								</div>

								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="remark">訂單備註</label>
									</div>
									<textarea class="form-control" id="remark" name="remark"
										aria-describedby="remark" autocomplete="off"
										style="resize: none;" readonly></textarea>
								</div>


								<table class="table">
									<thead>
										<tr>
											<th></th>
											<th>品名</th>
											<th>數量</th>
										</tr>
									</thead>
									<tbody id="detailBody">
									</tbody>
								</table>
								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="orderStats">訂單狀態</label>
									</div>
									<select class="form-control" aria-describedby="orderStats"
										name="orderStats" id="orderStats" required>
										<option value="" style="display: none"></option>
										<c:forEach items="${orderStats}" var="stat">
											<option value="${stat.orderStatsID}">${stat.orderStats}</option>
										</c:forEach>
									</select>
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
	<!--驗證並送出-->
	$('#editBtn').click(function(){
		let form = $('#editForm');
		let reportValidity = form[0].reportValidity();
		
		if(reportValidity){
			$('#editForm').submit();
		}
	});
	
	<!--明細-->
	$('body').on('click','button[name="edit"]',function(){
		let orderNumber = $(this).parent().parent().find("p").html();
		$.ajax({
			url:"http://localhost:8080/GroupOne/orderDetail?id=" + orderNumber,
			method:"get",
			success: function(data){
				$("#orderNumber").val(orderNumber);
				$("#coupon").val(data.orderInformation.coupon);
				$("#beforeDiscount").val(data.orderInformation.beforeDiscount);
				$("#totalAmount").val(data.orderInformation.totalAmount);
				$("#store").val(data.orderInformation.storename + " / " + data.orderInformation.storeaddress);
				$("#remark").val(data.orderInformation.remark);
				$("#orderStats").val(data.orderInformation.orderStats.orderStatsID)
				
				
				$("#detailBody").html("")
				for(i=0;i<data.orderDetailList.length;i++){
					$("#detailBody").append("<tr><td><img width='100px' src='http://localhost:8080/GroupOne/" + data.orderDetailList[i].product.productPicUrl + "'></td>" + 
									   "<td>" + data.orderDetailList[i].product.productName + "</td>"+
									   "<td>" + data.orderDetailList[i].amount + "</td></tr>")
				}
			}
		});
	});
	
	<!--分頁按鈕-->
	$('body').on('click','button.btn-sm',function(){
		let p = $(this).html();
		$('#searchbar').val("");
		$.ajax({
			url:"order/find?p=" + p,
			method:"get",
			dataType:"json",
			success: function(data){
				ajaxTable(data);
			}
		})
	})
	
	<!--模糊查詢-->
	$('#searchbar').keyup(function(){
		let search = $(this).val();
		if(search == null || search ==""){
			$.ajax({
				url:"order/find?p=1",
				method:"get",
				dataType:"json",
				success: function(data){
					ajaxTable(data);
				}
			})
			
		}else{
			$.ajax({
				url:"order/findlist?search=" + search,
				method:"get",
				success: function(data){
					$("#tbody").html("");
					$("#pagination").html("");
					for(i=0;i<data.length;i++){
						$("#tbody").append("<tr><td><p>" + data[i].orderNumber + "</p></td>" +
									"<td class='product'><img src='http://localhost:8080/GroupOne/src/" + data[i].member.pic+ "'>" +
									"<div class='product-de'><h5>" + data[i].member.name + "</h5>" + 
									"<p>" + data[i].member.email + "/" + data[i].member.tel + "</p></div></td>" + 
									"<td class='product-des'><div><h5>$ " + data[i].totalAmount + "</h5></div></td>" +
									"<td class='product-des'><div><p>" + data[i].coupon + "</p></div></td>" +
									"<td class='product-des'><p>" + data[i].orderDate.substring(0, 19) + "</p></td>" + 
									"<td class='active stat-" + data[i].orderStats.orderStatsID + "'><p>" + data[i].orderStats.orderStats + "</p></td>" + 
									"<td><button type='button' class='btn btn-info' name='edit' data-toggle='modal'	data-target='#editModal'>明細</button></td></tr>");
					
					}
				}
			})
		}
	})
	
	<!--ajax產Table (分頁)-->
	function ajaxTable(data){
		$("#tbody").html("");
		for(i=0;i<data.orders.length;i++){
			$("#tbody").append("<tr><td><p>" + data.orders[i].orderNumber + "</p></td>" +
						"<td class='product'><img src='http://localhost:8080/GroupOne/src/" + data.orders[i].member.pic+ "'>" +
						"<div class='product-de'><h5>" + data.orders[i].member.name + "</h5>" + 
						"<p>" + data.orders[i].member.email + "/" + data.orders[i].member.tel + "</p></div></td>" + 
						"<td class='product-des'><div><h5>$ " + data.orders[i].totalAmount + "</h5></div></td>" +
						"<td class='product-des'><div><p>" + data.orders[i].coupon + "</p></div></td>" +
						"<td class='product-des'><p>" + data.orders[i].orderDate.substring(0, 19) + "</p></td>" + 
						"<td class='active stat-" + data.orders[i].orderStats.orderStatsID + "'><p>" + data.orders[i].orderStats.orderStats + "</p></td>" + 
						"<td><button type='button' class='btn btn-info' name='edit' data-toggle='modal'	data-target='#editModal'>明細</button></td></tr>");
		
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
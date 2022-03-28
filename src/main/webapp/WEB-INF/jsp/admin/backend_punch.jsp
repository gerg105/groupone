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

<!-- ico -->
<link rel="shortcut icon" href="${contextRoot}/src/webimg/icon_round.ico">

<!-- flot -->
<script src='${contextRoot}/js/flot/jquery.js' type="text/javascript"></script>
<script src='${contextRoot}/js/flot/jquery.flot.js'
	type="text/javascript"></script>
<script src='${contextRoot}/js/flot/jquery.flot.pie.js'
	type="text/javascript"></script>

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
				<a href="${contextRoot}/admin/employee"><li><i class="fas fa-user-cog"></i>員工管理</li></a>
				<a href="${contextRoot}/admin/punch"><li class="active"><i class="fas fa-clock"></i>員工打卡紀錄</li></a>
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
			<div>
				<div class="title">
					<h3 class="i-name">員工打卡紀錄</h3>
				</div>
				<div>
					<div class="input-group mb-3 col-sm-10">
						<div class="input-group mb-3 col-sm-5">
							<select class="form-control" name="employees" id="employees">
								<option value="" style="display: none"></option>
								<c:forEach items="${emps}" var="emp">
									<option value="${emp.empId}">${emp.fkDeptno.dname}/${emp.fkTitleId.titleName}/${emp.empId}/${emp.username}</option>
								</c:forEach>
							</select>
						</div>
						<div class="input-group mb-3 col-sm-3">
							<select class="form-control" aria-describedby="punchYear"
								name="punchYear" id="punchYear" required>
								<option value="2022">2022</option>
							</select>
							<div class="input-group-append">
								<label class="input-group-text" for="punchYear">年</label>
							</div>
						</div>
						<div class="input-group mb-3 col-sm-2">
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
						<button type="button" class="btn btn-success" id="punchToCSV" style="height:38px;">產出報表</button>
					</div>
				</div>

					<div id="flot-memo"
				style="text-align: center; height: 30px; width: 100px; height: 20px; text-align: center; margin: 0"></div>
					<div id="flot-placeholder"
						style="width: 550px; height: 250px; margin: 5px"></div>

			</div>
			<div class="board">
				<table style="width: 100%;" id="punchtable">
				</table>
			</div>
		</section>
	</section>
	<script>
		var options = {
			series : {
				pie : {
					show : true,
					label : {
						show : true,
						radius : 50,
						formatter : function(label, series) {
							return '<div style="border:1px solid grey;font-size:10pt;text-align:center;padding:5px;color:white;">'
									+ label
									+ ' : '
									+ Math.round(series.percent) + '%</div>';
						},
						background : {
							opacity : 0.5,
							color : '#000'
						}
					}
				}
			},
			legend : {
				show : false
			},
			grid : {
				hoverable : true
			}
		};

		var options1 = {
			series : {
				pie : {
					show : true,
					tilt : 0.5
				}
			}
		};

		var options2 = {
			series : {
				pie : {
					show : true,
					innerRadius : 0.5,
					label : {
						show : true
					}
				}
			}
		};
		<!--選擇後ajax-->
		$("#employees").change(function(){
			getEmpYearMonth();
		});
		$("#punchYear").change(function(){
			getEmpYearMonth();
		});
		$("#punchMonth").change(function(){
			getEmpYearMonth();
		});
		function getEmpYearMonth(){
			let emp = $("#employees").val();
			let year = $("#punchYear").val();
			let month = $("#punchMonth").val();
			if(emp != "" && year != "" && month != ""){
				$.ajax({
					url:'http://localhost:8080/GroupOne/api/getEmpPunchFlot?empId=' + emp + '&year=' + year + '&month=' + month,
					dataType:'json',
					method:'get',
					success:function(data){
						late = data.late;
						onTime = data.onTime;
						var dataSet = [
						    { label: "遲到", data: data.late, color: "#DE000F" },
						    { label: "準時", data: data.onTime, color: "#009100" }    
						];
						
						$.plot($("#flot-placeholder"), dataSet, options);
					},
					error:function(err){
						}
				})
				$.ajax({
					url:'http://localhost:8080/GroupOne/admin/getEmpPunchData?empId=' + emp + '&year=' + year + '&month=' + month,
					dataType:'json',
					method:'get',
					success:function(data){
						ajaxTable(data);
					}
				})
			}
		}
		
		<!--ajax產Table-->
		function ajaxTable(data){
			$("#punchtable").html("");
			$("#punchtable").append("<thead><tr><td width='7%'>編號</td><td>打卡日期</td><td>上班時間</td><td>下班時間</td></tr></thead>")
			let tableBody = "";
			for(i=0;i<data.length;i++){
				tableBody+="<tr><td><p>" + data[i].empId +"</p></td>";
				tableBody+="<td><h5>" + data[i].punchYear + "-" + data[i].punchMonth + "-" + data[i].punchDate + "</h5></td>" + 
				"<td><h5>" + data[i].onWorkTime + "</h5></td>";
				
				if(data[i].offWorkTime == null || data[i].offWorkTime ==""){
					tableBody+="<td><h5>未有紀錄</h5></td></tr>"
				}else{
					tableBody+="<td><h5>" + data[i].offWorkTime + "</h5></td></tr>"
				}
			}
			$("#punchtable").append(tableBody);
		}
		
		<!--報表產出-->
		$("#punchToCSV").click(function(){
			let emp = $("#employees").val();
			let year = $("#punchYear").val();
			let month = $("#punchMonth").val();
			if(emp != "" && year != "" && month != ""){
				window.open('http://localhost:8080/GroupOne/api/getEmpPunchToCsv?empId=' + emp + '&year=' + year + '&month=' + month);
			}
		})
		
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
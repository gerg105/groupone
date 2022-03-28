<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>天食地栗 | 後臺系統</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${contextRoot}/css/backend_style.css" />
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css">

<!-- ico -->
<link rel="shortcut icon" href="${contextRoot}/src/webimg/icon_round.ico">

<!-- sweet alert -->
<link rel="stylesheet" href="${contextRoot}/css/sweetalert2.min.css">
<script src="${contextRoot}/js/sweetalert2.min.js"></script>

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
    
    <!--right section-->
	<div align="center" style="margin-top: 80px">
			<h3>歡迎使用《天食地栗》員工後臺系統</h3>
			<div>

				<img alt="" id="picH1" width="50" style="opacity: 0.3" />
				<img alt="" id="picH2" width="50" style="margin-left: -25px; opacity: 0.3" />
				<img alt="" id="colon" src="${contextRoot}/src/clock/colon.png" width="50" style="margin-left: -25px; opacity: 0.3" />
				<img alt="" id="picM1" width="50" style="margin-left: -25px;opacity: 0.3" />
				<img alt="" id="picM2" width="50" style="margin-left: -25px; opacity: 0.3" />
				<img alt="" id="colon" src="${contextRoot}/src/clock/colon.png" width="50" style="margin-left: -25px; opacity: 0.3" />
				<img alt="" id="picS1" width="50" style="margin-left: -25px;opacity: 0.3" />
				<img alt="" id="picS2" width="50" style="margin-left: -25px; opacity: 0.3" />
			</div>
			<div>
			<img src= "${contextRoot}/src/webimg/backend/logo.png" width="600" style="opacity: 0.1"/>
			</div>
		</div>
</section>


<script>
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

<!--計時器-->
function setClock(){
     // document.getElementById("picS1").src="WinImages/1.gif";//秒的十位數
	 // document.getElementById("picS2").src="WinImages/2.gif";//秒的個位數       
	 //建立日期
	 let d=new Date();
	 //取得秒數，分割為兩位數
	 let h=d.getHours();//取得Date的"取秒數"方法
	 let h1=parseInt(h/10);//分的十位數
	 let h2=h%10;//分的個位數
	
	 let m=d.getMinutes();//取得Date的"取秒數"方法
	 let m1=parseInt(m/10);//分的十位數
	 let m2=m%10;//分的個位數
	
	 let s=d.getSeconds();//取得Date的"取秒數"方法
	 let s1=parseInt(s/10);//秒的十位數
	 let s2=s%10;//秒的個位數
	
	 //顯示圖片，對應秒數
	 "${contextRoot}/src/img/EmpImg/${admin.photo}"
	 document.getElementById("picH1").src="${contextRoot}/src/clock/"+h1+".png";//before css5
	 document.getElementById("picH2").src="${contextRoot}/src/clock/"+h2+".png";//css6 
	 document.getElementById("picM1").src="${contextRoot}/src/clock/"+m1+".png";//before css5
	 document.getElementById("picM2").src="${contextRoot}/src/clock/"+m2+".png";//css6 
	 document.getElementById("picS1").src="${contextRoot}/src/clock/"+s1+".png";//before css5
	 document.getElementById("picS2").src="${contextRoot}/src/clock/"+s2+".png";//css6 
	 }
	 
	 
<!--計時器起動-->
setClock();
window.setInterval(setClock,1000);
</script>
</body>
</html>
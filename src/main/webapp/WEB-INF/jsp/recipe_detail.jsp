<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<!-- 本頁自有 -->
<link rel="stylesheet" href="${contextRoot}/css/frontend_recipe.css" />

<!-- sweet alert -->
<link rel="stylesheet" href="${contextRoot}/css/sweetalert2.min.css">
<script src="${contextRoot}/js/sweetalert2.min.js"></script>

<!-- Google 平台庫 (第三方登入) -->
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async
	defer></script>
<script src="${contextRoot}/js/google-login.js"></script>

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
				<li><a class="active" href="${contextRoot}/recipe">食譜</a></li>
				<li><a href="${contextRoot}/event">活動</a></li>
				<li><a href="${contextRoot}/contact">聯絡我們</a></li>

				<c:choose>
					<c:when test="${user.ID != null}">
						<li><a href="${contextRoot}/account">會員專區</a></li>
						<li><a href="#" onclick="signOut();">登出</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${contextRoot}/login">登入</a></li>
					</c:otherwise>
				</c:choose>
				<li><a href="${contextRoot}/shoppingCart"><i class="far fa-shopping-bag"></i></a></li>
			</ul>
		</div>
	</section>

	<section id="page-header" class="event-header">
		<h2>#食譜</h2>
	</section>
	<input id="userNow" type="text" value="${user.ID}" hidden="">
	<!-- 內文 -->
	<div class="main">
		<table class="main">
			<tr>
				<td class="top"><br>
					<h1>${rec.title}</h1> <span class="stars">${rec.rates}</span><br>
					&nbsp;<span class="type">${rec.rtp.rtype}</span><br> <br>
					&nbsp;&#9201;&nbsp;${rec.rtime}&nbsp;分鐘<br> &nbsp;${rec.serve}
					人份<br> <br>
				<td class="top">
					<div class="imgtd">
						<img class="img" src="${contextRoot}/${rec.img}" />
					</div>
		</table>
		<table id="inTab">
			<tr>
				<td class="left" colspan="2" id="ing">材料:<br></td>
			</tr>
			<tr>
				<td class="left" colspan="2" id="con"><br>步驟:<br></td>
			</tr>
			<tr>
				<td colspan="2"><iframe width="560" height="315"
						src="https://www.youtube.com/embed/${rec.video}" allowfullscreen>
					</iframe></td>
			</tr>
			<c:if test="${user != null}">
				<tr>
					<td colspan="2" id="rate"><span id='rr'>你為這篇食譜打幾分?</span> <img
						id="r1"> <img id="r2"> <img id="r3"> <img
						id="r4"> <img id="r5"> &nbsp;<span id="sp"></span></td>
				</tr>
			</c:if>
			<tr>
				<td onclick="window.location='<c:url value='/' />'" class="dir"
					colspan="2">回首頁</td>
			</tr>

		</table>

		<c:choose>
			<c:when test="${favId == 0}">
				<fieldset id="fav" class="unfav">
					&#9829;<br>收藏
				</fieldset>
				<br>
				<br>
			</c:when>
			<c:otherwise>
				<fieldset id="fav" class="fav">
					&#9829;<br>收藏
				</fieldset>
				<br>
				<br>
			</c:otherwise>
		</c:choose>

	</div>
	<!-- end of 內文 -->
	
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
	
	$(document).ready(function(){
		 const ing = `${rec.ing}`.split('\n');
         for(let i = 0; i < ing.length; i++){
             $("#ing").append(
                 '<label class="container">&nbsp;'+ing[i]+'<input type="checkbox"><span class="checkmark"></span></label>'
             );
         }
         const con = `${rec.con}`.split('\n');
         for(let j = 0; j < con.length; j++){
             $("#con").append(
                 '<label class="radio">&nbsp;'+con[j]+'<input type="radio" name="radio"><span class="rad"></span></label><br>'
             );
         }
	});
	<!--點擊收藏鈕-->
	$("#fav").click(function(){
		let uid = $("#userNow").val();
		if(uid == ""){
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: '請先登入喔!',
				})
		}else{
			let ftoObject = {
					"uid": uid,
					"rid": ${rec.rid}
			};
			let fto = JSON.stringify(ftoObject);
			$.ajax({
				url: 'http://localhost:8080/GroupOne/recipe/favrec',
		        contentType: 'application/json; charset=UTF-8',
		        dataType: 'json',
		        method: 'post',
		        data: fto,
		        success:function (msg){
		        	if ($("#fav").hasClass('unfav')) {
		        		Swal.fire({
							  icon: 'success',
							  title: '已加入收藏!',
							  showConfirmButton: false,
							  timer: 1000
							})
		                $("#fav").attr('class', 'fav');
		            } else{
		            	$("#fav").attr('class', 'unfav');
		            }
		                
		        }
			})
			
		}
	});
	
	<!--顯示平均星數-->
	 $.fn.stars = function() {
	  	  return $(this).each(function() {
	  	    $(this).html($('<span />').width(Math.max(0, 
	  	    	(Math.min(5, parseFloat($(this).html())))) * 24));
	  	  });
	  	}
	 
	 $(function() {
		 $('span.stars').stars();
		 });

	    /////////////////////////////
	    let check = 0;
	    for(let i = 1; i < 6; i++){
	      document.getElementById('r' + i).className = "no";
	      for(let j = 1; j < i + 1; j++){
	        document.getElementById('r' + i).addEventListener("mouseover", mouseover);
	        document.getElementById('r' + i).addEventListener("mouseout", mouseout);
	        document.getElementById('r' + i).addEventListener("click", click);
	        document.getElementById('r' + i).className = "no";
	        document.getElementById('r' + i).src = "${contextRoot}/src/star.png";
	        function mouseover(){
	          if(!check){
	            document.getElementById('r' + j).className = "yes";
	          }
	        }
	        function mouseout(){
	          if(!check){
	            document.getElementById('r' + j).className = "no";
	          }
	        }
	        function click(){
	          if(!check){
	            document.getElementById('r' + j).className = "yes";
	            check = 1;
	            document.getElementById("sp").innerHTML = '你打'+ i + '分，點我取消';
	            //////////
	            let g = $('#userNow').val();
	            if(g != null){
	              let rtoO = {
	                "uid": g,
	                "rid": ${rec.rid},
	                "rate": i
	              };
	              let rto = JSON.stringify(rtoO);
	              $.ajax({
	                url:'http://localhost:8080/GroupOne/rate',
	                contentType: 'application/json; charset=UTF-8',
	                dataType: 'json',
	                method: 'post',
	                data: rto,
	                success: console.log('評分成功'),
	                error: function(err){
	                console.log(err);
	                }
	              })
	            }
	          }
	        }
	      }
	    };
	    //////////
	    let sp = document.getElementById("sp");
	    sp.addEventListener("click", function(){
	      check = 0;
	      for(let i = 1; i < 6; i++){
	        document.getElementById('r' + i).className = "no";
	      };
	      let rtoO = {
	        "uid": $('#userNow').val(),
	        "rid": ${rec.rid},
	        "rate": 0
	      };
	      let rto = JSON.stringify(rtoO);
	      $.ajax({
	        url:'http://localhost:8080/GroupOne/rate',
	        contentType: 'application/json; charset=UTF-8',
	        dataType: 'json',
	        method: 'post',
	        data: rto,
	        success: console.log('取消成功'),
	        error: function(err){
	        console.log(err);
	        }
	      })
	      sp.innerHTML = "";
	    });
	    
	    //確認有無評分過
	    var rateCheck = 0;
	    $(document).ready(function(){
	      if(${myRate} != 0){
	        for(let i = 1; i < ${myRate} + 1; i++)
	          document.getElementById('r' + i).className = "yes";
	        rateCheck = 1;
	        document.getElementById("sp").innerHTML = '你打'+ ${myRate} + '分，點我取消';
	      };
	    });
	</script>
</body>

</html>
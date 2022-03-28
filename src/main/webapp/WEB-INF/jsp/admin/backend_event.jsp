<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<jsp:useBean id="newTime" class="java.util.Date" />
<fmt:formatDate var="now" value="${newTime}" pattern="yyyy-MM-dd-HH" />
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

<!-- Jquery ui 
<script src="${contextRoot}/js/jquery-ui.min.js"></script>
-->

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
				<a href="${contextRoot}/admin/event"><li class="active"><i class="far fa-calendar-check"></i>活動管理</li></a>
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
		<div class="title">
			<h3 class="i-name">活動管理</h3>
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-primary" data-toggle="modal"
				data-target="#insertModal">新增活動</button>
		</div>
		<div class="search">
			<i class="far fa-search"></i> <input type="text"
				placeholder="輸入活動名稱..." id="searchbar">
		</div>
		<div class="board">
			<table style="width: 100%;">
				<thead>
					<tr>
						<td width='5.5%'>編號</td>
						<td>活動名稱</td>
						<td>活動時間</td>
						<td>活動狀態</td>
						<td>最後修改時間</td>
						<td></td>
						<td></td>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:forEach items='${events.content}' var='event'>
						<tr>
							<td>
								<p>${event.id}</p>
							</td>
							<td class="product" style="margin-top: 12px;"><img
								src="${contextRoot}/src/${event.imagePath}">
								<div class="product-de">
									<h5>${event.title}</h5>
								</div></td>
							<c:set var="start" value="${event.startDate}" />
							<c:set var="end" value="${event.endDate}" />
							<c:set var="startDay" value="${fn:substring(start, 0, 10)}" />
							<c:set var="endDay" value="${fn:substring(end, 0, 10)}" />
							<c:set var="startHour" value="${fn:substring(start, 11, 13)}" />
							<c:set var="endHour" value="${fn:substring(end, 11, 13)}" />
							<td class="product-des">
								<h5>迄：${endDay}&nbsp;${endHour}:00</h5>
								<p>起：${startDay}&nbsp;${startHour}:00</p>
							</td>

							<fmt:parseDate var="startString" value="${startDay}-${startHour}"
								type="DATE" pattern="yyyy-MM-dd-HH" />
							<fmt:parseDate var="endString" value="${endDay}-${endHour}"
								type="DATE" pattern="yyyy-MM-dd-HH" />
							<fmt:formatDate var="startObj" value="${startString}"
								pattern="yyyy-MM-dd-HH" />
							<fmt:formatDate var="endObj" value="${endString}"
								pattern="yyyy-MM-dd-HH" />

							<c:choose>
									<c:when test="${now > endObj}">
							<td class="not-active">
											<p>已結束</p>
										</td>
							</c:when>
									<c:when test="${now < startObj}">
							<td class="not-active">
											<p style="background: #eaf080;">未開始</p>
										</td>
							</c:when>
									<c:otherwise>
							<td class="active">
											<p>進行中</p>
										</td>
							</c:otherwise>
								</c:choose>

							<td class="product-des">
								<p>${fn:substring(event.editDate, 0, 19)}</p>
							</td>

							<td>
								<button type="button" class="btn btn-info" name='edit'
									data-toggle="modal" data-target="#editModal">修改</button>
							</td>
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
			<c:forEach var="pageNumber" begin="1" end="${events.totalPages}">
				<button class="btn btn-secondary btn-sm">${pageNumber}</button>
			</c:forEach>
		</div>

		<!-- 新增活動Modal -->
		<div class="modal fade" id="insertModal" tabindex="-1"
			aria-labelledby="insertModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-scrollable modal-lg">
				<div class="modal-content ">

					<div class="modal-header">
						<h5 class="modal-title" id="insertModalLabel">新增活動</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<!-- form -->
						<form:form class="form" action="${contextRoot}/admin/addEvent"
							modelAttribute="addEvent" method="post"
							enctype="multipart/form-data" autocomplete="off">

							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<label class="input-group-text" for="eName">活動名稱</label>
								</div>
								<form:input path="title" type="text" class="form-control"
									id="eName" name="eName" aria-describedby="eName" />
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend"></div>
								<div class="custom-file">
									<form:input type="file" path="content.eventImage"
										class="custom-file-input" id="ePic" />
									<label class="custom-file-label" for="ePic">請上傳活動圖片</label>
								</div>
							</div>

							<!-- 預覽 -->
							<div class="preview-img">
								<img id="preview_img"
									src="${contextRoot}/src/webimg/backend/preview_img_800.jpg"
									style="max-width: 600px;" />
							</div>
							<!-- 預覽 -->
							<br>

							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<label class="input-group-text" for="eStart">開始時間</label>
								</div>

								<form:input path="startDate" type="text" id="eStart"
									aria-describedby="eStart" placeholder="請選擇時間與日期"
									class="form-control" />

								<form:select id="eStartHour" class="custom-select"
									path="startTime" aria-describedby="eStartHour"
									name="eStartHour">


									<option value="" style="display: none">請選擇時間</option>
									<c:forEach var="i" begin="0" end="23">
										<c:choose>
											<c:when test="${i < 10}">
												<option value="0${i}">0${i}</option>
											</c:when>
											<c:otherwise>
												<option value="${i}">${i}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</form:select>
								<div class="input-group-prepend">
									<label class="input-group-text" for="eStartHour">點</label>
								</div>
								<br>
							</div>

							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<label class="input-group-text" for="eEnd">結束時間</label>
								</div>
								<form:input path="endDate" type="text" id="eEnd"
									aria-describedby="eEnd" placeholder="請選擇時間與日期"
									class="form-control" />
								<form:select id="eEndHour" class="custom-select"
									aria-describedby="eEndHour" name="eEndHour" path="endTime">
									<option value="" style="display: none">請選擇時間</option>
									<c:forEach var="i" begin="0" end="23">
										<c:choose>
											<c:when test="${i < 10}">
												<option value="0${i}">0${i}</option>
											</c:when>
											<c:otherwise>
												<option value="${i}">${i}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</form:select>
								<div class="input-group-prepend">
									<label class="input-group-text" for="eEndHour">點</label>
								</div>
								<br>
							</div>

							<div class="text">
								<form:textarea rows="20" id="summernote" name="editordata"
									path="content.content" />
							</div>

							<br>
							<div class="modal-footer">
								<button type="button" class="btn btn-success" id="smartInput">快速輸入</button>
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">關閉</button>
								<input type="submit" class="btn btn-primary" value="送出" />
							</div>

						</form:form>
					</div>
				</div>
			</div>
		</div>
		<!-- end of modal -->
		
		
		<!-- 修改活動Modal -->
		<div class="modal fade" id="editModal" tabindex="-1"
			aria-labelledby="editModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-scrollable modal-lg">
				<div class="modal-content ">

					<div class="modal-header">
						<h5 class="modal-title" id="editModalLabel">修改活動</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<!-- form -->
						<form:form class="form" action="${contextRoot}/admin/editEvent"
							modelAttribute="editEvent" method="post"
							enctype="multipart/form-data" autocomplete="off">
							<form:input path="id" id="eID_e" name="eID_e" style="display: none;"/>
							<form:input path="content.id" id="eContentID_e" name="eContentID_e" style="display: none;"/>
							<form:input path="createDate" id="eCreateDate_e" name="eCreateDate_e" style="display: none;"/>
							<form:input path="imagePath" id="eImagePath_e" name="eImagePath_e" style="display: none;"/>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<label class="input-group-text" for="eName_e">活動名稱</label>
								</div>
								<form:input path="title" type="text" class="form-control"
									id="eName_e" name="eName_e" aria-describedby="eName_e" />
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend"></div>
								<div class="custom-file">
									<form:input type="file" path="content.eventImage"
										class="custom-file-input" id="ePic_e" />
									<label class="custom-file-label" for="ePic_e">請上傳活動圖片</label>
								</div>
							</div>

							<!-- 預覽 -->
							<div class="preview-img">
								<img id="preview_img_e"
									src="${contextRoot}/src/webimg/backend/preview_img_800.jpg"
									style="max-width: 600px;" />
							</div>
							<!-- 預覽 -->
							<br>

							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<label class="input-group-text" for="eStart_e">開始時間</label>
								</div>

								<form:input path="startDate" type="text" id="eStart_e"
									aria-describedby="eStart_e" placeholder="請選擇時間與日期"
									class="form-control" />

								<form:select id="eStartHour_e" class="custom-select"
									path="startTime" aria-describedby="eStartHour_e"
									name="eStartHour_e">


									<option value="" style="display: none">請選擇時間</option>
									<c:forEach var="i" begin="0" end="23">
										<c:choose>
											<c:when test="${i < 10}">
												<option value="0${i}">0${i}</option>
											</c:when>
											<c:otherwise>
												<option value="${i}">${i}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</form:select>
								<div class="input-group-prepend">
									<label class="input-group-text" for="eStartHour_e">點</label>
								</div>
								<br>
							</div>

							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<label class="input-group-text" for="eEnd_e">結束時間</label>
								</div>
								<form:input path="endDate" type="text" id="eEnd_e"
									aria-describedby="eEnd_e" placeholder="請選擇時間與日期"
									class="form-control" />
								<form:select id="eEndHour_e" class="custom-select"
									aria-describedby="eEndHour_e" name="eEndHour_e" path="endTime">
									<option value="" style="display: none">請選擇時間</option>
									<c:forEach var="i" begin="0" end="23">
										<c:choose>
											<c:when test="${i < 10}">
												<option value="0${i}">0${i}</option>
											</c:when>
											<c:otherwise>
												<option value="${i}">${i}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</form:select>
								<div class="input-group-prepend">
									<label class="input-group-text" for="eEndHour_e">點</label>
								</div>
								<br>
							</div>

							<div class="text">
								<form:textarea rows="20" id="summernote_e" name="editordata"
									path="content.content" />
							</div>

							<br>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">關閉</button>
								<input type="submit" class="btn btn-primary" value="送出" />
							</div>

						</form:form>
					</div>
				</div>
			</div>
		</div>
		<!-- end of modal -->

	</section>
	<script>
	<!--圖片預覽-->
	//新增
	$("#ePic").change(function() {
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
	$("#ePic_e").change(function() {
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
	
	<!-- 啟用日期選擇 -->
		$("#eStart").datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			language : 'zh-TW',
		});
		$("#eEnd").datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			language : 'zh-TW',
		});
		$("#eStart").change(function(){
			$('#eEnd').datepicker('setStartDate', new Date($(this).val()));
		})
		
	<!--summer note-->
		$('#summernote').summernote({
	        placeholder: '請輸入活動內容',
	        tabsize: 2,
	        width: 600,
	        height: 400,
	        toolbar: [
	            ['style', ['style']],
	            ['font', ['bold', 'underline', 'clear']],
	            ['color', ['color']],
	            ['para', ['ul', 'ol', 'paragraph']],
	            ['table', ['table']],
	            ['insert', ['link', 'picture', 'video']],
	            ['view', ['codeview']]
	          ],
	        lang: 'zh-TW'
	      });
		
	<!--模糊查詢-->
	$('#searchbar').keyup(function(){
		let eName = $(this).val();
		$.ajax({
			url:"event/find?eName=" + eName,
			method:"get",
			success: function(data){
				ajaxTable(data);
			}
		})
	})
	<!--分頁按鈕-->
	$('body').on('click','button.btn-sm',function(){
		let p = $(this).html();
		let eName = $('#searchbar').val();
		$.ajax({
			url:"event/find?eName=" + eName + "&p=" + p,
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
						url:"deleteEvent/" + id,
						method:"delete",
						success: function(data){
							ajaxTable(data);
						}
					});
				  Swal.fire(
			      '刪除成功',
			      '該活動已被刪除',
			      'success'
			    );
			  }
			});
	});
	<!--快速輸入-->
	$('#smartInput').click(function(){
		$('#eName').val("【體驗】自己的茶自己調 花草茶DIY");
		$('#eStart').val("2022-03-27");
		$('#eStartHour').val("19");
		$('#eEnd').val("2022-03-27");
		$('#eEndHour').val("21");
		
		<!--summer note需先destory方可重新輸入文字-->
		$('#summernote').summernote('destroy');
		$('#summernote').val("<p>喝夠了市售固定配方的花草茶嗎?<br>總是希望某些味道可以強烈一些<br>或是希望某種討厭的味道消失?<br><br>茶酒侍讓大家可以看到所有花草茶的原實物樣貌<br>藉由調茶的體驗活動中<br>認識更多花草茶<br>並了解這些花草茶的香氣<br>讓大家可以更加理解自己喜歡的是甚麼茶款<br><br>每一次活動會簡單介紹幾款台灣人較喜歡的單方花草茶<br>來賓可從中選擇自己喜愛的單方，並調配成自己喜愛的花草茶包<br><br>每場活動內容每人會有:<br>可供選擇多達40種單方花草<br>兩個玉米纖維茶包袋 (沒有漂白水、沒有塑化劑問題)<br>一顆可愛的花茶禮球 (可放入兩款茶包，茶用完也可以裝東西或當小吊飾)<br><br></p>");
		$('#summernote').summernote({
	        tabsize: 2,
	        width: 600,
	        height: 400,
	        toolbar: [
	            ['style', ['style']],
	            ['font', ['bold', 'underline', 'clear']],
	            ['color', ['color']],
	            ['para', ['ul', 'ol', 'paragraph']],
	            ['table', ['table']],
	            ['insert', ['link', 'picture', 'video']],
	            ['view', ['codeview']]
	          ],
	        lang: 'zh-TW'
	      });
	});
	
	<!--修改-->
	$('body').on('click','button[name="edit"]',function(){
		let id = $(this).parent().parent().find("p").html();
		$.ajax({
			url:"event/getjson?id=" + id,
			method:"get",
			success: function(data){
				$('#eID_e').val(data.id);
				$('#eName_e').val(data.title);
				$('#preview_img_e').attr('src', '/GroupOne/src/' + data.imagePath);
				$('#eStart_e').val(data.startDate.substring(0, 10));
				$('#eStartHour_e').val(data.startDate.substring(11, 13));
				$('#eEnd_e').val(data.endDate.substring(0, 10));
				$('#eEndHour_e').val(data.endDate.substring(11, 13));
				$('#eContentID_e').val(data.content.id);
				$('#eCreateDate_e').val(data.createDate);
				$('#eImagePath_e').val(data.imagePath);
				
				$('#summernote_e').summernote('destroy');
				$('#summernote_e').val(data.content.content);
				$('#summernote_e').summernote({
			        tabsize: 2,
			        width: 600,
			        height: 400,
			        toolbar: [
			            ['style', ['style']],
			            ['font', ['bold', 'underline', 'clear']],
			            ['color', ['color']],
			            ['para', ['ul', 'ol', 'paragraph']],
			            ['table', ['table']],
			            ['insert', ['link', 'picture', 'video']],
			            ['view', ['codeview']]
			          ],
			        lang: 'zh-TW'
			      });
				$("#eStart_e").datepicker({
					format : "yyyy-mm-dd",
					autoclose : true,
					language : 'zh-TW',
				});
				$("#eEnd_e").datepicker({
					format : "yyyy-mm-dd",
					autoclose : true,
					language : 'zh-TW',
					startDate : $("#eStart_e").val()
				});
				$("#eStart_e").change(function(){
					$('#eEnd_e').datepicker('setStartDate', new Date($(this).val()));
				})
			}
		});
	});
	
	<!--ajax產table-->
	function ajaxTable(data){
		let now = new Date();
		let body1 = "";
		$("#tbody").html("");
		for(i=0;i<data.events.length;i++){
			body1 += "<tr><td><p>" + data.events[i].id + "</p></td>" +
					"<td class='product'  style='margin-top: 12px;'><img src='http://localhost:8080/GroupOne/src/" + data.events[i].imagePath+ "'>" +
					"<div class='product-de'><h5>" + data.events[i].title + "</h5>" +  "</div></td>" + 
					"<td class='product-des'><h5>迄：" + data.events[i].endDate.substring(0, 10) + " " + 
					data.events[i].endDate.substring(11, 13) + ":00</h5><p>起：" + data.events[i].startDate.substring(0, 10) + " " + data.events[i].startDate.substring(11, 13) + ":00</p></td>";
			
			let startString = Date.parse(data.events[i].startDate + ":00:00");
			let endString = Date.parse(data.events[i].endDate + ":00:00");	
			
			if(now > endString){
				body1 += "<td class='not-active'><p>已結束</p></td>";
			}else if(now < startString){
				body1 += "<td class='not-active'><p style='background: #eaf080;'>未開始</p></td>";
			}else{
				body1 += "<td class='active'><p>進行中</p></td>";
			}
			body1 +=
					"<td class='product-des'><p>"+ data.events[i].editDate.substring(0, 19) +"</p></td>"+
					"<td><button type='button' class='btn btn-info' name='edit' data-toggle='modal'	data-target='#editModal'>修改</button></td>" + 
					"<td><button type='button' class='btn btn-danger' name='delete'>刪除</button></td></tr>";
	
		}
		$("#tbody").append(body1);
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
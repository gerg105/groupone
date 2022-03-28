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
				<a href="${contextRoot}/admin/member"><li><i class="fa fa-users"></i>會員管理</li></a>
				<a href="${contextRoot}/admin/order"><li><i class="far fa-file-invoice-dollar"></i>訂單管理</li></a>
				</c:if>
				<c:if test="${admin.fkDeptno.deptno == 200 || admin.fkDeptno.deptno == 400 }">
				<a href="${contextRoot}/admin/event"><li><i class="far fa-calendar-check"></i>活動管理</li></a>
				<a href="${contextRoot}/admin/recipe"><li class="active"><i class="fa fa-book"></i>食譜管理</li></a>
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
				<h3 class="i-name">食譜管理</h3>
				<!-- Button trigger modal -->
				<button type="button" class="btn btn-primary" data-toggle="modal"
					data-target="#insertModal">新增食譜</button>
			</div>
			<div class="search">
				<i class="far fa-search"></i> <input type="text"
					placeholder="輸入食譜名稱..." id="searchbar">
			</div>
			<div class="board">
				<table style="width: 100%;">
					<thead>
						<tr>
							<td width='8%'>編號</td>
							<td>評分</td>
							<td>食譜名稱</td>
							<td>食譜類別</td>
							<td>新增時間</td>
							<td></td>
							<td></td>
						</tr>
					</thead>
					<tbody id="tbody">
						<c:forEach items='${rcps.content}' var='rcp'>

							<tr>
								<td>
									<p>${rcp.rid}</p>
								</td>

								<td>
									<p>${rcp.rates}</p>
								</td>

								<td class="product"><img src="${contextRoot}/${rcp.img}">
									<div class="product-de">
										<h5>${rcp.title}</h5>
										<p>${rcp.rtime}分鐘/${rcp.serve}人份</p>
									</div></td>

								<td class="product-des">
									<h5>${rcp.rtp.rtype}</h5>
								</td>

								<td class="product-des">
									<p>${fn:substring(rcp.added, 0, 19)}</p>
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
				<c:forEach var="pageNumber" begin="1" end="${rcps.totalPages}">
					<button class="btn btn-secondary btn-sm">${pageNumber}</button>
				</c:forEach>
			</div>

			<!-- 新增食譜Modal -->
			<div class="modal fade" id="insertModal" tabindex="-1"
				aria-labelledby="insertModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable modal-lg">
					<div class="modal-content ">

						<div class="modal-header">
							<h5 class="modal-title" id="insertModalLabel">新增食譜</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<!-- form -->
							<form id="addRcpForm" class="form-inline" method="post"
								action="${contextRoot}/admin/NewRec"
								enctype="multipart/form-data">

								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="title">食譜標題</label>
									</div>
									<input type="text" class="form-control" id="title" name="title"
										aria-describedby="title" autocomplete="off" required><br>
								</div>


								<!-- 預覽 -->
								<div class="col-sm-12">
									<div class="preview-img">
										<img id="preview_img"
											src="${contextRoot}/src/webimg/backend/preview_img_400.jpg"
											style="max-width: 400px;" />

									</div>
									<br>
								</div>
								<!-- 預覽 -->
								<div class="input-group mb-3 col-sm-12">
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="img"
											name="img" data-target="preview_img"> <label
											class="custom-file-label" for="img" aria-describedby="img">請上傳食譜照片</label>
									</div>
								</div>

								<br>
								
								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="ing">食材</label>
									</div>
									<textarea class="form-control" id="ing" name="ing"
										aria-describedby="ing" autocomplete="off"
										style="height:150px" placeholder="請輸入食材(可使用Enter換行)"></textarea>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="type">食譜類型</label>
									</div>
									<select class="form-control" aria-describedby="type"
										name="type" id="type" required>
										<option value="" style="display: none">請選擇</option>
										<c:forEach items="${types}" var="type">
											<option value="${type.rtype_id}">${type.rtype}</option>
										</c:forEach>
									</select>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="time">烹飪時間(分)</label>
									</div>
									<input type="number" min="1" class="form-control" id="time" name="time"
										aria-describedby="time" autocomplete="off" required><br>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="serve">幾人份</label>
									</div>
									<input type="number" min="1" class="form-control" id="serve" name="serve"
										aria-describedby="serve" autocomplete="off" required><br>
								</div>
								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="video">影片</label>
									</div>
									<input type="text" class="form-control" id="video" name="video"
										aria-describedby="video" autocomplete="off" placeholder="(請複製watch?v=後文字)"><br>
								</div>
								
								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="con">料理步驟</label>
									</div>
									<textarea class="form-control" id="con" name="con"
										aria-describedby="con" autocomplete="off"  style="height:150px" placeholder="請輸入食材(可使用Enter換行)"></textarea>
								</div>

								<br>
							</form>
							<div class="modal-footer">
								<button type="button" class="btn btn-success" id="smartInput">快速輸入</button>
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">關閉</button>
								<button id="addbtn" type="button" class="btn btn-primary">送出</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end of modal -->
			
			
			
			
			
			<!-- 修改食譜Modal -->
			<div class="modal fade" id="editModal" tabindex="-1"
				aria-labelledby="editModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable modal-lg">
					<div class="modal-content ">

						<div class="modal-header">
							<h5 class="modal-title" id="editModalLabel">修改食譜</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<!-- form -->
							<form id="editRcpForm" class="form-inline" method="post"
								action="${contextRoot}/admin/updateRec"
								enctype="multipart/form-data">
								<input type="text" id="rid_e" name="rid" hidden="">
								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="title_e">食譜標題</label>
									</div>
									<input type="text" class="form-control" id="title_e" name="title"
										aria-describedby="title_e" autocomplete="off" required><br>
								</div>


								<!-- 預覽 -->
								<div class="col-sm-12">
									<div class="preview-img">
										<img id="preview_img_e"
											src="#"
											style="max-width: 400px;" />

									</div>
									<br>
								</div>
								<!-- 預覽 -->
								<div class="input-group mb-3 col-sm-12">
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="img_e"
											name="img" data-target="preview_img"> <label
											class="custom-file-label" for="img_e" aria-describedby="img_e">請上傳食譜照片</label>
									</div>
								</div>

								<br>
								
								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="ing_e">食材</label>
									</div>
									<textarea class="form-control" id="ing_e" name="ing"
										aria-describedby="ing" autocomplete="off" style="height:150px"></textarea>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="type_e">食譜類型</label>
									</div>
									<select class="form-control" aria-describedby="type_e"
										name="type" id="type_e" required>
										<option value="" style="display: none">請選擇</option>
										<c:forEach items="${types}" var="type">
											<option value="${type.rtype_id}">${type.rtype}</option>
										</c:forEach>
									</select>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="time_e">烹飪時間(分)</label>
									</div>
									<input type="number" min="1" class="form-control" id="time_e" name="time"
										aria-describedby="time_e" autocomplete="off" required><br>
								</div>

								<div class="input-group mb-3 col-sm-4">
									<div class="input-group-prepend">
										<label class="input-group-text" for="serve_e">幾人份</label>
									</div>
									<input type="number" min="1" class="form-control" id="serve_e" name="serve"
										aria-describedby="serve_e" autocomplete="off" required><br>
								</div>
								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="video_e">影片</label>
									</div>
									<input type="text" class="form-control" id="video_e" name="video"
										aria-describedby="video_e" autocomplete="off" placeholder="(請複製watch?v=後文字)"><br>
								</div>

								<div class="input-group mb-3 col-sm-12">
									<div class="input-group-prepend">
										<label class="input-group-text" for="con">料理步驟</label>
									</div>
									<textarea class="form-control" id="con_e" name="con"
										aria-describedby="con" autocomplete="off" style="height:150px"></textarea>
								</div>
								
								<br>
							</form>
							<div class="modal-footer">
								<button type="button" class="btn btn-success" id="smartInput">快速輸入</button>
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">關閉</button>
								<button id="editbtn" type="button" class="btn btn-primary">送出</button>
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
	$("#img").change(function() {
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
	
	<!--驗證並送出表單-->
		$('#addbtn').click(function(){
			let form = $('#addRcpForm');
			let reportValidity = form[0].reportValidity();
			
			if(reportValidity){
				$('#addRcpForm').submit();
			}
		});
		
		$('#editbtn').click(function(){
			let form = $('#editRcpForm');
			let reportValidity = form[0].reportValidity();
			
			if(reportValidity){
				$('#editRcpForm').submit();
			}
		});
	<!--快速輸入-->
	$('#smartInput').click(function(){
		$('#title').val("粉煎扇貝配燉青豆");
		$('#type').val("2");
		$('#time').val("20");
		$('#serve').val("2");
		$('#video').val("Rb4CT3zDu6Y");

		$('#ing').val("干貝 大顆6pcs\n麵粉 適量\n鹽 適量\n"+
					  "胡椒 適量\n奶油 適量\n沙拉油 適量\n"+
					  "冷凍青豆 130g\n培根 20g\n洋蔥 15g\n"+
					  "萵苣 30g\n雞湯 100ml\n香草(百里香/月桂葉/奧勒岡) 適量\n培根 4片");
		$('#con').val("1.製作燉青豆，先將10g奶油放入鍋中加熱，把切片培根放入拌炒，再將洋蔥放入鍋中不要炒到洋蔥變色\n"+
					  "2.等到洋蔥有點變軟放入萵苣和青豆一起炒，再加入雞湯和香草蓋上用烹調紙做成的紙鍋蓋燉煮一下，煮到液體剩下一半在加入10g奶油增加風味和濃稠度\n"+
					  "3.將干貝水分擦乾，撒上鹽與胡椒，沾上大量麵粉再將多餘的粉完全抖落\n"+
					  "4.在平底鍋裡放入可將干貝淹到1/3高度的沙拉油與奶油加熱，加熱至氣泡變小，油也微微變色後再放入干貝,煎到背面色澤恰到好處即可翻面，邊煎要邊舀起周圍的油淋在干貝上，待兩面都煎到金黃焦糖色澤即可\n" +
					  "5.將燉青豆鋪在盤中放上干貝用煎好的培根片裝飾，擺盤完成");
		
	});
	
	<!--模糊搜尋-->
	$('#searchbar').keyup(function(){
		let search = $(this).val();
		$.ajax({
			url:"recipe/find?search=" + search,
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
			url:"recipe/find?search=" + search + "&p=" + p,
			method:"get",
			success: function(data){
				console.log(data);
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
						url:"deleteRecipe/" + id,
						method:"delete",
						success: function(data){
							ajaxTable(data);
						}
					});
				  Swal.fire(
			      '刪除成功',
			      '該食譜已被刪除',
			      'success'
			    );
			  }
			});
	});
	<!--修改-->
	$('body').on('click','button[name="edit"]',function(){
		let id = $(this).parent().parent().find("p").html();
		$.ajax({
			url:"recipe/getjson?ID=" + id,
			method:"get",
			success: function(data){
				$('#rid_e').val(data.rid);
				$('#title_e').val(data.title);
				$('#type_e').val(data.rtp.rtype_id);
				$('#time_e').val(data.rtime);
				$('#serve_e').val(data.serve);
				$('#video_e').val(data.video);
				$('#preview_img_e').attr('src', '/GroupOne/' + data.img);
				

				$('#ing_e').val(data.ing);
				$('#con_e').val(data.con);
				
			}
		});
	});
	
	
	<!--ajax產table-->
	function ajaxTable(data){
		$("#tbody").html("");
		for(i=0;i<data.rcps.length;i++){
			$("#tbody").append(
					"<tr><td><p>" + data.rcps[i].rid + "</p></td>" +
					"<td><p>" + data.rcps[i].rates.toFixed(1) + "</p></td>" +
					"<td class='product'><img src='http://localhost:8080/GroupOne/" + data.rcps[i].img+ "'>" +
					"<div class='product-de'><h5>" + data.rcps[i].title + "</h5>" + 
					"<p>" + data.rcps[i].rtime + "分鐘/" + data.rcps[i].serve + "人份</p></div></td>" + 
					"<td class='product-des'><h5>" + data.rcps[i].rtp.rtype + "</h5></td>" +
					"<td class='product-des'><p>" +data.rcps[i].added.substring(0, 19) + "</p></td>" + 
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
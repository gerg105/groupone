<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<link href="${contextRoot}/css/backend_system_style.css"
	rel="stylesheet" />
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>天食地栗 | 後台系統</title>
<!-- ico -->
<link rel="shortcut icon" href="${contextRoot}/src/webimg/icon_round.ico">
<!-- sweet alert -->
<link rel="stylesheet" href="${contextRoot}/css/sweetalert2.min.css">
<script src="${contextRoot}/js/sweetalert2.min.js"></script>

</head>
<body>
	<div class="mx-auto app-login-box col-md-6">
		<div class="app-logo-inverse mx-auto mb-3"></div>
		<div class="modal-dialog w-100">
			<div class="modal-content">
				<div class="modal-header">
					<div class="h5 modal-title">
						忘記密碼?
						<h6 class="mt-1 mb-0 opacity-8">
							<span>請輸入您的Email來找回密碼</span>
						</h6>
					</div>
				</div>
				<div class="modal-body">
					
						<form  id="forgotPwdForm" action="${contextRoot}/adminForgotPwd" method="post">
							<div class="form-row">
								<div class="col-md-12">
									<div class="position-relative form-group">
										<input name="empEmail" id="exampleEmail" placeholder="Email"
											type="email" class="form-control" required>
									</div>
									<div>
									<span style="color: red">${requestScope.sendMailMsg}</span>
									</div>
									<div>
									<span style="color: red">${requestScope.errorMsg}</span>
									</div>
								</div>
							</div>
							<div class="modal-footer clearfix">
								<div class="float-right">
									<input type="button" id="smartInput" class="btn btn-success" value="一鍵輸入">
									<input type="button" id="subBtn" class="btn btn-primary" value="送出">
								</div>
							</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	<!--忘記密碼鈕-->
	$("#subBtn").click(function(){
		let form = $('#forgotPwdForm');
		let reportValidity = form[0].reportValidity();
		
		if(reportValidity){
			Swal.fire({
				  title: '處理中...',
				  didOpen: () => {
				    Swal.showLoading();
				  },
				})
			$('#forgotPwdForm').submit();
		}
	})
	
	$("#smartInput").click(function(){
		$("#exampleEmail").val("eeit138g1.07@gmail.com");
	})
	</script>
</body>
</html>
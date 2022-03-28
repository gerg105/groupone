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
<title>天食地栗 | 後臺系統</title>
<!-- ico -->
<link rel="shortcut icon" href="${contextRoot}/src/webimg/icon_round.ico">
</head>
<body>
	<div class="mx-auto app-login-box col-md-6">
		<div class="app-logo-inverse mx-auto mb-3"></div>
		<div class="modal-dialog w-100">
			<div class="modal-content">
				<div class="modal-header">
					<div class="h5 modal-title">
						<h4 class="mt-1 mb-0 opacity-8">
							<span>員工名稱:${emp.username}</span>
							<span>員工編號:${emp.empId}</span>
						</h4>
					</div>
				</div>
				<div class="modal-body">
					
						<form id="checkNewPasswordForm" action="${contextRoot}/adminCheckNewPassword" method="post">
							<div class="form-row">
								<div class="col-md-12">
									<div class="col-md-12">
										<div class="position-relative form-group">
											<input name="newPassword" id="newPassword" placeholder="新密碼"
												type="password" class="form-control">
										</div>
									</div>
									<div class="col-md-12">
										<div class="position-relative form-group">
											<input name="newPassword2" id="newPassword2" placeholder="確認新密碼"
												type="password" class="form-control">
										</div>
									</div>
									<div class="col-md-12">
										<div class="position-relative form-group">
											<input name="checkCode" id="checkCode" placeholder="驗證碼"
												type="text" class="form-control">
										</div>
									</div>
									<div>
									<span class="error" style="display:block;color: red">${errors.passwordError}</span>
									</div>
									<div>
									<span style="color: red">${errors.newPassword}</span>
									</div>
									<div>
									<span style="color: red">${errors.newPassword2}</span>
									</div>
									<div>
									<span style="color: red">${errors.codeError}</span>
									</div>
									<div>
									<input type="text" value="${emp.empId}" name="empId" hidden="" >
									<input type="text" value="${emp.idCode}" name="idCode" hidden="" >
									</div>
								</div>
							</div>
							<div class="modal-footer clearfix">
								<div class="float-right">
									<input type="button" id="smartInput" class="btn btn-success" value="一鍵輸入">
									<input type="button" id="submitBtn" class="btn btn-primary" value="送出">
								</div>
							</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	$("#submitBtn").click(function(){
		$("#checkNewPasswordForm").submit();
	})
	
	<!--一鍵輸入-->
	$("#smartInput").click(function(){
		$("#newPassword").val("Passw0rd123@");
		$("#newPassword2").val("Passw0rd123@");
	})
	
	</script>
</body>
</html>
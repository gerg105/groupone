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
</head>
<body>
	<div class="mx-auto app-login-box col-md-6">
		<div class="app-logo-inverse mx-auto mb-3"></div>
		<div class="modal-dialog w-100">
			<div class="modal-content">
				<div class="modal-header">
					<div class="h5 modal-title">
						寄送成功
						
					</div>
				</div>
				<div class="modal-body">
							<div class="form-row">
								<div class="col-md-12">
									<div>
									<h6 style="color: blue;">${requestScope.sendMailMsg}</h6>
									</div>
								</div>
							</div>
							<div class="modal-footer clearfix">
								<div class="float-right">
									<a href="${contextRoot}/adminLogin" ><button class="btn btn-primary btn-lg">返回首頁</button></a>
								</div>
							</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
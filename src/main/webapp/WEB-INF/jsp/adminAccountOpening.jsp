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
	<div class="d-flex h-100 justify-content-center align-items-center">
		<div class="modal-dialog w-100 mx-auto">
			<div class="modal-content">
				<div class="modal-body">
					<div>
						<h2>驗證成功，請返回登入頁面</h2>
					</div>
					<div class="float-right">
						<a href="${contextRoot}/adminLogin"><button
								class="btn btn-primary btn-lg" type="button">返回登入</button></a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
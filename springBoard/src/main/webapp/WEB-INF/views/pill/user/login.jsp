<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="https://kit.fontawesome.com/b7d831082a.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/pill/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/pill/default.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/pill/user/login.css"/>">
<title>Login</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		let saveCheck = localStorage.saveCheck;
		let id = localStorage.id;
		
		if(id) $j("#userId").val(id);
		if(saveCheck) $j("#saveId").prop("checked", true);
		
		$j("#loginBtn").on("click", function() {
			if(!$j("#userId").val()?.trim()) {
				alert("아이디를 입력해주세요.");
				$j("#userId").focus();
				return;
			}
			if(!$j("#userPw").val()?.trim()) {
				alert("비밀번호를 입력해주세요.");
				$j("#userPw").focus();
				return;
			}
			
			if(localStorage.id) {
				if(!($j("#saveId").is(":checked"))) {
					localStorage.removeItem("saveCheck");
					localStorage.removeItem("id");
					location.href = "/pill";
					return;
				}
			}
			
			localStorage.setItem("saveCheck", true);
			localStorage.setItem("id", $j("#userId").val());
			location.href = "/pill";
		});
	});
</script>
<body>
	<div class="wrap">
		<%@include file="/WEB-INF/views/pill/fix/header.jsp" %>

		<div class="container">
			<div class="login-box">
				<form class="login-form form-box" action="">
					<div class="user-id">
						<label for="userId">ID</label>
						<input type="text" name="userId" id="userId" class="form-control"
						oninput="this.value = this.value.replace(/[\W]/g, '')"
						>
					</div>
					<div class="user-pw">
						<label for="userPw">PW</label>
						<input type="password" name="userPw" id="userPw" class="form-control"
						oninput="this.value = this.value.replace(/[\W]/g, '')"
						>
					</div>
					<button type="button" id="loginBtn">로그인</button>
					<div class="save-id">
						<input type="checkbox" name="saveId" id="saveId">
						<label for="saveId">아이디 저장</label>
					</div>
				</form>
				<div class="option-box">
					<div class="login-option">
						<button type="button" class="kakao-login">
							<img src="/resources/img/menuIcon/kakao_login_medium_narrow.png" alt="카카오이미지">
						</button>
					</div>
					<div class="user-option">
						<a href="">아이디/비밀번호 찾기</a>
						<a href="/pill/join-select">회원가입</a>
					</div>
				</div>
			</div>
		</div>
  </div>
</body>
</html>


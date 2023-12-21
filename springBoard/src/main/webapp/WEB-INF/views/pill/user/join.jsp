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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/user/join.css"/>">
<title>Join</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		
		$j(".submit-btn").on("click", function() {
			const emailRegex = /^\w+@\w+\.\w+$/;
			let inputPw = $j("#userPw").val();
			let checkPw = $j("#pwCheck").val();
			
			if(!emailRegex.test($j("#userEmail").val())) {
				alert("이메일을 입력해주세요.");
				$j("userEmail").focus();
				return;
			}
			
			if(!inputPw) {
				alert("비밀번호를 입력해주세요.");
				$j("#userPw").focus();
				return;
			}
			
			if(!checkPw) {
				alert("비밀번호 확인을 입력해주세요.");
				$j("#pwCheck").focus();
				return;
			}
			
			if(inputPw != checkPw) { 
				alert("비밀번호가 다릅니다.");
				return;
			}
			
			alert("회원가입 성공");
			location.href = "/pill";
		});
	});
</script>
<body>
	<div class="wrap">
		<%@include file="/WEB-INF/views/pill/fix/header.jsp" %>

		<div class="container">
			<div class="join-box">
				<form class="join-form form-box" action="">
					<div class="user-email">
						<label for="userEmail">이메일</label>
						<input type="email" name="userEmail" id="userEmail" class="form-control"
						oninput="this.value = this.value.replace(/[^\w\@\.]/g, '')"
						>
					</div>
					<div class="user-pw">
						<label for="userPw">비밀번호</label>
						<input type="password" name="userPw" id="userPw" class="form-control"
						oninput="this.value = this.value.replace(/[\W]/g, '')"
						>
					</div>
					<div class="user-pw-check">
						<label for="pwCheck">비밀번호 확인</label>
						<input type="password" name="pwCheck" id="pwCheck" class="form-control"
						oninput="this.value = this.value.replace(/[\W]/g, '')"
						>
					</div>
					<button type="button" class="submit-btn">회원가입</button>
				</form>
			</div>
		</div>
  </div>
</body>
</html>


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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/user/join-select.css"/>">
<title>Join Select</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
	});
</script>
<body>
	<div class="wrap">
		<%@include file="/WEB-INF/views/pill/fix/header.jsp" %>

		<div class="container">
			<div class="join-select-box">
        <div class="join-select-header">
          회원가입 방식을 입력해주세요.
        </div>
        <div class="join-select-list">
          <div class="join-select-item email-join" onclick="location.href='/pill/join'">
            <i class="fa-solid fa-envelope" style="color: #969696;"></i>
            이메일로 회원가입
          </div>
          <div class="join-select-item kakao-join">
            <img src="/resources/img/menuIcon/kakao_join_medium_narrow.png" alt="카카오이미지">
          </div>
        </div>
  </div>
</body>
</html>


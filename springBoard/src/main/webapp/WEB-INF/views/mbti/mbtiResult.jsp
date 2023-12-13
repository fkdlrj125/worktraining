<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="<c:url value="/resources/css/mbti/mbti.css"/>">
<title>mbtiResult</title>
</head>
<script type="text/javascript">
</script>
</head>
<body>
	<div class="container">
		<a class="toTest" href="/mbtiTest.do">테스트로</a>
		<div class="resultMent">당신의 성격 유형은 : </div>
		<h2 class="mbtiResult">${fn:toUpperCase(mbti)}</h2>
	</div>
</body>
</html>
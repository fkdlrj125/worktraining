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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/ranking/ranking.css"/>">
<title>Ranking Result</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		var horizontalUnderLine = $j("#horizontal-underline");
		
		var horizontalIndicator = (e) => {
			horizontalUnderLine.css("left", e.currentTarget.offsetLeft + "px");
			horizontalUnderLine.css("width", e.currentTarget.offsetWidth + "px");

			$j(".ranking-type a").removeClass("selected");
			$j(e.currentTarget).addClass("selected");
		}
		
		$j(".ranking-type a").on("click", function(e) {
			horizontalIndicator(e);
		});
	});
</script>
<body>
	<div class="wrap">
		<%@include file="/WEB-INF/views/pill/fix/header.jsp" %>

		<div class="container">
			<div class="ranking-title">
			<div id="userInfo">20대 남성</div> 유저들이 뽑은 베스트 랭킹
			</div>
			<div class="ranking">
				<div class="ranking-type">
					<div id="horizontal-underline"></div>
					<a class="selected">전체</a>
					<a>멀티비타민</a>
					<a>일반</a>
				</div>
			</div>
		</div>
  </div>
</body>
</html>


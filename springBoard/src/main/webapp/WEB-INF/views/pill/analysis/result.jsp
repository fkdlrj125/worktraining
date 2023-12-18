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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/analysis/result.css"/>">
<title>Analysis Result</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		$j(".progress-bar").css("width", "74%");
		var selectCnt = 0;
		
		$j(".nutri-box").on("click", function() {
			if($j(this).find("i").attr("style") == "color: #56e166;") {
				$j(this).find("i").attr("style", "color: #c8c8c8;");
				selectCnt--;
				if(selectCnt == 0) {
					$j(".next-btn").css("background-color", "#e0e0ff");
					$j(".next-btn").css("pointer-events", "none");
				}				
				return;
			}
			selectCnt++;
			$j(this).find("i").attr("style", "color: #56e166;");
			$j(".next-btn").css("background-color", "#6c2ef1");
			$j(".next-btn").css("pointer-events", "auto");
		});
	});
	
	
</script>
<body>
	<div class="wrap">
		<nav class="navbar navbar-expand-lg">
		  <div class="container-fluid">
		    <a href="/pill" class="back-btn">
		    	<i class=" fas fa-solid fa-chevron-left fa-lg" style="color: #ffffff;"></i>
		    </a>
		  </div>
		</nav>

		<div class="container">
      <div class="user-rating">
        <div class="rating-header">
          <div class="header-text">상위 26%의 점수예요</div>
        </div>
        <div class="rating-graph">
          <div class="graph-score">
            <strong class="score">74</strong> 점
          </div>
          <div class="progress">
          	<div class="progress-bar" 
	          role="progressbar" style="width:0;"
	          aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
        <div class="rating-share">
          <i class="fas fa-regular fa-share-nodes" style="color: #6c2ef1"></i>
          내 점수 공유하기
        </div>
        <div class="analysis-btn-box">
          새로운 조합으로
          <button class="analysis-btn" onclick="location.href='/pill/analysis'">영양제 분석하기</button>
        </div>
      </div>
    </div>
  </div>
</body>
</html>


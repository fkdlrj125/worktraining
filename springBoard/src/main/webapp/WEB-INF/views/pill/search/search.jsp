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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/search/search.css"/>">
<title>Analysis</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		var selectCnt = 0;
		
		$j(".ingredient-item").on("click", function() {
			if($j(this).find("i").attr("style") == "color: #56e166;") {
				$j(this).find("i").attr("style", "color: #c8c8c8;");
				selectCnt--;
				if(selectCnt == 0) {
					$j(".fixed-search-btn").css("display", "none");
					$j(".fixed-search-btn").css("pointer-events", "none");
				}				
				return;
			}
			selectCnt++;
			$j(this).find("i").attr("style", "color: #56e166;");
			$j(".fixed-search-btn").css("display", "block");
			$j(".fixed-search-btn").css("pointer-events", "auto");
		});
	});
	
	
</script>
<body>
	<div class="wrap">
		<nav class="navbar navbar-expand-lg">
		  <div class="container-fluid">
        <form class="d-flex search-bar">
          <input class="form-control" type="search" placeholder="성분 이름을 입력해주세요">
          <a href="/pill" class="back-btn fa-solid fa-chevron-left fa-lg" style="color: #2a2a2a;"></a>
          <button class="search-btn fas fa-regular fa-magnifying-glass fa-lg" style="color: #6c2ef1;"></button>
        </form>
		  </div>
		</nav>

    <div class="selected-ingredient-box">
      <div class="selected-ingredient">
        <div class="item">
          <div class="item-name">비타민C&nbsp;&nbsp;</div>
          <i class="fa-solid fa-x" style="color: #ffffff;"></i>
        </div>
        <div class="item">
          <div class="item-name">프로바이오틱스(유산균)&nbsp;&nbsp;</div>
          <i class="fa-solid fa-x" style="color: #ffffff;"></i>
        </div>
        <div class="item">
          <div class="item-name">오메가3&nbsp;&nbsp;</div>
          <i class="fa-solid fa-x" style="color: #ffffff;"></i>
        </div>
      </div>
      <div id="selectedCnt"></div>
    </div>
    
		<div class="container">
      <div class="search-by-ingredient">
        <div class="search-ingredient-title">
          인기 성분이에요
        </div>
        <div class="ingredient-list">
          <div class="ingredient-item">
            <i class="ingredient-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="ingredient-name">오메가3</div>
          </div>
          <div class="ingredient-item">
            <i class="ingredient-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="ingredient-name">프로바이오틱스(유산균)</div>
          </div>
          <div class="ingredient-item">
            <i class="ingredient-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="ingredient-name">비타민C</div>
          </div>
          <div class="ingredient-item">
            <i class="ingredient-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="ingredient-name">오메가3</div>
          </div>
          <div class="ingredient-item">
            <i class="ingredient-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="ingredient-name">프로바이오틱스(유산균)</div>
          </div>
          <div class="ingredient-item">
            <i class="ingredient-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="ingredient-name">비타민C</div>
          </div>
        </div>
      </div>

      <button class="fixed-search-btn">검색</button>
    </div>
  </div>
</body>
</html>


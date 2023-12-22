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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/analysis/select.css"/>">
<title>Analysis</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		var selectCnt = 0;
		
		$j(".nutri-item").on("click", function() {
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
		
		$j(".x-btn").on("click", function() {
			$j(".form-control").val("");
			$j(this).removeClass("fa-circle-xmark");
		});
		
		$j(".form-control").on("keyup", function() {
			if($j(this).val()) {
				$j(".x-btn").css("display", "inline-block");
				$j(".x-btn").addClass("fa-circle-xmark");
				return;
			}
			
			$j(".x-btn").removeClass("fa-circle-xmark");
		});
	});
	
	
</script>
<body>
	<div class="wrap">
		<nav class="navbar navbar-expand-lg">
		  <div class="container-fluid">
        <form class="d-flex search-bar" accept-charset="UTF-8">
          <input name="search" class="form-control" type="text" placeholder="제품명이나 브랜드명으로 검색">
          <a href="/pill" class="back-btn fa-solid fa-chevron-left fa-lg" style="color: #2a2a2a;"></a>
          <button type="button" class="x-btn fa-solid fa-lg" style="color: #ccc;"></button>
          <button class="search-btn fas fa-regular fa-magnifying-glass fa-lg" style="color: #6c2ef1;"></button>
        </form>
		  </div>
		</nav>

		<div class="container">
      <div class="my-nutri">
        <div class="my-nutri-header">
          <div class="header-title">내 영양제</div>
          <a href="" class="header-all">모두 보기
            <div class="all-btn fa-solid fa-chevron-right" style="color: #ddd;"></div>
          </a>
        </div>
        <div class="nutri-list">
          <div class="nutri-item">
            <img src="/resources/img/nutriImg/thorneSAT.jpg" alt="내 영양제" class="nutri-img">
            <i class="nutri-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="nutri-company">쏜리서치</div>
            <div class="nutri-product">SAT</div>
          </div>
          <div class="nutri-item">
            <img src="/resources/img/nutriImg/omega3fishoil.jpg" alt="내 영양제" class="nutri-img">
            <i class="nutri-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="nutri-company">스포츠리서치</div>
            <div class="nutri-product">트리플 스트렝스 오메가3 피쉬오일</div>
          </div>
          <div class="nutri-item">
            <img src="/resources/img/nutriImg/thorneCMM.jpg" alt="내 영양제" class="nutri-img">
            <i class="nutri-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="nutri-company">쏜리서치</div>
            <div class="nutri-product">칼슘 마그네슘 말레이트</div>
          </div>
          <div class="nutri-item">
            <img src="/resources/img/nutriImg/lactobif30.jpg" alt="내 영양제" class="nutri-img">
            <i class="nutri-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="nutri-company">캘리포니아골드뉴트리션</div>
            <div class="nutri-product">락토비프 프로바이오틱스 3000억</div>
          </div>
          <div class="nutri-item">
            <img src="/resources/img/nutriImg/gorueVitamin.jpg" alt="내 영양제" class="nutri-img">
            <i class="nutri-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="nutri-company">고려은단</div>
            <div class="nutri-product">비타민C 1000</div>
          </div>
          <div class="nutri-item">
            <img src="/resources/img/nutriImg/thorneBasicB.jpg" alt="내 영양제" class="nutri-img">
            <i class="nutri-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="nutri-company">쏜리서치</div>
            <div class="nutri-product">베이직 B 컴플렉스</div>
          </div>
        </div>
      </div>

      <div class="interest-nutri">
        <div class="interest-nutri-header">
          <div class="header-title">내 관심 제품</div>
        </div>
        <div class="nutri-list">
          <div class="nutri-item">
            <img src="/resources/img/nutriImg/thorneSAT.jpg" alt="내 영양제" class="nutri-img">
            <i class="nutri-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="nutri-company">쏜리서치</div>
            <div class="nutri-product">SAT</div>
          </div>
          <div class="nutri-item">
            <img src="/resources/img/nutriImg/omega3fishoil.jpg" alt="내 영양제" class="nutri-img">
            <i class="nutri-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="nutri-company">스포츠리서치</div>
            <div class="nutri-product">트리플 스트렝스 오메가3 피쉬오일</div>
          </div>
          <div class="nutri-item">
            <img src="/resources/img/nutriImg/thorneCMM.jpg" alt="내 영양제" class="nutri-img">
            <i class="nutri-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="nutri-company">쏜리서치</div>
            <div class="nutri-product">칼슘 마그네슘 말레이트</div>
          </div>
          <div class="nutri-item">
            <img src="/resources/img/nutriImg/lactobif30.jpg" alt="내 영양제" class="nutri-img">
            <i class="nutri-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="nutri-company">캘리포니아골드뉴트리션</div>
            <div class="nutri-product">락토비프 프로바이오틱스 3000억</div>
          </div>
          <div class="nutri-item">
            <img src="/resources/img/nutriImg/gorueVitamin.jpg" alt="내 영양제" class="nutri-img">
            <i class="nutri-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="nutri-company">고려은단</div>
            <div class="nutri-product">비타민C 1000</div>
          </div>
          <div class="nutri-item">
            <img src="/resources/img/nutriImg/thorneBasicB.jpg" alt="내 영양제" class="nutri-img">
            <i class="nutri-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="nutri-company">쏜리서치</div>
            <div class="nutri-product">베이직 B 컴플렉스</div>
          </div>
        </div>
      </div>

      <button class="next-btn" type="button" onclick="location.href='/pill/analysis/result'">다음</button>
      
      <div class="fixed-btn">
        <i class="fas fa-regular fa-flask fa-xl" style="color: #6c2ef1;"></i>
      </div>
    </div>
  </div>
</body>
</html>


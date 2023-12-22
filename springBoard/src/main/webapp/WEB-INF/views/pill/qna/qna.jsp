<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="https://kit.fontawesome.com/b7d831082a.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/pill/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/pill/qna/qna.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/pill/default.css"/>">
<title>Q&A</title>
</head>
<script type="text/javascript">
	//캐러셀
	var showSlide = function(slideIndex) {
	    $j(".card-show").css('transform', `translate(-\${slideIndex * parseInt($j('.qna-card').css('width'))}px)`);
	}

	$j(document).ready(function() {
		var nowTime = new Date().getHours();
		var startTime = 09;
		var endTime = 21;
		let currentSlide = 0;
		
		// 상담 시간 설정
		if(nowTime > endTime || nowTime < startTime) {
			$j(".close-text").css("display", "block");
			$j(".counsel-btn").css({
				"background-color": "#aaa",
				"pointer-events" : "none"
				}).text("오늘 상담 요청이 마감되었어요");
		}
		
		
		// 캐러셀 이전 버튼
		$j(".pre-btn").on("click", function() {
			if(parseInt($j(".current-page").text())-1 == 0) {
				alert("첫 번째 페이지입니다.");
				return;
			}
			
			showSlide(--currentSlide);
			$j(".current-page").text(parseInt($j(".current-page").text())-1);
		});
		
		// 캐러셀 다음 버튼
		$j(".next-btn").on("click", function() {
			if(parseInt($j(".current-page").text())+1 > parseInt($j(".total-page").text())) {
				alert("마지막 페이지입니다.");
				return;
			}
			
			showSlide(++currentSlide);
			$j(".current-page").text(parseInt($j(".current-page").text())+1);
		});
		
		$j(".x-btn").on("click", function() {
			$j(".form-control").val("");
			$j(this).removeClass("fa-circle-xmark");
		});
		
		// 검색바 전체 지우기 
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
		<%@include file="/WEB-INF/views/pill/fix/header.jsp" %>

		<div class="container">
      <div class="qna-box">
      	<form class="d-flex search-bar" accept-charset="UTF-8">
	        <input name="search" class="form-control" type="text" placeholder="xxx님,무엇이 궁금하신가요?">
	        <button type="button" class="x-btn fa-solid fa-lg" style="color: #ccc;"></button>
	        <button class="search-btn fas fa-regular fa-magnifying-glass fa-lg" style="color: #6c2ef1;"></button>
	      </form>
	      
	      <div class="qna-title">인기있는 질문</div>
	      <div class="popular-qna-box">
	      	<div class="card-main">
		        <div class="card-show">
		        	<div class="qna-card">
			          <div class="qna-card-title">
			            <span class="qmark">Q.&nbsp;</span>
			            Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit animi ea mollitia. Corrupti facere recusandae adipisci reiciendis itaque voluptates placeat, aliquid inventore, cupiditate iure laborum sunt officiis exercitationem assumenda sapiente!
			          </div>
			          <div class="qna-card-content">
			            <img src="/resources/img/qnaIcon/anna.png" alt="유저아이콘">
			            <div class="qna-comment">
			              Lorem ipsum, dolor sit amet consectetur adipisicing elit. Quaerat eum explicabo incidunt rerum praesentium laudantium illum officiis et iure error asperiores corporis, unde, culpa obcaecati eaque, nihil ducimus veritatis itaque.
			            </div>
			          </div>
			          <div class="qna-user-info">
			            <div class="user-name">아**&nbsp;</div>
			            <div class="user-personal-info">20대 / 여</div>
			          </div>
			        </div>
			        <div class="qna-card">
			          <div class="qna-card-title">
			            <span class="qmark">Q.&nbsp;</span>
			            Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit animi ea mollitia. Corrupti facere recusandae adipisci reiciendis itaque voluptates placeat, aliquid inventore, cupiditate iure laborum sunt officiis exercitationem assumenda sapiente!
			          </div>
			          <div class="qna-card-content">
			            <img src="/resources/img/qnaIcon/anna.png" alt="유저아이콘">
			            <div class="qna-comment">
			              Lorem ipsum, dolor sit amet consectetur adipisicing elit. Quaerat eum explicabo incidunt rerum praesentium laudantium illum officiis et iure error asperiores corporis, unde, culpa obcaecati eaque, nihil ducimus veritatis itaque.
			            </div>
			          </div>
			          <div class="qna-user-info">
			            <div class="user-name">여**&nbsp;</div>
			            <div class="user-personal-info">30대 / 여</div>
			          </div>
			        </div>
		        </div>
	        </div>
	        <div class="pagination">
	          <button class="pre-btn" href="#">
	            <i class="fa-solid fa-chevron-left fa-lg" style="color: #aaa;"></i>
	          </button>
	          <div class="current-page">1</div>
	          &nbsp;|&nbsp;
	          <div class="total-page">5</div>
	          <button class="next-btn" href="#">
	            <i class="fa-solid fa-chevron-right fa-lg" style="color: #aaa;"></i>
	          </button>
	        </div>
	      </div>
	      <div class="counsel-box">
	          <div class="close-text">내일 다시 만나요</div>
	          <button class="counsel-btn">상담 요청 하기</button>
				</div>
      </div>
		</div>
  </div>
</body>
</html>


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
<title>Q&A</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		var horizontalUnderLine = $j("#horizontal-underline");
		
		var horizontalIndicator = (e) => {
			horizontalUnderLine.css("left", e.currentTarget.offsetLeft + "px");
			horizontalUnderLine.css("width", e.currentTarget.offsetWidth + "px");

			$j(".ranking-type button").removeClass("selected");
			$j(e.currentTarget).addClass("selected");
		}
		
		$j(".ranking-type button").on("click", function(e) {
			horizontalIndicator(e);
		});
	});
</script>
<body>
	<div class="wrap">
		<%@include file="/WEB-INF/views/pill/fix/header.jsp" %>

		<div class="container">
			<div class="ranking-title">
				<strong id="userInfo">20대 남성</strong> 유저들이 뽑은 베스트 랭킹
			</div>
			<div class="ranking">
				<div class="ranking-type">
					<div id="horizontal-underline"></div>
					<button class="selected">전체</button>
					<button>멀티비타민</button>
					<button>일반</button>
				</div>
				<div class="ranking-list">
					<div class="ranking-product">
						<img src="/resources/img/rankingIcon/ranking1.png" alt="랭킹아이콘">
						<img src="/resources/img/nutriImg/thorneSAT.jpg" alt="제품이미지">
						<div class="product-info">
							<div class="product-company">쏜리서치</div>
							<div class="product-name">SAT</div>
							<div class="product-rating">
								<img src="/resources/img/rankingIcon/star-icon.png" alt="별점아이콘">
								<div class="rating">4.59</div>
								<div class="comment-cnt">(296)</div>
							</div>
						</div>
					</div>
					<div class="ranking-product">
						<img src="/resources/img/rankingIcon/ranking2.png" alt="랭킹아이콘">
						<img src="/resources/img/nutriImg/omega3fishoil.jpg" alt="제품이미지">
						<div class="product-info">
							<div class="product-company">스포츠리서치</div>
							<div class="product-name">트리플 스트렝스 오메가3 피쉬오일</div>
							<div class="product-rating">
								<img src="/resources/img/rankingIcon/star-icon.png" alt="별점아이콘">
								<div class="rating">4.79</div>
								<div class="comment-cnt">(999)</div>
							</div>
						</div>
					</div>
					<div class="ranking-product">
						<img src="/resources/img/rankingIcon/ranking3.png" alt="랭킹아이콘">
						<img src="/resources/img/nutriImg/gorueVitamin.jpg" alt="제품이미지">
						<div class="product-info">
							<div class="product-company">고려은단</div>
							<div class="product-name">비타민C 1000</div>
							<div class="product-rating">
								<img src="/resources/img/rankingIcon/star-icon.png" alt="별점아이콘">
								<div class="rating">4.57</div>
								<div class="comment-cnt">(1,364)</div>
							</div>
						</div>
					</div>
					
					<a href="" class="move-ranking">
						<em>성별/연령별</em> 랭킹 전체 보기
						<i class="fa-solid fa-chevron-right fa-lg" style="color: #2a2a2a;"></i>
					</a>
				</div>
			</div>
		</div>
  </div>
</body>
</html>


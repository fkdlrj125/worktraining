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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/search/result.css"/>">
<title>Search Result</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		let searchValue = $j(".form-control").val();
		let searchReg = new RegExp(searchValue, 'g');
		
		$j(".item-name").each(function() {
			$j(this).html( $j(this).text().replace(searchReg, `<em>\${searchValue}</em>`) );
		});
		
		$j(".x-btn").on("click", function() {
			$j(".form-control").val("");
			$j(this).removeClass("fa-circle-xmark");
		});
		
		$j(".form-control").on("keyup", function() {
			if($j(this).val()) {
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
        <form class="d-flex search-bar">
          <input class="form-control" type="text" placeholder="성분 이름을 입력해주세요" value="비타민">
          <a href="/pill" class="back-btn fa-solid fa-chevron-left fa-lg" style="color: #2a2a2a;"></a>
          <button type="button" class="x-btn fa-solid fa-circle-xmark fa-lg" style="color: #ccc;"></button>
					<button type="submit" class="search-btn fas fa-regular fa-magnifying-glass fa-lg" style="color: #6c2ef1;"></button>
        </form>
		  </div>
		</nav>

		<div class="container">
      <div class="search-result-box">
        <div class="search-list">
					<div class="search-item">
						<img class="item-img" src="/resources/img/nutriImg/twoperdayvitamin.jpg" alt="제품이미지">
						<div class="item-info">
							<div class="item-company">라이프익스텐션</div>
							<div class="item-name">투퍼데이 멀티비타민</div>
						</div>
					</div>
					<div class="search-item">
						<img class="item-img" src="/resources/img/nutriImg/jongvitamin.jpg" alt="제품이미지">
						<div class="item-info">
							<div class="item-company">종근당</div>
							<div class="item-name">활력비타민B 플러스</div>
						</div>
					</div>
					<div class="search-item">
						<img class="item-img" src="/resources/img/nutriImg/gorueVitaminC1000.jpg" alt="제품이미지">
						<div class="item-info">
							<div class="item-company">고려은단</div>
							<div class="item-name">비타민C 1000 이지 + 비타민D</div>
						</div>
					</div>
					<div class="search-item">
						<img class="item-img" src="/resources/img/nutriImg/gorueVitamin.jpg" alt="제품이미지">
						<div class="item-info">
							<div class="item-company">고려은단</div>
							<div class="item-name">비타민C 1000</div>
						</div>
					</div>
					<div class="search-item">
						<img class="item-img" src="/resources/img/nutriImg/aliveMultiVitamin.jpg" alt="제품이미지">
						<div class="item-info">
							<div class="item-company">네이처스웨이</div>
							<div class="item-name">얼라이브 원스데일리 멀티비타민</div>
						</div>
					</div>
					<div class="search-item">
						<img class="item-img" src="/resources/img/nutriImg/gorueMultiVitamin.jpg" alt="제품이미지">
						<div class="item-info">
							<div class="item-company">고려은단</div>
							<div class="item-name">멀티비타민 올인원</div>
						</div>
					</div>
        </div>
      </div>

    </div>
		<button class="fixed-btn">
			<i class="fas fa-regular fa-flask fa-xl" style="color: #6c2ef1;"></i>
		</button>
  </div>
</body>
</html>


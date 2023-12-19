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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/qna/qna.css"/>">
<title>Q&A</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		var nowTime = new Date().getHours();
		var startTime = 09;
		var endTime = 21;
		
		if(nowTime > endTime || nowTime < startTime) {
			$j(".close-text").css("display", "block");
			$j(".counsel-btn").css({
				"background-color": "#aaa",
				"pointer-events" : "none"
				}).text("���� ��� ��û�� �����Ǿ����");
		}
		
		$j(".pre-btn").on("click", function() {
			if(parseInt($j(".current-page").text())-1 == 0) {
				alert("ù ��° �������Դϴ�.");
				return;
			}
			
			$j(".current-page").text(parseInt($j(".current-page").text())-1);
		});
		
		$j(".next-btn").on("click", function() {
			if(parseInt($j(".current-page").text())+1 > parseInt($j(".total-page").text())) {
				alert("������ �������Դϴ�.");
				return;
			}
			
			$j(".current-page").text(parseInt($j(".current-page").text())+1);
		});
	});
</script>
<body>
	<div class="wrap">
		<%@include file="/WEB-INF/views/pill/fix/header.jsp" %>

		<div class="container">
      <form class="d-flex search-bar">
        <input class="form-control" type="search" placeholder="xxx��,������ �ñ��ϽŰ���?">
        <button class="search-btn fas fa-regular fa-magnifying-glass fa-lg" style="color: #6c2ef1;"></button>
      </form>
      
      <div class="qna-title">�α��ִ� ����</div>
      <div class="popular-qna-box">
        <div class="qna-card">
          <div class="qna-card-title">
            <span class="qmark">Q.&nbsp;</span>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit animi ea mollitia. Corrupti facere recusandae adipisci reiciendis itaque voluptates placeat, aliquid inventore, cupiditate iure laborum sunt officiis exercitationem assumenda sapiente!
          </div>
          <div class="qna-card-content">
            <img src="/resources/img/qnaIcon/anna.png" alt="����������">
            <div class="qna-comment">
              Lorem ipsum, dolor sit amet consectetur adipisicing elit. Quaerat eum explicabo incidunt rerum praesentium laudantium illum officiis et iure error asperiores corporis, unde, culpa obcaecati eaque, nihil ducimus veritatis itaque.
            </div>
          </div>
          <div class="qna-user-info">
            <div class="user-name">��**&nbsp;</div>
            <div class="user-personal-info">20�� / ��</div>
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
          <div class="close-text">���� �ٽ� ������</div>
          <button class="counsel-btn">��� ��û �ϱ�</button>
        </div>
	</div>
  </div>
</body>
</html>


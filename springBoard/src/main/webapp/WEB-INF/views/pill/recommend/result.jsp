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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/recommend/result.css"/>">
<title>Recommend Result</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		
		$j(".heart-btn").on("click", function() {
			if($j(this).attr("style") == "color: #bbb;") {
				$j(this).attr("style", "color: #ff8787;");
				return;
			}
			$j(this).attr("style", "color: #bbb;");
		});
	});
	
	
</script>
<body>
	<div class="wrap">
		<%@include file="/WEB-INF/views/pill/fix/header.jsp" %>

		<div class="container">
			<h2 class="rec-title">
				<div id="userId">xxx</div>�Բ� �� �´� ������ <br/>
				�˷��帱�Կ�
			</h2>
			<div class="rec-box">
				<div class="rec-box-title">
					<img src="<c:url value='/resources/img/functionIcon/sleep.png'/>" alt="">
					<a href="/pill/product?type=sleep">
						<h3 class="title-text">���� ��� ����</h3>
						<i class=" fas fa-solid fa-chevron-right fa-lg" style="color: #233;"></i>
					</a>
					<div class="recommend-type">�ǰ� ����</div>
				</div>
				<div class="rec-box-comment">
					Lorem ipsum dolor, sit amet consectetur adipisicing elit. In iusto ex quidem aliquam. Minima pariatur qui quasi laudantium omnis, aliquam consequuntur ipsum officiis tempora, impedit, temporibus eligendi quia nihil error.
				</div>
				<div class="rec-box-products">
					<div class="product-item">
						<div class="product-img">
							<img src="<c:url value='/resources/img/nutriImg/thorneSAT.jpg'/>" alt="�� ������" class="nutri-img">
							<i class="heart-btn fas fa-solid fa-heart fa-lg" style="color: #bbb;"></i>
						</div>
            <div class="product-name">SAT</div>
            <div class="product-company">�𸮼�ġ</div>
					</div>
					<div class="product-item">
						<div class="product-img">
							<img src="<c:url value='/resources/img/nutriImg/omega3fishoil.jpg'/>" alt="�� ������" class="nutri-img">
							<i class="heart-btn fas fa-solid fa-heart fa-lg" style="color: #bbb;"></i>
						</div>
            <div class="product-name">Ʈ���� ��Ʈ���� ���ް�3 �ǽ�����</div>
            <div class="product-company">����������ġ</div>
					</div>
					<div class="product-item">
						<div class="product-img">
							<img src="<c:url value='/resources/img/nutriImg/thorneCMM.jpg'/>" alt="�� ������" class="nutri-img">
							<i class="heart-btn fas fa-solid fa-heart fa-lg" style="color: #bbb;"></i>
						</div>
            <div class="product-name">Į�� ���׳׽� ������Ʈ</div>
            <div class="product-company">�𸮼�ġ</div>
					</div>
				</div>
			</div>
    </div>
  </div>
</body>
</html>


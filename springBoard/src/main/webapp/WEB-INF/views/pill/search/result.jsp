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
          <input class="form-control" type="text" placeholder="���� �̸��� �Է����ּ���" value="��Ÿ��">
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
						<img class="item-img" src="/resources/img/nutriImg/twoperdayvitamin.jpg" alt="��ǰ�̹���">
						<div class="item-info">
							<div class="item-company">�������ͽ��ټ�</div>
							<div class="item-name">���۵��� ��Ƽ��Ÿ��</div>
						</div>
					</div>
					<div class="search-item">
						<img class="item-img" src="/resources/img/nutriImg/jongvitamin.jpg" alt="��ǰ�̹���">
						<div class="item-info">
							<div class="item-company">���ٴ�</div>
							<div class="item-name">Ȱ�º�Ÿ��B �÷���</div>
						</div>
					</div>
					<div class="search-item">
						<img class="item-img" src="/resources/img/nutriImg/gorueVitaminC1000.jpg" alt="��ǰ�̹���">
						<div class="item-info">
							<div class="item-company">�������</div>
							<div class="item-name">��Ÿ��C 1000 ���� + ��Ÿ��D</div>
						</div>
					</div>
					<div class="search-item">
						<img class="item-img" src="/resources/img/nutriImg/gorueVitamin.jpg" alt="��ǰ�̹���">
						<div class="item-info">
							<div class="item-company">�������</div>
							<div class="item-name">��Ÿ��C 1000</div>
						</div>
					</div>
					<div class="search-item">
						<img class="item-img" src="/resources/img/nutriImg/aliveMultiVitamin.jpg" alt="��ǰ�̹���">
						<div class="item-info">
							<div class="item-company">����ó������</div>
							<div class="item-name">����̺� �������ϸ� ��Ƽ��Ÿ��</div>
						</div>
					</div>
					<div class="search-item">
						<img class="item-img" src="/resources/img/nutriImg/gorueMultiVitamin.jpg" alt="��ǰ�̹���">
						<div class="item-info">
							<div class="item-company">�������</div>
							<div class="item-name">��Ƽ��Ÿ�� ���ο�</div>
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


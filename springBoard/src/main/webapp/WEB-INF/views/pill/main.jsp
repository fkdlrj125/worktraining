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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/main.css"/>">
<title>Main</title>
</head>
<script type="text/javascript">

</script>
<body>
	<div class="wrap">
		<nav class="navbar navbar-expand-lg">
		  <div class="container-fluid">
		    <a class="navbar-brand" href="#"></a>
		     <form class="d-flex search-bar">
		        <input class="form-control me-sm-2" type="search" placeholder="� ������ ã������?">
		        <button class="search-btn fas fa-regular fa-magnifying-glass fa-lg" style="color: #6c2ef1;"></button>
		      </form>
		    <div class="collapse navbar-collapse" id="navbarColor04">
		      <ul class="navbar-nav me-auto">
		        <li class="nav-item">
		          <a class="nav-link" href="#">
		          	<i class="fa-solid fa-bell" style="color: #ffffff;"></i>
		          </a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="#">
		          	<i class="fa-solid fa-user" style="color: #ffffff;"></i>
		          </a>
		        </li>
		      </ul>
		    </div>
		  </div>
		</nav>
		<div class="container">

      <div class="menu-box">
        <a href="/pill/analysis" class="card">
          <p class="card-header">�� ������ ������?</p>
          <div class="card-body">
            <h2 class="card-title">AI �м�</h2>
          </div>
          <img src="/resources/img/menuIcon/analysis.png" alt="AI�м�">
        </a>
        
        <a href="/pill/recommend" class="card">
          <p class="card-header">�� �´� ������</p>
          <div class="card-body">
            <h2 class="card-title">���� ��õ</h2>
          </div>
          <img src="/resources/img/menuIcon/recommend.png" alt="������õ">
        </a>

        <a href="/pill/ranking" class="card">
          <p class="card-header">������ ����</p>
          <div class="card-body">
            <h2 class="card-title">������ ��ŷ</h2>
          </div>
          <img src="/resources/img/menuIcon/ranking.png" alt="��ŷ">
        </a>

        <a href="/pill/qna" class="card">
          <p class="card-header">���԰� 1:1���</p>
          <div class="card-body">
            <h2 class="card-title">�ǰ� Q&A</h2>
          </div>
          <img src="/resources/img/menuIcon/qa.png" alt="Q&A">
        </a>
      </div>

      <div class="search-nutri">
        <a href="pill/search" class="search-header">
          <h2 class="search-title">�������� ������ �˻�</h2>
          <i class="fa-solid fa-chevron-right fa-lg" style="color: #c8c8c8;"></i>
        </a>
        <div class="search-nutribar">
          <form class="search-bar">
		        <input class="form-control" type="search" placeholder="Į��, ��Ÿ��D ����ִ� ������">
		        <button class="search-btn fas fa-regular fa-magnifying-glass fa-lg" style="color: #6c2ef1;"></button>
		      </form>
        </div>
      </div>
	  </div>
  </div>
</body>
</html>


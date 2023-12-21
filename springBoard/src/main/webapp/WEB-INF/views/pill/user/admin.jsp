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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/user/admin.css"/>">
<title>Admin</title>
</head>
<script type="text/javascript">
	var tableNormal = `
	<tr class="table-normal">
        <th scope="row"></th>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
      </tr> 
     `;
	var tableActive = `
	<tr class="table-active">
        <th scope="row"></th>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
      </tr>`;

	var addRow = function() {
		if($j("tbody").children(":last").attr("class") == "table-active") {
			$j("tbody").append(tableNormal);
			return;
		}
		$j("tbody").append(tableActive);
	}

	$j(document).ready(function() {
		let nowDate = new Date();
		let rangeDate = new Date(nowDate);
		rangeDate.setMonth(nowDate.getMonth() - 1);
		
		$j("input[type=date]:eq(0)").val(rangeDate.toISOString().substring(0, 10));
		$j("input[type=date]:eq(1)").val(nowDate.toISOString().substring(0, 10));
		
		$j(".nav-item").on("click", function(e) {
			$j("button.active").removeClass("active").addClass("disabled");
			$j(this).find("button").removeClass("disabled").addClass("active");
		});
		
		$j(".start-btn").on("click", function() {
			$j(".current-page").text(1);
		});
		
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
		
		$j(".end-btn").on("click", function() {
			$j(".current-page").text(10);
		});
		
		$j("#submitBtn").on("click", function() {
			$j("tbody").find("input:checked").closest("tr").remove();
			addRow();
			
		});
		
		$j("#deleteBtn").on("click", function() {
			$j("tbody").find("input:checked").closest("tr").remove();
			addRow();
		});
	});
</script>
<body>
	<div class="wrap">
		<%@include file="/WEB-INF/views/pill/fix/header.jsp" %>

		<div class="container">
      <div class="admin-box">
        <div class="admin-header">
          <ul class="nav nav-tabs" role="tablist">
            <li class="nav-item" role="presentation">
              <button class="nav-link active" data-bs-toggle="tab" aria-selected="true" role="tab">ȸ��</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link disabled" aria-selected="false" tabindex="-1" role="tab">��û ȸ��</button>
            </li>
          </ul>
          <div class="nav-btns">
	            <button id="submitBtn" type="button">����</button>
	            <button id="deleteBtn" type="button">����</button>
         	 </div>
        </div>
        <div id="myTabContent" class="tab-content">
        <div class="date-box">
        	<input type="date">
        	~
        	<input type="date">
        	<button type="submit" class="search-btn fas fa-regular fa-magnifying-glass " style="color: #6c2ef1;"></button>        </div>
        <table class="table table-hover">
          <thead>
            <tr class="table-primary">
              <th scope="col">
                <input type="checkbox" name="" id="">
              </th>
              <th scope="col">���̵�</th>
              <th scope="col">�̸�</th>
              <th scope="col">�̸���</th>
              <th scope="col">��ȭ��ȣ</th>
              <th scope="col">�����</th>
            </tr>
          </thead>
          <tbody>
            <tr class="table-active">
              <th scope="row">
                <input type="checkbox" name="" id="">
              </th>
              <td>ldh123</td>
              <td>�̵���</td>
              <td>doobar2@gmail.com</td>
              <td>010XXXXXXXX</td>
              <td>2018.05.10</td>
            </tr>
            <tr class="table-normal">
              <th scope="row">
                <input type="checkbox" name="" id="">
              </th>
              <td>Kby123</td>
              <td>�躸��</td>
              <td>kby123@gmail.com</td>
              <td>010XXXXXXXX</td>
              <td>2018.09.10</td>
            </tr>
            <tr class="table-active">
              <th scope="row"></th>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
            </tr>
            <tr class="table-normal">
              <th scope="row"></th>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
            </tr> 
            <tr class="table-active">
              <th scope="row"></th>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="pagination">
      	<button class="start-btn">
      		<i class="fa-solid fa-angles-left fa-lg" style="color: #aaa;"></i>
      	</button>
        <button class="pre-btn">
          <i class="fa-solid fa-chevron-left fa-lg" style="color: #aaa;"></i>
        </button>
        <div class="current-page">1</div>
        <button class="next-btn">
          <i class="fa-solid fa-chevron-right fa-lg" style="color: #aaa;"></i>
        </button>
        <button class="end-btn">
      		<i class="fa-solid fa-angles-right fa-lg" style="color: #aaa;"></i>
      	</button>
      </div>
    </div>
   </div>
  </div>
</body>
</html>


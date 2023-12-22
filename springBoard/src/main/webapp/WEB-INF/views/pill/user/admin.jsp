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

	var addRow = function(cnt) {
		console.log(cnt);
		for(let i = 0; i < cnt; i++) {
			$j("tbody").children(":last").attr("class") == "table-active" ? 
					$j("tbody").append(tableNormal) : $j("tbody").append(tableActive);
		}
	}

	$j(document).ready(function() {
		let nowDate = new Date();
		let rangeDate = new Date(nowDate);
		let endPage = 10;
		rangeDate.setMonth(nowDate.getMonth() - 1);
		
		$j("input[type=date]:eq(0)").val(rangeDate.toISOString().substring(0, 10));
		$j("input[type=date]:eq(1)").val(nowDate.toISOString().substring(0, 10));
		
		// 탭 조작
		$j(".nav-item").on("click", function(e) {
			$j("button.active").removeClass("active").addClass("disabled");
			$j(this).find("button").removeClass("disabled").addClass("active");
		});
		
		// 페이징
		$j(".start-btn").on("click", function() {
			$j(".current-page").text(1);
		});
		
		$j(".pre-btn").on("click", function() {
			if(parseInt($j(".current-page").text())-1 == 0) {
				alert("첫 번째 페이지입니다.");
				return;
			}
			
			$j(".current-page").text(parseInt($j(".current-page").text())-1);
		});
		
		$j(".next-btn").on("click", function() {
			if(parseInt($j(".current-page").text())+1 > endPage) {
				alert("마지막 페이지입니다.");
				return;
			}
			
			$j(".current-page").text(parseInt($j(".current-page").text())+1);
		});
		
		$j(".end-btn").on("click", function() {
			$j(".current-page").text(endPage);
		});
		
		// 행 조작
		$j("#checkAll").on("click", function() {
			$j("#checkAll").is(":checked") ? 
					$j("input:not(#checkAll):checkbox").prop("checked", true)
					: $j("input:not(#checkAll):checkbox").prop("checked", false);
		});
		
		$j("input:not(#checkAll):checkbox").on("click", function() {
			if($j("#checkAll").is(":checked")) 
				$j("#checkAll").prop("checked", false);
		});
		
		$j("#submitBtn").on("click", function() {
			let submitCnt = $j("tbody").find("input:checked").length;
			$j("tbody").find("input:checked").closest("tr").remove();
			addRow(submitCnt);
			
		});
		
		$j("#deleteBtn").on("click", function() {
			let deleteCnt = $j("tbody").find("input:checked").length;
			$j("tbody").find("input:checked").closest("tr").remove();
			addRow(deleteCnt);
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
              <button class="nav-link active" data-bs-toggle="tab" aria-selected="true" role="tab">회원</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link disabled" aria-selected="false" tabindex="-1" role="tab">신청 회원</button>
            </li>
          </ul>
          <div class="nav-btns">
	            <button id="submitBtn" type="button">승인</button>
	            <button id="deleteBtn" type="button">삭제</button>
         	 </div>
        </div>
        <div id="myTabContent" class="tab-content">
        <form class="date-form date-box" action="/pill/admin">
        	<input type="date" name="sd">
        	~
        	<input type="date" name="ed">
        	<button type="submit" class="search-btn fas fa-regular fa-magnifying-glass " style="color: #6c2ef1;"></button>
        </form>
        <table class="table table-hover">
          <thead>
            <tr class="table-primary">
              <th scope="col">
                <input type="checkbox" name="" id="checkAll">
              </th>
              <th scope="col">아이디</th>
              <th scope="col">이름</th>
              <th scope="col">이메일</th>
              <th scope="col">전화번호</th>
              <th scope="col">등록일</th>
            </tr>
          </thead>
          <tbody>
            <tr class="table-active">
              <th scope="row">
                <input type="checkbox" name="" id="">
              </th>
              <td>ldh123</td>
              <td>이두현</td>
              <td>doobar2@gmail.com</td>
              <td>010XXXXXXXX</td>
              <td>2018.05.10</td>
            </tr>
            <tr class="table-normal">
              <th scope="row">
                <input type="checkbox" name="" id="">
              </th>
              <td>Kby123</td>
              <td>김보영</td>
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


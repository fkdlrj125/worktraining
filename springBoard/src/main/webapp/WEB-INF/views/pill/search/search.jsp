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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/search/search.css"/>">
<title>Search</title>
</head>
<script type="text/javascript">
		$j(document).ready(function() {
		var selectCnt = 0;
		let itemName = "";
		let itemId = "";
		let html = `<div class="item">
	          <div class="item-name"></div>
	          <i class="fa-solid fa-x" style="color: #ffffff;"></i>
	        </div>`;
	    
		
		$j(".ingredient-item").on("click", function() {
			itemName = $j(this).text().trim();
			itemId = $j(this).attr("id");
			
			// 해제할 때
			if($j(this).find("i").attr("style") == "color: #56e166;") {
				$j(this).find("i").attr("style", "color: #c8c8c8;");
				$j(`.\${itemId}`).remove();
				selectCnt--;
				if(selectCnt == 0) {
					$j(".fixed-search-btn").css("display", "none");
					$j(".fixed-search-btn").css("pointer-events", "none");
					$j(".selected-ingredient").addClass("remove");
				}				
				return;
			}

			// 선택할 때
			selectCnt++;
			$j(".selected-ingredient").append(html);
			$j(".selected-ingredient").removeClass("remove");
			$j(".item").last().addClass(itemId);
			$j(".item").last().find(".item-name").text(itemName);
			$j(this).find("i").attr("style", "color: #56e166;");
			$j(".fixed-search-btn").css("display", "block");
			$j(".fixed-search-btn").css("pointer-events", "all");
		});
		
		// selected-ingredient에서 클릭할 때
		$j(document).on("click", ".item",function() {
			let className = $j(this).attr("class").split(" ")[1];
			$j(this).remove();
			$j(`#\${className}`).find("i").attr("style", "color: #c8c8c8;");
			selectCnt--;
			
			// 선택된 게 없을 때
			if(selectCnt === 0) {
				$j(".fixed-search-btn").css("display", "none");
				$j(".fixed-search-btn").css("pointer-events", "none");
				$j(".selected-ingredient").addClass("remove");
			}
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
        <form class="d-flex search-bar" action="/pill/search/result" accept-charset="UTF-8">
          <input name="search" class="form-control" type="text" placeholder="성분 이름을 입력해주세요">
          <a href="/pill" class="back-btn fa-solid fa-chevron-left fa-lg" style="color: #2a2a2a;"></a>
          <button type="button" class="x-btn fa-solid fa-lg" style="color: #ccc;"></button>
          <button type="submit" class="search-btn fas fa-regular fa-magnifying-glass fa-lg" style="color: #6c2ef1;"></button>
        </form>
		  </div>
		</nav>

    <div class="selected-ingredient-box">
      <div class="selected-ingredient remove">
      </div>
    </div>
    
		<div class="container">
      <div class="search-by-ingredient">
        <div class="search-ingredient-title">
          인기 성분이에요
        </div>
        <div class="ingredient-list">
          <div id="omega3" class="ingredient-item">
            <i class="ingredient-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="ingredient-name">오메가3</div>
          </div>
          <div id="probiotics" class="ingredient-item">
            <i class="ingredient-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="ingredient-name">프로바이오틱스(유산균)</div>
          </div>
          <div id="vitaminC" class="ingredient-item">
            <i class="ingredient-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="ingredient-name">비타민C</div>
          </div>
          <div id="coenzymeQ10" class="ingredient-item">
            <i class="ingredient-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="ingredient-name">코엔자임Q10</div>
          </div>
          <div id="vitaminB1" class="ingredient-item">
            <i class="ingredient-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="ingredient-name">비타민B1</div>
          </div>
          <div id="garcinia" class="ingredient-item">
            <i class="ingredient-check fa-solid fa-circle-check fa-lg" style="color: #c8c8c8;"></i>
            <div class="ingredient-name">가르시니아캄보지아</div>
          </div>
          
        </div>
      </div>

      <button type="button" class="fixed-search-btn" onclick="location.href='/pill/search/result'">검색</button>
    </div>
  </div>
</body>
</html>


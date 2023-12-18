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
<link rel="stylesheet" href="<c:url value="/resources/css/pill/recommend/select.css"/>">
<title>Recommend</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		var selectCnt = 0;
		
		$j(".list-item").on("click", function() {
			if($j(this).find("img").css("background-color") == "rgb(254, 254, 254)") {
				$j(this).find("img").css("background-color", "#e0e0ff");
				selectCnt++;
				$j(".submit-btn").css("background-color", "#6c2ef1");
				$j(".submit-btn").css("pointer-events", "auto");
				$j("#selectCnt").text(`\${selectCnt}/8`);
				return;
			}
			$j(this).find("img").css("background-color", "#fefefe");
			selectCnt--;
			if(selectCnt == 0) {
				$j(".submit-btn").css("background-color", "#e0e0ff");
				$j(".submit-btn").css("pointer-events", "none");
			}
			
			$j("#selectCnt").text(`\${selectCnt}/8`);
		});
	});
	
	
</script>
<body>
	<div class="wrap">
		<%@include file="/WEB-INF/views/pill/fix/header.jsp" %>

		<div class="container">
      <div class="health-box">
        <div class="health-header">
          <div class="header-title">
            고민되시거나 개선하고 싶은 건강 고민을 선택해주세요
          </div>
          <div class="header-comment">
            최대 8개 선택
          </div>
        </div>
        <div class="health-list">
          <div class="list-item">
            <img src="/resources/img/functionIcon/fatigue.png" alt="피로감" class="item-img">
            <div class="item-title">피로감</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/eyes.png" alt="눈 건강" class="item-img">
            <div class="item-title">눈 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/skincare.png" alt="피부 건강" class="item-img">
            <div class="item-title">피부 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/fat.png" alt="체지방" class="item-img">
            <div class="item-title">체지방</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/blood_circulation.png" alt="혈관 & 혈액순환" class="item-img">
            <div class="item-title">혈관 & 혈액순환</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/liver.png" alt="간 건강" class="item-img">
            <div class="item-title">간 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/intestine.png" alt="장 건강" class="item-img">
            <div class="item-title">장 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/sleep.png" alt="스트레스 & 수면" class="item-img">
            <div class="item-title">스트레스 & 수면</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/immunity.png" alt="면역 기능" class="item-img">
            <div class="item-title">면역 기능</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/cholesterol.png" alt="혈중 콜레스테롤" class="item-img">
            <div class="item-title">혈중 콜레스테롤</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/bones2.png" alt="뼈 건강" class="item-img">
            <div class="item-title">뼈 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/anti-aging.png" alt="노화 & 항산화" class="item-img">
            <div class="item-title">노화 & 항산화</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/women.png" alt="여성 건강" class="item-img">
            <div class="item-title">여성 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/stomach.png" alt="소화 & 위식도 건강" class="item-img">
            <div class="item-title">소화 & 위식도 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/men.png" alt="남성 건강" class="item-img">
            <div class="item-title">남성 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/blood_pressure.png" alt="혈압" class="item-img">
            <div class="item-title">혈압</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/strength.png" alt="운동 능력 & 근육량" class="item-img">
            <div class="item-title">운동 능력 & 근육량</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/brain.png" alt="두뇌활동" class="item-img">
            <div class="item-title">두뇌활동</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/blood_sugar.png" alt="혈당" class="item-img">
            <div class="item-title">혈당</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/cholesterol.png" alt="혈중 중성지방" class="item-img">
            <div class="item-title">혈중 중성지방</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/tooth.png" alt="치아 & 잇몸" class="item-img">
            <div class="item-title">치아 & 잇몸</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/pregnant.png" alt="임산부 & 태아 건강" class="item-img">
            <div class="item-title">임산부 & 태아 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/hair_loss.png" alt="탈모 & 손톱 건강" class="item-img">
            <div class="item-title">탈모 & 손톱 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/joint.png" alt="관절 건강" class="item-img">
            <div class="item-title">관절 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/menopause.png" alt="여성 갱년기" class="item-img">
            <div class="item-title">여성 갱년기</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/breath.png" alt="호흡기 건강" class="item-img">
            <div class="item-title">호흡기 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/thyroid.png" alt="갑상선 건강" class="item-img">
            <div class="item-title">갑상선 건강</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/anemia.png" alt="빈혈" class="item-img">
            <div class="item-title">빈혈</div>
          </div>
        </div>
        <div class="submit-btn-box">
          <button class="submit-btn" onclick="location.href='/pill/recommend/result'">확인<div id="selectCnt">0/8</div></button>
        </div>
      </div>
    </div>
  </div>
</body>
</html>


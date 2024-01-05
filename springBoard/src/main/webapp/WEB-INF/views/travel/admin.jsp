<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="<c:url value="/resources/css/travel/travel.css"/>">
<title>Travel Admin</title>
</head>
<!-- 
    [페이지]
    - 고객리스트 테이블
    - 일별 버튼 들어올 공간
    - 추가 삭제 버튼 들어올 공간
    - 일정 리스트 테이블
    - 저장버튼

	[JS]
	- [고객리스트]
	  - 고객리스트에서 고객명 클릭 시 ajax로 일정 리스트 요청
	- 선택한 고객의 여행 기간에 따라 일별 버튼 생성
	  - 여행 기간만큼 반복해서 버튼 생성
	  - 버튼 클릭 시 기존 입력 정보는 세션스토리지에 저장
	- 추가 및 삭제 버튼으로 일정 리스트 추가 및 삭제
	  - 삭제를 버튼 누르자마자 요청할지 백단에서 할지 타이밍을 생각해 보기
	
	- [일정리스트]
	  시간, 지역(시/도, 시군구), 장소, 이동수단, 이동시간, 이용요금, 계획상세 입력
	  교통비는 교통편 및 예상이동시간에 따라 계산하여 출력
	  - 스케쥴이 겹치는 시간은 선택 불가(이건 찾아봐야함)
	    시간은 오전 7시 ~ 다음날 오전 4시까지 등록 가능
	  - 이동수단
	    - 도보(W)
	    - 버스(B)
	      - 1400원
	      - 20분 초과시 200원씩 할증
	    - 지하철(S)
	      - 1450원
	      - 20분 초과시 200원씩 할증
	    - 택시(T)
	      - 시간대 별로 할증 계산
	        22시~24시 20프로
	        24시~04시 40프로
	      - 기본요금 3800원(10분)
	        - 이동거리 10분당 5000원
	    - 렌트(R)
	      - 10분당 500원 연료비
	      - 1~2일 10만원 렌트기간에 따라 일 1만원 할인(최저 7만원)
	        (3~4일 9만원, 5~6일 8만원)
	    - 자차(C)
	- 일정 리스트 작성 후 저장버튼 클릭 시 이용요금 및 교통비 합산하여 고객 리스트 견적경비에 출력
	  예상 경비 초과 시 견적경비는 붉은색으로 변경
  	- 입력한 일정들은 POST요청 
 -->
<script type="text/javascript">
</script>
<body>
	<div class="container">
		<table border="1" class="userTable">
			<thead>
				<tr>
					<th>
						<div class="userListTableHead">고객명</div>
					</th>
					<th>
						<div class="userListTableHead">휴대폰번호</div>
					</th>
					<th>
						<div class="userListTableHead">여행지</div>
					</th>
					<th>
						<div class="userListTableHead">여행 기간</div>
					</th>
					<th>
						<div class="userListTableHead">이동수단</div>
					</th>
					<th>
						<div class="userListTableHead">예상 경비</div>
					</th>
					<th>
						<div class="userListTableHead">견적 경비</div>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<div class="userListTableContent" data-seq=""></div>
					</td>
					<td>
						<div class="userListTableContent"></div>
					</td>
					<td>
						<div class="userListTableContent"></div>
					</td>
					<td>
						<div class="userListTableContent"></div>
					</td>
					<td>
						<div class="userListTableContent"></div>
					</td>
					<td>
						<div class="userListTableContent"></div>
					</td>
					<td>
						<div class="userListTableContent"></div>
					</td>
				</tr>
			</tbody>
		</table>
		<form action="">
			<div id="dayBtnBox">
				<button type="button" class="dayBtn">1</button>
			</div>
			<div id="tableBtn">
				<button type="button">추가</button>
				|
				<button type="button">삭제</button>
			</div>
			<table border="1" class="travelTable">
				<thead>
					<tr>
						<td>
						</td>
						<td>
							<label for="travelTime">시간</label>
						</td>
						<td>
							<label for="travelCity">지역</label>
							<label for="travelCounty" class="hidden"></label>
						</td>
						<td>
							<label for="travelLoc">장소명</label>
						</td>
						<td>
							<label for="travelTrans">교통편</label>
						</td>
						<td>
							<label for="useTime">예상이동시간</label>
						</td>
						<td>
							<label for="useExpend">이용요금(예상지출비용)</label>
						</td>
						<td>
							<label for="travelDetail">계획상세</label>
						</td>
						<td>
							<label for="transExpend">교통비</label>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<input id="travelSeq" type="checkbox">
						</td>
						<td>
							<input id="travelTime" type="time" value="">
						</td>
						<td>
							<select id="travelCity">
								
							</select>
							<select id="travelCounty">

							</select>
						</td>
						<td>
							<input id="travelLoc" type="text" value=""
							oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\w\d]/, '')">
						</td>
						<td>
							<select id="travelTrans">

							</select>
						</td>
						<td>
							<input id="useTime" type="text" value=""
							oninput="this.value = this.value.replace()">
						</td>
						<td>
							<input id="useExpend" type="text" value=""
							oninput="this.value = this.value.replace()">
						</td>
						<td>
							<input id="travelDetail" type="text" value=""
							oninput="this.value = this.value.replace()">
						</td>
						<td>
							<input id="transExpend" type="text" value=""
							oninput="this.value = this.value.replace()">
						</td>
					</tr>
				</tbody>
			</table>
			<button type="button" id="submit">저장</button>
		</form>
	</div>
</body>
</html>
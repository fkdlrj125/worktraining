<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="<c:url value="/resources/css/travel/travel.css"/>">
<title>Travel Book</title>
</head>
<!--
	[페이지] 
	- 유저 입력 폼
	- 일별 버튼 들어올 공간(JSTL을 이용해 값이 있으면 생성)
    - 수정요청버튼 들어올 공간(JSTL을 이용해 값이 있으면 생성)
	- 일정 리스트 테이블(JSTL을 이용해 값이 있으면 생성)
	
	[JS]
	- 로그인 한 고객 정보 자동 출력(이름, 휴대폰번호)
	  - 이름과 휴대폰번호는 변경 불가능하게 readonly설정
	  - 신청버튼 로그아웃으로 변경
	  
	- 여행 기간, 이동수단, 여행경비, 여행지 선택 및 입력 후 신청버튼 클릭
	  - 여행기간 : 1~30
	    - 숫자로 입력제한
	    - 입력값이 1~30 사이인지 유효성 검사
	  - 이동수단 : 렌트(R), 대중교통(B), 자차(C)
	  - 여행경비
	    - 숫자와 ","로 입력제한
	    - "," 자동 입력
	  - 여행지 : 전국 시/도
	  	- api로 받기
 -->
<script type="text/javascript">
</script>
<body>
	<div class="container">
		<form action="">
			<table border="1">
				<tr>
					<th>
						<div>고객명</div>
					</th>
					<td>
						<div id="userName"></div>
					</td>
				</tr>
				<tr>
					<th>
						<div>휴대폰번호</div>
					</th>
					<td>
						<div id="userPhone"></div>
					</td>
				</tr>
				<tr>
					<th>
						<label for="period">여행 기간</label>
					</th>
					<td>
						<input id="period" type="text" name="period" value=""
						oninput="this.value = this.value.replace(/[^\D]/, '')">
					</td>
				</tr>
				<tr>
					<th>
						<label for="tansport">이동 수단</label>
					</th>
					<td>
						<select id="tansport" name="tansport">
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<label for="expend">예상 경비</label>
					</th>
					<td>
						<input id="expend" type="text" name="expend" value=""
						oninput="this.value = this.value.replace(/[^\D\,]/, '')">
					</td>
				</tr>
				<tr>
					<th>
						<label for="travelCity">여행지</label>
					</th>
					<td>
						<select id="travelCity" name="travelCity">
						</select>
					</td>
				</tr>
			</table>

			<button type="button" id="submit">신청</button>
		</form>

		<form>
			<div id="dayBtnBox">
				<button type="button" class="dayBtn">1</button>
			</div>
			<div id="adjustBtn">
				<button type="button">수정요청</button>
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
		</form>
	</div>
</body>
</html>
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
	$j.fn.serializeObject = function(day) {
		let result = [];
		let obj = null;
		
		let pushObj = function(obj) {
			obj["travelDay"] = `\${day}`;
			result.push(Object.assign({}, obj));
			return {};
		}
		
		try {
			let arr = this.serializeArray();

			if(arr.length > 0) {
				let obj = {};
				
				$j.each(arr, function() {
					obj.hasOwnProperty(this.name) ? obj = pushObj(obj) : "";
					obj[this.name] = this.value;
				});
				pushObj(obj);
			} 
		} catch (e) {
			alert(e.message);
		}
		
		return result;
	}
	
	$j(document).ready(function() {
		var rowNum = $j("table:eq(1) tbody tr").length;
		
		// 추가 버튼
		$j("#addBtn").on("click", function() {
			let copyRow = $j("table:eq(1) tbody tr:eq(0)").clone();

			$j.each($j(copyRow).find("input, select"), function() {
				if($j(this).prop("tagName") == "INPUT") {
					$j(this).val("");
				}

				if($j(this).prop("tagName") == "SELECT") {
					$j(this).find("option:eq(0)").attr("selected", "selected");
				}
				
				if($j(this).data("seq")) 
					$j(this).removeAttr("data-seq");
				
				$j(this).attr("id", $j(this).attr("id").replace(/\d/g, "") + rowNum);
			});
			
			$j("table:eq(1) tbody").append(copyRow);
			rowNum++;
		});
		
		// 삭제 버튼
		$j("#subBtn").on("click", function(){
			let checkedBoxInData = $j("input[data-seq]:checked");
			let checkedBox = $j("input:not([data-seq]):checked");
			
			if(checkedBoxInData.length + checkedBox.length == $j("input:checkBox").length) {
				alert("최소 한 개 이상의 행을 남겨주세요.");
				$j("input:checkBox").prop("checked",false);
				return;
			}
			
			$j.each(checkedBox, function() {
				$j(this).closest("tr").remove();
			});
			
			if(checkedBoxInData.length == 0) return;
			
			let obj = null;
			let data = [];
			
			$j.each(checkedBoxInData, function() {
				obj = {};
				obj[$j(this).attr("id").replace(/\d/, "")] = $j(this).data("seq");
				result.put(Object.assign({}, obj));
			});
			
			console.log(data);
		});
		
		$j(".dayBtn").on("click", function() {
			let userSeq = $j("[data-seq]").data("seq");
			let day = $j(this).text();
			
			// ajax로 요청하면 됨
			console.log(userSeq);
			console.log(day);
		});
		
		$j("#submit").on("click", function() {
			let data = $j("table:eq(1) tbody input, table:eq(1) tbody select");
			let day = $j("[data-day]").data("day");
			
			let sendData = {
				clientVo : {
					userSeq : $j("[data-seq]").data("seq")
				},
				travelList : data.serializeObject(day)
			}
			
			$j.ajax({
				url : "/travel/admin",
				type : "POST",
				data : JSON.stringify(sendData),
				dataType : "json",
				contentType : "application/json",
				success : function(res) {
					console.log(res);
				},
				error : function(thrownError) {
					alert(thrownError);
				}
			});
		});
	});
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
				<c:forEach items="${userList}" var="user">
					<tr>
						<td>
							<div id="travelInfo" class="userListTableContent" onclick="location.href='/travel/admin?userSeq=${user.userSeq}'">${user.userName}</div>
						</td>
						<td>
							<div class="userListTableContent">${user.userPhone}</div>
						</td>
						<td>
							<div class="userListTableContent">${user.travelCity}</div>
						</td>
						<td>
							<div class="userListTableContent">${user.period}</div>
						</td>
						<td>
							<div class="userListTableContent">
								<c:if test="${user.transport eq'R'}">렌트</c:if>
								<c:if test="${user.transport eq 'B'}">대중교통</c:if>
								<c:if test="${user.transport eq 'C'} ">자차</c:if>
							</div>
						</td>
						<td>
							<div class="userListTableContent">${user.expend}</div>
						</td>
						<td>
							<div id="travelPeriod" class="userListTableContent"></div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<c:if test="${travelList ne null}">
			<form>
				<div id="dayBtnBox" data-period="${selectUser.period}">
					<c:forEach begin="1" end="${selectUser.period}" var="idx" varStatus="status">
						<c:choose>
							<c:when test="${status.last}">
								<button type="button" class="dayBtn">${idx}</button>
								<c:if test="">data-selected="selected"</c:if>
							</c:when>
							<c:otherwise>
								<button type="button" class="dayBtn">${idx}</button> |
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<div id="tableBtn">
					<button id="addBtn" type="button">추가</button>
					|
					<button id="subBtn" type="button">삭제</button>
				</div>
				<table border="1" class="travelTable" data-seq="${selectUser.userSeq}">
					<thead>
						<tr>
							<th>
							</th>
							<th>
								<label for="travelTime0">시간</label>
							</th>
							<th>
								<label for="travelCity0">지역</label>
								<label for="travelCounty0" class="hidden"></label>
							</th>
							<th>
								<label for="travelLoc0">장소명</label>
							</th>
							<th>
								<label for="travelTrans0">교통편</label>
							</th>
							<th>
								<label for="useTime0">예상이동시간</label>
							</th>
							<th>
								<label for="useExpend0">이용요금(예상지출비용)</label>
							</th>
							<th>
								<label for="travelDetail0">계획상세</label>
							</th>
							<th>
								교통비
							</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${!empty travelList}">
								<c:forEach items="${travelList}" var="item" varStatus="status">
									<tr>
										<td>
											<input type="checkbox">
											<input id="travelSeq${status.index}" class="hidden" name="travelSeq" value="${item.travelSeq}">
										</td>
										<td>
											<input id="travelTime${status.index}" name="travelTime" type="time" value="${item.travelTime}" data-day="${item.travelDay}">
										</td>
										<td>
											<select id="travelCity${status.index}" name="travelCity">
												<c:forEach items="${cityList}" var="city">
													<option value="${city.name}" 
													<c:if test="${city.name eq selectUser.travelCity}">
														selected = 'selected'
													</c:if>>
														${city.name}
													</option>
												</c:forEach>
											</select>
											<select id="travelCounty${status.index}" name="travelCounty">
												<c:forEach items="${countyList}" var="county">
													<option value="${county.name}" 
													<c:if test="${county.name eq item.travelCounty}">
														selected = 'selected'
													</c:if>>
														${county.name}
													</option>
												</c:forEach>
											</select>
										</td>
										<td>
											<input id="travelLoc${status.index}" name="travelLoc" type="text" value="${item.travelLoc}"
											oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\w\d]/, '')">
										</td>
										<td>
											<select id="travelTrans${status.index}" name="travelTrans">
												<option value="R" <c:if test="${selectUser.transport eq 'R'}">selected = 'selected'</c:if>>렌트</option>
												<option value="W" <c:if test="${selectUser.transport eq 'W'}">selected = 'selected'</c:if>>도보</option>
												<option value="S" <c:if test="${selectUser.transport eq 'S'}">selected = 'selected'</c:if>>지하철</option>
												<option value="T" <c:if test="${selectUser.transport eq 'T'}">selected = 'selected'</c:if>>택시</option>
												<option value="B" <c:if test="${selectUser.transport eq 'B'}">selected = 'selected'</c:if>>버스</option>
												<option value="C" <c:if test="${selectUser.transport eq 'C'}">selected = 'selected'</c:if>>자차</option>
											</select>
										</td>
										<td>
											<input id="transTime${status.index}" name="transTime" type="text" value="${item.transTime}"
											oninput="this.value = this.value.replace()">
										</td>
										<td>
											<input id="useExpend${status.index}" name="useExpend" type="text" value="${item.useExpend}"
											oninput="this.value = this.value.replace()">
										</td>
										<td>
											<input id="travelDetail${status.index}" name="travelDetail" type="text" value="${item.travelDetail}"
											oninput="this.value = this.value.replace()">
										</td>
										<td>
											<div></div>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td>
									<input type="checkbox">
								</td>
								<td>
									<input id="travelTime0" name="travelTime" type="time" data-day="${selectDay}">
								</td>
								<td>
									<select id="travelCity0" name="travelCity">
										<c:forEach items="${cityList}" var="city">
											<option value="${city.name}" 
											<c:if test="${city.name eq selectUser.travelCity}">
												selected = 'selected'
											</c:if>>
												${city.name}
											</option>
										</c:forEach>
									</select>
									<select id="travelCounty0" name="travelCounty">
										<c:forEach items="${countyList}" var="county">
											<option value="${county.name}" 
											<c:if test="${county.name eq item.travelCounty}">
												selected = 'selected'
											</c:if>>
												${county.name}
											</option>
										</c:forEach>
									</select>
								</td>
								<td>
									<input id="travelLoc0" name="travelLoc" type="text"
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\w\d]/, '')">
								</td>
								<td>
									<select id="travelTrans0" name="travelTrans">
										<option value="R" <c:if test="${loginUser eq null || loginUser.transport eq 'R'}">selected = 'selected'</c:if>>렌트</option>
										<option value="W" <c:if test="${loginUser.transport eq 'W'}">selected = 'selected'</c:if>>도보</option>
										<option value="S" <c:if test="${loginUser.transport eq 'S'}">selected = 'selected'</c:if>>지하철</option>
										<option value="T" <c:if test="${loginUser.transport eq 'T'}">selected = 'selected'</c:if>>택시</option>
										<option value="B" <c:if test="${loginUser.transport eq 'B'}">selected = 'selected'</c:if>>버스</option>
										<option value="C" <c:if test="${loginUser.transport eq 'C'}">selected = 'selected'</c:if>>자차</option>
									</select>
								</td>
								<td>
									<input id="transTime0" name="transTime" type="text"
									oninput="this.value = this.value.replace()">
								</td>
								<td>
									<input id="useExpend0" name="useExpend" type="text"
									oninput="this.value = this.value.replace()">
								</td>
								<td>
									<input id="travelDetail0" name="travelDetail" type="text"
									oninput="this.value = this.value.replace()">
								</td>
								<td>
									<div></div>
								</td>
							</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<button type="button" id="submit">저장</button>
			</form>
		</c:if>
	</div>
</body>
</html>
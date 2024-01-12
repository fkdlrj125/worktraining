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
    [페이지] x
    - 고객리스트 테이블
    - 일별 버튼 들어올 공간
    - 추가 삭제 버튼 들어올 공간
    - 일정 리스트 테이블
    - 저장버튼

	[JS] 
	- [고객리스트] x
	  - 고객리스트에서 고객명 클릭 시 ajax로 일정 리스트 요청
	- 선택한 고객의 여행 기간에 따라 일별 버튼 생성 x
	  - 여행 기간만큼 반복해서 버튼 생성
	  - 버튼 클릭 시 기존 입력 정보는 세션스토리지에 저장
	- 추가 및 삭제 버튼으로 일정 리스트 추가 및 삭제 x
	  - 삭제를 버튼 누르자마자 요청할지 백단에서 할지 타이밍을 생각해 보기
	
	- [일정리스트]
	  시간, 지역(시/도, 시군구), 장소, 이동수단, 이동시간, 이용요금, 계획상세 입력 x
	  교통비는 교통편 및 예상이동시간에 따라 계산하여 출력 x - 계산 요청보내는 이벤트를 바꿔야 할듯
	  - 스케쥴이 겹치는 시간은 선택 불가(이건 찾아봐야함) 
	    시간은 오전 7시 ~ 다음날 오전 4시까지 등록 가능
	  - 이동수단 x
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
  	- 입력한 일정들은 POST요청 x
  	
  	- 남은 거
  		- 스케쥴 겹치는 시간 선택 불가
  		- 시간 오전 7시 ~ 다음날 오전 4시까지로 제한
  		- 일정 리스트 작성 후 저장버튼 클릭 시 이용요금 및 교통비 합산하여 고객 리스트 견적경비에 출력
  		  예상 경비 초과 시 견적경비는 붉은색으로 변경
  		- 일정 리스트 전달 시 여러 개 처리되나 확인
  		- 날짜 선택
  		- 저장하지 않고 날짜 옮길 시 세션 스토리지에 저장
  		- 저장 버튼 클릭 시 세션 스토리지 확인 후 데이터 있다면 가져와서 같이 전송
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
	
	var validation = function(data) {
		let testObj = {};
		let result = true;
		
		$j.each(data, function() {
			if(!$j(this).val()?.trim()) {
				alert(`\${$j(`label[for='\${$j(this).attr('id').replace(/\d/g, '0')}']`).text()}을 입력해주세요`);
				$j(this).focus();
				result = false;
				return false;
			}
			
			switch($j(this).attr("name")) {
			case "transTime": case "useExpend":
				if(testObj[$j(this).attr("name")] == null)
					testObj[$j(this).attr("name")] = [];
				
				testObj[$j(this).attr("name")].push($j(this).val());
				
				break;
			}
		});
		
		if(!result) return result;
		
		let regex = {
			transTime : /^(([0-5][1-9]|[0-9])\ubd84)$/,
			useExpend : /^[^\,].*[^\,]$/
		}
		
		let alertComment = {
			transTime : "을 xx분 형식으로 입력해주세요.",
			useExpend : "을 xxx,xxx 형식으로 입력해주세요." 
		}
		
		// 장소명, 예상이동시간, 이용금액(앞 뒤에 , 있는지) 검사
		$j.each(Object.keys(testObj), function(index) {
			let id = this;
			$j.each(testObj[id], function() {
				console.log(this);
				console.log(regex[id]);
				console.log(!regex[id].test(this));
				if(!regex[id].test(this)) {
					alert(`\${$j(`label[for="\${id}0"]`).text()}` + alertComment[id]);
					$j(`[id*=\${id}]:eq(\${index})`).focus();
					result = false;
					return false;
				}
			});
			if(!result) return false;
		});
		
		return result;
	}
	
	// 견적 비용 계산
	var calTravelExpend = function() {
		
	}
	
	$j(document).ready(function() {
		var rowNum = $j("table:eq(1) tbody tr").length;
		var rentExpend = 100000 - (10000 * (Math.round(($j("#dayBtnBox").data("period")) / 2) - 1));
		var currentRent = {
			row : 0,
			add : 0
		};
		
		// 이용금액 , 찍기
		$j(document).on("keypress", "input[name='useExpend']",function(e) {
			let insertPosition = ($j(this).val().replaceAll(",", "").length % 3) + 1;
			let cnt = Math.floor($j(this).val().replaceAll(",", "").length / 3);
			
			if(e.keyCode < 48 || e.keyCode > 57)
				insertPosition -= 1;
			
			$j(this).val($j(this).val().replaceAll(",", ""));
			for(let i = 0; i < cnt; i++) {
				$j(this).val($j(this).val().slice(0, insertPosition) + "," + $j(this).val().slice(insertPosition));
				insertPosition += 4;
			}
		});
		
		// 교통비 찍기
		$j(document).on("change", "input[name='transTime']", "select[name='travelTrans']", function() {
			let transport = $j(this).closest("tr").find("[name=travelTrans]").val();
			let travelTime = $j(this).closest("tr").find("[name=travelTime]").val();
			let transTime = $j(this).val().replace(/\D/, "");
			let textPosition = $j(this).closest("tr").find("[id*=transExpend]");
			let row = $j(textPosition).attr("id").replace(/\D/g, "");
		
			if(transport == "R" && row == currentRent.row)
				rentExpend -= currentRent.add;
			
			$j.ajax({
				url : `/travel/calculate?ts=\${transport}&tlt=\${travelTime}&tst=\${transTime}`,
				type : "GET",
				success : function(res) {
					res = JSON.parse(res);

					if(transport == "R") {
						currentRent.row = row;
						currentRent.add = res.expend;
						rentExpend += currentRent.add;
						$j(textPosition).text(rentExpend);
						return;
					}
					console.log(res.expend);
					$j(textPosition).text(res.expend);
				},
				error : function(errorThrown) {
					alert(errorThrown);
				}
			});
		});
		
		// 추가 버튼 - ㅇ
		$j("#addBtn").on("click", function() {
			let copyRow = $j("table:eq(1) tbody tr:eq(0)").clone();

			$j.each($j(copyRow).find("input:not(:checkBox), select, div"), function() {
				switch ($j(this).prop("tagName")) {
				case "INPUT":
					$j(this).val("");
					break;
					
				case "SELECT":
					$j(this).find("option:eq(0)").attr("selected", "selected");
					break;
					
				case "DIV":
					$j(this).text("");
					break;
				}
				
				if($j(this).data("seq")) 
					$j(this).removeAttr("data-seq");
				
				$j(this).attr("id", $j(this).attr("id").replace(/\d/g, rowNum));
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
			
			// 삭제 요청 해야함
			console.log(data);
		});
		
		// 날짜 버튼 - 
		$j(".dayBtn").on("click", function() {
			let userSeq = $j("[data-seq]").data("seq");
			let day = $j(this).text();
			
			// ajax로 요청하면 됨
			console.log(userSeq);
			console.log(day);
		});
		
		// 저장 버튼 
		$j("#submit").on("click", function() {
			let validationData = $j("table:eq(1) tbody input:not(:checkBox)");
			let day = $j("[data-day]").data("day");
			
			if(!validation(validationData)) return;
			
			let data = $j("table:eq(1) tbody input:not(:checkBox), table:eq(1) tbody select");
			
			let sendData = {
				clientVo : {
					userSeq : $j("[data-seq]").data("seq")
				},
				travelList : data.serializeObject(day)
			}
			
			console.log(sendData);
			
			$j.ajax({
				url : "/travel/admin",
				type : "POST",
				data : JSON.stringify(sendData),
				dataType : "json",
				contentType : "application/json",
				success : function(res) {
					res.success == "Y" ? calTravelExpend() : alert("저장 실패");
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
							<div id="travelExpend" class="userListTableContent"></div>
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
								<label for="transTime0">예상이동시간</label>
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
											oninput="this.value = this.value.replace(/^\dㄱ-ㅎ\uac00-\ud7a3/)">
										</td>
										<td>
											<input id="useExpend${status.index}" name="useExpend" type="text" value="${item.useExpend}"
											oninput="this.value = this.value.replace(/[^\d\,]/, '')">
										</td>
										<td>
											<input id="travelDetail${status.index}" name="travelDetail" type="text" value="${item.travelDetail}"
											oninput="this.value = this.value.replace()">
										</td>
										<td>
											<div id="transExpend${status.index}"></div>
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
										<option value="R" <c:if test="${selectUser.transport eq 'R'}">selected = 'selected'</c:if>>렌트</option>
										<option value="W" <c:if test="${selectUser.transport eq 'W'}">selected = 'selected'</c:if>>도보</option>
										<option value="S" <c:if test="${selectUser.transport eq 'S'}">selected = 'selected'</c:if>>지하철</option>
										<option value="T" <c:if test="${selectUser.transport eq 'T'}">selected = 'selected'</c:if>>택시</option>
										<option value="B" <c:if test="${selectUser.transport eq 'B'}">selected = 'selected'</c:if>>버스</option>
										<option value="C" <c:if test="${selectUser.transport eq 'C'}">selected = 'selected'</c:if>>자차</option>
									</select>
								</td>
								<td>
									<input id="transTime0" name="transTime" type="text"
									oninput="this.value = this.value.replace(/^\dㄱ-ㅎ\uac00-\ud7a3/)">
								</td>
								<td>
									<input id="useExpend0" name="useExpend" type="text"
									oninput="this.value = this.value.replace(/[^\d\,]/, '')">
								</td>
								<td>
									<input id="travelDetail0" name="travelDetail" type="text"
									oninput="this.value = this.value.replace()">
								</td>
								<td>
									<div id="transExpend0"></div>
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
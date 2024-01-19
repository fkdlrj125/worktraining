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
  		- 스케쥴 겹치는 시간 선택 불가 x 
  		- 시간 오전 7시 ~ 다음날 오전 4시까지로 제한 x 
  		- 일정 리스트 작성 후 저장버튼 클릭 시 이용요금 및 교통비 합산하여 고객 리스트 견적경비에 출력
  		  예상 경비 초과 시 견적경비는 붉은색으로 변경 
  		- 일정 리스트 전달 시 여러 개 처리되나 확인 x
  		- 날짜 선택 x
 -->
<script type="text/javascript">
	$j.fn.serializeObject = function(day) {
		let result = [];
		let obj = null;
		
		let pushObj = function(obj) {
			obj["travelDay"] = `\${day}`;
			obj["request"] = "C";
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
		let checkTime = new Date();
		let transTime = parseInt($j(data).closest("tr").find("input[name='transTime']").val().replace(/\D/g, ""));
		let prevTime = null;
		let time = null;
		let checkDateStart = new Date();
		let checkDateEnd = new Date();
		
		$j.each(data, function() {
			if(!$j(this).val()?.trim()) {
				alert(`\${$j(`label[for='\${$j(this).attr('id').replace(/\d/g, '0')}']`).text()}을 입력해주세요`);
				$j(this).focus();
				result = false;
				return false;
			}
			
			switch($j(this).attr("name")) {
			case "transTime":
				if(testObj[$j(this).attr("name")] == null)
					testObj[$j(this).attr("name")] = [];
				
				testObj[$j(this).attr("name")].push($j(this).val());
				
				break;
				
			case "travelTime":
				time = $j(this).val().split(":");
				
				checkTime.setHours(time[0]);
				checkTime.setMinutes(time[1]);
				checkDateStart.setHours("7","0","0");
				checkDateEnd.setDate(checkDateEnd.getDate() + 1);
				checkDateEnd.setHours("4","0","0");
				
				if(checkTime < checkDateStart || checkTime > checkDateEnd) {
					alert("스케쥴 시간은 오전 7시 ~ 다음날 오전 4시까지 등록 가능합니다.");
					$j(this).focus();
					result = false;
					break;
				}
				
				if(prevTime == null) {
					checkTime.setMinutes(checkTime.getMinutes() + transTime);
					prevTime = new Date(checkTime.getTime());
					break;
				}
				
				if(checkTime < prevTime) {
					alert("이전 스케쥴 시간과 겹치지 않게 설정해주세요.");
					$j(this).focus();
					result = false;
				}
				
				checkTime.setMinutes(checkTime.getMinutes() + transTime);
				prevTime = checkTime;
			}
		});
		
		if(!result) return result;
		
		let regex = {
			transTime : /^(([1-9]?[0-9][0-9]|[0-9])\ubd84)$/,
		}
		
		let alertComment = {
			transTime : "을 분 단위로 입력해주세요.",
		}
		
		$j.each(Object.keys(testObj), function(index) {
			let id = this;
			$j.each(testObj[id], function() {
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
	
	$j(document).ready(function() {
		var userSeq = $j("[data-seq]").data("seq");
		var rowNum = $j("table:eq(1) tbody tr").length;
		var day = $j("[data-day]").data("day");
		var period = Math.round(($j("#dayBtnBox").data("period")) / 2) - 1;
		var rentExpend = 100000 - (10000 * (period > 3 ? 3 : period));
		var preRentExpend = 0;
		var rentInfo = sessionStorage.getItem(`\${userSeq}rent`) ? 
				JSON.parse(sessionStorage.getItem(`\${userSeq}rent`)) :
				{};
		var isChange = false;
		
		for(let key of Object.keys(localStorage)) {
		 	let saveData = JSON.parse(localStorage.getItem(key));
		 	let inputPosition = key.replace(/\D/g, "")
		 	
		 	if(saveData.travelExpendOver)
				$j(`#travelExpend\${inputPosition}`).css("color", "red");
		 	
		 	$j(`#travelExpend\${inputPosition}`).text(saveData.travelExpend);
		}
		
		
		$j(document).on("change", ".travelTable input, .travelTable select", function() {
			isChange = true;
		});
		
		// 교통비 계산
		var calTransExpend = function(data) {
			let transport = $j(data).closest("tr").find("[name=travelTrans]");
			let travelTime = $j(data).closest("tr").find("[name=travelTime]").val();
			let transTime = $j(data).closest("tr").find("input[name='transTime']").val().replace(/\D/g, "");
			let textPosition = $j(data).closest("tr").find("[id*=transExpend]");
			let keys = Object.keys(rentInfo).filter((key) => /\d/.test(key));
			
			if(transport.val() == "R") {
				let filterOption = transport.find("option:selected").filter((idx, value) => $j(value).val() == "R");
				let expend = 0;
				let totalTime = 0;
				let time = 0;
				transTime = 0;
				
				if(rentInfo[day-1]) {
					for(let i = 1; i < day; i++)
						transTime += parseInt(rentInfo[i]);
				}
				
				$j.each(filterOption.closest("tr").find("input[name='transTime']"), function() {
					textPosition = $j(this).closest("tr").find("[id*=transExpend]");
					
					time = parseInt($j(this).val().replace(/\D/g, ""))
					totalTime += time;
					transTime += time;
					
					expend = 500 * (transTime > 9 ? Math.floor(transTime / 10) : 0);
					rentExpend += expend;
					rentExpend -= preRentExpend;
					preRentExpend = expend;
					$j(textPosition).text(`\${rentExpend}원`);
				});
				
				if(isChange) return;
				
				if(rentInfo[day] == totalTime)
					return;
				
				rentInfo[day] = totalTime;
				sessionStorage.setItem(`\${userSeq}rent`, JSON.stringify(rentInfo));
				return;
			}
			
			$j.ajax({
				url : `/travel/calculate?ts=\${transport.val()}&tlt=\${travelTime}&tst=\${transTime}`,
				type : "GET",
				async : false,
				success : function(res) {
					res = JSON.parse(res);
					$j(textPosition).text(`\${res.expend}원`);
				},
				error : function(errorThrown) {
					alert(errorThrown);
				}
			});
		}
		
		// 견적 비용 계산
		var calTravelExpend = function() {
			let userExpend = parseInt($j(`#userExpend\${userSeq}`).text().replace(/\D/g, ""));
			let useExpend = 0;
			let transExpend = 0;
			let travelExpend = 0;
			let travelExpendOver = 0;
			let totalExpend = 0;
			let dayExpend = 0;
			let saveObj = localStorage.getItem(`travelExpend\${userSeq}`) 
						? JSON.parse(localStorage.getItem(`travelExpend\${userSeq}`)) 
						: {};
			let isRent = false;
			let prevRent = 0;
			
			$j("[name=useExpend]").each(function() {
				useExpend += parseInt($j(this).val().replace(/\D/g, ""));
			});
			
			$j("[id*=transExpend]").each(function() {
				if($j(this).closest("tr").find("[name=travelTrans] option:selected").val() == "R") {
					isRent = true;
					transExpend += rentExpend - prevRent;
					prevRent = rentExpend;
					return true;
				}
				transExpend += parseInt($j(this).text().replace(/\D/g, ""));
			});
			
			travelExpend = saveObj.travelExpend ? parseInt(saveObj.travelExpend.replace(/\D/g, "")) : 0;
			dayExpend = saveObj[day] ? parseInt(saveObj[day]) : 0;	
			
			totalExpend = useExpend + transExpend;
			
			travelExpend += totalExpend - dayExpend;
			travelExpendOver = userExpend < travelExpend ? 1 : 0;
			
			$j(`#travelExpend\${userSeq}`).css("color", "black");
			if(travelExpendOver)
				$j(`#travelExpend\${userSeq}`).css("color", "red");
			
			travelExpend = travelExpend.toLocaleString('ko-KR');
			$j(`#travelExpend\${userSeq}`).text(travelExpend);
			
			saveObj.travelExpend = travelExpend;
			saveObj.travelExpendOver = travelExpendOver;
			saveObj[day] = totalExpend;
			saveObj.prevDay = day;
			
			localStorage.setItem(`travelExpend\${userSeq}`, JSON.stringify(saveObj));
		}
		
		// 교통비 찍기
		$j(document).on("change", "input[name='transTime'], select[name='travelTrans']", function() {
			calTransExpend(this);
		});
		
		if(!!$j("input[name='transTime']").val()?.trim()) {
			$j.each($j("input[name='transTime']"), function() {
				calTransExpend(this);
			});
		}
		
		// 이용금액 , 찍기
		$j(document).on("keyup", "input[name='useExpend']",function(e) {
			let parseValue = parseInt($j(this).val().replace(/\D/g, ""));
			
			if(parseValue)
				$j(this).val(parseValue.toLocaleString('ko-KR'));
		});
		
		// 지역 변경
		$j(document).on("change", "[name=travelCity]", function() {
			let travelCounty = $j(this).siblings("[name=travelCounty]");
			
			$j.ajax({
				url : "/travel/county",
				type : "get",
				data : $j(this).serialize(),
				dataType : "json",
				success : function(res) {
					$j(travelCounty).find("option").remove();
					
					$j.each(res, function() {
						$j(travelCounty).append(`<option value="\${this.code}">\${this.name}</option>`);
					});
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
			
			$j(copyRow).find("input:checkBox").prop("selected", false);	
			$j("table:eq(1) tbody").append(copyRow);
			rowNum++;
		});
		
		// 삭제 버튼
		$j("#subBtn").on("click", function(){
			let checkedBox = $j("input:checked");
			let checkedBoxInData = 
			checkedBox.filter((index, el) => $j(el).siblings("[name='travelSeq']").val()?.trim());
			
			if(checkedBox.length == $j("input:checkBox").length) {
				alert("최소 한 개 이상의 행을 남겨주세요.");
				$j("input:checkBox").prop("checked",false);
				return;
			}
			
			$j.each(checkedBox, function() {
				$j(this).closest("tr").remove();
			});
			
			if(checkedBoxInData.length == 0) return;
			
			let obj = null;
			let tInfoList = [];
			
			$j.each(checkedBoxInData.siblings("[name='travelSeq']"), function() {
				obj = {};
				obj[$j(this).attr("id").replace(/\d/, "")] = $j(this).val();
				obj["userSeq"] = userSeq;
				tInfoList.push(Object.assign({}, obj));
			});
			
			console.log(obj);
			
			$j.ajax({
				url : "/travel/delete",
				type : "POST",
				data : JSON.stringify(tInfoList),
				dataType : "json",
				contentType : "application/json",
				success : function(res) {
					res.success == "Y" ? "" : alert("삭제 실패");
				},
				error : function() {
					alert("삭제 실패");
				}
			});
		});
		
		// 날짜 버튼 - 
		$j(".dayBtn").on("click", function() {
			let day = $j(this).text();
			
			if(isChange) {
				if(confirm("편집한 내용을 저장하지 않고 이동하시겠습니까?"))
					location.href=`/travel/admin?userSeq=\${userSeq}&day=\${day}`;
				return;
			}
				
			location.href=`/travel/admin?userSeq=\${userSeq}&day=\${day}`;
		});
		
		// 저장 버튼 
		$j("#submit").on("click", function() {
			let day = $j("[data-day]").data("day");
			let validationData = $j("table:eq(1) tbody input:not(:checkBox)");
			
			if(!validation) return;
			
			if(calTravelExpend()) {
				alert("예상 경비를 초과했습니다.");
			}
			
			let data = $j("table:eq(1) tbody input:not(:checkBox), table:eq(1) tbody select");
			
			let sendData = {
				clientVo : {
					userSeq : userSeq
				},
				travelList : data.serializeObject(day),
				travelExpendOver : JSON.parse(localStorage.getItem(`travelExpend\${userSeq}`)).travelExpendOver
			}
			
			$j.ajax({
				url : "/travel/admin",
				type : "POST",
				data : JSON.stringify(sendData),
				dataType : "json",
				contentType : "application/json",
				success : function(res) {
					res.success == "Y" ? alert("저장 완료") : alert("저장 실패");
					isChange = false;
					calTransExpend($j("input[name='transTime']"));
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
							<div id="userExpend${user.userSeq}" class="userListTableContent">${user.expend}</div>
						</td>
						<td>
							<div id="travelExpend${user.userSeq}" class="userListTableContent"></div>
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
				<div id="tableBtnBox">
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
												<option value="R" <c:if test="${item.travelTrans eq 'R'}">selected = 'selected'</c:if>>렌트</option>
												<option value="W" <c:if test="${item.travelTrans eq 'W'}">selected = 'selected'</c:if>>도보</option>
												<option value="S" <c:if test="${item.travelTrans eq 'S'}">selected = 'selected'</c:if>>지하철</option>
												<option value="T" <c:if test="${item.travelTrans eq 'T'}">selected = 'selected'</c:if>>택시</option>
												<option value="B" <c:if test="${item.travelTrans eq 'B'}">selected = 'selected'</c:if>>버스</option>
												<option value="C" <c:if test="${item.travelTrans eq 'C'}">selected = 'selected'</c:if>>자차</option>
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
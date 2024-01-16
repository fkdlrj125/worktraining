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
		let result = true;
		
		$j.each(data, function() {
			if(!$j(this).val()?.trim()) {
				alert($j(`label[for=\${$j(this).attr('id')}]`).text() + "을 입력해주세요.");
				$j(this).focus();
				result = false;
				return false;
			}
		});
		
		if(result == false) return;
		
		let periodReg = /^(1[0-9]|2[0-9]|30|[1-9])$/
		
		if(!periodReg.test($j(period).val())) {
			alert($j(`label[for=\${$j(period).attr('id')}]`).text() + "을 1~30일 사이로 입력해주세요.");
			$j(period).focus();
			result = false;
		}
		
		return result;
	}

	$j(document).ready(function() {
		var userSeq = ${loginUser.userSeq}
		var rentInfo = sessionStorage.getItem(`\${userSeq}rent`) ? 
				JSON.parse(sessionStorage.getItem(`\${userSeq}rent`)) :
				{
					transTime : 0,
				};
		var period = Math.round(($j("#dayBtnBox").data("period")) / 2) - 1;
		var rentExpend = 100000 - (10000 * (period > 3 ? 3 : period));
		var preRentExpend = 0;
		
		var calTransExpend = function(data) {
			let transport = $j(data).closest("tr").find("[name=travelTrans]").val();
			let travelTime = $j(data).closest("tr").find("[name=travelTime]").val();
			let transTime = $j(data).closest("tr").find("input[name='transTime']").val().replace(/\D/g, "");
			let textPosition = $j(data).closest("tr").find("[id*=transExpend]");
			
			if(transport == "R") {
				let filterOption = $j(".travelTable").find("select option:selected").filter((idx, value) => $j(value).val() == "R");
				let expend = 0
				transTime = parseInt(rentInfo.transTime);

				$j.each(filterOption.closest("tr").find("input[name='transTime']"), function() {
					textPosition = $j(this).closest("tr").find("[id*=transExpend]");
					
					transTime += parseInt($j(this).val().replace(/\D/g, ""));
					
					expend = 500 * (transTime > 9 ? Math.floor(transTime / 10) : 0);
					rentExpend += expend;
					rentExpend -= preRentExpend;
					preRentExpend = expend;
					
					$j(textPosition).text(`\${rentExpend}원`);
				});
				
				sessionStorage.setItem(`\${userSeq}rent`, JSON.stringify(rentInfo));
				return;
			}
			
			$j.ajax({
				url : `/travel/calculate?ts=\${transport}&tlt=\${travelTime}&tst=\${transTime}`,
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
		
		calTransExpend($j("input[name='transTime']"));
		
		
		$j(".travelTable").find("input, select").each(function() {
			$j(this).prop("disabled", true);
			
			if($j(this).closest("tr").data("request") == "C")
				$j(this).closest("tr").find("input:checkBox, input.hidden").prop("disabled", false);
		})
		
		$j("#expend").on("keyup", function(e) {
			let parseValue = parseInt($j(this).val().replace(/\D/g, ""));
			
			if(parseValue)
				$j(this).val(parseValue.toLocaleString('ko-KR'));
		});
		
		$j("#logout").on("click", function() {
			$j.ajax({
				url : "/travel/logout",
				type : "post",
				success : function() {
					location.href = "/travel/login";
				},
				error : function() {
					alert("로그아웃 실패");
				}
			})
		});
		
		$j(".dayBtn").on("click", function() {
			let day = $j(this).text();
			
			location.href=`/travel/book?day=\${day}`;
		});
		
		$j("#modBtn").on("click", function() {
			let day = $j("[data-day]").data("day");
			let checkBoxes = $j("input:checkBox:checked");
			let data = checkBoxes.closest("tr").find("input, select");
			data.prop("disabled", false);
			
			let sendData = {
				travelList : data.serializeObject(day)
			}
			
			$j.ajax({
				url : "/travel/mod",
				type : "post",
				data : JSON.stringify(sendData),
				dataType : "json",
				contentType : "application/json",
				success : function(res) {
					res.success == "Y" ? alert("요청 완료") : alert("요청 실패");
				},
				error : function() {
					alert("요청 실패");
				}
			});
			data.prop("disabled", true);
		});
		
		$j("#submit").on("click", function() {
			let data = $j("form:eq(0) input, form:eq(0) select");
			if(!validation(data)) return;
			
			let sendData = 
				{
					clientVo : {
						userSeq : ${loginUser.userSeq},
						userName : $j("#userName").text(),
						userPhone : $j("#userPhone").text()
					}
				}
			
			Object.assign(sendData["clientVo"], data.serializeObject());
			
			$j.ajax({
				url : "/travel/book",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(sendData),
				dataType : "json",
				success : function(res) {
					res.success == "Y" ? location.href = "/travel/login" : alert("신청 실패");
				},
				error : function(e) {
					alert(e);
				}			
			})
		});
	});
</script>
<body>
	<div class="container">
		<form>
			<table border="1">
				<tr>
					<th>
						<div>고객명</div>
					</th>
					<td>
						<div id="userName">${loginUser.userName}</div>
					</td>
				</tr>
				<tr>
					<th>
						<div>휴대폰번호</div>
					</th>
					<td>
						<div id="userPhone">${loginUser.userPhone}</div>
					</td>
				</tr>
				<tr>
					<th>
						<label for="period">여행 기간</label>
					</th>
					<td>
						<input id="period" type="text" name="period" value="${loginUser.period}"
						oninput="this.value = this.value.replace(/[\D]/, '')">
					</td>
				</tr>
				<tr>
					<th>
						<label for="transport">이동 수단</label>
					</th>
					<td>
						<select id="transport" name="transport">
							<option value="R" <c:if test="${loginUser eq null || loginUser.transport eq 'R'}">selected = 'selected'</c:if>>렌트</option>
							<option value="B" <c:if test="${loginUser.transport eq 'B'}">selected = 'selected'</c:if>>대중교통</option>
							<option value="C" <c:if test="${loginUser.transport eq 'C'}">selected = 'selected'</c:if>>자차</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<label for="expend">예상 경비</label>
					</th>
					<td>
						<input id="expend" type="text" name="expend" value="${loginUser.expend}"
						oninput="this.value = this.value.replace(/[^\d\,]/, '')">
					</td>
				</tr>
				<tr>
					<th>
						<label for="travelCity">여행지</label>
					</th>
					<td>
						<select id="travelCity" name="travelCity">
						<c:forEach items="${cityList}" var="item">
							<option value="${item.name}" 
							<c:if test="${(item.name eq loginUser.travelCity) 
							|| loginUser.travelCity eq null && item.name eq '서울'}">
								selected = 'selected'
							</c:if>>
								${item.name}
							</option>
						</c:forEach>
						</select>
					</td>
				</tr>
			</table>
			
			<button type="button" id="submit" <c:if test="${travelInfoList ne null}">class="hidden"</c:if>>신청</button>
			<button type="button" id="logout" <c:if test="${travelInfoList eq null}">class="hidden"</c:if>>로그아웃</button>
		</form>

		<form <c:if test="${travelInfoList eq null}">class="hidden"</c:if>>
			<div id="dayBtnBox" data-period="${loginUser.period}">
				<c:forEach begin="1" end="${loginUser.period}" var="idx" varStatus="status">
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
			<div id="modBtnBox">
				<button id="modBtn" type="button">수정요청</button>
			</div>
			<table border="1" class="travelTable">
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
					<c:forEach items="${travelInfoList}" var="item" varStatus="status">
						<tr data-request="${item.request}">
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
										<c:if test="${city.name eq loginUser.travelCity}">
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
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>
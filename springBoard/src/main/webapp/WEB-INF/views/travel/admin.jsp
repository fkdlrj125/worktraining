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
    [������] x
    - ������Ʈ ���̺�
    - �Ϻ� ��ư ���� ����
    - �߰� ���� ��ư ���� ����
    - ���� ����Ʈ ���̺�
    - �����ư

	[JS] 
	- [������Ʈ] x
	  - ������Ʈ���� ���� Ŭ�� �� ajax�� ���� ����Ʈ ��û
	- ������ ���� ���� �Ⱓ�� ���� �Ϻ� ��ư ���� x
	  - ���� �Ⱓ��ŭ �ݺ��ؼ� ��ư ����
	  - ��ư Ŭ�� �� ���� �Է� ������ ���ǽ��丮���� ����
	- �߰� �� ���� ��ư���� ���� ����Ʈ �߰� �� ���� x
	  - ������ ��ư �����ڸ��� ��û���� ��ܿ��� ���� Ÿ�̹��� ������ ����
	
	- [��������Ʈ]
	  �ð�, ����(��/��, �ñ���), ���, �̵�����, �̵��ð�, �̿���, ��ȹ�� �Է� x
	  ������ ������ �� �����̵��ð��� ���� ����Ͽ� ��� x - ��� ��û������ �̺�Ʈ�� �ٲ�� �ҵ�
	  - �������� ��ġ�� �ð��� ���� �Ұ�(�̰� ã�ƺ�����) 
	    �ð��� ���� 7�� ~ ������ ���� 4�ñ��� ��� ����
	  - �̵����� x
	    - ����(W)
	    - ����(B)
	      - 1400��
	      - 20�� �ʰ��� 200���� ����
	    - ����ö(S)
	      - 1450��
	      - 20�� �ʰ��� 200���� ����
	    - �ý�(T)
	      - �ð��� ���� ���� ���
	        22��~24�� 20����
	        24��~04�� 40����
	      - �⺻��� 3800��(10��)
	        - �̵��Ÿ� 10�д� 5000��
	    - ��Ʈ(R)
	      - 10�д� 500�� �����
	      - 1~2�� 10���� ��Ʈ�Ⱓ�� ���� �� 1���� ����(���� 7����)
	        (3~4�� 9����, 5~6�� 8����)
	    - ����(C)
	- ���� ����Ʈ �ۼ� �� �����ư Ŭ�� �� �̿��� �� ����� �ջ��Ͽ� �� ����Ʈ ������� ���
	  ���� ��� �ʰ� �� �������� ���������� ����
  	- �Է��� �������� POST��û x
  	
  	- ���� ��
  		- ������ ��ġ�� �ð� ���� �Ұ� x 
  		- �ð� ���� 7�� ~ ������ ���� 4�ñ����� ���� x 
  		- ���� ����Ʈ �ۼ� �� �����ư Ŭ�� �� �̿��� �� ����� �ջ��Ͽ� �� ����Ʈ ������� ���
  		  ���� ��� �ʰ� �� �������� ���������� ���� 
  		- ���� ����Ʈ ���� �� ���� �� ó���ǳ� Ȯ�� x
  		- ��¥ ���� x
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
				alert(`\${$j(`label[for='\${$j(this).attr('id').replace(/\d/g, '0')}']`).text()}�� �Է����ּ���`);
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
					alert("������ �ð��� ���� 7�� ~ ������ ���� 4�ñ��� ��� �����մϴ�.");
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
					alert("���� ������ �ð��� ��ġ�� �ʰ� �������ּ���.");
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
			transTime : "�� �� ������ �Է����ּ���.",
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
		
		// ����� ���
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
					$j(textPosition).text(`\${rentExpend}��`);
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
					$j(textPosition).text(`\${res.expend}��`);
				},
				error : function(errorThrown) {
					alert(errorThrown);
				}
			});
		}
		
		// ���� ��� ���
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
		
		// ����� ���
		$j(document).on("change", "input[name='transTime'], select[name='travelTrans']", function() {
			calTransExpend(this);
		});
		
		if(!!$j("input[name='transTime']").val()?.trim()) {
			$j.each($j("input[name='transTime']"), function() {
				calTransExpend(this);
			});
		}
		
		// �̿�ݾ� , ���
		$j(document).on("keyup", "input[name='useExpend']",function(e) {
			let parseValue = parseInt($j(this).val().replace(/\D/g, ""));
			
			if(parseValue)
				$j(this).val(parseValue.toLocaleString('ko-KR'));
		});
		
		// ���� ����
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
		
		// �߰� ��ư - ��
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
		
		// ���� ��ư
		$j("#subBtn").on("click", function(){
			let checkedBox = $j("input:checked");
			let checkedBoxInData = 
			checkedBox.filter((index, el) => $j(el).siblings("[name='travelSeq']").val()?.trim());
			
			if(checkedBox.length == $j("input:checkBox").length) {
				alert("�ּ� �� �� �̻��� ���� �����ּ���.");
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
					res.success == "Y" ? "" : alert("���� ����");
				},
				error : function() {
					alert("���� ����");
				}
			});
		});
		
		// ��¥ ��ư - 
		$j(".dayBtn").on("click", function() {
			let day = $j(this).text();
			
			if(isChange) {
				if(confirm("������ ������ �������� �ʰ� �̵��Ͻðڽ��ϱ�?"))
					location.href=`/travel/admin?userSeq=\${userSeq}&day=\${day}`;
				return;
			}
				
			location.href=`/travel/admin?userSeq=\${userSeq}&day=\${day}`;
		});
		
		// ���� ��ư 
		$j("#submit").on("click", function() {
			let day = $j("[data-day]").data("day");
			let validationData = $j("table:eq(1) tbody input:not(:checkBox)");
			
			if(!validation) return;
			
			if(calTravelExpend()) {
				alert("���� ��� �ʰ��߽��ϴ�.");
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
					res.success == "Y" ? alert("���� �Ϸ�") : alert("���� ����");
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
						<div class="userListTableHead">����</div>
					</th>
					<th>
						<div class="userListTableHead">�޴�����ȣ</div>
					</th>
					<th>
						<div class="userListTableHead">������</div>
					</th>
					<th>
						<div class="userListTableHead">���� �Ⱓ</div>
					</th>
					<th>
						<div class="userListTableHead">�̵�����</div>
					</th>
					<th>
						<div class="userListTableHead">���� ���</div>
					</th>
					<th>
						<div class="userListTableHead">���� ���</div>
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
								<c:if test="${user.transport eq'R'}">��Ʈ</c:if>
								<c:if test="${user.transport eq 'B'}">���߱���</c:if>
								<c:if test="${user.transport eq 'C'} ">����</c:if>
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
					<button id="addBtn" type="button">�߰�</button>
					|
					<button id="subBtn" type="button">����</button>
				</div>
				<table border="1" class="travelTable" data-seq="${selectUser.userSeq}">
					<thead>
						<tr>
							<th>
							</th>
							<th>
								<label for="travelTime0">�ð�</label>
							</th>
							<th>
								<label for="travelCity0">����</label>
								<label for="travelCounty0" class="hidden"></label>
							</th>
							<th>
								<label for="travelLoc0">��Ҹ�</label>
							</th>
							<th>
								<label for="travelTrans0">������</label>
							</th>
							<th>
								<label for="transTime0">�����̵��ð�</label>
							</th>
							<th>
								<label for="useExpend0">�̿���(����������)</label>
							</th>
							<th>
								<label for="travelDetail0">��ȹ��</label>
							</th>
							<th>
								�����
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
											oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\w\d]/, '')">
										</td>
										<td>
											<select id="travelTrans${status.index}" name="travelTrans">
												<option value="R" <c:if test="${item.travelTrans eq 'R'}">selected = 'selected'</c:if>>��Ʈ</option>
												<option value="W" <c:if test="${item.travelTrans eq 'W'}">selected = 'selected'</c:if>>����</option>
												<option value="S" <c:if test="${item.travelTrans eq 'S'}">selected = 'selected'</c:if>>����ö</option>
												<option value="T" <c:if test="${item.travelTrans eq 'T'}">selected = 'selected'</c:if>>�ý�</option>
												<option value="B" <c:if test="${item.travelTrans eq 'B'}">selected = 'selected'</c:if>>����</option>
												<option value="C" <c:if test="${item.travelTrans eq 'C'}">selected = 'selected'</c:if>>����</option>
											</select>
										</td>
										<td>
											<input id="transTime${status.index}" name="transTime" type="text" value="${item.transTime}"
											oninput="this.value = this.value.replace(/^\d��-��\uac00-\ud7a3/)">
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
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\w\d]/, '')">
								</td>
								<td>
									<select id="travelTrans0" name="travelTrans">
										<option value="R" <c:if test="${selectUser.transport eq 'R'}">selected = 'selected'</c:if>>��Ʈ</option>
										<option value="W" <c:if test="${selectUser.transport eq 'W'}">selected = 'selected'</c:if>>����</option>
										<option value="S" <c:if test="${selectUser.transport eq 'S'}">selected = 'selected'</c:if>>����ö</option>
										<option value="T" <c:if test="${selectUser.transport eq 'T'}">selected = 'selected'</c:if>>�ý�</option>
										<option value="B" <c:if test="${selectUser.transport eq 'B'}">selected = 'selected'</c:if>>����</option>
										<option value="C" <c:if test="${selectUser.transport eq 'C'}">selected = 'selected'</c:if>>����</option>
									</select>
								</td>
								<td>
									<input id="transTime0" name="transTime" type="text"
									oninput="this.value = this.value.replace(/^\d��-��\uac00-\ud7a3/)">
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
				<button type="button" id="submit">����</button>
			</form>
		</c:if>
	</div>
</body>
</html>
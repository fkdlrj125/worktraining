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
    [������]
    - ������Ʈ ���̺�
    - �Ϻ� ��ư ���� ����
    - �߰� ���� ��ư ���� ����
    - ���� ����Ʈ ���̺�
    - �����ư

	[JS]
	- [������Ʈ]
	  - ������Ʈ���� ���� Ŭ�� �� ajax�� ���� ����Ʈ ��û
	- ������ ���� ���� �Ⱓ�� ���� �Ϻ� ��ư ����
	  - ���� �Ⱓ��ŭ �ݺ��ؼ� ��ư ����
	  - ��ư Ŭ�� �� ���� �Է� ������ ���ǽ��丮���� ����
	- �߰� �� ���� ��ư���� ���� ����Ʈ �߰� �� ����
	  - ������ ��ư �����ڸ��� ��û���� ��ܿ��� ���� Ÿ�̹��� ������ ����
	
	- [��������Ʈ]
	  �ð�, ����(��/��, �ñ���), ���, �̵�����, �̵��ð�, �̿���, ��ȹ�� �Է�
	  ������ ������ �� �����̵��ð��� ���� ����Ͽ� ���
	  - �������� ��ġ�� �ð��� ���� �Ұ�(�̰� ã�ƺ�����)
	    �ð��� ���� 7�� ~ ������ ���� 4�ñ��� ��� ����
	  - �̵�����
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
  	- �Է��� �������� POST��û 
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
		
		// �߰� ��ư
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
		
		// ���� ��ư
		$j("#subBtn").on("click", function(){
			let checkedBoxInData = $j("input[data-seq]:checked");
			let checkedBox = $j("input:not([data-seq]):checked");
			
			if(checkedBoxInData.length + checkedBox.length == $j("input:checkBox").length) {
				alert("�ּ� �� �� �̻��� ���� �����ּ���.");
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
			
			// ajax�� ��û�ϸ� ��
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
								<label for="useTime0">�����̵��ð�</label>
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
												<option value="R" <c:if test="${selectUser.transport eq 'R'}">selected = 'selected'</c:if>>��Ʈ</option>
												<option value="W" <c:if test="${selectUser.transport eq 'W'}">selected = 'selected'</c:if>>����</option>
												<option value="S" <c:if test="${selectUser.transport eq 'S'}">selected = 'selected'</c:if>>����ö</option>
												<option value="T" <c:if test="${selectUser.transport eq 'T'}">selected = 'selected'</c:if>>�ý�</option>
												<option value="B" <c:if test="${selectUser.transport eq 'B'}">selected = 'selected'</c:if>>����</option>
												<option value="C" <c:if test="${selectUser.transport eq 'C'}">selected = 'selected'</c:if>>����</option>
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
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\w\d]/, '')">
								</td>
								<td>
									<select id="travelTrans0" name="travelTrans">
										<option value="R" <c:if test="${loginUser eq null || loginUser.transport eq 'R'}">selected = 'selected'</c:if>>��Ʈ</option>
										<option value="W" <c:if test="${loginUser.transport eq 'W'}">selected = 'selected'</c:if>>����</option>
										<option value="S" <c:if test="${loginUser.transport eq 'S'}">selected = 'selected'</c:if>>����ö</option>
										<option value="T" <c:if test="${loginUser.transport eq 'T'}">selected = 'selected'</c:if>>�ý�</option>
										<option value="B" <c:if test="${loginUser.transport eq 'B'}">selected = 'selected'</c:if>>����</option>
										<option value="C" <c:if test="${loginUser.transport eq 'C'}">selected = 'selected'</c:if>>����</option>
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
				<button type="button" id="submit">����</button>
			</form>
		</c:if>
	</div>
</body>
</html>
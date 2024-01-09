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
	[������] 
	- ���� �Է� ��
	- �Ϻ� ��ư ���� ����(JSTL�� �̿��� ���� ������ ����)
    - ������û��ư ���� ����(JSTL�� �̿��� ���� ������ ����)
	- ���� ����Ʈ ���̺�(JSTL�� �̿��� ���� ������ ����)
	
	[JS]
	- �α��� �� �� ���� �ڵ� ���(�̸�, �޴�����ȣ)
	  - �̸��� �޴�����ȣ�� ���� �Ұ����ϰ� readonly����
	  - ��û��ư �α׾ƿ����� ����
	  
	- ���� �Ⱓ, �̵�����, ������, ������ ���� �� �Է� �� ��û��ư Ŭ��
	  - ����Ⱓ : 1~30
	    - ���ڷ� �Է�����
	    - �Է°��� 1~30 �������� ��ȿ�� �˻�
	  - �̵����� : ��Ʈ(R), ���߱���(B), ����(C)
	  - ������
	    - ���ڿ� ","�� �Է�����
	    - "," �ڵ� �Է�
	  - ������ : ���� ��/��
	  	- api�� �ޱ�
 -->
<script type="text/javascript">
	$j.fn.serializeObject = function() {
		var result = [];
		var obj = null;
		
		try {
			var arr = this.serializeArray();
			
			if(arr) {
				obj = {};
				
				$j.each(arr, function() {
					obj[this.name] = this.value;
				});
				result.push(Object.assign({}, obj));
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
				alert($j(`label[for=\${$j(this).attr('id')}]`).text() + "�� �Է����ּ���.");
				$j(this).focus();
				result = false;
				return false;
			}
		});
		
		if(result == false) return;
		
		let periodReg = /^(1[0-9]|2[0-9]|30|[1-9])$/
		
		if(!periodReg.test($j(period).val())) {
			alert($j(`label[for=\${$j(period).attr('id')}]`).text() + "�� 1~30�� ���̷� �Է����ּ���.");
			$j(period).focus();
			result = false;
		}
		
		return result;
	}

	$j(document).ready(function() {
		
		$j("#expend").on("keypress", function(e) {
			let insertPosition = ($j(this).val().replaceAll(",", "").length % 3) + 1;
			let cnt = Math.floor($j(this).val().replaceAll(",", "").length / 3);
			
			if(cnt > 0) {
				$j(this).val($j(this).val().replaceAll(",", ""));
				for(let i = 0; i < cnt; i++) {
					$j(this).val($j(this).val().slice(0, insertPosition) + "," + $j(this).val().slice(insertPosition));
					insertPosition += 4;
				}
			}
		});
		
		$j("#submit").on("click", function() {
			let data = $j("form:eq(0) input, form:eq(0) select");
			if(!validation(data)) return;
			
			let sendData = {
				userName : $j("#userName").text(),
				userPhone : $j("#userPhone").text()
			}
			Object.assign({}, sendData, data.serializeObject());
			
			console.log(sendData);
			
			return;
			$j.ajax({
				url : "/travel/book",
				type : "post",
				data : sendData,
				dataType : "json",
				contentType : "application/json",
				success : function(res) {
					res.success == "Y" ? location.href = "/travel/login" : alert("��û ����");
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
						<div>����</div>
					</th>
					<td>
						<div id="userName">${loginUser.userName}</div>
					</td>
				</tr>
				<tr>
					<th>
						<div>�޴�����ȣ</div>
					</th>
					<td>
						<div id="userPhone">${loginUser.userPhone}</div>
					</td>
				</tr>
				<tr>
					<th>
						<label for="period">���� �Ⱓ</label>
					</th>
					<td>
						<input id="period" type="text" name="period" value="${loginUser.period}"
						oninput="this.value = this.value.replace(/[\D]/, '')">
					</td>
				</tr>
				<tr>
					<th>
						<label for="tansport">�̵� ����</label>
					</th>
					<td>
						<select id="tansport" name="tansport">
							<option value="R" <c:if test="${loginUser eq null || loginUser.transport eq 'R'}">selected = 'selected'</c:if>>��Ʈ</option>
							<option value="B" <c:if test="${loginUser.transport eq 'B'}">selected = 'selected'</c:if>>���߱���</option>
							<option value="C" <c:if test="${loginUser.transport eq 'C'}">selected = 'selected'</c:if>>����</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<label for="expend">���� ���</label>
					</th>
					<td>
						<input id="expend" type="text" name="expend" value="${loginUser.expend}"
						oninput="this.value = this.value.replace(/[^\d\,]/, '')">
					</td>
				</tr>
				<tr>
					<th>
						<label for="travelCity">������</label>
					</th>
					<td>
						<select id="travelCity" name="travelCity">
						<c:forEach items="${cityList}" var="item">
							<option value="${item.code}" 
							<c:if test="${(loginUser.travelCity eq null && item.code eq '11') 
							|| item.code eq loginUser.travelCity}">
								selected = 'selected'
							</c:if>>
								${item.name}
							</option>
						</c:forEach>
						</select>
					</td>
				</tr>
			</table>
			
			<button type="button" id="submit">��û</button>
			<button type="button" id="logout" class="hidden">�α׾ƿ�</button>
		</form>

		<form <c:if test="${travelInfoList eq null}">class="hidden"</c:if>>
			<div id="dayBtnBox">
				<button type="button" class="dayBtn">1</button>
			</div>
			<div id="adjustBtn">
				<button type="button">������û</button>
			</div>
			<table border="1" class="travelTable">
				<thead>
					<tr>
						<th>
						</th>
						<th>
							<label for="travelTime">�ð�</label>
						</th>
						<th>
							<label for="travelCity">����</label>
							<label for="travelCounty" class="hidden"></label>
						</th>
						<th>
							<label for="travelLoc">��Ҹ�</label>
						</th>
						<th>
							<label for="travelTrans">������</label>
						</th>
						<th>
							<label for="useTime">�����̵��ð�</label>
						</th>
						<th>
							<label for="useExpend">�̿���(����������)</label>
						</th>
						<th>
							<label for="travelDetail">��ȹ��</label>
						</th>
						<th>
							�����
						</th>
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
							oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\w\d]/, '')">
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
							<div></div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>
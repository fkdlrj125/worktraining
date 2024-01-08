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
	$j.ajax({
		url 	: "https://api.vworld.kr/req/data?key=990C9653-E457-3637-8610-FFE3CA0A9247&domain=http://localhost:8080/travel/book&service=data&version=2.0&request=getfeature&format=json&size=1000&page=1&geometry=false&attribute=true&crs=EPSG:3857&geomfilter=BOX(13663271.680031825,3894007.9689600193,14817776.555251127,4688953.0631258525)&data=LT_C_ADSIDO_INFO&callback=jQuery111107369229617841166_1704700345340&_=1704700345341",
		type	: "GET",
		dataType : "jsonp",
		success : function(data) {
			console.log(data);
		}
	})
</script>
<body>
	<div class="container">
		<form action="">
			<table border="1">
				<tr>
					<th>
						<div>����</div>
					</th>
					<td>
						<div id="userName">${userName}</div>
					</td>
				</tr>
				<tr>
					<th>
						<div>�޴�����ȣ</div>
					</th>
					<td>
						<div id="userPhone">${userPhone}</div>
					</td>
				</tr>
				<tr>
					<th>
						<label for="period">���� �Ⱓ</label>
					</th>
					<td>
						<input id="period" type="text" name="period" value="${period}"
						oninput="this.value = this.value.replace(/[^\D]/, '')">
					</td>
				</tr>
				<tr>
					<th>
						<label for="tansport">�̵� ����</label>
					</th>
					<td>
						<select id="tansport" name="tansport">
							<option value="R" <c:if test="${transport eq 'R'}">selected = 'selected'</c:if>>��Ʈ</option>
							<option value="B" <c:if test="${transport eq 'B'}">selected = 'selected'</c:if>>���߱���</option>
							<option value="C" <c:if test="${transport eq 'C'}">selected = 'selected'</c:if>>����</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<label for="expend">���� ���</label>
					</th>
					<td>
						<input id="expend" type="text" name="expend" value="${expend}"
						oninput="this.value = this.value.replace(/[^\D\,]/, '')">
					</td>
				</tr>
				<tr>
					<th>
						<label for="travelCity">������</label>
					</th>
					<td>
						<select id="travelCity" name="travelCity">
						</select>
					</td>
				</tr>
			</table>
			
			<button type="button" id="submit">��û</button>
			<button type="button" id="logout" class="hidden">�α׾ƿ�</button>
		</form>

		<form class="">
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
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
						<div id="userName"></div>
					</td>
				</tr>
				<tr>
					<th>
						<div>�޴�����ȣ</div>
					</th>
					<td>
						<div id="userPhone"></div>
					</td>
				</tr>
				<tr>
					<th>
						<label for="period">���� �Ⱓ</label>
					</th>
					<td>
						<input id="period" type="text" name="period" value=""
						oninput="this.value = this.value.replace(/[^\D]/, '')">
					</td>
				</tr>
				<tr>
					<th>
						<label for="tansport">�̵� ����</label>
					</th>
					<td>
						<select id="tansport" name="tansport">
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<label for="expend">���� ���</label>
					</th>
					<td>
						<input id="expend" type="text" name="expend" value=""
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
		</form>

		<form>
			<div id="dayBtnBox">
				<button type="button" class="dayBtn">1</button>
			</div>
			<div id="adjustBtn">
				<button type="button">������û</button>
			</div>
			<table border="1" class="travelTable">
				<thead>
					<tr>
						<td>
						</td>
						<td>
							<label for="travelTime">�ð�</label>
						</td>
						<td>
							<label for="travelCity">����</label>
							<label for="travelCounty" class="hidden"></label>
						</td>
						<td>
							<label for="travelLoc">��Ҹ�</label>
						</td>
						<td>
							<label for="travelTrans">������</label>
						</td>
						<td>
							<label for="useTime">�����̵��ð�</label>
						</td>
						<td>
							<label for="useExpend">�̿���(����������)</label>
						</td>
						<td>
							<label for="travelDetail">��ȹ��</label>
						</td>
						<td>
							<label for="transExpend">�����</label>
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
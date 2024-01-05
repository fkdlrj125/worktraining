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
				<tr>
					<td>
						<div class="userListTableContent" data-seq=""></div>
					</td>
					<td>
						<div class="userListTableContent"></div>
					</td>
					<td>
						<div class="userListTableContent"></div>
					</td>
					<td>
						<div class="userListTableContent"></div>
					</td>
					<td>
						<div class="userListTableContent"></div>
					</td>
					<td>
						<div class="userListTableContent"></div>
					</td>
					<td>
						<div class="userListTableContent"></div>
					</td>
				</tr>
			</tbody>
		</table>
		<form action="">
			<div id="dayBtnBox">
				<button type="button" class="dayBtn">1</button>
			</div>
			<div id="tableBtn">
				<button type="button">�߰�</button>
				|
				<button type="button">����</button>
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
			<button type="button" id="submit">����</button>
		</form>
	</div>
</body>
</html>
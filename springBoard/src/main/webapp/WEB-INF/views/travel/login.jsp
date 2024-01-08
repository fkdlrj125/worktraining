<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="<c:url value="/resources/css/travel/travel.css"/>">
<title>Travel Login</title>
</head>
<!-- ���� �ڵ� ���� -->
<script type="text/javascript">
var nameCheck = function() {
	const nameRegex = /[\uac00-\ud7a3]/g;
	
	if(!nameRegex.test($j("#userName").val())) {
		alert("�̸��� �Է����ּ���.");
		$j("#userName").focus();
		return false;
	}
	return true;
}

var phoneCheck = function() {
	const phoneRegex = /^01([0|1|6|7|8|9])-\d{3,4}-\d{4}$/;
	
	if(!$j("#userPhone").val()?.trim()) {
		alert("�޴�����ȣ�� �Է����ּ���.");
		$j("#userPhone").focus();
		return false;
	}
	
	if(!phoneRegex.test($j("#userPhone").val())) {
		alert("�޴�����ȣ�� xxx-xxxx-xxxx �Ǵ� xxx-xxx-xxxx�������� �Է����ּ���.");
		$j("#userPhone").focus();
		return false;
	}
	return true;
}

$j(document).ready(function() {
	
	$j("#login").on("click", function() {
		
		if(!nameCheck()) return;
		
		if(!phoneCheck()) return;
		
		var param = $j(":input");
		
		$j.ajax({
			url : "/travel/login",
			type : "POST",
			data : param.serialize(),
			dataType : "json",
			success : function(data) {
				data.success == "Y" ? location.href = "/travel/book" : alert("����");
			},
			error : function(errorThrown) {
				console.log(errorThrown);
			}
		});
	});
	
	$j("#userName").on("change", function() {
		$j(this).val(($j(this).val().length > 5) ? $j(this).val().slice(0,5) : $j(this).val());
	});
	
	$j("#userPhone").on("keypress", function(e) {
		if(e.keyCode != 45 && !/^\d{0,3}-\d{0,4}-\d{0,4}$/.test($j(this).val())) {
			$j(this).val().length == 3 ? $j(this).val($j(this).val() + "-") : "";
			$j(this).val().length == 8 ? $j(this).val($j(this).val() + "-") : "";
		}
	});
});
</script>
<body>
<div class="container">
	<form>
		<table border="1">
			<tr>
				<th>
					<label for="userName">
						�̸�
					</label>
				</th>
				<td>
					<input type="text" id="userName" name="userName" maxlength="5"
					oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3]/, '')">
				</td>
			</tr>
			<tr>
				<th>
					<label for="userPhone">
						�޴�����ȣ
					</label>
				</th>
				<td>
					<input type="text" id="userPhone" name="userPhone" maxlength="13"
					oninput="this.value = this.value.replace(/[^0-9-]/g, '')">
				</td>
			</tr>
			<tr>
				<td colspan=2 class="submitBtn">
					<button type="button" id="login">�α���</button>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
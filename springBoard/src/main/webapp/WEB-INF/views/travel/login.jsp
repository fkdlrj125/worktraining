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
<!-- 기존 코드 재사용 -->
<script type="text/javascript">
var nameCheck = function() {
	const nameRegex = /[\uac00-\ud7a3]/g;
	
	if(!nameRegex.test($j("#travelName").val())) {
		alert("이름을 입력해주세요.");
		$j("#travelName").focus();
		return false;
	}
	return true;
}

var phoneCheck = function() {
	const phoneRegex = /^01([0|1|6|7|8|9])-\d{3,4}-\d{4}$/;
	
	if(!$j("#travelPhone").val()?.trim()) {
		alert("휴대폰번호를 입력해주세요.");
		$j("#travelPhone").focus();
		return false;
	}
	
	if(!phoneRegex.test($j("#travelPhone").val())) {
		alert("휴대폰번호를 xxx-xxxx-xxxx 또는 xxx-xxx-xxxx형식으로 입력해주세요.");
		$j("#travelPhone").focus();
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
				data.success == "Y" ? location.href = "/recruit/main" : alert("실패");
			},
			error : function(errorThrown) {
				console.log(errorThrown);
			}
		});
	});
	
	$j("#travelName").on("change", function() {
		$j(this).val(($j(this).val().length > 5) ? $j(this).val().slice(0,5) : $j(this).val());
	});
	
	$j("#travelPhone").on("keypress", function(e) {
		if(e.keyCode != 45 && !/^\d{3}-\d{3,4}-\d{4}$/.test($j(this).val())) {
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
					<label for="travelName">
						이름
					</label>
				</th>
				<td>
					<input type="text" id="travelName" name="travelName" maxlength="5"
					oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3]/, '')">
				</td>
			</tr>
			<tr>
				<th>
					<label for="travelPhone">
						휴대폰번호
					</label>
				</th>
				<td>
					<input type="text" id="travelPhone" name="travelPhone" maxlength="13"
					oninput="this.value = this.value.replace(/[^0-9-]/g, '')">
				</td>
			</tr>
			<tr>
				<td colspan=2 class="submitBtn">
					<button type="button" id="login">로그인</button>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
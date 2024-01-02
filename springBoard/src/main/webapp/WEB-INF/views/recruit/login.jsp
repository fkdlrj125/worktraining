<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="<c:url value="/resources/css/recruit/recruit.css"/>">
<title>Login</title>
</head>
<script type="text/javascript">

	var nameCheck = function() {
		const nameRegex = /[\uac00-\ud7a3]/g;
		
		if(!nameRegex.test($j("#RecName").val())) {
			alert("이름을 입력해주세요.");
			$j("#RecName").focus();
			return true;
		}
		return false;
	}

	var phoneCheck = function() {
		const phoneRegex = /^01([0|1|6|7|8|9])-?\d{3,4}-?\d{4}$/;
		
		if(!phoneRegex.test($j("#RecPhone").val())) {
			alert("휴대폰번호를 입력해주세요.");
			$j("#RecPhone").focus();
			return true;
		}
		return false;
	}

	$j(document).ready(function() {
		
		$j("#login").on("click", function() {
			
			if(nameCheck()) return;
			
			if(phoneCheck()) return;
			
			var param = $j(":input");
			
			$j.ajax({
				url : "/recruit/login",
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
		
		$j("#RecName").on("change", function() {
			$j(this).val(($j(this).val().length > 5) ? $j(this).val().slice(0,5) : $j(this).val());
		});
	});
</script>
<body>
	<div class="container">
		<form>
			<table border="1">
				<tr>
					<th>
						<label for="RecName">
							이름
						</label>
					</th>
					<td>
						<input type="text" id="RecName" name="RecName" maxlength="5"
						oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3]/, '')">
					</td>
				</tr>
				<tr>
					<th>
						<label for="RecPhone">
							휴대폰번호
						</label>
					</th>
					<td>
						<input type="text" id="RecPhone" name="RecPhone" maxlength="11"
						oninput="this.value = this.value.replace(/[^0-9-]/g, '')">
					</td>
				</tr>
				<tr>
					<td colspan=2 class="submitBtn">
						<button type="button" id="login">입사지원</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
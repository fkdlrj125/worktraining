<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>main</title>
</head>
<script>
</script>
<body>
	<form class="login">
		<table align="center" border="1">
			<tr>
				<td align="center">
					<label for="loginId">
						<strong>이름</strong>
					</label>
				</td>
				<td>
					<input type="text" id="loginId" width="100">
				</td>
			</tr>
			<tr>
				<td align="center">
					<label for="loginPhone">
						<strong>휴대폰번호</strong>
					</label>
				</td>
				<td>
					<input type="text" id="loginPhone">
				</td>
			</tr>
			<tr>
				<td align="center" colspan=2>
					<button id="login">입사지원</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
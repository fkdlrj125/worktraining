<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>userLogin</title>
</head>
<script type="text/javascript">
</script>
<body>
	<form class="userJoin">
		<table  align="center">
			<tr>
				<td>
					<table id="boardTable" border = "1">
						<tr>
							<td width="100" align="center">
								<label for="id">
									id
								</label>
							</td>
							<td width="250" align="left">
								<input type="text" id="id" name="loginId">
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="pw">
									pw
								</label>
							</td>
							<td align="left">
								<input type="password" id="pw" name="loginPw">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<input id="login" type="button" value="login">
				</td>
			</tr>
		</table>	
	</form>
</body>
</html>
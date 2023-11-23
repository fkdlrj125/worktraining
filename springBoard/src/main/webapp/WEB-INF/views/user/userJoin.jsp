<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>userJoin</title>
</head>
<script type="text/javascript">
</script>
<body>
	<form class="userJoin">
		<table  align="center">
			<tr >
				<td align="left">
				<a href="/board/boardList.do">List</a>
			</td>
			</tr>
			<tr>
				<td>
					<table id="boardTable" border = "1">
						<tr>
							<td width="120" align="center">
								<label for="id">
									id
								</label>
							</td>
							<td width="420" align="left">
								<input type="text" id="id" name="userId" style="width: 140px;">
								<input type="button" id="idCheck" value="중복확인">
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="pw">
									pw
								</label>
							</td>
							<td align="left">
								<input type="password" id="pw" name="userPw">
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="pwCheck">
									pw check
								</label>
							</td>
							<td align="left">
								<input type="password" id="pwCheck">
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="name">
									name
								</label>
							</td>
							<td align="left">
								<input type="text" id="name" name="userName">
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="phoneSnd">
									phone
								</label>
							</td>
							<td align="left">
								<select name="phoneFst">
									<c:forEach items="" var="phoneFirst">
										<option value=""></option>
									</c:forEach>
								</select>
								-
								<input type="text" id="phoneSnd" name="phoneSnd" style="width: 50px;">
								-
								<input type="text" name="phoneTrd" style="width: 50px;">
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="postNo">
									postNo
								</label>
							</td>
							<td align="left">
								<input type="postNo" id="postNo" name="userPN">
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="address">
									address
								</label>
							</td>
							<td align="left">
								<input type="text" id="address" name="userAd">
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="company">
									company
								</label>
							</td>
							<td align="left">
								<input type="text" id="company" name="userCo">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<input id="join" type="button" value="join">
				</td>
			</tr>
		</table>	
	</form>
</body>
</html>
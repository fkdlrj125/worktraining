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
<%--
		로그인 기능
		1. 아이디 비밀번호 유효성 테스트
			1-1. 아이디 비밀번호가 틀릴 시 알람창
--%>

	$j(document).ready(function() {
		$j("#login").on("click", function() {
			var $frm = $j(":input");
			var param = $frm.serialize();
			
			console.log(param);
			
			$j.ajax({
				url : "/user/userLogin.do",
				type : "POST",
				data : param,
				dataType : "json",
				success : function(data) {
					switch (data.result) {
					
					case "":
						location.href="/board/boardList.do";
						break;
					case "1":
						alert("비밀번호가 일치하지 않습니다.");
						break;
					case "2":
						alert("아이디가 존재하지 않습니다.");
						break;
					default:
						alert("아이디와 비밀번호를 다시 입력해주세요.")
						break;
					}
					
				},
				error : function(thrownError) {
					console.log(thrownError);
				},
				beforeSend : function(xhr) {
					if(!$j("#id").val()) {
						alert("아이디를 입력해주세요.");
						xhr.abort();
					} else if(!$j("#pw").val()) {
						alert("비밀번호를 입력해주세요.");
						xhr.abort();
					}
				}
			});
		});
	})
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
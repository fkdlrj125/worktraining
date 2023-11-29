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
<%--
	회원가입 기능
	1. 아이디 중복확인 o
	2. 유효성 검사  
		2-1. 필수값 아이디, 비밀번호, 비밀번호 확인, 이름, 휴대폰 번호
		2-2. 휴대폰과 우편번호 형식 확인
			- 휴대폰 형식 : xxx-xxxx-xxxx
			- 우편번호 형식 : xxx-xxx 
		2-3. 비밀번호와 비밀번호 확인 일치 
--%>
	function pwCheck() {
		let inputPw = $j("#userPw").val();
		let checkPw = $j("#pwCheck").val();
		let result;
		
		if(inputPw == checkPw) {
			alert("비밀번호가 일치합니다.");
			result = false;
		} else {
			alert("비밀번호가 일치하지 않습니다.");
			result = true;
		}
		
		return result;
	}
	
	

	$j(document).ready(function(){
		var idCheckResult = false;
		const phoneRegex = /^\d{4}$/;
		const addrRegex = /^\d{3}-\d{3}$/;
		const pwRegex = /^.{6,12}$/;
		
		$j("#userPw").change(function() {
			if($j(this).val() && !pwRegex.test($j(this).val())) {
				alert("비밀번호를 6~12자리로 입력해주세요.");
				$j(this).focus();
			}
		});
		
		$j("#pwCheck").change(function() {
			if($j(this).val() && pwCheck()) {
				$j(this).focus();
			}
		});
		
		$j("#userPhone2").change(function() {
			if($j(this).val() && !phoneRegex.test($j(this).val())) {
				alert("핸드번호 가운데 4자리를 입력해주세요.")
				$j(this).focus();
			}
		});
		
		$j("input[name='userPhone3']").change(function() {
			if($j(this).val() && !phoneRegex.test($j(this).val())) {
				alert("핸드번호 마지막 4자리를 입력해주세요.")
				$j(this).focus();
			}
		})
		
		$j("#userAddr1").change(function() {
			console.log(addrRegex.test($j(this).val()));
			if($j(this).val() && !addrRegex.test($j(this).val())){
				alert("xxx-xxx형식으로 작생해주세요");
				$j(this).focus();
			}
		});
		
		$j("#idCheck").on("click", function(){
			let inputId = $j("#userId").val();
			
			if(inputId) {
				$j.ajax({
					url : "/user/userIdCheck.do",
					type : "POST",
					data : {"inputId" : inputId},
					dataType : "json",
					success : function(data) {
						if(data.success == "Y") {
							alert("사용 가능한 아이디 입니다.");
							idCheckResult = true;
						} else {
							alert("중복된 아이디 입니다.");
							idCheckResult = false;
						}
					},
					error : function(thrownError) {
						console.log(thrownError);
					}
				});
			} else {
				alert("아이디를 입력해주세요.");
			}
		});
		
		$j("#join").on("click", function(){
			var $frm = $j(":input");
			var param = $frm.serialize();
			
			$j.ajax({
				url : "/user/userJoin.do",
				type : "POST",
				data : param,
				dataType : "json",
				success : function(data) {
					alert("가입완료");
					alert("메세지:"+data.success);
				},
				error : function(thrownError) {
					console.log(thrownError);
				},
				beforeSend : function(xhr) {
					if(idCheckResult) {
						let info, inputId;
						
						$j(":input").each(function(index) {
							info = $j(this);
							
							if(info.prop("required")) {
								if(!info.val()?.trim()) {
									inputId = $j(`label[for=\${info.attr('id')}]`).text().trim();
									
									alert(`\${inputId} 값을 입력해주세요.`);
									
									xhr.abort();
									return false; 
								}
							}
						});
					} else {
						alert("아이디 중복확인을 해주세요.");
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
								<label for="userId">
									id
								</label>
							</td>
							<td width="420" align="left">
								<input type="text" id="userId" name="userId" style="width: 140px;" required>
								<input type="button" id="idCheck" value="중복확인">
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="userPw">
									pw
								</label>
							</td>
							<td align="left">
								<input type="password" id="userPw" name="userPw" required>
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="pwCheck">
									pw check
								</label>
							</td>
							<td align="left">
								<input type="password" id="pwCheck" required>
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="userName">
									name
								</label>
							</td>
							<td align="left">
								<input type="text" id="userName" name="userName" required>
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="userPhone2">
									phone
								</label>
							</td>
							<td align="left">
								<select name="userPhone1">
									<c:forEach items="${typeList}" var="type">
										<option value="${type.codeId}" 
										<c:if test ="${type.codeId eq '1'}">selected="selected"</c:if>>
										${type.codeName}
										</option>
									</c:forEach>
								</select>
								-
								<input type="text" id="userPhone2" name="userPhone2" style="width: 50px;" required>
								-
								<input type="text" id="userPhone2" name="userPhone3" style="width: 50px;" required>
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="userAddr1">
									postNo
								</label>
							</td>
							<td align="left">
								<input type="text" id="userAddr1" name="userAddr1">
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="userAddr2">
									address
								</label>
							</td>
							<td align="left">
								<input type="text" id="userAddr2" name="userAddr2">
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="userCompany">
									company
								</label>
							</td>
							<td align="left">
								<input type="text" id="userCompany" name="userCompany">
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
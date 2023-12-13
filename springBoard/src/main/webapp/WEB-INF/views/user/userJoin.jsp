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
		
	사용자에게 형식을 제대로 지정해줄것
	제한을 두고 싶을 땐 그냥 막아버릴것
	알람을 어디에 사용할 지 잘 생각해볼것 
	조건절안에 조건절 사용 안 하는 게 좋음
	조건을 else if로 엮는게 좋은지 안 좋을지 생각해보기
--%>
	const pwCheckObj = {
		pwInputCheck : function() {
			const pwRegex = /^.{6,12}$/;
			let inputPw = $j("#userPw").val();
			
			if(!inputPw) {
				$j("#pwWarn2").css("display", "block");
				$j("#pwWarn1").css("display", "none");
				$j("#userPw").focus();
				
			} else if(!pwRegex.test($j("#userPw").val())) {
				$j("#pwWarn1").css("display", "block");
				$j("#pwWarn2").css("display", "none");
				$j("#userPw").focus();
				
			} else {
				$j("#pwWarn1").css("display", "none");
				$j("#pwWarn2").css("display", "none");
				return true;
			}
			
			return false;
		},
		
		pwCheck : function() {
			let inputPw = $j("#userPw").val();
			let checkPw = $j("#pwCheck").val();
			
			return (pwCheckObj.pwInputCheck() && inputPw == checkPw) ? true : false;
		}
			
	};
	
	function phoneCheck() {
		const phoneRegex = /^\d{4}$/;
		let phone2 = $j("#userPhone2").val();
		let phone3 = $j("input[name='userPhone3']").val()
		
		if(phone2 && !phoneRegex.test(phone2)) {
			$j("#phone2Warn").css("display", "block");
		} else if(phone3 && !phoneRegex.test(phone3)) {
			$j("#phone3Warn").css("display", "block");
		} else {
			$j("#phone2Warn").css("display", "none");
			$j("#phone3Warn").css("display", "none");
			return true;
		}
		
		return false;
	}
	
	$j(document).ready(function(){
		var idDuplCheckResult = false;
		var pwCheckResult = false;
		var nameCheckResult = false;
		var phoneCheckResult = false;
		var addrCheckResult = true;
		
		const addrRegex = /^\d{3}-\d{3}$/;
		
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
							idDuplCheckResult = true;
						} else {
							alert("중복된 아이디 입니다.");
							idDuplCheckResult = false;
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
		
		$j("#userPw").change(function() {
			if(!pwCheckObj.pwCheck()) {
				$j(this).focus();
				pwCheckResult = false;
			} else
				pwCheckResult = true;
		});
		
		$j("#pwCheck").change(function() {
			if(!pwCheckObj.pwCheck()) {
				$j(this).focus();
				pwCheckResult = false;
			} else
				pwCheckResult = true;
		});
		
		$j("#userName").change(function() {
			$j(this).val(($j(this).val().length > 5) ? $j(this).val().slice(0,5) : $j(this).val());
			
			if(/[^\uac00-\ud7a3]/.test($j(this).val())) {
				$j("#nameWarn").css("display", "block");
				nameCheckResult = false;
			} else {
				$j("#nameWarn").css("display", "none");
				nameCheckResult = true;
			}
		});
		
		$j("#userPhone2").change(function() {
			if(!phoneCheck()){
				$j(this).focus();
				phoneCheckResult = false;
			} else if($j("input[name='userPhone3']").val().length != 4) {
				phoneCheckResult = false;
			} else {
				phoneCheckResult = true;
			}
			
		});
		
		$j("input[name='userPhone3']").change(function() {
			if(!phoneCheck()){
				$j(this).focus();
				phoneCheckResult = false;
			} else if($j("#userPhone2").val().length != 4) {
				phoneCheckResult = false;
			} else {
				phoneCheckResult = true;
			}
		})
		
		$j("#userAddr1").change(function() {
			if($j(this).val() && !addrRegex.test($j(this).val())){
				$j("#addr1Warn").css("display", "block");
				addrCheckResult = false;
				$j(this).focus();
			} else {
				$j("#addr1Warn").css("display", "none");
				addrCheckResult = true;
			}
		}).on("keypress", function() {
			if($j(this).val().length == 3) {
				$j(this).val($j(this).val().concat("-"));
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
					location.href="/user/userLogin.do";
				},
				error : function(thrownError) {
					console.log(thrownError);
				},
				beforeSend : function(xhr) {
					if(!idDuplCheckResult) {
						
						if(!$j("#userId").val()?.trim()) {
							alert("아이디를 입력해주세요.");
							$j("#userId").focus();
							xhr.abort();
							return;
						} 
						
						alert("아이디 중복확인을 해주세요.")
						$j("#userId").focus();
						xhr.abort();
						return;
						
					} 
					
					if(!pwCheckResult) {
						
						if(!$j("#userPw").val()?.trim()) {
							$j("#userPw").focus();
							alert("비밀번호를 입력해주세요.");
							
						} else if(!pwCheckObj.pwInputCheck()) {
							$j("#userPw").focus();
							alert("비밀번호를 확인해주세요.");
							
						} else if(!$j("#pwCheck").val()?.trim()) {
							$j("#pwCheck").focus();
							alert("비밀번호확인을 입력해주세요.");
						} else {
							$j("#pwCheck").focus();
							alert("비밀번호가 일치하지 않습니다.");
						}
						
						xhr.abort();
						return;
					} 
					
					if(!nameCheckResult) {
						
						alert("이름을 입력해주세요.");
						$j("#userName").focus();
						xhr.abort();
						return;
					} 
					
					if(!phoneCheckResult) {
						
						if($j("#userPhone2").val().length < 4) {
							alert("휴대전화번호 가운데 4자리를 입력해주세요.");
							$j("#userPhone2").focus();
						} else {
							alert("휴대전화번호 마지막 4자리를 입력해주세요.");
							$j("input[name='userPhone3']").focus();
						}
						
						xhr.abort();
						return;
					} 
					
					if(!addrCheckResult) {
						
						alert("우편번호를 확인해주세요.");
						$j("#userAddr1").focus();
						xhr.abort();
						return;
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
				<td style="height:285px; vertical-align: top;">
					<table id="boardTable" border = "1" >
						<tr>
							<td width="120" align="center">
								<label for="userId">
									id
								</label>
							</td>
							<td width="420" align="left">
								<input type="text" id="userId" name="userId" maxlength="15" 
								oninput="this.value = this.value.replace(/\W/g, '')"
								style="width: 140px;" required>
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
								<div id="pwWarn1" style="font-size:12px; display:none;">비밀번호: 6~12자 이내로 사용해 주세요</div>
								<div id="pwWarn2" style="font-size:12px; display:none;">비밀번호: 비밀번호를 입력해주세요.</div>
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
								<div id="pwCheckWarn" style="font-size:12px; display:none;"></div>
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="userName">
									name
								</label>
							</td>
							<td align="left">
								<input type="text" id="userName" name="userName"
								oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3]/, '')"
								required>
								<div id="nameWarn" style="font-size:12px; display:none;">이름: 이름을 입력해주세요.</div>
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
								<input type="text" id="userPhone2" name="userPhone2" maxlength="4"
								oninput="this.value = this.value.replace(/[^0-9]/g, '')"
								style="width: 50px;" required>
								-
								<input type="text" name="userPhone3" maxlength="4"
								oninput="this.value = this.value.replace(/[^0-9]/g, '')"
								style=" width: 50px;" required>
								<div id="phone2Warn" style="font-size:12px; display:none;">휴대전화번호: 가운데 4자리를 입력해주세요.</div>
								<div id="phone3Warn" style="font-size:12px; display:none;">휴대전화번호: 마지막 4자리를 입력해주세요.</div>
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="userAddr1">
									postNo
								</label>
							</td>
							<td align="left">
								<input type="text" id="userAddr1" name="userAddr1" maxlength="7"
								oninput="this.value = this.value.replace(/[^0-9-]/g, '')">
								<div id="addr1Warn" style="font-size:12px; display:none;">우편번호: xxx-xxx형식으로 입력해주세요.</div>
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="userAddr2">
									address
								</label>
							</td>
							<td align="left">
								<input type="text" id="userAddr2" name="userAddr2" maxlength="50">
							</td>
						</tr>
						<tr>
							<td align="center">
								<label for="userCompany">
									company
								</label>
							</td>
							<td align="left">
								<input type="text" id="userCompany" name="userCompany" maxlength="20">
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
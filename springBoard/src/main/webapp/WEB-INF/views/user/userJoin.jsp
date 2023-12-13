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
	ȸ������ ���
	1. ���̵� �ߺ�Ȯ�� o
	2. ��ȿ�� �˻�  
		2-1. �ʼ��� ���̵�, ��й�ȣ, ��й�ȣ Ȯ��, �̸�, �޴��� ��ȣ
		2-2. �޴����� �����ȣ ���� Ȯ��
			- �޴��� ���� : xxx-xxxx-xxxx
			- �����ȣ ���� : xxx-xxx 
		2-3. ��й�ȣ�� ��й�ȣ Ȯ�� ��ġ
		
	����ڿ��� ������ ����� �������ٰ�
	������ �ΰ� ���� �� �׳� ���ƹ�����
	�˶��� ��� ����� �� �� �����غ��� 
	�������ȿ� ������ ��� �� �ϴ� �� ����
	������ else if�� ���°� ������ �� ������ �����غ���
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
							alert("��� ������ ���̵� �Դϴ�.");
							idDuplCheckResult = true;
						} else {
							alert("�ߺ��� ���̵� �Դϴ�.");
							idDuplCheckResult = false;
						}
					},
					error : function(thrownError) {
						console.log(thrownError);
					}
				});
			} else {
				alert("���̵� �Է����ּ���.");
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
					alert("���ԿϷ�");
					alert("�޼���:"+data.success);
					location.href="/user/userLogin.do";
				},
				error : function(thrownError) {
					console.log(thrownError);
				},
				beforeSend : function(xhr) {
					if(!idDuplCheckResult) {
						
						if(!$j("#userId").val()?.trim()) {
							alert("���̵� �Է����ּ���.");
							$j("#userId").focus();
							xhr.abort();
							return;
						} 
						
						alert("���̵� �ߺ�Ȯ���� ���ּ���.")
						$j("#userId").focus();
						xhr.abort();
						return;
						
					} 
					
					if(!pwCheckResult) {
						
						if(!$j("#userPw").val()?.trim()) {
							$j("#userPw").focus();
							alert("��й�ȣ�� �Է����ּ���.");
							
						} else if(!pwCheckObj.pwInputCheck()) {
							$j("#userPw").focus();
							alert("��й�ȣ�� Ȯ�����ּ���.");
							
						} else if(!$j("#pwCheck").val()?.trim()) {
							$j("#pwCheck").focus();
							alert("��й�ȣȮ���� �Է����ּ���.");
						} else {
							$j("#pwCheck").focus();
							alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
						}
						
						xhr.abort();
						return;
					} 
					
					if(!nameCheckResult) {
						
						alert("�̸��� �Է����ּ���.");
						$j("#userName").focus();
						xhr.abort();
						return;
					} 
					
					if(!phoneCheckResult) {
						
						if($j("#userPhone2").val().length < 4) {
							alert("�޴���ȭ��ȣ ��� 4�ڸ��� �Է����ּ���.");
							$j("#userPhone2").focus();
						} else {
							alert("�޴���ȭ��ȣ ������ 4�ڸ��� �Է����ּ���.");
							$j("input[name='userPhone3']").focus();
						}
						
						xhr.abort();
						return;
					} 
					
					if(!addrCheckResult) {
						
						alert("�����ȣ�� Ȯ�����ּ���.");
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
								<input type="button" id="idCheck" value="�ߺ�Ȯ��">
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
								<div id="pwWarn1" style="font-size:12px; display:none;">��й�ȣ: 6~12�� �̳��� ����� �ּ���</div>
								<div id="pwWarn2" style="font-size:12px; display:none;">��й�ȣ: ��й�ȣ�� �Է����ּ���.</div>
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
								oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3]/, '')"
								required>
								<div id="nameWarn" style="font-size:12px; display:none;">�̸�: �̸��� �Է����ּ���.</div>
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
								<div id="phone2Warn" style="font-size:12px; display:none;">�޴���ȭ��ȣ: ��� 4�ڸ��� �Է����ּ���.</div>
								<div id="phone3Warn" style="font-size:12px; display:none;">�޴���ȭ��ȣ: ������ 4�ڸ��� �Է����ּ���.</div>
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
								<div id="addr1Warn" style="font-size:12px; display:none;">�����ȣ: xxx-xxx�������� �Է����ּ���.</div>
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
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
--%>
	function pwCheck() {
		let inputPw = $j("#userPw").val();
		let checkPw = $j("#pwCheck").val();
		let result;
		
		if(inputPw == checkPw) {
			alert("��й�ȣ�� ��ġ�մϴ�.");
			result = false;
		} else {
			alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
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
				alert("��й�ȣ�� 6~12�ڸ��� �Է����ּ���.");
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
				alert("�ڵ��ȣ ��� 4�ڸ��� �Է����ּ���.")
				$j(this).focus();
			}
		});
		
		$j("input[name='userPhone3']").change(function() {
			if($j(this).val() && !phoneRegex.test($j(this).val())) {
				alert("�ڵ��ȣ ������ 4�ڸ��� �Է����ּ���.")
				$j(this).focus();
			}
		})
		
		$j("#userAddr1").change(function() {
			console.log(addrRegex.test($j(this).val()));
			if($j(this).val() && !addrRegex.test($j(this).val())){
				alert("xxx-xxx�������� �ۻ����ּ���");
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
							alert("��� ������ ���̵� �Դϴ�.");
							idCheckResult = true;
						} else {
							alert("�ߺ��� ���̵� �Դϴ�.");
							idCheckResult = false;
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
									
									alert(`\${inputId} ���� �Է����ּ���.`);
									
									xhr.abort();
									return false; 
								}
							}
						});
					} else {
						alert("���̵� �ߺ�Ȯ���� ���ּ���.");
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
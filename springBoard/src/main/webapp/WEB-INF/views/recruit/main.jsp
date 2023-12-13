<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/recruit/recruit.css"/>">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>main</title>
</head>
<script type="text/javascript">
	$j.fn.serializeObject = function() {
		var result = [];
		var obj = null;
		
		try {
			var arr = this.serializeArray();
			
			if(arr) {
				obj = {};
				$j.each(arr, function(index) {
					obj[this.name] = this.value;
				});
				result.push(Object.assign({}, obj));
			}
		} catch (e) {
			alert(e.message);
		}
		return result;
	}

	var rowAdd = function(category) {
		let rowHTML = $j(`#\${category}Table tbody tr:first`).clone();
		$j(rowHTML).find(`input[name^=\${category}]`).each(function() {
			$j(this).removeAttr("value");
		});
		
		$j(rowHTML).find(`input:checkbox`).removeAttr("value");
		
		$j(`#\${category}Table tbody`).append("<tr>"+$j(rowHTML).html()+"</tr>");
	}
	
	var rowSub = function(category) {
		let checkBox = $j(`#\${category}Table tbody input:checkbox`);
		let checkSeq = {
							"edu" : []
							,"car" : []
							,"cert" : []};
		let removeList = [];
		
		checkBox.each(function() {
			if($j(this).is(":checked")) {
				removeList.push($j(this).closest("tr"));
				checkSeq[category].push($j(this).val());
			}
		});
		
		if(removeList.length == checkBox.length) {
			alert("�ּ� �� �� �̻��� ���� �����ּ���");
			return;
		}
		
		if(confirm("�����Ͻðڽ��ϱ�?")) {
			$j.each(removeList, function() {
				$j(this).remove();
			});
			
			console.log(checkSeq[category]);
			if(checkSeq[category].includes("on")) return;
			
			$j.ajax({
				url : "/recruit/delete",
				type : "POST",
				data : JSON.stringify(checkSeq),
				dataType : "json",
				contentType : "application/json",
				success : function(data) {
					if(data.success == "N")
						alert("���� ����");
				}
			});
		}
	}
	
	var emptyWarn = function(data) {
		let result = false;
		
		if(!$j(`#\${data}`).val()?.trim()) {
			alert($j(`label[for=\${$j(`#\${data}`).attr('id')}]`).text().trim()
					+"�� �Է����ּ���.");
			$j(`#\${data}`).focus();
			result = true;
		}
		return result;
	}
	
	var checkFunc = {
			stringCheck : function(data) {
				const nameRegex = /[^\uac00-\ud7a3]/g;
				const stringRegex = /[^\uac00-\ud7a3\w\-\/\s]/g;
				if(emptyWarn(data)) return false;
				
				if(data == "recName") {
					if(nameRegex.test($j(`#\${data}`).val())) {
						alert($j(`label[for=\${$j(`#\${data}`).attr('id')}]`).text().trim()
						+"�� �Է����ּ���.");
						$j(`#\${data}`).focus();
						return false;
					}
					return true;
				}
				
				if(stringRegex.test($j(`#\${data}`).val())) {
					alert($j(`label[for=\${$j(`#\${data}`).attr('id')}]`).text().trim()
					+"�� �Է����ּ���.");
					$j(`#\${data}`).focus();
					return false;
				}
				return true;
			},
			
			dateCheck : function(data) {
				const birthRegex = /^\d{4}\.\d{2}\.\d{2}$/;
				const dateRegex = /^\d{4}\.\d{2}\$/;
				if(emptyWarn(data)) return false;
				
				if(data == "recBirth") {
					if(!birthRegex.test($j(`#\${data}`).val())) {
						alert($j(`label[for=\${$j(`#\${data}`).attr('id')}]`).text().trim()
						+"�� xxxx.xx.xx �������� �Է����ּ���.");
						$j(`#\${data}`).focus();
						return false;
					}
					return true;
				}
				
				if(!dateRegex.test($j(`#\${data}`).val())) {
					alert($j(`label[for=\${$j(`#\${data}`).attr('id')}]`).text().trim()
					+"�� xxxx.xx �������� �Է����ּ���.");
					$j(`#\${data}`).focus();
					return false;
				}
				return true;
				
			},
			
			phoneCheck : function(data) {
				const phoneRegex = /^01([0|1|6|7|8|9])-?\d{3,4}-?\d{4}$/;
				if(emptyWarn(data)) return false;
				
				if(!phoneRegex.test($j(`#\${data}`).val())) {
					alert($j(`label[for=\${$j(`#\${data}`).attr('id')}]`).text().trim()
					+"�� �Է����ּ���.");
					$j(`#\${data}`).focus();
					return false;
				}
				return true;
			},
			
			gradeCheck : function(data) {
				const gradeRegex = /^\d{1}\.\d{1}$/;
				if(emptyWarn(data)) return false;
				
				if(!gradeRegex.test($j(`#\${data}`).val())) {
					alert($j(`label[for=\${$j(`#\${data}`).attr('id')}]`).text().trim()
					+"�� x.x �������� �Է����ּ���.");	
					$j(`#\${data}`).focus();
					return false;
				}
				return true;
			},
			
			taskCheck : function(data) {
				const taskRegex = /[^\uac00-\ud7a3\/\w]/g;
				if(emptyWarn(data)) return false;
				
				if(taskRegex.test($j(`#\${data}`).val())) {
					alert($j(`label[for=\${$j(`#\${data}`).attr('id')}]`).text().trim()
					+"�� �μ�/��å/���� ���·� �Է����ּ���.");
					$j(`#\${data}`).focus();
					return false;
				}
				return true;
			},
			
			emailCheck : function(data) {
				const emailRegex = /^\w*@\w*\.\w*$/;
				if(emptyWarn(data)) return false;
				
				if(!emailRegex.test($j(`#\${data}`).val())) {
					alert($j(`label[for=\${$j(`#\${data}`).attr('id')}]`).text().trim()
					+"�� xxx@xxx.xxx �������� �Է����ּ���.");
					$j(`#\${data}`).focus();
					return false;
				}
				return true;
			}
			
	}
	
	var validation = function(data) {
		let result = true;
		let idList = [];
		let testList = [];
		
		$j.each(data, function(index) {
			idList.push($j(this).attr('id'));
			testList.push($j(this).attr('id').match(/[A-Z]\w*/)[0]);
		});
		
		$j.each(idList, function(index) {
			switch(testList[index]) {
				case "Name": case "School": case "Major":
				case "Addr": case "Company": case "Loc":
				case "Qualifi": case "Organize":
					if(checkFunc.stringCheck(this)) break;
					result = false;
					break;
				case "Birth": case "Start": case "End": 
				case "Acqu":
					if(checkFunc.dateCheck(this)) break;
					result = false;
					break;
				case "Phone":
					if(checkFunc.phoneCheck(this)) break;
					result = false;
					break;
				case "Email":
					if(checkFunc.emailCheck(this)) break;
					result = false;
					break;
				case "Grade":
					if(checkFunc.gradeCheck(this)) break;
					result = false;
					break;
				case "Task":
					if(checkFunc.taskCheck(this)) break;
					result = false;
					break;
				default :
					console.log(testList[index]);
					result = false;
			}
			
			if(result == false) return false;
			
		});
		
		return result;
	}
	
	var sendData = function(type) {
		var requiredData = $j("input[required]");
		
		if(!validation(requiredData)) return;
		
		
		var recData = $j("input[name^='rec'], select[name^='rec']").serializeObject();
		var eduData = $j("input[name^='edu'], select[name^='edu']").serializeObject();
		var carData = $j("input[name^='car']").serializeObject();
		var certData = $j("input[name^='cert']").serializeObject();
		
		if(Object.values(carData[0]).find((el) => !!el?.trim()))
			if(!validation($j("input[name^='car']"))) return
			
		if(Object.values(certData[0]).find((el) => !!el?.trim()))
			if(!validation($j("input[name^='cert']"))) return
			
		$j.ajax({
			url : `/recruit/\${type}`,
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify({
					"recData" : recData,
					"eduData" : eduData,
					"carData" : carData,
					"certData" : certData
				})
			,
			dataType : "json",
			success : function(data) {
				console.log(data.success);
				switch (data.success) {
				case "Y":
					alert("���� �Ϸ�");
					location.href="/recruit/login";
					break;
					
				case "N":
					alert("���� ����");
					break;
					
				case "S":
					alert("���� �� ������ �Ұ����մϴ�.");
					location.href="/recruit/login";
					break;

				default:
					alert("���� ����");
					break;
				}
				
			},
			error : function() {
				alert("���� ����");
			}
		})
	}

	$j(document).ready(function() {
		
		$j("#save").on("click", function() {
			sendData("save");
		});
		
		$j("#submit").on("click", function() {
			if(confirm("���� �� ������ �Ұ����մϴ�. �����Ͻðڽ��ϱ�?"))
				sendData("submit");
		});
		
		$j("#addEdu").on("click", function() {
			rowAdd("edu");
		});
		
		$j("#addCar").on("click", function() {
			rowAdd("car");
		});
		
		$j("#addCert").on("click", function() {
			rowAdd("cert");
		});
		
		$j("#subEdu").on("click", function() {
			rowSub("edu");
		});
		
		$j("#subCar").on("click", function() {
			rowSub("car");
		});
		
		$j("#subCert").on("click", function() {
			rowSub("cert");
		});
	});
	
</script>
<body>
	<div class="container">
		<form class="main" >
			<h1>�Ի� ������</h1>
			<div class="tableBox">
				<table border="1">
					<tr>
						<th class="name">
							<label for="recName">
								�̸�
							</label>
						</th>
						<td class="birth">
							<input type="text" id="recName" name="recName" width="150" maxlength="5"
							value="${userInfo.recName}" 
							oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3]/, '')"
							required>
						</td>
						<th>
							<label for="recBirth">
								�������
							</label>
						</th>
						<td>
							<input type="text" id="recBirth" name="recBirth"  maxlength="10"
							oninput="this.value = this.value.replace(/[^\d\.]/, '')"
							value="${userInfo.recBirth}" required>
						</td>
					</tr>
					<tr>
						<th>
							<label for="recGender">
								����
							</label>
						</th>
						<td>
							<select id="recGender" name="recGender" required>
								<option value="m" 
								<c:if test="${userInfo.recGender eq 'm' 
								|| empty userInfo.recGender}">selected='selected'</c:if>>
								����</option>
								
								<option value="fm" 
								<c:if test="${userInfo.recGender eq 'fm'}">selected='selected'</c:if>>
								����</option>
							</select>
						</td>
						<th>
							<label for="recPhone">
								����ó
							</label>
						</th>
						<td>
							<input type="text" id="recPhone" name="recPhone"  maxlength="11"
							value="${userInfo.recPhone}"
							oninput="this.value = this.value.replace(/[^\d]/, '')"
							required>
						</td>
					</tr>
					<tr>
						<th>
							<label for="recEmail">
								email
							</label>
						</th>
						<td>
							<input type="text" id="recEmail" name="recEmail"  maxlength="50"
							value="${userInfo.recEmail}"
							oninput="this.value = this.value.replace(/[^\@\.\w]/g, '')"
							required>
						</td>
						<th>
							<label for="recAddr">
								�ּ�
							</label>
						</th>
						<td>
							<input type="text" id="recAddr" name="recAddr"  maxlength="50"
							value="${userInfo.recAddr}"
							oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\d\-\s]/, '')"
							required>
						</td>
					</tr>
					<tr>
						<th>
							<label for="recLoc">
								����ٹ���
							</label>
						</th>
						<td>
							<select id="recLoc" name="recLoc" required>
								<c:forEach items="${location}" var="loc">
									<option value="${loc.codeId}" 
									<c:if test="${userInfo.recLoc eq loc.codeId 
									|| loc.codeName eq '����'}">selected='selected'</c:if>>
									${loc.codeName}</option>
								</c:forEach>
							</select>
						</td>
						<th>
							<label for="recWt">
								�ٹ�����
							</label>
						</th>
						<td>
							<select id="recWt" name="recWt" required>
								<option value="������"
								<c:if test="${userInfo.recWt eq '������' 
								|| empty userInfo.recWt}">selected='selected'</c:if>>
								������</option>
								<option value="�����"
								<c:if test="${userInfo.recWt eq '�����'}">selected='selected'</c:if>>
								�����</option>
							</select>
						</td>
					</tr>
				</table>
				
				<table border="1" <c:if test="${not empty userInfo.recSubmit}">style="display: table"</c:if>>
					<thead>
						<tr>
							<th>�з»���</th>
							<th>��»���</th>
							<th>�������</th>
							<th>����ٹ���/�ٹ�����</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td></td>
							<td></td>
							<td>ȸ�系�Կ� ����</td>
							<td></td>
						</tr>
					</tbody>
				</table>
				
				<h2 class="category">�з�</h2>
				<div id="eduBtn">
					<button type="button" id="addEdu">�߰�</button>
					<button type="button" id="subEdu">����</button>
				</div>
				<table border="1" id="eduTable">
					<thead>
						<tr>
							<th></th>
							<th>
								<label for="eduStart">���бⰣ</label>
								<label for="eduEnd" class="hiddenLabel">���бⰣ</label>
							</th>
							<th>
								<label for="eduDiv">����</label>
							</th>
							<th>
								<label for="eduSchool">�б���(������)</label>
							</th>
							<th>
								<label for="eduMajor">����</label>
							</th>
							<th>
								<label for="eduGrade">����</label>
							</th>
						</tr>
					</thead>
					<c:choose>
					<c:when test="${not empty eduList}">
						<c:forEach items="${eduList}" var="edu">
						<tbody>
							<tr>
								<td>
									<input type="checkbox" value="${edu.eduSeq}">
								</td>
								<td>
									<input type="text" id="eduStart" name="eduStart"  maxlength="7"
									value="${edu.eduStart}" 
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									required>
									~
									<input type="text" id="eduEnd" name="eduEnd"  maxlength="7"
									value="${edu.eduEnd}" 
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									required>
								</td>
								<td>
									<select id="eduDiv" name="eduDiv" required>
										<option value="����"
										<c:if test="${edu.eduDiv eq '����'}">selected='selected'</c:if>>����</option>
										<option value="����"
										<c:if test="${edu.eduDiv eq '����'}">selected='selected'</c:if>>����</option>
										<option value="����"
										<c:if test="${edu.eduDiv eq '����' || empty edu.eduDiv}">selected='selected'</c:if>>����</option>
									</select>
								</td>
								<td>
									<input type="text" id="eduSchool" name="eduSchool"  maxlength="50"
									value = "${edu.eduSchool}"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\s]/, '')"
									required>
									<select id="eduLoc" name="eduLoc" required>
										<c:forEach items="${location}" var="loc">
										<option value="${loc.codeId}" 
										<c:if test="${edu.eduLoc eq loc.codeId 
										|| loc.codeName eq '����'}">selected='selected'</c:if>>
										${loc.codeName}</option>
									</c:forEach>
									</select>
								</td>
								<td>
									<input type="text" id="eduMajor" name="eduMajor"  maxlength="30"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\s]/, '')"
									value="${edu.eduMajor}" required>
								</td>
								<td>
									<input type="text"
									id="eduGrade" name="eduGrade" value="${edu.eduGrade}"  maxlength="3"
									oninput="this.value = this.value.replace(/[^\d\.]/, '').replace(/(\..*)\./g, '$1')"
									required
									>
								</td>
							</tr>
						</tbody>
					</c:forEach>
					</c:when>
					<c:otherwise>
						<tbody>
							<tr>
								<td>
									<input type="checkbox">
								</td>
								<td>
									<input type="text" id="eduStart" name="eduStart"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									required>
									~
									<input type="text" id="eduEnd" name="eduEnd"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									required>
								</td>
								<td>
									<select id="eduDiv" name="eduDiv" required>
										<option value="����"
										>����</option>
										<option value="����"
										>����</option>
										<option value="����"
										selected='selected'>����</option>
									</select>
								</td>
								<td>
									<input type="text" id="eduSchool" name="eduSchool"  maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\s]/, '')"
									required>
									<select id="eduLoc" name="eduLoc" required>
										<c:forEach items="${location}" var="loc">
										<option value="${loc.codeId}" 
										<c:if test="${edu.eduLoc eq loc.codeId 
										|| loc.codeName eq '����'}">selected='selected'</c:if>>
										${loc.codeName}</option>
									</c:forEach>
									</select>
								</td>
								<td>
									<input type="text" id="eduMajor" name="eduMajor"  maxlength="30"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\s]/, '')"
									required>
								</td>
								<td>
									<input type="text"
									id="eduGrade" name="eduGrade" maxlength="3"
									oninput="this.value = this.value.replace(/[^\d\.]/, '').replace(/(\..*)\./g, '$1')"
									required
									>
								</td>
							</tr>
						</tbody>
					</c:otherwise>
					</c:choose>
					
				</table>
				
				<h2 class="category">���</h2>
				<div id="carBtn">
					<button type="button" id="addCar">�߰�</button>
					<button type="button" id="subCar">����</button>
				</div>
				<table border="1" id="carTable">
					<thead>
						<tr>
							<th></th>
							<th>
								<label for="carStart">�ٹ��Ⱓ</label>
								<label for="carEnd" class="hiddenLabel">�ٹ��Ⱓ</label>
							</th>
							<th>
								<label for="carCompany">ȸ���</label>
							</th>
							<th>
								<label for="carTask">�μ�/��å/����</label>
							</th>
							<th>
								<label for="carLoc">����</label>
							</th>
						</tr>
					</thead>
					<c:choose>
					<c:when test="${not empty carList}">
					<c:forEach items="${carList}" var="car">
						<tbody>
							<tr>
								<td>
									<input type="checkbox" value="${car.carSeq}">
								</td>
								<td>
									<input type="text" id="carStart" name="carStart"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d.]/, '')"
									value="${car.carStart}">
									-
									<input type="text" id="carEnd" name="carEnd"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d.]/, '')"
									value="${car.carEnd}">
								</td>
								<td>
									<input type="text" id="carCompany" name="carCompany"  maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\d\s]/, '')"
									value="${car.carCompany}">
								</td>
								<td>
									<input type="text" id="carTask" name="carTask" maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\/\w]/, '')"
									 value="${car.carTask}">
								</td>
								<td>
									<input type="text" id="carLoc" name="carLoc"  maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\d\-\s]/, '')"
									value="${car.carLoc}">
								</td>
							</tr>
						</tbody>
					</c:forEach>
					</c:when>
					<c:otherwise>
						<tbody>
							<tr>
								<td>
									<input type="checkbox">
								</td>
								<td>
									<input type="text" id="carStart" name="carStart"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d.]/, '')"
									>
									-
									<input type="text" id="carEnd" name="carEnd"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d.]/, '')"
									>
								</td>
								<td>
									<input type="text" id="carCompany" name="carCompany"  maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\d\s]/, '')"
									>
								</td>
								<td>
									<input type="text" id="carTask" name="carTask" maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\/\w]/, '')"
									 >
								</td>
								<td>
									<input type="text" id="carLoc" name="carLoc"  maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\d\-\s]/, '')"
									>
								</td>
							</tr>
						</tbody>
					</c:otherwise>
					</c:choose>
				</table>
				
				<h2 class="category">�ڰ���</h2>
				<div id="certBtn">
					<button type="button" id="addCert">�߰�</button>
					<button type="button" id="subCert">����</button>
				</div>
				<table border="1" id="certTable">
					<thead>
						<tr>
							<th></th>
							<th>
								<label for="certQualifi">�ڰ�����</label>
							</th>
							<th>
								<label for="certAcqu">�����</label>
							</th>
							<th>
								<label for="certOrganize">����ó</label>
							</th>
						</tr>
					</thead>
					<c:choose>
					<c:when test="${not empty certList}">
					<c:forEach items="${certList}" var="cert">
						<tbody>
							<tr>
								<td>
									<input type="checkbox" value="${cert.certSeq}">
								</td>
								<td>
									<input type="text" id="certQualifi" name="certQualifi"  maxlength="30"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\w\s]/, '')"
									value="${cert.certQualifi}">
								</td>
								<td>
									<input type="text" id="certAcqu" name="certAcqu"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									value="${cert.certAcqu}">
								</td>
								<td>
									<input type="text" id="certOrganize" name="certOrganize"  maxlength="30"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\w\s]/, '')"
									 value="${cert.certOrganize}">
								</td>
							</tr>
						</tbody>
					</c:forEach>
					</c:when>
					<c:otherwise>
						<tbody>
							<tr>
								<td>
									<input type="checkbox">
								</td>
								<td>
									<input type="text" id="certQualifi" name="certQualifi"  maxlength="30"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\w\s]/, '')"
									>
								</td>
								<td>
									<input type="text" id="certAcqu" name="certAcqu"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									>
								</td>
								<td>
									<input type="text" id="certOrganize" name="certOrganize"  maxlength="30"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\w\s]/, '')"
									>
								</td>
							</tr>
						</tbody>
					</c:otherwise>
					</c:choose>
				</table>
			</div>
			<div id="svsbBtn">
				<button type="button" id="save">����</button>
				<button type="button" id="submit">����</button>
			</div>
		</form>
	</div>
</body>
</html>
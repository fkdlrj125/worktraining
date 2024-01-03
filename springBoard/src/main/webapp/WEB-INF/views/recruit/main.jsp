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
/*
 * 1�� �ǵ��
 * �̸��� ����ó�� �������� x
 * ������ϰ� �ٸ� �Ⱓ���� �� x
 * �б�, ����, ȸ���, �μ�/��å/����, �ڰ�����, ����ó�� ��� ���� ��� x
 * �˶�â�� ���� �˷��ֱ�(�ּ�, �б���, ����) x
 * �� ���� ���� ���� �ذ� x
 *	- �⺻������ ��� ���� �߰����ִ��� 
 *	- ���ƹ�����
 	-> ���ƹ������ �ذ�(����ȭ �� ���� ���� �� �ִٸ� ����)
 * ������ �Ҽ����� �������� x
 	-> ����ǥ���� ����
 * ����̶� �ڰ����� �ٸ� ���� ���� �� �� �� üũ x
 	-> �� ������ ��� input�� ���� ������ �˻�
 * 2�� �ǵ��
 * �Է»��� �ֱ� ��¥ ������ ����(�ذ�)
 	-> ��ȸ�ϴ� �� ���� ���� ������ order by ���
 * �ٹ��Ⱓ ��� Ȯ��(�ذ�)
 	-> ������ ���� �Ⱓ ���� 1 ����
 * �Ⱓ�Է��� �� '.' ������ �� ����(�ذ�)
 	-> ����ǥ���İ� includes�� ���
 * �� �ϳ� ������ �� ���� ����(�ذ�)
 	-> ���� �ڵ忡�� edu�� ���� ���� ���� ����
 * �μ�/��å/���� ��Ʈ ����(�ذ�)
 * 3�� �ǵ��
 * ��¿� �ٹ��Ⱓ ������ �������� ������ ������������(�ذ�)
 * �ڰ��� ����� ����(�ذ�)
 * ���� �� input�� �ƴ϶� �׳� �ؽ�Ʈ��(�ذ�)
   ��ư�̳� ����Ʈ�� �� ���̰�
 */
	$j.fn.serializeObject = function() {
		var result = [];
		var obj = null;
		
		var objInsert = function(obj) {
			let fullObj = true;
			
			$j.each(obj, function() {
				if(!this?.trim()) {
					fullObj = false;
					return false;
				}
			});
			
			if(fullObj) {
				result.push(Object.assign({}, obj));
			}
			
			return {};
		}
		
		try {
			var arr = this.serializeArray();

			if(arr) {
				obj = {};
				$j.each(arr, function(index) {
					obj.hasOwnProperty(this.name) ? obj = objInsert(obj) : "";
					obj[this.name] = this.value;
				});
				objInsert(obj);
			}
		} catch (e) {
			alert(e.message);
		}
		return result;
	}

	var rowAdd = function(category) {
		let copyRow = $j(`#\${category}Table tbody`).children("tr:eq(0)").clone();
		let rowLength = $j(`#\${category}Table tbody`).children().length;
		let copyId = "";
		
		$j(copyRow).find(`input[name^=\${category}], select[name^=\${category}]`).each(function() {
			$j(this).removeAttr("value");
			copyId = $j(this).attr("id").slice(0,-1);
			$j(this).attr("id", copyId+rowLength);
		});
		
		$j(copyRow).find(`input:checkbox`).removeAttr("value");
		
		$j(`#\${category}Table tbody`).append("<tr>"+$j(copyRow).html()+"</tr>");
	}
	
	var rowSub = function(category) {
		let checkBox = $j(`#\${category}Table tbody input:checkbox`);
		let checkSeq = {};
		let removeList = [];
		checkSeq[category] = [];

		checkBox.each(function() {
			if($j(this).is(":checked")) {
				removeList.push($j(this).closest("tr"));
				checkSeq[category].push($j(this).val());
			}
		});
		
		if(removeList.length == 0) {
			alert("�ּ� �� �� �̻��� ���� �������ּ���.");
			return;
		}
		
		if(confirm("�����Ͻðڽ��ϱ�?")) {
			if(removeList.length == checkBox.length) {
				alert("�ּ� �� ���� ���� �����ּ���");
				checkBox.prop("checked", false);
				return;
			}
			
			if(checkSeq[category].includes("on")) 
				checkSeq[category] = checkSeq[category].filter((val) => val !== "on");
			
			if(checkSeq[category].length == 0) {
				$j.each(removeList, function() {
					$j(this).remove();
				});
				return;
			}
			
			let promise = new Promise(function(resolve, reject) { 
				$j.ajax({
					url : "/recruit/delete",
					type : "POST",
					data : JSON.stringify(checkSeq),
					dataType : "json",
					contentType : "application/json",
					success : function(data) {
						switch (data.success) {
						case "Y":
							resolve();
							break;
							
						case "N":
							alert("���� ����");
							break;
							
						case "S":
							alert("���� �� ������ �Ұ����մϴ�.");
							break;

						default:
							alert("���� ����");
							break;
						}
					}
				});
			});
			
			promise
			.then(function() {
				$j.each(removeList, function() {
					$j(this).remove();
				});
			});
		}
	}
	
	var emptyWarn = function(data) {
		if(!$j(`#\${data}`).val()?.trim()) {
			alert($j(`label[for=\${$j(`#\${data}`).attr('id').slice(0,-1)+0}]`).text().trim()
					+"�� �Է����ּ���.");
			$j(`#\${data}`).focus();
			return true;
		}
		return false;
	}
	
	var checkFunc = function(idList, testList) {
		let now = new Date();
		let birth = new Date($j("#recBirth0").val()); 
		let result = true;
		let regex = {
			name : /[\uac00-\ud7a3]/,
			string	: /^[\uac00-\ud7a3\w][\uac00-\ud7a3\w\-\/\s]*/,
			birth	: /^\d{4}\.\d{2}\.\d{2}$/,
			birth2	: /^\d{4}\.(0[1-9]|1[012]).(0[1-9]|[12][0-9]|3[01])$/,
			phone	: /^(01[0|1|6|7|8|9])-?\d{3,4}-?\d{4}$/,
			email	: /^\w*@\w*\.\w*(\.\w*)?$/,
			addr	: /^([\uac00-\ud7a3\w]+[\uc2dc|\ub3c4|si|do])[\uac00-\ud7a3\d\-\/\s]+/,
			date	: /^\d{4}\.\d{2}\$/,
			date2	: /^\d{4}\.(0[1-9]|1[012])\$/,
			school	: /.+(\ud559\uad50|school|university)$/i,
			grade	: /^\d{1}(\.\d{1})?$/,
			task	: /[\uac00-\ud7a3\w]+\/[\uac00-\ud7a3\w]+\/[\uac00-\ud7a3\w]+/,
			
		}
		
		let comment = {
			name	: "�� �Է����ּ���.",
			string	: "��(��) �Է����ּ���.",
			birth	: "�� xxxx.xx.xx �������� �Է����ּ���.",
			birth2	: "�� ��(01-12) �Ǵ� ��(01-31)�� ��Ȯ�� �Է����ּ���.",
			phone	: "�� �Է����ּ���.",
			email	: "�� xxx@xxx.xxx �Ǵ� xxx@xxx.xx.xx �������� �Է����ּ���.",
			addr	: "�� �����õ� �ñ��� ���θ� (�ǹ�)��ȣ�������� �Է����ּ���.",
			date	: "�� xxxx.xx �������� �Է����ּ���.",
			date2	: "�� ��(01-12)�� ��Ȯ�� �Է����ּ���.",
			school	: "�� xxx�б�, xxx school, xxx university �������� �Է����ּ���.",
			grade	: "�� xxx �Ǵ� x.x �������� �Է����ּ���.",
			task	: "�� �Է����ּ���.",
		}
		
		let check = function(data, type) { 
			if(emptyWarn(data)) return false;
			
			switch(type) {
				case "birth": case "date":
					if(!regex[type].test($j(`#\${data}`).val())) {
						alert($j(`label[for=\${$j(`#\${data}`).attr('id').slice(0,-1)+0}]`).text().trim()
								+comment[type]);
						$j(`#\${data}`).focus();
						return false;
					}
					
					if(!regex[type+2].test($j(`#\${data}`).val())) {
						alert($j(`label[for=\${$j(`#\${data}`).attr('id').slice(0,-1)+0}]`).text().trim()
								+comment[type+2]);
						$j(`#\${data}`).focus();
						return false;
					}
					break;
					
				default:
					if(!regex[type].test($j(`#\${data}`).val())) {
						alert($j(`label[for=\${$j(`#\${data}`).attr('id').slice(0,-1)+0}]`).text().trim()
								+comment[type]);
						$j(`#\${data}`).focus();
						return false;
					}
			}				
			
			return true;
		}
		
		$j.each(idList, function(index) {
			switch(testList[index]) {
			 	case "School": 
			 		if(check(this, "school")) break;
					result = false;
					break;
					
				case "Addr": 
					if(check(this, "addr")) break;
					result = false;
					break;
					
				case "Major": case "Company": case "Loc": 
				case "Qualifi": case "Organize":
					if(check(this, "string")) break;
					result = false;
					break;
					
				case "Start":
					if(!check(this, "date")) {
						result = false;
						break;
					}
					
					if(!check(this.replace("Start", "End"), "date")) {
						result = false;
						break;
					}
					
					let start = new Date($j(`#\${this}`).val());
					let end = new Date($j(`#\${this.replace("Start", "End")}`).val())
					
					if(now < start) {
						alert("���� ��¥�� �Ѿ ��¥�Դϴ�. �ٽ� �Է����ּ���.");
						$j(`#\${this}`).focus();
						result = false;
						break;
					}
					
					if(start < birth) {
						alert("������� ���� ��¥�Դϴ�. �ٽ� �Է����ּ���.");
						$j(`#\${this}`).focus();
						result = false;
						break;
					}
					
					if(start > end) {
						alert("���۳�¥ ����¥ ������ �Է����ּ���.");
						$j(`#\${this}`).focus();
						result = false;
					}
					break;
					
				case "Acqu":
					let acqu = new Date($j(`#\${this}`).val());
					
					if(acqu < birth) {
						alert("������� ���� ��¥�Դϴ�. �ٽ� �Է����ּ���.");
						$j(`#\${this}`).focus();
						result = false;
						break;
					}
					
					if(check(this, "date")) break;
					result = false;
					break;
					
				case "Name":
					if(check(this, "name")) break;
					result = false;
					break;
					
				case "Birth":
					if(now < birth) {
						alert("���� ��¥�� �Ѿ ��¥�Դϴ�. �ٽ� �Է����ּ���.");
						$j("#recBirth0").focus();
						result = false;
						break;
					}
					
					if(check(this, "birth")) break;
					result = false;
					break;
					
				case "Phone":
					if(check(this, "phone")) break;
					result = false;
					break;
					
				case "Email":
					if(check(this, "email")) break;
					result = false;
					break;
					
				case "Grade":
					if(check(this, "grade")) break;
					result = false;
					break;
					
				case "Task":
					if(check(this, "task")) break;
					result = false;
					break;
			}
			
			if(!result) return result;
			
		});
		return result;
	}
	
	var validation = function(data) {
		let idList = [];
		let testList = [];
		let testObj = typeof(data) == "object" ? data : {};
		
		if(typeof(data) == "string") {
			$j.each($j(`table[id^='\${data}'] tbody tr`), function(index) {
				let row = $j(this).find("input:text");
				
				$j.each(row, function() {
					if(!!$j(this).val()?.trim()) {
						$j.each(row, function() {
							testObj[Object.keys(testObj).length] = this;
						});
						return false;
					}
				});
			});
		}
		
		if(Object.keys(testObj).length == 0) {
			return true;
		}
		
		$j.each(testObj, function(index) {
			idList.push($j(this).attr('id'));
			testList.push($j(this).attr('id').match(/[A-Z][a-z]*/)[0]);
		});
		
		return checkFunc(idList, testList);
	}
	
	var sendData = function(type) {
		var requiredData = $j("input[required]");
		let data = {};
		
		if(!validation(requiredData)) return;
		
		data["recData"] = $j("input[name^='rec'], select[name^='rec']").serializeObject();
		data["eduData"] = $j("input[name^='edu'], select[name^='edu']").serializeObject();
		
		if(!validation('car')) return;
		if(!validation('cert')) return;
			
		let carData = $j("input[name^='car']").serializeObject();
		let certData = $j("input[name^='cert']").serializeObject();
		
		if(carData.length != 0) data["carData"] = carData;
		if(certData.length != 0) data["certData"] = certData;
		
		$j.ajax({
			url : `/recruit/\${type}`,
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
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
		var userSubmit = '${userSubmit}';

		if(userSubmit == 'Y') {
			$j("button:not(#backBtn button)").addClass("hidden");
			$j("#backBtn").css("display", "block");
		}
		
		$j("#recBirth0").on("keypress", function(e) {
			if(e.keyCode != 46 && !(/^\d{1,4}\.\d{1,2}\.\d{1,2}$/.test($j(this).val()))) {
				$j(this).val().length == 4 ? $j(this).val($j(this).val() + ".") : "";
				$j(this).val().length == 7 ? $j(this).val($j(this).val() + ".") : "";
			}
		});
		
		$j(document).on("keypress", "input[name*=Start], input[name*=End], input[name*=Acqu]", function(e) {
			if(e.keyCode != 46 && !($j(this).val().includes('.'))) 
				$j(this).val().length == 4 ? $j(this).val($j(this).val() + ".") : "";
		});
		
		$j(document).on("keypress", "input[name*=Grade]", function(e) {
			if(e.keyCode != 46 && !($j(this).val().includes('.'))) 
				$j(this).val().length == 1 ? $j(this).val($j(this).val() + ".") : "";
		});
		
		$j("#save").on("click", function() {
			$j("input[type=checkbox]").prop("checked", true);
			sendData("save");
			$j("input[type=checkbox]").prop("checked", false);
		});
		
		$j("#submit").on("click", function() {
			if(confirm("���� �� ������ �Ұ����մϴ�. �����Ͻðڽ��ϱ�?")) {
				$j("input[type=checkbox]").prop("checked", true);
				sendData("submit");
				$j("input[type=checkbox]").prop("checked", false);
			}
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
				<table id="recTable" border="1">
					<c:choose>
					<c:when test="${userInfo.recSubmit eq 'Y'}">
						<tr>
							<th class="name">
								<label for="recName0">
									�̸�
								</label>
							</th>
							<td class="name">
								<div id="recName0">${userInfo.recName}</div>
							</td>
							<th>
								<label for="recBirth0">
									�������
								</label>
							</th>
							<td>
								<div id="recBirth0">${userInfo.recBirth}</div>
							</td>
						</tr>
						<tr>
							<th>
								<label for="recGender0">
									����
								</label>
							</th>
							<td>
								<div id="recGender0">
									<c:if test="${userInfo.recGender eq 'm'}">����</c:if>
									<c:if test="${userInfo.recGender eq 'fm'}">����</c:if>
								</div>
							</td>
							<th>
								<label for="recPhone0">
									����ó
								</label>
							</th>
							<td>
								<div id="recPhone0">${userInfo.recPhone}</div>
							</td>
						</tr>
						<tr>
							<th>
								<label for="recEmail0">
									email
								</label>
							</th>
							<td>
								<div id="recEmail0">${userInfo.recEmail}</div>
							</td>
							<th>
								<label for="recAddr0">
									�ּ�
								</label>
							</th>
							<td>
								<div id="recAddr0">${userInfo.recAddr}</div>
							</td>
						</tr>
						<tr>
							<th>
								<label for="recLoc0">
									����ٹ���
								</label>
							</th>
							<td>
								<div id="recLoc0"></div>
									<c:forEach items="${location}" var="loc">
										<c:if test="${userInfo.recLoc eq loc.codeId}">${loc.codeName}</c:if>
									</c:forEach>
								</div>
							</td>
							<th>
								<label for="recWt0">
									�ٹ�����
								</label>
							</th>
							<td>
								<div id="recWt0">${userInfo.recWt}</div>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<th class="name">
								<label for="recName0">
									�̸�
								</label>
							</th>
							<td class="name">
								<input type="text" id="recName0" name="recName" width="150" maxlength="5"
								value="${userInfo.recName}" 
								oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3]/, '')"
								readonly
								required>
							</td>
							<th>
								<label for="recBirth0">
									�������
								</label>
							</th>
							<td>
								<input type="text" id="recBirth0" name="recBirth"  maxlength="10"
								oninput="this.value = this.value.replace(/[^\d\.]/, '')"
								value="${userInfo.recBirth}" required>
							</td>
						</tr>
						<tr>
							<th>
								<label for="recGender0">
									����
								</label>
							</th>
							<td>
								<select id="recGender0" name="recGender" required>
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
								<label for="recPhone0">
									����ó
								</label>
							</th>
							<td>
								<input type="text" id="recPhone0" name="recPhone"  maxlength="11"
								value="${userInfo.recPhone}"
								oninput="this.value = this.value.replace(/[^\d]/, '')"
								readonly
								required>
							</td>
						</tr>
						<tr>
							<th>
								<label for="recEmail0">
									email
								</label>
							</th>
							<td>
								<input type="text" id="recEmail0" name="recEmail"  maxlength="50"
								value="${userInfo.recEmail}"
								oninput="this.value = this.value.replace(/[^\@\.\w]/g, '')"
								required>
							</td>
							<th>
								<label for="recAddr0">
									�ּ�
								</label>
							</th>
							<td>
								<input type="text" id="recAddr0" name="recAddr"  maxlength="50"
								value="${userInfo.recAddr}"
								oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\d\-\s]/, '')"
								required>
							</td>
						</tr>
						<tr>
							<th>
								<label for="recLoc0">
									����ٹ���
								</label>
							</th>
							<td>
								<select id="recLoc0" name="recLoc" required>
									<c:forEach items="${location}" var="loc">
										<option value="${loc.codeId}" 
										<c:if test="${userInfo.recLoc eq loc.codeId 
										|| loc.codeName eq '����'}">selected='selected'</c:if>>
										${loc.codeName}</option>
									</c:forEach>
								</select>
							</td>
							<th>
								<label for="recWt0">
									�ٹ�����
								</label>
							</th>
							<td>
								<select id="recWt0" name="recWt" required>
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
					</c:otherwise>
					</c:choose>
				</table>
				
				<table border="1" <c:if test="${not empty userInfo.recBirth}">style="display: table"</c:if>>
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
							<td>
								<div id="edu">
								${userBoxInfo.school}<c:if test="${userBoxInfo.school eq '���б�'}">(4����)</c:if>
								${userBoxInfo.division}
								</div>
							</td>
							<td>
								<div id="career">${userBoxInfo.carPeriod}</div>
							</td>
							<td>ȸ�系�Կ� ����</td>
							<td>
								<c:forEach items="${location}" var="loc">
									<div id="workLoc">
										<c:if test="${userBoxInfo.workLoc eq loc.codeId}">${loc.codeName} ��ü</c:if>
									</div>
								</c:forEach>
								<div id="workType">${userBoxInfo.workType}</div>
							</td>
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
							<th>
								<label for="eduStart0">���бⰣ</label>
								<label for="eduEnd0" class="hidden">���бⰣ</label>
							</th>
							<th>
								<label for="eduDiv0">����</label>
							</th>
							<th>
								<label for="eduSchool0">�б���(������)</label>
							</th>
							<th>
								<label for="eduMajor0">����</label>
							</th>
							<th>
								<label for="eduGrade0">����</label>
							</th>
						</tr>
					</thead>
					<tbody>
					<c:choose>
					<c:when test="${userInfo.recSubmit eq 'Y'}">
					<c:forEach items="${eduList}" var="edu" varStatus="status">
							<tr>
								<td>
									<div id="eduStart${status.index}">${edu.eduStart}</div>
									<div>~</div>
									<div id="eduEnd${status.index}">${edu.eduEnd}</div>
								</td>
								<td>
									<div id="eduDiv${status.index}">${edu.eduDiv}</div>
								</td>
								<td>
									<div id="eduSchool${status.index}">${edu.eduSchool}</div>
									<div id="eduLoc${status.index}">
										<c:forEach items="${location}" var="loc">
											<c:if test="${edu.eduLoc eq loc.codeId}">${loc.codeName}</c:if>
										</c:forEach>
									</div>
								</td>
								<td>
									<div id="eduMajor${status.index}">${edu.eduMajor}</div>
								</td>
								<td>
									<div id="eduGrade${status.index}">${edu.eduGrade}</div>
								</td>
							</tr>
					</c:forEach>
					</c:when>
					<c:when test="${not empty eduList}">
						<c:forEach items="${eduList}" var="edu" varStatus="status">
							<tr>
								<td>
									<input type="checkbox" id="eduSeq${status.index}" name="eduSeq" value="${edu.eduSeq}">
								</td>
								<td>
									<input type="text" id="eduStart${status.index}" name="eduStart"  maxlength="7"
									value="${edu.eduStart}" 
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									required>
									~
									<input type="text" id="eduEnd${status.index}" name="eduEnd"  maxlength="7"
									value="${edu.eduEnd}" 
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									required>
								</td>
								<td>
									<select id="eduDiv${status.index}" name="eduDiv" required>
										<option value="����"
										<c:if test="${edu.eduDiv eq '����'}">selected='selected'</c:if>>����</option>
										<option value="����"
										<c:if test="${edu.eduDiv eq '����'}">selected='selected'</c:if>>����</option>
										<option value="����"
										<c:if test="${edu.eduDiv eq '����' || empty edu.eduDiv}">selected='selected'</c:if>>����</option>
									</select>
								</td>
								<td>
									<input type="text" id="eduSchool${status.index}" name="eduSchool"  maxlength="50"
									value = "${edu.eduSchool}"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\s\w]/, '')"
									required>
									<select id="eduLoc${status.index}" name="eduLoc" required>
										<c:forEach items="${location}" var="loc">
										<option value="${loc.codeId}" 
										<c:if test="${edu.eduLoc eq loc.codeId 
										|| loc.codeName eq '����'}">selected='selected'</c:if>>
										${loc.codeName}</option>
									</c:forEach>
									</select>
								</td>
								<td>
									<input type="text" id="eduMajor${status.index}" name="eduMajor"  maxlength="30"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\s\w]/, '')"
									value="${edu.eduMajor}" required>
								</td>
								<td>
									<input type="text"
									id="eduGrade${status.index}" name="eduGrade" value="${edu.eduGrade}"  maxlength="3"
									oninput="this.value = this.value.replace(/[^\d\.]/, '').replace(/(\..*)\./g, '$1')"
									required
									>
								</td>
							</tr>
					</c:forEach>
					</c:when>
					<c:otherwise>
							<tr>
								<td>
									<input type="checkbox" id="eduSeq0" name="eduSeq">
								</td>
								<td>
									<input type="text" id="eduStart0" name="eduStart"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									required>
									~
									<input type="text" id="eduEnd0" name="eduEnd"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									required>
								</td>
								<td>
									<select id="eduDiv0" name="eduDiv" required>
										<option value="����"
										>����</option>
										<option value="����"
										>����</option>
										<option value="����"
										selected='selected'>����</option>
									</select>
								</td>
								<td>
									<input type="text" id="eduSchool0" name="eduSchool"  maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\s\w]/, '')"
									required>
									<select id="eduLoc0" name="eduLoc" required>
										<c:forEach items="${location}" var="loc">
										<option value="${loc.codeId}" 
										<c:if test="${edu.eduLoc eq loc.codeId 
										|| loc.codeName eq '����'}">selected='selected'</c:if>>
										${loc.codeName}</option>
									</c:forEach>
									</select>
								</td>
								<td>
									<input type="text" id="eduMajor0" name="eduMajor"  maxlength="30"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\s\w]/, '')"
									required>
								</td>
								<td>
									<input type="text"
									id="eduGrade0" name="eduGrade" maxlength="3"
									oninput="this.value = this.value.replace(/[^\d\.]/, '').replace(/(\..*)\./g, '$1')"
									required
									>
								</td>
							</tr>
					</c:otherwise>
					</c:choose>
						</tbody>
					
				</table>
				
				<h2 class="category">���</h2>
				<div id="carBtn">
					<button type="button" id="addCar">�߰�</button>
					<button type="button" id="subCar">����</button>
				</div>
				<table border="1" id="carTable">
					<thead>
						<tr>
							<th>
								<label for="carStart0">�ٹ��Ⱓ</label>
								<label for="carEnd0" class="hidden">�ٹ��Ⱓ</label>
							</th>
							<th>
								<label for="carCompany0">ȸ���</label>
							</th>
							<th>
								<label for="carTask0">�μ�/��å/����</label>
							</th>
							<th>
								<label for="carLoc0">����</label>
							</th>
						</tr>
					</thead>
					<tbody>
					<c:choose>
					<c:when test="${userInfo.recSubmit eq 'Y'}">
					<c:forEach items="${carList}" var="car" varStatus="status">
							<tr>
								<td>
									<div id="carStart${status.index}">${car.carStart}</div>
									<div>-</div>
									<div id="carEnd${status.index}">${car.carEnd}</div>
								</td>
								<td>
									<div id="carCompany${status.index}">${car.carCompany}</div>
								</td>
								<td>
									<div id="carTask${status.index}">${car.carTask}</div>
								</td>
								<td>
									<div id="carLoc${status.index}">${car.carLoc}</div>
								</td>
							</tr>
					</c:forEach>
					</c:when>
					<c:when test="${not empty carList}">
					<c:forEach items="${carList}" var="car" varStatus="status">
							<tr>
								<td>
								</td>
								<td>
									<input type="text" id="carStart${status.index}" name="carStart"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d.]/, '')"
									value="${car.carStart}">
									-
									<input type="text" id="carEnd${status.index}" name="carEnd"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d.]/, '')"
									value="${car.carEnd}">
								</td>
								<td>
									<input type="text" id="carCompany${status.index}" name="carCompany"  maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\d\s\w]/, '')"
									value="${car.carCompany}">
								</td>
								<td>
									<input type="text" id="carTask${status.index}" name="carTask" maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\/\w]/, '')"
									 value="${car.carTask}">
								</td>
								<td>
									<input type="text" id="carLoc${status.index}" name="carLoc"  maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\d\-\s]/, '')"
									value="${car.carLoc}">
								</td>
							</tr>
					</c:forEach>
					</c:when>
					<c:otherwise>
							<tr>
								<td>
									<input type="checkbox" id="carSeq0" name="carSeq">
								</td>
								<td>
									<input type="text" id="carStart0" name="carStart"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d.]/, '')"
									>
									-
									<input type="text" id="carEnd0" name="carEnd"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d.]/, '')"
									>
								</td>
								<td>
									<input type="text" id="carCompany0" name="carCompany"  maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\d\s\w]/, '')"
									>
								</td>
								<td>
									<input type="text" id="carTask0" name="carTask" maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\/\w]/, '')"
									 >
								</td>
								<td>
									<input type="text" id="carLoc0" name="carLoc"  maxlength="50"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\d\-\s]/, '')"
									>
								</td>
							</tr>
					</c:otherwise>
					</c:choose>
					</tbody>
				</table>
				
				<h2 class="category">�ڰ���</h2>
				<div id="certBtn">
					<button type="button" id="addCert">�߰�</button>
					<button type="button" id="subCert">����</button>
				</div>
				<table border="1" id="certTable">
					<thead>
						<tr>
							<th>
								<label for="certQualifi0">�ڰ�����</label>
							</th>
							<th>
								<label for="certAcqu0">�����</label>
							</th>
							<th>
								<label for="certOrganize0">����ó</label>
							</th>
						</tr>
					</thead>
					<tbody>
					<c:choose>
					<c:when test="${userInfo.recSubmit eq 'Y'}">
					<c:forEach items="${certList}" var="cert" varStatus="status">
							<tr>
								<td>
									<div id="certQualifi${status.index}">${cert.certQualifi}</div>
								</td>
								<td>
									<div id="certAcqu${status.index}">${cert.certAcqu}</div>
								</td>
								<td>
									<div id="certOrganize${status.index}">${cert.certOrganize}</div>
								</td>
							</tr>
					</c:forEach>
					</c:when>
					<c:when test="${not empty certList}">
					<c:forEach items="${certList}" var="cert" varStatus="status">
							<tr>
								<td>
									<input type="checkbox" id="certSeq${status.index}" name="certSeq" value="${cert.certSeq}" >
								</td>
								<td>
									<input type="text" id="certQualifi${status.index}" name="certQualifi"  maxlength="30"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\w\s]/, '')"
									value="${cert.certQualifi}">
								</td>
								<td>
									<input type="text" id="certAcqu${status.index}" name="certAcqu"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									value="${cert.certAcqu}">
								</td>
								<td>
									<input type="text" id="certOrganize${status.index}" name="certOrganize"  maxlength="30"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\w\s]/, '')"
									 value="${cert.certOrganize}">
								</td>
							</tr>
					</c:forEach>
					</c:when>
					<c:otherwise>
							<tr>
								<td>
									<input type="checkbox" id="certSeq" name="certSeq">
								</td>
								<td>
									<input type="text" id="certQualifi0" name="certQualifi"  maxlength="30"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\w\s]/, '')"
									>
								</td>
								<td>
									<input type="text" id="certAcqu0" name="certAcqu"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									>
								</td>
								<td>
									<input type="text" id="certOrganize0" name="certOrganize"  maxlength="30"
									oninput="this.value = this.value.replace(/[^��-��\uac00-\ud7a3\w\s]/, '')"
									>
								</td>
							</tr>
					</c:otherwise>
					</c:choose>
					</tbody>
				</table>
			</div>
			<div id="svsbBtn">
				<button type="button" id="save">����</button>
				<button type="button" id="submit">����</button>
			</div>
			<div id="backBtn">
				<button type="button" onclick="location.href='/recruit/login'">�ڷ�</button>
			</div>
		</form>
	</div>
</body>
</html>
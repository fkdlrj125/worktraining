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
			alert("최소 한 개 이상의 행을 남겨주세요");
			return;
		}
		
		if(confirm("삭제하시겠습니까?")) {
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
						alert("삭제 실패");
				}
			});
		}
	}
	
	var emptyWarn = function(data) {
		let result = false;
		
		if(!$j(`#\${data}`).val()?.trim()) {
			alert($j(`label[for=\${$j(`#\${data}`).attr('id')}]`).text().trim()
					+"을 입력해주세요.");
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
						+"을 입력해주세요.");
						$j(`#\${data}`).focus();
						return false;
					}
					return true;
				}
				
				if(stringRegex.test($j(`#\${data}`).val())) {
					alert($j(`label[for=\${$j(`#\${data}`).attr('id')}]`).text().trim()
					+"을 입력해주세요.");
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
						+"을 xxxx.xx.xx 형식으로 입력해주세요.");
						$j(`#\${data}`).focus();
						return false;
					}
					return true;
				}
				
				if(!dateRegex.test($j(`#\${data}`).val())) {
					alert($j(`label[for=\${$j(`#\${data}`).attr('id')}]`).text().trim()
					+"을 xxxx.xx 형식으로 입력해주세요.");
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
					+"를 입력해주세요.");
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
					+"을 x.x 형식으로 입력해주세요.");	
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
					+"을 부서/직책/직급 형태로 입력해주세요.");
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
					+"을 xxx@xxx.xxx 형식으로 입력해주세요.");
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
					alert("저장 완료");
					location.href="/recruit/login";
					break;
					
				case "N":
					alert("저장 실패");
					break;
					
				case "S":
					alert("제출 후 수정은 불가능합니다.");
					location.href="/recruit/login";
					break;

				default:
					alert("저장 실패");
					break;
				}
				
			},
			error : function() {
				alert("저장 실패");
			}
		})
	}

	$j(document).ready(function() {
		
		$j("#save").on("click", function() {
			sendData("save");
		});
		
		$j("#submit").on("click", function() {
			if(confirm("제출 후 수정이 불가능합니다. 제출하시겠습니까?"))
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
			<h1>입사 지원서</h1>
			<div class="tableBox">
				<table border="1">
					<tr>
						<th class="name">
							<label for="recName">
								이름
							</label>
						</th>
						<td class="birth">
							<input type="text" id="recName" name="recName" width="150" maxlength="5"
							value="${userInfo.recName}" 
							oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3]/, '')"
							required>
						</td>
						<th>
							<label for="recBirth">
								생년월일
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
								성별
							</label>
						</th>
						<td>
							<select id="recGender" name="recGender" required>
								<option value="m" 
								<c:if test="${userInfo.recGender eq 'm' 
								|| empty userInfo.recGender}">selected='selected'</c:if>>
								남자</option>
								
								<option value="fm" 
								<c:if test="${userInfo.recGender eq 'fm'}">selected='selected'</c:if>>
								여자</option>
							</select>
						</td>
						<th>
							<label for="recPhone">
								연락처
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
								주소
							</label>
						</th>
						<td>
							<input type="text" id="recAddr" name="recAddr"  maxlength="50"
							value="${userInfo.recAddr}"
							oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\d\-\s]/, '')"
							required>
						</td>
					</tr>
					<tr>
						<th>
							<label for="recLoc">
								희망근무지
							</label>
						</th>
						<td>
							<select id="recLoc" name="recLoc" required>
								<c:forEach items="${location}" var="loc">
									<option value="${loc.codeId}" 
									<c:if test="${userInfo.recLoc eq loc.codeId 
									|| loc.codeName eq '서울'}">selected='selected'</c:if>>
									${loc.codeName}</option>
								</c:forEach>
							</select>
						</td>
						<th>
							<label for="recWt">
								근무형태
							</label>
						</th>
						<td>
							<select id="recWt" name="recWt" required>
								<option value="정규직"
								<c:if test="${userInfo.recWt eq '정규직' 
								|| empty userInfo.recWt}">selected='selected'</c:if>>
								정규직</option>
								<option value="계약직"
								<c:if test="${userInfo.recWt eq '계약직'}">selected='selected'</c:if>>
								계약직</option>
							</select>
						</td>
					</tr>
				</table>
				
				<table border="1" <c:if test="${not empty userInfo.recSubmit}">style="display: table"</c:if>>
					<thead>
						<tr>
							<th>학력사항</th>
							<th>경력사항</th>
							<th>희망연봉</th>
							<th>희망근무지/근무형태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td></td>
							<td></td>
							<td>회사내규에 따름</td>
							<td></td>
						</tr>
					</tbody>
				</table>
				
				<h2 class="category">학력</h2>
				<div id="eduBtn">
					<button type="button" id="addEdu">추가</button>
					<button type="button" id="subEdu">삭제</button>
				</div>
				<table border="1" id="eduTable">
					<thead>
						<tr>
							<th></th>
							<th>
								<label for="eduStart">재학기간</label>
								<label for="eduEnd" class="hiddenLabel">재학기간</label>
							</th>
							<th>
								<label for="eduDiv">구분</label>
							</th>
							<th>
								<label for="eduSchool">학교명(소재지)</label>
							</th>
							<th>
								<label for="eduMajor">전공</label>
							</th>
							<th>
								<label for="eduGrade">학점</label>
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
										<option value="재학"
										<c:if test="${edu.eduDiv eq '재학'}">selected='selected'</c:if>>재학</option>
										<option value="중퇴"
										<c:if test="${edu.eduDiv eq '중퇴'}">selected='selected'</c:if>>중퇴</option>
										<option value="졸업"
										<c:if test="${edu.eduDiv eq '졸업' || empty edu.eduDiv}">selected='selected'</c:if>>졸업</option>
									</select>
								</td>
								<td>
									<input type="text" id="eduSchool" name="eduSchool"  maxlength="50"
									value = "${edu.eduSchool}"
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\s]/, '')"
									required>
									<select id="eduLoc" name="eduLoc" required>
										<c:forEach items="${location}" var="loc">
										<option value="${loc.codeId}" 
										<c:if test="${edu.eduLoc eq loc.codeId 
										|| loc.codeName eq '서울'}">selected='selected'</c:if>>
										${loc.codeName}</option>
									</c:forEach>
									</select>
								</td>
								<td>
									<input type="text" id="eduMajor" name="eduMajor"  maxlength="30"
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\s]/, '')"
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
										<option value="재학"
										>재학</option>
										<option value="중퇴"
										>중퇴</option>
										<option value="졸업"
										selected='selected'>졸업</option>
									</select>
								</td>
								<td>
									<input type="text" id="eduSchool" name="eduSchool"  maxlength="50"
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\s]/, '')"
									required>
									<select id="eduLoc" name="eduLoc" required>
										<c:forEach items="${location}" var="loc">
										<option value="${loc.codeId}" 
										<c:if test="${edu.eduLoc eq loc.codeId 
										|| loc.codeName eq '서울'}">selected='selected'</c:if>>
										${loc.codeName}</option>
									</c:forEach>
									</select>
								</td>
								<td>
									<input type="text" id="eduMajor" name="eduMajor"  maxlength="30"
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\s]/, '')"
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
				
				<h2 class="category">경력</h2>
				<div id="carBtn">
					<button type="button" id="addCar">추가</button>
					<button type="button" id="subCar">삭제</button>
				</div>
				<table border="1" id="carTable">
					<thead>
						<tr>
							<th></th>
							<th>
								<label for="carStart">근무기간</label>
								<label for="carEnd" class="hiddenLabel">근무기간</label>
							</th>
							<th>
								<label for="carCompany">회사명</label>
							</th>
							<th>
								<label for="carTask">부서/직책/직급</label>
							</th>
							<th>
								<label for="carLoc">지역</label>
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
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\d\s]/, '')"
									value="${car.carCompany}">
								</td>
								<td>
									<input type="text" id="carTask" name="carTask" maxlength="50"
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\/\w]/, '')"
									 value="${car.carTask}">
								</td>
								<td>
									<input type="text" id="carLoc" name="carLoc"  maxlength="50"
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\d\-\s]/, '')"
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
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\d\s]/, '')"
									>
								</td>
								<td>
									<input type="text" id="carTask" name="carTask" maxlength="50"
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\/\w]/, '')"
									 >
								</td>
								<td>
									<input type="text" id="carLoc" name="carLoc"  maxlength="50"
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\d\-\s]/, '')"
									>
								</td>
							</tr>
						</tbody>
					</c:otherwise>
					</c:choose>
				</table>
				
				<h2 class="category">자격증</h2>
				<div id="certBtn">
					<button type="button" id="addCert">추가</button>
					<button type="button" id="subCert">삭제</button>
				</div>
				<table border="1" id="certTable">
					<thead>
						<tr>
							<th></th>
							<th>
								<label for="certQualifi">자격증명</label>
							</th>
							<th>
								<label for="certAcqu">취득일</label>
							</th>
							<th>
								<label for="certOrganize">발행처</label>
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
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\w\s]/, '')"
									value="${cert.certQualifi}">
								</td>
								<td>
									<input type="text" id="certAcqu" name="certAcqu"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									value="${cert.certAcqu}">
								</td>
								<td>
									<input type="text" id="certOrganize" name="certOrganize"  maxlength="30"
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\w\s]/, '')"
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
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\w\s]/, '')"
									>
								</td>
								<td>
									<input type="text" id="certAcqu" name="certAcqu"  maxlength="7"
									oninput="this.value = this.value.replace(/[^\d\.]/, '')"
									>
								</td>
								<td>
									<input type="text" id="certOrganize" name="certOrganize"  maxlength="30"
									oninput="this.value = this.value.replace(/[^ㄱ-ㅎ\uac00-\ud7a3\w\s]/, '')"
									>
								</td>
							</tr>
						</tbody>
					</c:otherwise>
					</c:choose>
				</table>
			</div>
			<div id="svsbBtn">
				<button type="button" id="save">저장</button>
				<button type="button" id="submit">제출</button>
			</div>
		</form>
	</div>
</body>
</html>
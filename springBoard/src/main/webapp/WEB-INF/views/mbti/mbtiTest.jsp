<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="<c:url value="/resources/css/mbti/mbti.css"/>">
<title>mbtiTest</title>
</head>
<script type="text/javascript">
<%--
	var getResult = () => {
		let resultArr = $j("input:radio").serializeArray();
		let obj = null;
		
		try {
			if(resultArr) {
				obj = {};
				$j.each(resultArr, function(index) {
					obj[this.name] = $j(`input[name=\${this.name}]:checked`).attr('value');
				});
			}
		} catch (e) {
			alert(e.message);
		}
		return Object.assign({}, obj);
	}	
	
// s : strong, m : moderate
// a : agree, d : disagree, ns : notsure
	var calMBTI = (result, mbti) => {
		
		$j.each(result, function(name, value) {
			switch (value) {
			case "sa":
				mbti[name.slice(0,1)] += 3;
				break;
			case "ma":
				mbti[name.slice(0,1)] += 2;
				break;
			case "a":
				mbti[name.slice(0,1)] += 1;
				break;
			case "d":
				mbti[name.slice(1,2)] += 1;
				break;
			case "md":
				mbti[name.slice(1,2)] += 2;
				break;
			case "sd":
				mbti[name.slice(1,2)] += 3;
				break;
			}
		});
		return mbti;
	}
	
	var compareMBTI = (mbti) => {
		let result = "";
		let first = ["e", "n", "f", "j"];
		let second = ["i", "s", "t", "p"];
		
		for(let i = 0; i < first.length; i++) {
			if(mbti[first[i]] != mbti[second[i]]) {
				result += mbti[first[i]] > mbti[second[i]] ?  first[i] : second[i];
			} else {
				result += first[i] > second[i] ? second[i] : first[i];
			}
		}
		
		return result
	}

	var drawHTML = (data) => {
		html = "";
		
		$j.each(data["boardList"], function() {
			html += `
			<div class="questionBox">
				<h3 class="qText">\${this.boardComment}</h3>
				<div class="radioGroup">
					<div class="agreeText">동의</div>
					<div class="radioBtn">
						<input type="radio" class="strong" value="sa" name="\${this.boardType}\${this.boardNum}">
						<input type="radio" class="moderate" value="ma" name="\${this.boardType}\${this.boardNum}">
						<input type="radio" class="normal" value="a" name="\${this.boardType}\${this.boardNum}">
						<input type="radio" class="notSure" value="ns" name="\${this.boardType}\${this.boardNum}">
						<input type="radio" class="normal" value="d" name="\${this.boardType}\${this.boardNum}">
						<input type="radio" class="moderate" value="md" name="\${this.boardType}\${this.boardNum}">
						<input type="radio" class="strong" value="sd" name="\${this.boardType}\${this.boardNum}">
					</div>
					<div class="disagreeText">비동의</div>
				</div>
			</div>
			`
		});
		
		$j("#question").html(html);
	}
	
	var reqQuestion = (mbti) => {
		let userSelect = getResult();
		return calMBTI(userSelect, mbti);
	}
	
	$j(document).ready(function() {
		var mbti = {
				"i" : 0,
				"e" : 0,
				"n" : 0,
				"s" : 0,
				"t" : 0,
				"f" : 0,
				"p" : 0,
				"j" : 0
		}
		var pageNo = 1;
		
		$j(".submitBtn").on("click", function() {
			
			if($j("input:checked").length < 5) {
				$j("input[value=sa]").each(function() {
					if($j(`input[name=\${this.name}]:not(:checked)`).length == 7) {
						alert(
						(this.name.length == 3 ?
						this.name.slice(-1) : 
						this.name.slice(-2))
						+ "번째 질문을 선택해주세요.");
						$j(`input[name=\${this.name}]`).focus();
						return false;
					}
					console.log();
				});
			}
			
			if($j("input:radio").serializeArray().length != 5)
				return;
			
			mbti = reqQuestion(mbti);
			
			switch (pageNo) {
			case 1: case 2:
				$j.ajax({
					url : "/mbtiTest.do",
					type : "POST",
					data : {"pageNo" : ++pageNo},
					dataType : "json",
					success : function(data) {
						drawHTML(data);
					},
					error : function(errorThrown) {
						console.log(errorThrown);
					}
				});
				break;
				
			case 3:
				$j.ajax({
					url : "/mbtiTest.do",
					type : "POST",
					data : {"pageNo" : ++pageNo},
					dataType : "json",
					success : function(data) {
						drawHTML(data);
					},
					error : function(errorThrown) {
						console.log(errorThrown);
					}
				});
				
				$j(".submitBtn").val("제출");
				break;
				
			case 4:
				location.href=`/mbtiResult.do?mbti=\${compareMBTI(mbti)}`;
				break;
			}
		});
	});
	--%>
	
	var drawHTML = (data) => {
		html = "";

		$j.each(data["boardList"], function() {
			html += `
			<div class="questionBox">
				<h3 class="qText">\${this.boardComment}</h3>
				<div class="radioGroup">
					<div class="agreeText">동의</div>
					<div class="radioBtn">
						<input type="radio" class="strong" value="1" name="\${this.boardType}\${this.boardNum}">
						<input type="radio" class="moderate" value="2" name="\${this.boardType}\${this.boardNum}">
						<input type="radio" class="normal" value="3" name="\${this.boardType}\${this.boardNum}">
						<input type="radio" class="notSure" value="4" name="\${this.boardType}\${this.boardNum}">
						<input type="radio" class="normal" value="5" name="\${this.boardType}\${this.boardNum}">
						<input type="radio" class="moderate" value="6" name="\${this.boardType}\${this.boardNum}">
						<input type="radio" class="strong" value="7" name="\${this.boardType}\${this.boardNum}">
					</div>
					<div class="disagreeText">비동의</div>
				</div>
			</div>
			`
		});
		
		$j("#question").html(html);
	}
	
	$j(document).ready(function() {
		var pageNo = 1;
		var userData = [];
		
		
		$j(".submitBtn").on("click", function() {
			
			// alert
			if($j("input:checked").length < 5) {
				$j("input[value=1]").each(function() {
					if($j(`input[name=\${this.name}]:not(:checked)`).length == 7) {
						alert(
						(this.name.length == 3 ?
						this.name.slice(-1) : 
						this.name.slice(-2))
						+ "번째 질문을 선택해주세요.");
						$j(`input[name=\${this.name}]`).focus();
						return false;
					}
				});
				return;
			}
			
			userData.push($j("input:checked").serializeArray());
			
			// 데이터 요청
			switch (pageNo) {
			case 3:
				$j.ajax({
					url : "/mbtiTest.do",
					type : "POST",
					data : {"pageNo" : ++pageNo},
					dataType : "json",
					success : function(data) {
						drawHTML(data);
					},
					error : function(errorThrown) {
						console.log(errorThrown);
					}
				});
				
				$j(".submitBtn").val("제출");
				break;
				
			case 4:
				$j.ajax({
					url : "/mbtiResult.do",
					type : "POST",
					data : {"data" : JSON.stringify(userData)},
					dataType : "json",
					success : function(data) {
						console.log(data);
						location.href=`/mbtiResult.do?mbti=\${data.mbti}`;
					},
					error : function(errorThrown) {
						console.log(errorThrown);
					}
				});
				break;
				
			default:
				$j.ajax({
					url : "/mbtiTest.do",
					type : "POST",
					data : {"pageNo" : ++pageNo},
					dataType : "json",
					success : function(data) {
						drawHTML(data);
					},
					error : function(errorThrown) {
						console.log(errorThrown);
					}
				});
			}
		});
	});
</script>
</head>
<body>
	<div class="container">
		<form>
			<div id="question">
				<c:forEach items="${mbtiList}" var="list">
					<div class="questionBox">
						<h3 class="qText">${list.boardComment}</h3>
						<div class="radioGroup">
							<div class="agreeText">동의</div>
							<div class="radioBtn">
								<input type="radio" class="strong" value="1" name="${list.boardType}${list.boardNum}">
								<input type="radio" class="moderate" value="2" name="${list.boardType}${list.boardNum}">
								<input type="radio" class="normal" value="3" name="${list.boardType}${list.boardNum}">
								<input type="radio" class="notSure" value="4" name="${list.boardType}${list.boardNum}">
								<input type="radio" class="normal" value="5" name="${list.boardType}${list.boardNum}">
								<input type="radio" class="moderate" value="6" name="${list.boardType}${list.boardNum}">
								<input type="radio" class="strong" value="7" name="${list.boardType}${list.boardNum}">
							</div>
							<div class="disagreeText">비동의</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<input type="button" value="다음" class="submitBtn">
		</form>
	</div>
</body>
</html>
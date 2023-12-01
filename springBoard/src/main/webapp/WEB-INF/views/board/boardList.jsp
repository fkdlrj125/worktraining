<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">
	
	<%--
		카테고리 체크박스에서 전체가 아닐 때 전체 체크박스 해제
	--%>
	
	<%-- 
	window.onpageshow = function() {
			if(sessionStorage.getItem("html")){
				$j("#boardTable").html(sessionStorage.getItem("html"));
				const reg = new RegExp(/type.../, "g");
				var checkList = sessionStorage.getItem("checkList").match(reg);
				
				$j.each(checkList, function(index, check) {
					$j(`#\${check}`).prop("checked", true);
				})
			}
		}
	--%>
	
	function drawHTML(data) {
		var html = `<tr>
			<td width="80" align="center">
				Type
			</td>
			<td width="40" align="center">
				No
			</td>
			<td width="300" align="center">
				Title
			</td>
		</tr>`;
		
		var {totalCnt, typeList, pageNo, boardList} = data[0];
		
		$j.each(boardList, function(index, board){
			html += `
				<tr>
					<td align="center">
						\${board.boardType}
					</td>
					<td>
						\${board.boardNum}
					</td>
					<td>
						<a href = '/board/\${board.boardType}/\${board.boardNum}/boardView.do?pageNo=\${pageNo}'>\${board.boardTitle}</a>
					</td>
				</tr>	
				`;
		});
		
		$j("#boardTable").html(html);
		$j("#totalCnt").text(`total : \${totalCnt}`);
	}

	$j(document).ready(function() {
		<%--
		if(performance.navigation.type == 1) {
			if(sessionStorage.getItem("checkedData")){
				var checkedData = sessionStorage.getItem("checkedData")
				checkedData = JSON.parse(checkedData);
				console.log(checkedData);
				drawHTML(checkedData);
				
				const reg = new RegExp(/type.../, "g");
				var checkList = sessionStorage.getItem("checkList").match(reg);
				
				$j.each(checkList, function(index, check) {
					$j(`#\${check}`).prop("checked", true);
				})
			}
		}
		--%>
		var loginUser = "${loginUser.userId}";
		console.log(loginUser);
		
		if(!loginUser?.trim()) {
			$j("#logout").css("display", "none");
			$j("#userLoginDiv").css("display", "inline");
			$j("#userNameDiv").css("display", "none");
		} else {
			$j("#logout").css("display", "inline");
			$j("#userLoginDiv").css("display", "none");
			$j("#userNameDiv").css("display", "inline");
			$j("#logout").on("click", function(event){
				event.preventDefault();
				
				$j.ajax({
					url : "/user/userLogout.do",
					type : "POST",
					complete : function() {
						location.reload();
					}
				})
			})
		}
		
		$j("#checkAll").on("click", function(){
			if($j("#checkAll").is(":checked")) {
				$j("input:not(#checkAll):checkbox").prop("checked", true);
			} else {
				$j("input:not(#checkAll):checkbox").prop("checked", false);
			}
		});
		
		$j("input:not(#checkAll):checkbox").on("click", function() {
			if($j("#checkAll").is(":checked")) {
				$j("#checkAll").prop("checked", false);
			} 
		});
		
//		일반적으로 ajax로 받은 데이터는 jstl(jsp의 확장태그 ex.forEach등)에 다시 뿌리지 못함
//		서버의 작업 순서가 JAVA > JSTL > HTML > JavaScript순으로 이루어지기 때문에 기본적으로는 불가능
//		다른 파일에서 ajax를 통해 데이터를 요청하고 컨트롤러에서 데이터를 그려줄 파일로 보내서 하는 법이 있기는 함
//		하지만 .append나 .html를 이용하는 방법을 권장함
		
		$j("#search").on("click", function(){
			var checkList = $j("input:not(#checkAll):checkbox").serialize();

			if(!!checkList?.trim()) {
				$j.ajax({
					url : `/board/boardList.do?pageNo=${pageNo}`,
					type : "POST",
					data : {"param" : checkList},
					dataType : "json",
					success : function(data){
						drawHTML(data);
						sessionStorage.setItem("checkedData", JSON.stringify(data));
						sessionStorage.setItem("checkList", checkList);
					},
					error : function(errorThrown) {
						alert("실패");
					}
				});
			}
		});
//			새로고침하면 필터가 풀림
//			재요청을 하기 때문에 당연히 그런다
//			쿼리파라미터를 이용해 요청 자체를 바꿔야 겠다
	});

</script>
<body>
<table  align="center">
	<tr >
		<td>
			<div style="justify-content: space-between; display: flex;">
				<div id="userLoginDiv" style="display: inline">
					<a href="/user/userLogin.do">login</a>
					<a href="/user/userJoin.do">join</a>
				</div>
				<div id="userNameDiv" style="display: inline">
					${loginUser.userName}
				</div>
				<div style="display: inline" id="totalCnt">
					total : ${totalCnt}
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
							${list.boardType}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
			<a href ="" id="logout">로그아웃</a>
		</td>
	</tr>
	<tr align="left">
		<td>
			<input type="checkbox" id="checkAll">
			<label for="checkAll">전체</label>
			<c:forEach items="${typeList}" var="tlist">
				<input type="checkbox" id="type${tlist.codeId}" name="type${tlist.codeId}">
				<label for="type${tlist.codeId}">${tlist.codeName}</label>
			</c:forEach>
			<input type=button id="search" value="조회">
		</td>
	</tr>
	<tr align="right">
		<c:forEach items="" var="page">
			<td></td>
		</c:forEach>
	</tr>
</table>	
</body>
</html>
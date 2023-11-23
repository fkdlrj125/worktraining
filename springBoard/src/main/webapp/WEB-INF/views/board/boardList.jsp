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

	$j(document).ready(function(){
		$j("#search").on("click", function(){
			var checkedBoxes = [];
			
			$j("input:checkbox").each((index, el) => {
				if(el.checked) {
					checkedBoxes.push(el[0].id);
				}
			});
			
			console.log(checkedBoxes[0].id);	
		})
	});

</script>
<body>
<table  align="center">
	<tr >
		<td>
			<div style="justify-content: space-between; display: flex;">
				<div style="display: inline">
					<a href="/user/userLogin.do">login</a>
					<a href="/user/userJoin.do">join</a>
				</div>
				<div style="display: inline">
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
		</td>
	</tr>
	<tr align="left">
		<td>
			<input type="checkbox" id="typeAll">
			<label for="typeAll">전체</label>
			<input type="checkbox" id="typeNomal">
			<label for="typeNomal">일반</label>
			<input type="checkbox" id="typeQA">
			<label for="typeQA">Q&A</label>
			<input type="checkbox" id="typeAnoy">
			<label for="typeAnoy">익명</label>
			<input type="checkbox" id="typeFree">
			<label for="typeFree">자유</label>
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
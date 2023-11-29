<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		var path = `/board/${boardType}/${boardNum}`;
	
		// 삭제
		// ajax 하나 쓰고 삭제만으로 동시 삭제 해결
		// 체크 필요 없음
		$j("#delete").on("click", function(){
			
			if(confirm("삭제하시겠습니까?")){
				$j.ajax({
					url : path + "/boardDelete.do",
					type : "POST",
					dataType : "json",
					success : function(data) {
						
						if(data.success == "Y") {
							alert("삭제성공");
						} else {
							alert("삭제실패")
						}
						
						location.href = "/board/boardList.do?pageNo=";
					}
				});
			}
		});
		
		// 수정
		$j("#update").on("click", function(){
			location.href = path + `/boardUpdate.do`;
		});
	});

</script>
<body>
<table align="center">
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">
					Type
					</td>
					<td width="400">
					${board.boardType}
					</td>
				</tr>
				<tr>
					<td align="center">
					Title
					</td>
					<td>
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<button id="update">Update</button>
			<button id="delete">Delete</button>
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
</table>	
</body>
</html>
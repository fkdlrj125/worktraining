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
	
		// ����
		// ajax �ϳ� ���� ���������� ���� ���� �ذ�
		// üũ �ʿ� ����
		$j("#delete").on("click", function(){
			
			if(confirm("�����Ͻðڽ��ϱ�?")){
				$j.ajax({
					url : path + "/boardDelete.do",
					type : "POST",
					dataType : "json",
					success : function(data) {
						
						if(data.success == "Y") {
							alert("��������");
						} else {
							alert("��������")
						}
						
						location.href = "/board/boardList.do?pageNo=";
					}
				});
			}
		});
		
		// ����
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
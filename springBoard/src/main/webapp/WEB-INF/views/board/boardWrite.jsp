<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#submit").on("click",function(){
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			
			if(!$frm[1].value?.trim()){ // 옵셔널 체이닝을 이용한 null, undefine, 빈 문자 체크 
				alert("제목을 입력해주세요");
			}
			else{
				$j.ajax({
				    url : "/board/boardWriteAction.do",
				    dataType: "json",
				    type: "POST",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
						alert("작성완료");
						
						alert("메세지:"+data.success);
						location.href = "/board/boardList.do?pageNo=";
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("실패");
				    }
				});
			}
		});
		
		// 글 추가에서 행 추가 행 삭제 기능 추가
		// 행 -> title 과 comment 한 묶음
		// 행 삭제는 원하는 행을 지정해서 삭제 가능하도록
		// 행 추가는 됐는데 기존 행에 값이 있을 때 그 값도 같이 복사되는 상태 -> 해결해야됨
		
		$j("#addrow").on("click", function() {
			var length = $j('tbody:eq(1) tr').length-2;
			var position = $j('tbody:eq(1) tr:eq(-2)');
			
			var titleClone = $j("tbody:eq(1) tr:eq(0)").clone(true);
			var commentClone = $j("tbody:eq(1) tr:eq(1)").clone(true);
			
			var newComment = position.after(commentClone);
			var newTitle = position.after(titleClone);
			
		});
	});
	
</script>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
			<input id="addrow" type="button" value="행추가">
			</td>
			<td align="right">
			<input id="subrow" type="button" value="행삭제">
			</td>
			<td align="right">
			<input id="submit" type="button" value="작성">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1"> 
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
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
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>
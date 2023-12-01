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
		ī�װ� üũ�ڽ����� ��ü�� �ƴ� �� ��ü üũ�ڽ� ����
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
		
//		�Ϲ������� ajax�� ���� �����ʹ� jstl(jsp�� Ȯ���±� ex.forEach��)�� �ٽ� �Ѹ��� ����
//		������ �۾� ������ JAVA > JSTL > HTML > JavaScript������ �̷������ ������ �⺻�����δ� �Ұ���
//		�ٸ� ���Ͽ��� ajax�� ���� �����͸� ��û�ϰ� ��Ʈ�ѷ����� �����͸� �׷��� ���Ϸ� ������ �ϴ� ���� �ֱ�� ��
//		������ .append�� .html�� �̿��ϴ� ����� ������
		
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
						alert("����");
					}
				});
			}
		});
//			���ΰ�ħ�ϸ� ���Ͱ� Ǯ��
//			���û�� �ϱ� ������ �翬�� �׷���
//			�����Ķ���͸� �̿��� ��û ��ü�� �ٲ�� �ڴ�
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
			<a href ="/board/boardWrite.do">�۾���</a>
			<a href ="" id="logout">�α׾ƿ�</a>
		</td>
	</tr>
	<tr align="left">
		<td>
			<input type="checkbox" id="checkAll">
			<label for="checkAll">��ü</label>
			<c:forEach items="${typeList}" var="tlist">
				<input type="checkbox" id="type${tlist.codeId}" name="type${tlist.codeId}">
				<label for="type${tlist.codeId}">${tlist.codeName}</label>
			</c:forEach>
			<input type=button id="search" value="��ȸ">
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
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
	// 게시글 작성에 type추가(selectbox로 선택가능하게/DB에 있는 정보 사용)
	// 게시글 리스트에 게시글의 타입 보이게, 하단에 체크박스를 통해 원하는 게시글 타입들만 볼 수 있게
	
	// 백단에서 게시글 타입 표현은 코드id를 사용하는 게 좋아 보임
	// 저장
	// 1. 컨트롤러에서 작성폼에 게시글 타입에 대한 정보 전달 
	//  -> 문제1. 맵퍼에서 클래스의 경로를 지정하지 않고 그냥 넣어서 에러 발생
	//	-> 문제2. root-context.xml에 component-scan을 지정하지 않아 빈이 생성되지 않음
	//  -> 문제3. 맵퍼의 개념이 부족해 제대로 적용하지 못 함
	//		-> sql을 호출하기 위한 것
	//		-> namespace는 이 맵퍼들을 모아놓은 곳(경로와 같은 개념이라 생각됨)
	//		-> 빈에 등록해 주입받아 쓰는 방법도 있고 MapperFactoryBean을 이용해 등록하는 방법도 있음
	// 2. 뷰에 타이틀 선택하는 selet태그 생성(name="boardType")
	
	// 3. 컨트롤러에서 객체에 게시글 타입도 추가
	
	// 출력
	// 1. 컨트롤러에서 게시글 리스트에 게시글 타입에 대한 정보 전달
	// 2. 하단 필터링에 맞는 스크립트 작성
	//  2-1. 전체를 누르면 모든 체크박스 체크
	//  2-2. 선택한 게시글 타입에 대한 게시물만 출력
	
	
	$j(document).ready(function(){
		$j.fn.serializeObject = function(writer) {
			var result = [];
			var obj = null;
			
			try {
				var arr = this.serializeArray();
				
				if(arr) {
					obj = {};
					$j.each(arr, function(index) {
						obj[this.name] = this.value;
						if((index+1)%3==0) {
							result.push(Object.assign({}, obj));
						}
					});
					result.push(Object.assign({}, writer));
				}
			} catch (e) {
				alert(e.message);
			}
			return result;
		}
		
		$j("#submit").on("click",function(){
			var $frm = $j(".boardWrite :input");
			var writer = {"writer" : $j("#writer").text().trim()};
			var param = $frm.serializeObject(writer);
			
			console.log(param);
			
			for(var i=0; i < param.length-1; i++) {
				if(!param[i]["boardTitle"]?.trim()) {
					alert("제목을 입력해주세요");
					return;
				}
			}
			
			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    type : "POST",
			    traditional : true,
			    data : {"param" : JSON.stringify(param)},
			    dataType : "json",
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
			 
			// ver.1
			
			// var $frm = $j(":input")
			// var param = $frm.serialize();
			
			// var values = param.split("&");
			
			<%-- for(var i=0; i < values.length/2; i++) {
				if(!values[i*2].split("=")[1]?.trim()) {
					alert("제목을 입력해주세요");
					return;
				}
			} --%>
			
			<%-- $j.ajax({
			    url : "/board/boardWriteAction.do",
			    type : "POST",
			    data : param, 
			    dataType : "json",
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
			}); --%>
		});
		
		$j("#addrow").on("click", function() {
			var typeClone = $j("tbody:eq(1) tr:eq(0)").clone(true);
			var titleClone = $j("tbody:eq(1) tr:eq(1)").clone(true);
			var commentClone = $j("tbody:eq(1) tr:eq(2)").clone(true);
			
			$j("tbody:eq(1) tr:eq(-2)").after(typeClone);
			$j("tbody:eq(1) tr:eq(-2)").after(titleClone);
			$j("tbody:eq(1) tr:eq(-2)").after(commentClone);
			
			
			$j("tbody:eq(1) tr:eq(-3) :input")[0].value = "";
			$j("tbody:eq(1) tr:eq(-3) input:checkbox.dcheck").prop("checked", false);
			$j("tbody:eq(1) tr:eq(-2) :input")[0].value = "";
		});
		
		$j("#subrow").on("click", function() {
			var iarr = [];
			$j(".dcheck").each(function(index, el) {
				if(el.checked) {
					iarr.push(index);
				}
			})
			
			if(($j("tbody:eq(1) tr").length-3) > iarr.length) {
				var count = 0;
				iarr.forEach(function(i){
					i -= count;
					$j(`tbody:eq(1) tr:eq(\${i*2})`).remove();
					$j(`tbody:eq(1) tr:eq(\${i*2})`).remove();
					$j(`tbody:eq(1) tr:eq(\${i*2})`).remove();
					count++;
				});
			} else {
				alert("최소 한 개의 행을 남겨주세요.");
			}
		});
	});
	
</script>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
				<input id="addrow" type="button" value="행추가">
				<input id="subrow" type="button" value="행삭제">
				<input id="submit" type="button" value="작성">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1"> 
					<tr>
						<td width="120" align="center">
						Type
						</td>
						<td width="420" align="left">
						<select name="boardType">
							<c:forEach items="${typeList}" var="list">
								<option value="${list.codeId}" 
								<c:if test ="${list.codeId eq 'a01'}">selected="selected"</c:if>>
								${list.codeName}
								</option>
							</c:forEach>
						</select>
						</td>
					</tr>
					<tr>
						<td align="center">
						Title
						</td>
						<td align="left">
						<input name="boardTitle" type="text" size="50" value="${board.boardTitle}">
						<input class="dcheck" type="checkbox">
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
						<td id="writer">
							${loginUser.userName}
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
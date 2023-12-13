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
	// �Խñ� �ۼ��� type�߰�(selectbox�� ���ð����ϰ�/DB�� �ִ� ���� ���)
	// �Խñ� ����Ʈ�� �Խñ��� Ÿ�� ���̰�, �ϴܿ� üũ�ڽ��� ���� ���ϴ� �Խñ� Ÿ�Ե鸸 �� �� �ְ�
	
	// ��ܿ��� �Խñ� Ÿ�� ǥ���� �ڵ�id�� ����ϴ� �� ���� ����
	// ����
	// 1. ��Ʈ�ѷ����� �ۼ����� �Խñ� Ÿ�Կ� ���� ���� ���� 
	//  -> ����1. ���ۿ��� Ŭ������ ��θ� �������� �ʰ� �׳� �־ ���� �߻�
	//	-> ����2. root-context.xml�� component-scan�� �������� �ʾ� ���� �������� ����
	//  -> ����3. ������ ������ ������ ����� �������� �� ��
	//		-> sql�� ȣ���ϱ� ���� ��
	//		-> namespace�� �� ���۵��� ��Ƴ��� ��(��ο� ���� �����̶� ������)
	//		-> �� ����� ���Թ޾� ���� ����� �ְ� MapperFactoryBean�� �̿��� ����ϴ� ����� ����
	// 2. �信 Ÿ��Ʋ �����ϴ� selet�±� ����(name="boardType")
	
	// 3. ��Ʈ�ѷ����� ��ü�� �Խñ� Ÿ�Ե� �߰�
	
	// ���
	// 1. ��Ʈ�ѷ����� �Խñ� ����Ʈ�� �Խñ� Ÿ�Կ� ���� ���� ����
	// 2. �ϴ� ���͸��� �´� ��ũ��Ʈ �ۼ�
	//  2-1. ��ü�� ������ ��� üũ�ڽ� üũ
	//  2-2. ������ �Խñ� Ÿ�Կ� ���� �Խù��� ���
	
	
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
					alert("������ �Է����ּ���");
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
					alert("�ۼ��Ϸ�");
					
					alert("�޼���:"+data.success);
					location.href = "/board/boardList.do?pageNo=";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("����");
			    }
			}); 
			 
			// ver.1
			
			// var $frm = $j(":input")
			// var param = $frm.serialize();
			
			// var values = param.split("&");
			
			<%-- for(var i=0; i < values.length/2; i++) {
				if(!values[i*2].split("=")[1]?.trim()) {
					alert("������ �Է����ּ���");
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
					alert("�ۼ��Ϸ�");
					
					alert("�޼���:"+data.success);
					location.href = "/board/boardList.do?pageNo=";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("����");
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
				alert("�ּ� �� ���� ���� �����ּ���.");
			}
		});
	});
	
</script>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
				<input id="addrow" type="button" value="���߰�">
				<input id="subrow" type="button" value="�����">
				<input id="submit" type="button" value="�ۼ�">
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
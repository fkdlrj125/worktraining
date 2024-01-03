<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Calendar</title>
</head>
<script src="/resources/js/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		let now = new Date();
		let selectYear = $("#calendarYear");
		let selectMonth = $("#calendarMonth");
		
		selectYear.append(`<option value="\${now.getFullYear()}" selected="selected">\${now.getFullYear()}</option>`);
		
		for(let i = 1; i < 5; i++) {
			selectYear.prepend(`<option value="\${now.getFullYear() - i}">\${now.getFullYear() - i}</option>`);
			selectYear.append(`<option value="\${now.getFullYear() + i}">\${now.getFullYear() + i}</option>`);
		}
		
		for(let i = 1; i < 13; i++) {
			selectMonth.append(`<option value="\${i}">\${i}</option>`);
		}
		
		$(`option[value='\${now.getMonth()+1}']`).attr("selected", "selected");
		
	});
</script>
<body>
	<div class="wrapper">
		<div class="container" width="100%">
			<div class="header"></div>
			<div class="content">
				<div class="calendarBox" style="text-align: center;">
					<form action="/download/calendar" method="POST">
						<select id="calendarYear" name="year">
						</select>
						<select id="calendarMonth" name="month">
						</select>
						<button type="submit">달력 엑셀 출력</button>
					</form>
				</div>
			</div>
			<div class="footer"></div>
		</div>
	</div>
</body>
</html>
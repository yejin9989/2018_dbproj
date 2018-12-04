<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, phase3.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정 화면</title>
<script type="text/javascript">
	function checkValue() {
		if(!document.deleteform.password.value) {
			alert("비밀번호를 입력하지 않았습니다.");
			return false;
		}
	}
</script>
</head>
<body>
	<br><br>
	<b><font size="6" color="gray">내 정보</font></b>
	<br><br><br>
	
	<form name="modifypreview" method="post" action="ModifyFrom.jsp"
		onsubmit="return checkValue()">
		
		<table>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="password" maxlength="20"></td>
			</tr>
		</table>
		
		<br>
		<input type="button" value="취소" onclick="location.href='Main.jsp'">
		<input type="submit" value="확인" />
	</form>
</body>
</html>
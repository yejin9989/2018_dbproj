<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
<form action="joinOK.jsp" method="post">
<input type="hidden" name ="ip" value="<%=request.getRemoteAddr()%>"/>
<table width="400" align="center" border="1">
	<tr><th colspan="2">회원 가입</th></tr>
	<tr>
		<td width="200" align="center">아이디</td>
		<td width="200" align="center"><input type="text" maxlength="15" name="id"/></td>
	</tr>
	<tr>
		<td width="200" align="center">비밀번호</td>
		<td width="200" align="center"><input type="password" maxlength="20" name="password"/></td>
	</tr>
	<tr>
		<td width="200" align="center">성별</td>
		<td width="200" align = "center">
		<input type="radio" name="sex" >M
		<input type="radio" name="sex">F
		</td>
	<tr>
		<td width="200" align="center">주소</td>
		<td width="200" align="center"><input type="text" maxlength="100" name="address"/></td>
	</tr>
	<tr>
		<td width="200" align="center">나이</td>
		<td width="200" align="center"><input type="text" name="age"/></td>
	</tr>
	<tr>
		<td width="200" align="center">이름</td>
		<td width="200" align="center"><input type="text" maxlength="30" name="name"/></td>
	</tr>
	<tr>
		<td width="200" align="center">핸드폰 번호</td>
		<td width="200" align="center"><input type="text" maxlength="20" name="phonenumber"/></td>
	</tr>
	<tr>
		<td width="200" align="center">직업</td>
		<td width="200" align="center"><input type="text" maxlength="20" name="job"/></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="submit" value="회원가입 하기"/></td>
	</tr>
</table>
</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, phase3.*"%>
<!DOCTYPE html>
<html>
<head>
<%
	Connection conn = DBUtil.getMySQLConnection();
	String s_id = (String) session.getAttribute("s_id");
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM CUSTOMER WHERE ID = ?";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, s_id);
	rs = pstmt.executeQuery();
%>
<meta charset="UTF-8">
<title>회원정보 수정화면</title>
<script type="text/javascript">
	function checkValue() {
		if(!document.userInfo.password.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
	}
</script>
</head>
<body>
	<br><br>
	<b><font size="6" color="gray">회원정보 수정</font></b>
	<br><br><br>
	
	<form method="post" action="Main.jsp?contentPage=ModifyPro.jsp" name="userInfo" onsubmit="return checkValue()">
	
	<table>
		<tr>
			<td id="title">아이디</td>
			<td id="title"><%=rs.getString("ID")%></td>
		</tr>
		<tr>
			<td id="title">비밀번호</td>
			<td><input type="password" name="password" maxlength="20" value="<%=rs.getString("PW")%>"></td>
		</tr>
	</table>
	<br><br>
	<table>
		<tr>
			<td id="title">성별</td>
			<td><input type="text" name="sex" value="<%=rs.getString("Sex")%>"></td>
		</tr>
		<tr>
			<td id="title">주소</td>
			<td><input type="text" name="address" maxlength="100" value="<%=rs.getString("Address")%>"></td>
		</tr>
		<tr>
			<td id="title">나이</td>
			<td><input type="text" name="age" value="<%=rs.getInt("Age")%>"></td>
		</tr>
		<tr>
			<td id="title">이름</td>
			<td><input type="text" name="name" value="<%=rs.getString("Name")%>"></td>
		</tr>
		<tr>
			<td id="title">전화번호</td>
			<td><input type="text" name="phonenumber" value="<%=rs.getString("Phone_number")%>"></td>
		</tr>
		<tr>
			<td id="title">직업</td>
			<td><input type="text" name="job" value="<%=rs.getString("Job")%>"></td>
		</tr>
	</table>
	<br><br>
	<input type="button" value="취소" onclick="location.href='Main.jsp'">
	<input type="submit" value="수정"/>
	</form>
</body>
</html>
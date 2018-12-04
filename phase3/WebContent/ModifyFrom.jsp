<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, phase3.*"%>
    <% request.setCharacterEncoding("UTF-8"); %>
<%
	Connection conn = DBUtil.getMySQLConnection();
	String s_id = (String) session.getAttribute("s_id");
	String pw = request.getParameter("password");
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM CUSTOMER WHERE Id = ? AND PW = ?";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, s_id);
	pstmt.setString(2, pw);
	rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
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
	
	<form method="post" action="ModifyPro.jsp" name="userInfo" onsubmit="return checkValue()">

<%

	while(rs.next()) {
		String id = rs.getString("Id");
		String sex = rs.getString("Sex");
		String address = rs.getString("Address");
		int age = rs.getInt("Age");
		String name = rs.getString("Name");
		String phonenumber = rs.getString("Phone_number");
		String job = rs.getString("Job");
%>
<table>
		<tr>
			<td id="title">아이디</td>
			<td><%=id %></td>
		</tr>
		<tr>
			<td id="title">비밀번호</td>
			<td><input type="password" name="password" maxlength="20"></td>
		</tr>
		<tr>
			<td id="title">성별</td>
			<td><input type="text" name="sex" value="<%=sex%>"></td>
		</tr>
		<tr>
			<td id="title">주소</td>
			<td><input type="text" name="address" maxlength="100" value="<%=address%>"></td>
		</tr>
		<tr>
			<td id="title">나이</td>
			<td><input type="text" name="age" value="<%=age%>"></td>
		</tr>
		<tr>
			<td id="title">이름</td>
			<td><input type="text" name="name" value="<%=name%>"></td>
		</tr>
		<tr>
			<td id="title">전화번호</td>
			<td><input type="text" name="phonenumber" value="<%=phonenumber%>"></td>
		</tr>
		<tr>
			<td id="title">직업</td>
			<td><input type="text" name="job" value="<%=job%>"></td>
		</tr>
		</table>
<% } %>

	<br><br>
	<input type="button" value="취소" onclick="javascript:location.href='Main.jsp'">
	<input type="submit" value="수정"/>
	</form>
</body>
</html>

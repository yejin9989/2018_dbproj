<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, phase3.*"%>
<%
	Connection conn = DBUtil.getMySQLConnection();

	String s_id = (String) session.getAttribute("s_id");
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM CUSTOMER ORDER BY ID";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
%>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
</head>
<body>
	<%=if(s_id != null) {
		response.sendRedirect("Login.jsp");
	}
	else {
	%>
	<form name="update_Form" action="Update_Member_Action.jsp">
		<table border="1">
			<%while(rs.next()) { %>
			<tr>
				<td>아이디</td>
				<td><%=rs.getString("ID")%></td>
			</tr>
			<tr>
				<td>패스워드</td>
				<td><input type="password" name="pw" value="<%=rs.getString("PW")%>"></td>
			</tr>
			<tr>
				<td>성별</td>
				<td><input type="text" name="sex" value="<%=rs.getString("Sex") %>"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="address" value="<%=rs.getString("Address") %>"></td>
			</tr>
			<tr>
				<td>나이</td>
				<td><input type="text" name="age" value="<%=rs.getInt("Age")%>"></td>
			</tr>	
			<tr>
				<td>이름</td>
				<td><input type="text" name="name" value="<%=rs.getString("Name")%>"></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="phonenumber" value="<%=rs.getString("Phone_number")%>"></td>
			</tr>	
			<tr>
				<td>직업</td>
				<td><input type="text" name="job" value="<%=rs.getString("Job")%>"></td>
			</tr>
			<tr>
				<td colspan="1" align="center">
					<input type="submit" value="변경"></td>
			</tr>	
			<%} %>
		</table>
	</form>
	<%} %>
</body>
</html>
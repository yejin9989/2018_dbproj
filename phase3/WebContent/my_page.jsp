<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, phase3.*"%>
<%
	Connection conn = DBUtil.getMySQLConnection();

	String s_id = (String) session.getAttribute("s_id");
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM CUSTOMER WHERE Id = ?";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, s_id);
	rs = pstmt.executeQuery();
	rs.next();
	
%>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
</head>
<body>
	<br><br>
	<b><font size="6" color="gray">마이 페이지</font></b>
	<br><br><br>
	
	<table>

			<tr>
			<td id="title">아이디</td>
			<td><%=rs.getString("Id") %></td>
			</tr>
			
			<tr>
			<td id="title">비밀번호</td>
			<td><%=rs.getString("PW") %></td>
			</tr>
			
			<tr>
			<td id="title">성별</td>
			<td><%=rs.getString("Sex") %></td>
			</tr>
			
			<tr>
			<td id="title">주소</td>
			<td><%=rs.getString("Address") %></td>
			</tr>
			
			<tr>
			<td id="title">나이</td>
			<td><%=rs.getInt("Age") %></td>
			</tr>
			
			<tr>
			<td id="title">이름</td>
			<td><%=rs.getString("Name") %></td>
			</tr>
			
			<tr>
			<td id="title">전화번호</td>
			<td><%=rs.getString("Phone_number") %></td>
			</tr>
			
			<tr>
			<td id="title">직업</td>
			<td><%=rs.getString("Job") %></td>
			</tr>
			</table>
			
	<br>
	<input type="button" value="뒤로" onclick="location.href='Main.jsp'">
	<input type="button" value="구매내역 확인" onclick="location.href='checkPurchase.jsp'">
	<input type="button" value="회원정보 변경" onclick="location.href='ModifyPre.jsp'">
	<input type="button" value="회원탈퇴" onclick="location.href='DeleteForm.jsp'">

</body>
</html>
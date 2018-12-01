<%@ page import="database.DBUtil"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int age = 0;
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String[] sex = request.getParameterValues("sex");
	String address = request.getParameter("address");
	try {
		age = Integer.parseInt(request.getParameter("age"));
	} catch(NumberFormatException e) {
		age = 0;
	}
	String name = request.getParameter("name");
	String phonenumber = request.getParameter("phonenumber");
	String job = request.getParameter("job");
	
	Connection conn = DBUtil.getMySQLConnection();
	
	String sql = "insert into CUSTOMER values(?,?,?,?,?,?,?,?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, id);
	pstmt.setString(2, password);
	pstmt.setString(3, sex[0]);
	pstmt.setString(4, address);
	if(age == 0) {
		pstmt.setString(5, "");
	}
	else pstmt.setInt(5, age);
	pstmt.setString(6, name);
	pstmt.setString(7, phonenumber);
	pstmt.setString(8, job);
	pstmt.executeUpdate();
	
	DBUtil.close(pstmt);
	DBUtil.close(conn);
%>
</body>
</html>
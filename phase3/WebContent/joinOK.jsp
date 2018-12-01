<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="phase3.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	int age = 0;
	request.setCharacterEncoding("EUC-KR");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String sex = request.getParameter("sex");
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
	if(sex.equals("M")){
		pstmt.setString(3, "M");
		out.println(sex);
	}
	else{
		pstmt.setString(3, "F");
		out.println(sex);
	}
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
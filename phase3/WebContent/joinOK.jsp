<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="phase3.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

Connection conn = DBUtil.getMySQLConnection();
PreparedStatement pstmt = null;

	try{
		int age = 0;
		request.setCharacterEncoding("UTF-8");
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
		
		
		String sql = "insert into CUSTOMER values(?,?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		pstmt.setString(2, password);
		if(sex.equals("M"))
			pstmt.setString(3, "M");
		else
			pstmt.setString(3, "F");
		pstmt.setString(4, address);
		if(age == 0) {
			pstmt.setString(5, "");
		}
		else pstmt.setInt(5, age);
		pstmt.setString(6, name);
		pstmt.setString(7, phonenumber);
		pstmt.setString(8, job);
		pstmt.executeUpdate();%>
		<script>
		alert('회원가입 되었습니다. 환영합니다. :)');
		document.location.href="main.html";
		</script>
		<%
		//response.sendRedirect("main.html");
	} catch(SQLException e){
		e.printStackTrace();%>
		<script>
		alert('회원가입에 실패했습니다!');
		document.location.href="main.html";
		</script>");
	<%}
	DBUtil.close(pstmt);
	DBUtil.close(conn);
%>
</body>
</html>
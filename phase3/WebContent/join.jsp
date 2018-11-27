<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="phase3.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>COMP322003/004: Databases</title>
</head>
<body>
	<h2>회원가입하기</h2>
	
<%
	Connection conn = DBUtil.getMySQLConnection();
	PreparedStatement pstmt;
	ResultSet rs;
	
	////////query1///////
	String id = request.getParameter("ID");
	String pw = request.getParameter("PW");
	String query = "select * from customer where id = ?";
	pstmt = conn.prepareStatement(query);
	
	pstmt.setString(1, id);
	rs=pstmt.executeQuery();
	String password;
	rs.next();
	password = rs.getString("PW");
	////////////////////
%>

<%
	if(password.equals(pw)){
		out.println("환영합니다!");
		out.println("<script>");
		out.println("alert('로그인 되었습니다. 환영합니다. :)')");
		out.println("location.href='mypage.html");
		out.println("</script>");
	}else{
		out.println("일치하는 회원정보가 없습니다!");
		out.println("<script>");
		out.println("alert'해당하는 정보가 없습니다!)')");
		out.println("location.href='main.jsp");
		out.println("</script>");
	}
	pstmt.close();
	conn.close();
%>
</body>
</html>
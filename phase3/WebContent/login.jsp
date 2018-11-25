<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>COMP322003/004: Databases</title>
</head>
<body>
	<h2>환영합니다!</h2>
	
<%
	String serverIP = "localhost"; //ifconfig localhost
	String dbname = "Shoppingmall_X";
	String portNum = "3306";
	String url = "jdbc:mysql://"+serverIP+":"+portNum+"/"+dbname;
	String user = "root";
	String pass = "yejin159357";
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, pass);
	
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
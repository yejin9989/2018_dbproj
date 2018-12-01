<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="phase3.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TMI :: TooMuchItem</title>
</head>
<body>
	<h2>TMI :: TooMuchItem</h2>
	
<%
/*	String serverIP = "localhost"; //ifconfig localhost
	String dbname = "Shoppingmall_X";
	String portNum = "3306";
	String url = "jdbc:mysql://"+serverIP+":"+portNum+"/"+dbname;
	String user = "root";
	String pass = "yejin159357";
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, pass);*/
	//jsp내에서 연결을 해결했었으나,DBUtil클래스를 생성해 중복을 피했음.
	
	Connection conn = DBUtil.getMySQLConnection();
	PreparedStatement pstmt;
	ResultSet rs;
	
	////////query1///////
	String id = request.getParameter("ID");
	String pw = request.getParameter("PW"); //사용자가 login.html에서 입력한 id, 비밀번호
	String query = "select * from customer where id = ?";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, id);
	rs=pstmt.executeQuery();
	String password = "";
	String name = "";
	while(rs.next()){
		password = rs.getString("PW");
		name = rs.getString("Name");
	}

	pstmt.close();
	conn.close(); //비밀번호 정보를 가져왔으므로 디비 연결 종료  
	
	////////////////////
%>

<%
	if(password.equals(pw)){
		out.println("<script> alert('로그인 되었습니다. 환영합니다. :)'); </script>");
		session.setAttribute("userSession", name);
		response.sendRedirect("Main.jsp");
		
	}else{
		out.println("<script> alert(\"회원 정보가 없습니다\"); history.back(); </script>");
	}
%>
</body>
</html>
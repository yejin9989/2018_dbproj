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
	//jsp������ ������ �ذ��߾�����,DBUtilŬ������ ������ �ߺ��� ������.
	
	Connection conn = DBUtil.getMySQLConnection();
	PreparedStatement pstmt;
	ResultSet rs;
	
	////////query1///////
	String id = request.getParameter("ID");
	String pw = request.getParameter("PW"); //����ڰ� login.html���� �Է��� id, ��й�ȣ
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
	conn.close(); //��й�ȣ ������ ���������Ƿ� ��� ���� ����  
	
	////////////////////
%>

<%
	if(password.equals(pw)){
		out.println("<script> alert('�α��� �Ǿ����ϴ�. ȯ���մϴ�. :)'); </script>");
		session.setAttribute("userSession", name);
		response.sendRedirect("Main.jsp");
		
	}else{
		out.println("<script> alert(\"ȸ�� ������ �����ϴ�\"); history.back(); </script>");
	}
%>
</body>
</html>
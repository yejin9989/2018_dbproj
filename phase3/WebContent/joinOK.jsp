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
	String age2 = request.getParameter("age");
	String name = request.getParameter("name");
	String phonenumber = request.getParameter("phonenumber");
	String job = request.getParameter("job");
	
	Connection conn = DBUtil.getMySQLConnection();
	
	String sql = "insert into CUSTOMER values(?,?,?,?,?,?,?,?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, id);
	pstmt.setString(2, password);

	try {
	if(sex.equals("M")){
		pstmt.setString(3, "M");
		//out.println(sex);
	}
	else{
		pstmt.setString(3, "F");
		//out.println(sex);
	}
	} catch (Exception e) {
		%>
		<script>alert("���Կ� �����߽��ϴ�."); 
		<input type="button" value="ù ȭ������" onclick = "javascript:location.href='login.html'"/></script>
	<% }%>
<%
	pstmt.setString(4, address);
	
	try {
		age = Integer.parseInt(age2);
		pstmt.setInt(5, age);
	} catch(NumberFormatException e) {
		pstmt.setInt(5, 0);
	}
	
	pstmt.setString(6, name);
	pstmt.setString(7, phonenumber);
	pstmt.setString(8, job);
	try {
		pstmt.executeUpdate();
%>
	<br><br>
	<font size="4" color = "gray">ȸ�����ԵǾ����ϴ�!</font>
	<br><br>
	<input type="button" value="ù ȭ������" onclick = "javascript:location.href='login.html'"/>
	<%
	} catch (Exception e) {
	%>
	<script>
	alert("���Կ� �����߽��ϴ�."); 
	<input type="button" value="ù ȭ������" onclick = "javascript:location.href='login.html'"/>
	</script>
	<% }%>
<%
	DBUtil.close(pstmt);
	DBUtil.close(conn);
%>

	<br><br>
	<font size="4" color = "gray">���Կ� �����߽��ϴ�.</font>
	<br><br>
	<input type="button" value="ù ȭ������" onclick = "javascript:location.href='login.html'"/>
</body>
</html>
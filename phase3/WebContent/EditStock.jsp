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
ResultSet rs = null;
	try{
		request.setCharacterEncoding("UTF-8");

		String Rno = request.getParameter("Rno");
		String Ino = request.getParameter("Ino");
		String stock = request.getParameter("Stock");
		
		String sql = "UPDATE HAS_A set Stock = ? where Ino=? and Rno=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,stock);
		pstmt.setString(2,Ino);
		pstmt.setString(3,Rno);
		System.out.println(stock+" / "+Ino+" / "+Rno);
		pstmt.executeUpdate();
		%>
	<script>
	alert('재고수정을 완료했습니다.');
	document.location.href="Page_admin.jsp";
	</script>
	<%
	//response.sendRedirect("main.html");
} catch(SQLException e){
	e.printStackTrace();%>
	<script>
	alert('재고수정에 실패했습니다.');
	document.location.href="Page_admin.jsp";
	</script>");
<%} finally{
	DBUtil.close(pstmt);
	DBUtil.close(conn);
	DBUtil.close(rs);
}
%>
</body>
</html>
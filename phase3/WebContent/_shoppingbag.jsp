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
PreparedStatement pstmt1 = null;
Statement stmt = null;
	try{
		request.setCharacterEncoding("UTF-8");
		ResultSet rs = null;

		String id = request.getParameter("id");
		String Ino = request.getParameter("Ino");
		int num = Integer.parseInt(request.getParameter("num"));
		
		String query = "select * from SHOPPINGBAG where Purchase_item = ?";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, Ino);
		rs = pstmt.executeQuery();
		while(rs.next()){
			int quantity = rs.getInt("Quantity");
			String sql = "update SHOPPINGBAG set Quantity = ? where Purchase_item=? and Customer_id=?";
			pstmt1 = conn.prepareStatement(sql);
			
			pstmt1.setInt(1, num);
			pstmt1.setString(2, Ino);
			pstmt1.setString(3, id);
			pstmt1.executeUpdate();
		}
		%>
	<script>
	alert('수량 수정을 완료했습니다.');
	document.location.href="shoppingbag.jsp";
	</script>
	<%
	//response.sendRedirect("main.html");
} catch(SQLException e){
	e.printStackTrace();%>
	<script>
	alert('선택한 물품을 장바구니에 담지 못했습니다!');
	document.location.href="Main.jsp";
	</script>");
<%}
DBUtil.close(pstmt);
DBUtil.close(pstmt1);
DBUtil.close(conn);
%>
</body>
</html>
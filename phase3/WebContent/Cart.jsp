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
		System.out.println(id + "/" + Ino + "/" + num);
		String query = "select * from SHOPPINGBAG where Purchase_item = ? and Customer_id = ?";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, Ino);
		pstmt.setString(2, id);
		rs = pstmt.executeQuery();
		
		if(rs.isBeforeFirst()){
			rs.next();
			int quantity = rs.getInt("Quantity");
			String sql = "update SHOPPINGBAG set Quantity = ? where Purchase_item=? and Customer_id=?";
			pstmt1 = conn.prepareStatement(sql);
			
			pstmt1.setInt(1, quantity+num);
			pstmt1.setString(2, Ino);
			pstmt1.setString(3, id);
			pstmt1.executeUpdate();
			%>
			<script>
			if(confirm('선택한 물품을 장바구니에 담았습니다. 이미 담으신 상품입니다. 장바구니를 확인하시겠습니까?')){
					document.location.href="shoppingbag.jsp";
				}
			else
				{
					history.back();
				}
			</script>
			<%
		}
		else{
			String sql = "insert into SHOPPINGBAG values(?,?,?)";
			pstmt1 = conn.prepareStatement(sql);
			
			pstmt1.setString(1, id);
			pstmt1.setString(2, Ino);
			pstmt1.setInt(3, num);
			pstmt1.executeUpdate();
			%>
			<script>
			if(confirm('선택한 물품을 장바구니에 담았습니다. 장바구니를 확인하시겠습니까?')){
					document.location.href="shoppingbag.jsp";
				}
			else
				{
					history.back();
				}
			</script>
			<%
		}
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, phase3.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 삭제 처리</title>
</head>
<body>
	<%
		String id = (String)session.getAttribute("s_id");
		String pw = request.getParameter("password");
		
		Connection conn = DBUtil.getMySQLConnection();
		
		String sql = "delete from CUSTOMER where Id = ?, PW = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		int check = pstmt.executeUpdate();
		
		if(check == 1) {
			conn.commit();
	%>
		<br><br>
		<b><font size="4" color = "gray">회원정보가 삭제되었습니다.</font></b>
		<br><br><br>
		
		<input type="button" value="확인" onclick = "location.href='main.html'">
	<%
		}else {
	%>
		<script>
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
		</script>
	<%
		}
		DBUtil.close(pstmt);
		DBUtil.close(conn);
	%>
</body>
</html>
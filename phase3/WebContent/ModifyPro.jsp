<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, phase3.*"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정처리</title>
</head>
<body>
<%
   int age;
   String s_id = (String)session.getAttribute("s_id");
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
   
   Connection conn = DBUtil.getMySQLConnection();
   PreparedStatement pstmt = null;
   
   String sql = "UPDATE CUSTOMER SET PW = ?, Sex = ?, Address = ?, Age = ?, Name = ?, Phone_number = ?, Job = ? WHERE ID = ?";
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1,password);
   pstmt.setString(2,sex);
   pstmt.setString(3,address);
   if(age == 0) {
		pstmt.setString(4, "");
	}
	else pstmt.setInt(4, age);
   pstmt.setString(5,name);
   pstmt.setString(6,phonenumber);
   pstmt.setString(7, job);
   pstmt.setString(8, s_id);
   
   int check = pstmt.executeUpdate();
   
   if(check == 1) {
		conn.commit();
%>
	<br><br>
	<b><font size="4" color = "gray">회원정보가 수정되었습니다.</font></b>
	<br><br>
	<input type="button" value="메인으로" onclick = "location.href='Main.jsp'">
<%
	}else {
%>
	<script>
		alert("수정에 실패했습니다.");
		<input type="button" value="확인" onclick = "location.href='my_page.jsp'">
	</script>
<%
	}
	DBUtil.close(pstmt);
	DBUtil.close(conn);
%>
</body>
</html>
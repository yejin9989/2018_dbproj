<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, phase3.*"%>
 <% request.setCharacterEncoding("UTF-8"); %>
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
   String age2 = request.getParameter("age");
   String name = request.getParameter("name");
   String phonenumber = request.getParameter("phonenumber");
   String job = request.getParameter("job");
   
   Connection conn = DBUtil.getMySQLConnection();
   PreparedStatement pstmt = null;
   
   String sql = "UPDATE CUSTOMER SET PW = ?, Sex = ?, Address = ?, Age = ?, Name = ?, Phone_number = ?, Job = ? WHERE Id = ?";
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1,password);
   try {
   if(sex.equals("M")){
		pstmt.setString(2, "M");
		//out.println(sex);
	}
	else{
		pstmt.setString(2, "F");
		//out.println(sex);
	}
   } catch (NullPointerException e) {
	   pstmt.setString(2, "");
   }
   pstmt.setString(3,address);
   try {
		age = Integer.parseInt(age2);
		pstmt.setInt(4, age);
	} catch(NumberFormatException e) {
		pstmt.setInt(4, 0);
	}
   pstmt.setString(5,name);
   pstmt.setString(6,phonenumber);
   pstmt.setString(7, job);
   pstmt.setString(8, s_id);
   
	pstmt.executeUpdate();

	DBUtil.close(pstmt);
	DBUtil.close(conn);
%>

<br><br>
	<font size="4" color = "gray">회원정보가 수정되었습니다.</font>
<br><br>
	<input type="button" value="메인으로" onclick = "javascript:location.href='Main.jsp'"/>
</body>
</html>
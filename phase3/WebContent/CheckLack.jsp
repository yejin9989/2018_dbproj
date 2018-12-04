<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, phase3.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	Connection conn = DBUtil.getMySQLConnection();

	String s_id = (String) session.getAttribute("s_id");
	PreparedStatement pstmt = null;
	ResultSet rs = null;
%>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
	<br><br>
	<b><font size="6" color="gray">관리자 페이지</font></b>
	<br>
	<a href="Main.jsp" style="float:left;"> HOME </a>
	<br><br><br>
	
	<div class = "admin_cate">
		<a href="Additem.jsp">재고증가</a>
	 	| 
		<a href="CheckLack.jsp"><span style="color:red">재고 모자란 아이템</span></a>
	 	| 
		<a href="Revenue.jsp">매출 확인</a>
		<br><br><br>
	</div>
	
	<form action = "_CheckLack.jsp">
	지점명 : 
	<select name='RETAILER'>
    <option value='' selected>-- 선택 --</option>
    <option value='1'>서울특별시</option>
    <option value='2'>인천광역시</option>
    <option value='3'>대전광역시</option>
    <option value='4'>대구광역시</option>
    <option value='5'>울산광역시</option>
    
    <option value='6'>부산광역시</option>
    <option value='7'>광주광역시</option>
    <option value='8'>세종특별자치시</option>
    <option value='9'>강원도</option>
    <option value='10'>경기도</option>
    
    <option value='11'>충청북도</option>
    <option value='12'>충청남도</option>
    <option value='13'>전라북도</option>
    <option value='14'>전라남도</option>
    <option value='15'>경상북도</option>
    
    <option value='16'>경상남도</option>
    <option value='17'>제주특별자치도</option>
	</select>
	<input type="submit" value="go">
	</form>

</body>
</html>
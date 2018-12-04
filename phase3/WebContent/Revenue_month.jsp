<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, phase3.*, java.sql.Date, java.text.ParseException, java.text.SimpleDateFormat"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	Connection conn = DBUtil.getMySQLConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String query = "";
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
		<a href="CheckLack.jsp">재고 모자란 아이템</a>
	 	| 
		<a href="Revenue.jsp"><span style="color:red">매출 확인</span></a>
		<br><br><br>
	</div>

	<div class = "revenue_cate">
		<a href="Revenue_total.jsp">전체 매출</a>
	 	| 
		<a href="Revenue_month.jsp"><span style="color:red">월별 매출</span></a>
	 	| 
		<a href="Revenue_date.jsp">일별 매출</a>
		<br><br><br>
	</div><form action = "_month.jsp">
	<select name='year'>
    <option value='' selected>-- 선택 --</option>
    <option value='2016'>2016</option>
    <option value='2017'>2017</option>
    <option value='2018'>2018</option>
	</select>
	년
	<select name='month'>
    <option value='' selected>-- 선택 --</option>
    <option value='01'>1</option>
    <option value='02'>2</option>
    <option value='03'>3</option>
    <option value='04'>4</option>
    <option value='05'>5</option>
    
    <option value='06'>6</option>
    <option value='07'>7</option>
    <option value='08'>8</option>
    <option value='09'>9</option>
    <option value='10'>10</option>
    
    <option value='11'>11</option>
    <option value='12'>12</option>
	</select>
	월
	<input type="submit" value="go">
	</form><br>
	
</body>
</html>
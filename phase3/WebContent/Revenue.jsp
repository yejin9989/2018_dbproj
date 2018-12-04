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
		<a href="CheckLack.jsp">재고 모자란 아이템</a>
	 	| 
		<a href="Revenue.jsp"><span style="color:red">매출 확인</span></a>
		<br><br><br>
	</div>

	<div class = "revenue_cate">
		<a href="Revenue_total.jsp">전체 매출</a>
	 	| 
		<a href="Revenue_month.jsp">월별 매출</a>
	 	| 
		<a href="Revenue_date.jsp">일별 매출</a>
		<br><br><br>
	</div>
	
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, phase3.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	Connection conn = DBUtil.getMySQLConnection();

	String s_id = (String) session.getAttribute("s_id");
	Statement stmt = null;
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
		<a href="Revenue_total.jsp"><span style="color:red">전체 매출</span></a>
	 	| 
		<a href="Revenue_month.jsp">월별 매출</a>
	 	| 
		<a href="Revenue_date.jsp">일별 매출</a>
		<br><br><br>
	</div>
	
	<%
	query = "SELECT SUM(L.Pquantity * I.Price) "+
			"FROM ORDER_LIST L, ITEM I "+
			"WHERE L.Pitem = I.Item_number";
	
	stmt = conn.createStatement();
	rs = stmt.executeQuery(query);
	int sum = 0;
	while(rs.next()){
		sum = rs.getInt("SUM(L.Pquantity * I.Price)");
	}
	
	DBUtil.close(conn);
	DBUtil.close(stmt);
	DBUtil.close(rs);
	
	%>
	
	전체 매출액 : <%=sum%>원
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.sql.Date, phase3.*, java.util.*, java.text.ParseException, java.text.SimpleDateFormat"%>
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
	</select>월
	<input type="submit" value="go">
	</form>
	<br>
	
	<%
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String date = year+"-"+month+"-"+"01";
	String date2 = year+"-"+Integer.toString((Integer.parseInt(month)+1))+"-"+"01";
	
	Date d1 = Date.valueOf(date);
	Date d2 = Date.valueOf(date2);
	
	query = "SELECT SUM(L.Pquantity * I.Price) "+
			"FROM ORDER_LIST L, ITEM I, ORDER1 O "+
			"WHERE L.Pitem = I.Item_number "+
			"AND L.Order_num = O.Order_number "+
			"AND O.Order_date between ? and ?";
	
	pstmt = conn.prepareStatement(query);
	pstmt.setDate(1, d1);
	pstmt.setDate(2, d2);
	rs = pstmt.executeQuery();
	int sum = 0;
	while(rs.next()){
		sum = rs.getInt("SUM(L.Pquantity * I.Price)");
	}
	
	DBUtil.close(conn);
	DBUtil.close(pstmt);
	DBUtil.close(rs);
	
	%>
	
	<%=year%>년 <%=month%>월 매출액 : <%=sum%>원
</body>
</html>
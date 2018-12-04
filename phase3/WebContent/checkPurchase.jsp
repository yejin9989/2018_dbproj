<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="phase3.*,java.sql.*,java.util.*"%>
   <% request.setCharacterEncoding("UTF-8"); %>
<%
	ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
	Connection conn = DBUtil.getMySQLConnection();

	String s_id = (String) session.getAttribute("s_id");
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	MemberBean member = null;
	StringBuffer query = new StringBuffer();
	query.append("SELECT ORDER1.Order_date, ORDER_LIST.Order_num, ITEM.Item_name, ORDER_LIST.Pquantity FROM CUSTOMER, ITEM, ORDER1, ORDER_LIST WHERE CUSTOMER.Id = ? AND CUSTOMER.Id = ORDER1.Cid AND ORDER1.Order_number = ORDER_LIST.Order_num AND ITEM.Item_number = ORDER_LIST.Pitem ORDER BY ORDER1.Order_date");
	pstmt = conn.prepareStatement(query.toString());
	pstmt.setString(1, s_id);
	rs = pstmt.executeQuery();
	while(rs.next()) {
		member = new MemberBean();
		member.setDate(rs.getDate("Order_date"));
		member.setOrdernum(rs.getInt("Order_num"));
		member.setPitem(rs.getString("Item_name"));
		member.setPquantity(rs.getInt("Pquantity"));

		memberList.add(member);
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매내역 확인</title>
</head>
<body>
	<br><br>
	<b><font size="6" color="gray">전체 구매내역</font></b>
	<br><br>
	
	<table>
		<tr align = "center">
			<td id=title>주문날짜</td>
			<td id=title>주문번호</td>
			<td id=title>구매물품</td>
			<td id=title>수량</td>
		</tr>
		
		<%
			for(MemberBean member2 : memberList) {
		%>
			<tr align = "center">
				<td><%=member2.getDate() %></td>
				<td><%=member2.getOrdernum() %></td>
				<td><%=member2.getPitem() %></td>
				<td><%=member2.getPquantity() %></td>
			</tr>
		<%}%>
	</table>
	
	<input type="button" value="뒤로" onclick="location.href='my_page.jsp'">
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, phase3.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	Connection conn = DBUtil.getMySQLConnection();

	String s_id = (String) session.getAttribute("s_id");
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String query = "";
	String sql = "";
	
	String Rname = "";
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

	<%/*재고증가하려는 매장정보*/
	String Rno = request.getParameter("RETAILER");
	/*매장이름 찾아서 표시*/
	query = "SELECT Retailer_name FROM RETAILER WHERE Retailer_number = ?";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, Rno);
	rs = pstmt.executeQuery();
	while(rs.next())
		Rname=rs.getString("Retailer_name");%>
		
	<%=Rname%>점 : 재고가 부족한 아이템 목록<br><br>
	
	<%
	/*모든아이템 가져오기 */
	
	conn = DBUtil.getMySQLConnection();
	sql = "SELECT I.Item_image, I.Item_number, I.Item_name, H.Stock "+
			"FROM HAS_A H, ITEM I, RETAILER R "+
			"WHERE H.Rno = R.Retailer_number "+
			"AND H.Ino = I.Item_number "+
			"AND H.Stock = 0 "+
			"AND R.Retailer_number = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, Rno);
		rs = pstmt.executeQuery();
		String image = "";
		String Ino = "";
		String Itemname = "";
		int stock = 0;%>
		상품이미지 | 상품번호 | 상품이름 | 재고
		<br><br>
		<%
		while(rs.next()){
			image = rs.getString("I.Item_image");
			Ino = rs.getString("I.Item_number");
			Itemname = rs.getString("I.Item_name");
			stock = rs.getInt("H.Stock");
		%>
			<div class="image-box">
				<a href="board.jsp?Ino=<%=Ino %>">
					<img src="<%=image%>" width="50" height="50">
				</a>
			</div>
			<div class="box-itemnumber">
			    	<%=Ino%>
			</div>
			<div class="box-itemname">
			    	<%=Itemname%>
			</div>
		<form action="EditStock.jsp?Rno=<%=Rno%>&Ino=<%=Ino%>" method="post">
            <div class="box-itemquan">
				 <input type="number" name="Stock" value="<%=stock%>" min="<%=stock%>">개
				 <input type="submit" value="재고증가">
			</div>
		</form>
		<%}%>
</body>
</html>
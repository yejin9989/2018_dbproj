<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="phase3.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Connection conn = DBUtil.getMySQLConnection();
PreparedStatement pstmt = null;
PreparedStatement pstmt1 = null;
PreparedStatement pstmt2 = null;
Statement stmt = null;
ResultSet rs = null;
ResultSet rs1 = null;
String sql = "";
String query = "";

	try{
		/*장바구니에 물건이 있는지 확인*/
		query = "SELECT * FROM CUSTOMER C, SHOPPINGBAG B WHERE B.Customer_id = C.Id AND C.Id = ?";
		pstmt = conn.prepareStatement(query);
		String id = request.getParameter("id"); // 주문자 id 받아오기
		pstmt.setString(1,id);
		rs = pstmt.executeQuery();
		if(!rs.isBeforeFirst()){ 
			/*장바구니에 물건이 없다 : 돌아가기*/
		%>
		<script>
			alert('장바구니에 구매할 제품이 없습니다!')
			history.back();
		</script>
		<%
		}
		
		/*주문번호 생성*/
		/*code*/
		
		/*현재날짜 받아오기*/
		/*code*/
		
		/*사용자 주소 근처 매장에 충분한 재고가 있는지 확인*/
		request.setCharacterEncoding("UTF-8");
		System.out.println(id);
		query = "SELECT distinct C.Name, I.Item_number, I.Item_name, H.Stock, B.Quantity, R.Retailer_number "+
				"FROM SHOPPINGBAG B, CUSTOMER C, RETAILER R, HAS_A H, ITEM I "+
				"WHERE B.Customer_id = C.Id "+
				"AND H.Ino = B.Purchase_item "+
				"AND H.Ino = I.Item_number "+
				"AND H.Rno = R.Retailer_number "+
				"AND EXISTS (SELECT NULL "+
				                 "FROM RETAILER R1 "+
				                "WHERE C.Address LIKE CONCAT('%', R1.Retailer_name, '%') "+
								"AND R.Retailer_number = R1.Retailer_number) "+
				"AND EXISTS (SELECT NULL "+
					         "WHERE H.Stock < B.Quantity) "+
				"AND C.Id = ?";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		if(rs.isBeforeFirst()){//근처 매장에 재고가 부족한 제품이 있다.%>
	<script>
			if(!confirm('근처 매장의 재고가 모두 소진되어 구매할 수 없습니다. 재고가 있는 타 지역 매장에서 구매 하시겠습니까?'))
				document.location.href="Main.jsp"; //No선택시 메인화면으로 돌아가기
	</script>
		<%
		rs.next();
		String inum = "";
		int quan = 0;
		int Rnum = 0;
		int stock = 0;
			/*yes선택시 재고가 충분한 다른 매장에서 구입함*/
		do{
			/*재고가 충분한 매장 찾기(1개만 선택)*/
			sql = "SELECT C.Name, I.Item_number, H.Stock, B.Quantity, R.Retailer_name "+
					"FROM SHOPPINGBAG B, CUSTOMER C, RETAILER R, HAS_A H, ITEM I "+
					"WHERE B.Customer_id = C.Id "+
					"AND H.Ino = B.Purchase_item "+
					"AND H.Ino = I.Item_number "+
					"AND H.Rno = R.Retailer_number "+
					"AND EXISTS (SELECT NULL "+
						    "WHERE H.Stock >= B.Quantity) "+
					"AND C.Id = ? "+
					"ORDER BY R.Retailer_name DESC limit 1 ";
		
			pstmt1 = conn.prepareStatement(sql);
			pstmt1.setString(1, id);
			rs1 = pstmt1.executeQuery();
			while(rs1.next()){
				inum = rs1.getString("I.Item_number");
				quan = rs1.getInt("B.Quantity");
				Rnum = rs1.getInt("R.Retailer_number");
				stock = rs1.getInt("H.Stock");
			}
			int nowstock = stock-quan;
			sql = "UPDATE HAS_A SET Stock = ? where Ino=? and Rno=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1,nowstock);
			pstmt2.setString(2,inum);
			pstmt2.setInt(3,Rnum);
			pstmt2.executeUpdate();
			/*구매한 매장 재고 깎기*/
			}while(rs.next());
		}
		else{
			/*구매가능한 제품은 근처매장에서 구입하기*/
			query = "SELECT distinct C.Name, I.Item_number, I.Item_name, H.Stock, B.Quantity, R.Retailer_number "+
					"FROM SHOPPINGBAG B, CUSTOMER C, RETAILER R, HAS_A H, ITEM I "+
					"WHERE B.Customer_id = C.Id "+
					"AND H.Ino = B.Purchase_item "+
					"AND H.Ino = I.Item_number "+
					"AND H.Rno = R.Retailer_number "+
					"AND EXISTS (SELECT NULL "+
					                 "FROM RETAILER R1 "+
					                "WHERE C.Address LIKE CONCAT('%', R1.Retailer_name, '%') "+
									"AND R.Retailer_number = R1.Retailer_number) "+
					"AND EXISTS (SELECT NULL "+
						         "WHERE H.Stock >= B.Quantity) "+
					"AND C.Id = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				/*구매한 매장 재고 깎기*/
				int Rnum = rs.getInt("R.Retailer_number");
				int stock = rs.getInt("H.Stock");
				int quan = rs.getInt("B.Quantity");
				String inum = rs.getString("I.Item_number");
				int nowstock = stock-quan;
				sql = "UPDATE HAS_A SET Stock = ? where Ino=? and Rno=?";
				pstmt2 = conn.prepareStatement(sql);
				pstmt2.setInt(1,nowstock);
				pstmt2.setString(2,inum);
				pstmt2.setInt(3,Rnum);
				pstmt2.executeUpdate();
			}
			/*구매내역 업데이트*/
		}
		
	} catch(SQLException e){
		e.printStackTrace();
		}%>
</body>
</html>
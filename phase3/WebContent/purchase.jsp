<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.util.Random" %>
<%@ page language="java" import="phase3.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

request.setCharacterEncoding("UTF-8");

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
			document.location.href="Main.jsp"; 
		</script>
		<%
		}

		/*현재날짜 받아오기*/
		Calendar cal = Calendar.getInstance();
		String year = Integer.toString(cal.get(Calendar.YEAR));
		String month = Integer.toString(cal.get(Calendar.MONTH)+1);
		String date = Integer.toString(cal.get(Calendar.DATE));
		String today = year + month + date;
		String todayformat = year+"-"+month+"-"+date;
		/*code*/
		
		/*주문번호 생성*/
		int order_num = 0;
		do{
			Random random = new Random();
			int o = random.nextInt(99)+1;
			query = "SELECT * " +
					"FROM ORDER1 "+
					"WHERE Order_number = ?";
			pstmt = conn.prepareStatement(query);
			order_num = Integer.parseInt(o+today);
			pstmt.setInt(1,order_num);
			rs=pstmt.executeQuery();
		}while(rs.isBeforeFirst());
		DBUtil.close(pstmt);pstmt=null;
		DBUtil.close(rs);rs=null;
		query = "";

		System.out.println(order_num);
		/*code*/
		
		
		/*사용자 주소 근처 매장에 충분한 재고가 있는지 확인*/
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
		if(rs.isBeforeFirst()){//근처 매장에 재고가 부족한 제품이 있다.
			
			/*
	<script>
			if(!confirm('근처 매장의 재고가 모두 소진되어 구매할 수 없습니다. 재고가 있는 타 지역 매장에서 구매 하시겠습니까?'))
				document.location.href="Main.jsp"; //No선택시 메인화면으로 돌아가기
	</script>
				*/
		
			rs.next();
			String inum = "";
			int quan = 0;
			int Rnum = 0;
			int stock = 0;
			/*yes선택시 재고가 충분한 다른 매장에서 구입함*/
			/*재고가 충분한 매장 찾기(1개만 선택)*/
			sql = "SELECT R.Retailer_number "+
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
			if(!rs1.isBeforeFirst()){
				/*재고가 있는 매장이 없다 : 돌아가기*/
				%>
				<script>
					alert('현재 재고가 충분한 매장이 없습니다.')
					document.location.href="Main.jsp"; 
				</script>
				<%
				}
			while(rs1.next()){ //구매할 매장 정보 가져오기
				Rnum = rs1.getInt("R.Retailer_number");
			}
			sql = "";
			DBUtil.close(pstmt1);pstmt1 = null;
			DBUtil.close(rs1);rs1 = null;

			/*매장에서 구매할 제품의 현재 재고, 제품 사야할 수량, 받아와서 재고깎기*/
			sql = "SELECT distinct C.Name, I.Item_number, H.Stock, B.Quantity, R.Retailer_number "+
					"FROM SHOPPINGBAG B, CUSTOMER C, RETAILER R, HAS_A H, ITEM I "+
					"WHERE B.Customer_id = C.Id "+
					"AND H.Ino = B.Purchase_item "+
					"AND H.Ino = I.Item_number "+
					"AND H.Rno = R.Retailer_number "+
					"AND EXISTS (SELECT NULL "+
						    "WHERE H.Stock >= B.Quantity) "+
					"AND C.Id = ? "+
					"AND R.Retailer_number = ?";
		
			pstmt1 = conn.prepareStatement(sql);
			pstmt1.setString(1, id);
			pstmt1.setInt(2, Rnum);
			rs1 = pstmt1.executeQuery();
			int nowstock = stock-quan;
			
			/*order1에 추가*/
			sql = "insert into ORDER1 values(?,?,?,?)";
			PreparedStatement pstmt3 = conn.prepareStatement(sql);
			pstmt3.setString(1,id);
			pstmt3.setInt(2,order_num);
			pstmt3.setString(3,todayformat);
			pstmt3.setInt(4,Rnum);
			pstmt3.executeUpdate();
			DBUtil.close(pstmt3);pstmt3=null;
			/**/
			
			while(rs1.next()){
				inum = rs1.getString("I.Item_number");
				quan = rs1.getInt("B.Quantity");
				Rnum = rs1.getInt("R.Retailer_number");
				stock = rs1.getInt("H.Stock");
				nowstock = stock-quan;
				
				/*구매한 매장 재고 깎기*/
				sql = "UPDATE HAS_A SET Stock = ? where Ino=? and Rno=?";
				pstmt2 = conn.prepareStatement(sql);
				pstmt2.setInt(1,nowstock);
				pstmt2.setString(2,inum);
				pstmt2.setInt(3,Rnum);
				pstmt2.executeUpdate();
				
				/*초기화*/
				sql = "";
				DBUtil.close(pstmt2); pstmt2 = null;
				
				/*orderlist에 추가*/
				sql = "insert into ORDER_LIST values(?,?,?)";
				pstmt2 = conn.prepareStatement(sql);
				pstmt2.setInt(1,order_num);
				pstmt2.setString(2,inum);
				pstmt2.setInt(3,quan);
				pstmt2.executeUpdate();
			}
			
		}
		else{
			/*매장정보 받아오기위한 쿼리*/
			query = "SELECT distinct R.Retailer_number "+
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
			pstmt1 = conn.prepareStatement(query);
			pstmt1.setString(1, id);
			rs = pstmt1.executeQuery();
			
			int Rnum = 0;
			int stock = 0;
			int quan = 0;
			String inum = "";
			int nowstock = 0;
			
			while(rs.next()){//매장 정보 받아오기
				Rnum = rs.getInt("R.Retailer_number");
			}
			query = "";
			DBUtil.close(pstmt1);pstmt1=null;
			DBUtil.close(rs); rs=null;
			
			/*order1에 추가*/
			sql = "insert into ORDER1 values(?,?,?,?)";
			PreparedStatement pstmt3 = conn.prepareStatement(sql);
			pstmt3.setString(1,id);
			pstmt3.setInt(2,order_num);
			pstmt3.setString(3,todayformat);
			pstmt3.setInt(4,Rnum);
			pstmt3.executeUpdate();
			DBUtil.close(pstmt3);pstmt3=null;
			/**/
			
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
			pstmt1 = conn.prepareStatement(query);
			pstmt1.setString(1, id);
			rs = pstmt1.executeQuery();
			
			while(rs.next())
			{
				/*구매한 매장 재고 깎기*/
				Rnum = rs.getInt("R.Retailer_number");
				stock = rs.getInt("H.Stock");
				quan = rs.getInt("B.Quantity");
				inum = rs.getString("I.Item_number");
				nowstock = stock-quan;
				sql = "UPDATE HAS_A SET Stock = ? where Ino=? and Rno=?";
				pstmt2 = conn.prepareStatement(sql);
				pstmt2.setInt(1,nowstock);
				pstmt2.setString(2,inum);
				pstmt2.setInt(3,Rnum);
				pstmt2.executeUpdate();
				
				/*초기화*/
				DBUtil.close(pstmt2); pstmt2 = null;
				sql = "";
				/*구매내역 업데이트*/
				sql = "insert into ORDER_LIST values(?,?,?)";
				pstmt2 = conn.prepareStatement(sql);
				pstmt2.setInt(1,order_num);
				pstmt2.setString(2,inum);
				pstmt2.setInt(3,quan);
				pstmt2.executeUpdate();
			}
			
		}
		sql = "";
		DBUtil.close(pstmt); pstmt=null;
		sql = "DELETE FROM SHOPPINGBAG WHERE Customer_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		%>
		<script>
		alert('물품을 성공적으로 구매했습니다');
		document.location.href="Main.jsp";
		</script>");
	<%
	} catch(SQLException e){
		e.printStackTrace();%>
		<script>
		alert('물품 구매에 실패했습니다');
		document.location.href="Main.jsp";
		</script>");
	<%
	} finally{
		DBUtil.close(conn);
		DBUtil.close(pstmt);
		DBUtil.close(pstmt1);
		DBUtil.close(pstmt2);
		DBUtil.close(stmt);
		DBUtil.close(rs);
		DBUtil.close(rs1);
	}%>
</body>
</html>
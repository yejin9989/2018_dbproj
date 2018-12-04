<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="phase3.*" %>

<!DOCTYPE html>
<html>
<head>
<style>
	#topMenu
	{ 
	height: 30px; /* ���� �޴��� ���� */
	width: 850px; /* ���� �޴��� ���� */ 
	}
	
	#topMenu ul 
	{ 
	/* ���� �޴� ���� ul�� ������: �����޴��� ul+���� �޴��� ul */ 
	list-style-type: none; /* ���� �޴� ���� ul ������ ��� ǥ�ø� ������ */ 
	margin: 0px; /* ���� �޴� ���� ul�� margin�� ���� */ 
	padding: 0px; /* ���� �޴� ���� ul�� padding�� ���� */ 
	}
	
	#topMenu ul li { 
	/* ���� �޴� �ȿ� ul �±� �ȿ� �ִ� li �±��� ��Ÿ�� ����(����/�����޴� ���) */ 
	color: white; /* �۾� ���� ������� ���� */ 
	background-color: #2d2d2d; /* ��� ���� RGB(2D2D2D)�� ���� */ 
	float: left; /* �������� �����ǵ��� ���� */ 
	line-height: 30px; /* �ؽ�Ʈ �� ���� ���̸� 30px�� ���� */ 
	vertical-align: middle; /* ���� ������ ����� ���� */ 
	text-align: center; /* �ؽ�Ʈ�� ����� ���� */ 
	position: relative; /* �ش� li �±� ������ top/left ������ �ʱ�ȭ */ 
	} 
	
	.menuLink, .submenuLink { 
	/* ���� �޴��� ���� �޴��� a �±׿� �������� ������ ��Ÿ�� */ 
	text-decoration:none; /* a �±��� �ٹ� ȿ�� ���� */ 
	display: block; /* a �±��� Ŭ�� ������ ���� */ 
	width: 150px; /* �⺻ ���̸� 150px�� ���� */ 
	font-size: 12px; /* ��Ʈ ����� 12px�� ���� */ 
	font-weight: bold; /* ��Ʈ�� ���� ���� */ 
	font-family: "Trebuchet MS", Dotum; /* �⺻ ��Ʈ�� ����/�ѱ� ������� ���� */ 
	} 
	
	.menuLink { 
	/* ���� �޴��� �۾����� ������� ���� */ 
	color: white; 
	} 
	
	.topMenuLi:hover .menuLink { 
	/* ���� �޴��� li�� ���콺���� �Ǿ��� �� ��Ÿ�� ���� */ 
	color: red; /* �۾� �� ������ */ 
	background-color: #4d4d4d; /* ������ ���� ȸ������ ���� */ 
	} 
	
	.submenuLink {
	 /* ���� �޴��� a �±� ��Ÿ�� ���� */ 
	 color: #2d2d2d; /* �۾� ���� RGB(2D2D2D)�� ���� */ 
	 background-color: white; /* ������ ������� ���� */ 
	 border: solid 1px black; /* �׵θ��� ���� */ 
	 margin-top: -1px; /* �� ĭ�� �ϴ� �׵θ��� �Ʒ�ĭ�� ��� �׵θ��� ���������� �� */ 
	 } 
	 
	 .longLink { 
	 /* �� �� �� �޴� ��Ÿ�� ���� */ 
	 width: 190px; /* ���̴� 190px�� ���� */ 
	 } 
	 
	 .submenu { 
	 /* ���� �޴� ��Ÿ�� ���� */ 
	 position: absolute; /* html�� flow�� ������ ��ġ�� �ʰ� absolute ���� */ 
	 height: 0px; /* �ʱ� ���̴� 0px�� ���� */ 
	 overflow: hidden; /* �� ������ ���̺��� Ŀ���� �ش� ���� ���� */ 
	 transition: height .2s; /* height�� ��ȭ ������ �� 0.2�ʰ� ��ȭ �ǵ��� ����(�⺻) */ 
	 -webkit-transition: height .2s; /* height�� ��ȭ ������ �� 0.2�ʰ� ��ȭ �ǵ��� ����(������ ũ��/���Ķ��) */ 
	 -moz-transition: height .2s; /* height�� ��ȭ ������ �� 0.2�ʰ� ��ȭ �ǵ��� ����(������ ����) */ 
	 -o-transition: height .2s; /* height�� ��ȭ ������ �� 0.2�ʰ� ��ȭ �ǵ��� ����(������ �����) */ 
	 } 
	 
	 .topMenuLi:hover .submenu {
	  /* ���� �޴��� ���콺 ����� ��� �� ���� ���� �޴� ��Ÿ�� ���� */
	  height: 93px; /* ���̸� 93px�� ���� */ 
	  }
	  
	   .submenuLink:hover { 
	   /* ���� �޴��� a �±��� ���콺 ���� ��Ÿ�� ���� */ 
	   color: red; /* �۾����� ���������� ���� */ 
	   background-color: #dddddd; /* ����� RGB(DDDDDD)�� ���� */ 
	   } 
	   
	   </style>
<meta charset="EUC-KR">
<title>TMI :: TooMuchItem</title>
</head>
<body>
	<h2>TMI :: TooMuchItem</h2>
	<div class = "greetID">
		<%	// ���� �����ͼ� �̸� ����
			String name = session.getAttribute("userSession") + "";
		%>
		<a href="Main.jsp" style="float:left;"> HOME </a>
		<b> <%=name%>�� &nbsp; </b>
		
		<% if(name.equals("admin")) { %>
		<a href="Page_admin.jsp"> ������ </a> |	<%} %>
		<a href="my_page.jsp">����������</a>
		<a href="_logout.jsp"> �α׾ƿ� </a>
		
	</div>
	
	<form action = "search.jsp">
	<input type = "text" name = "searchitem"/>
	<input type= "submit" value = "SEARCH"/>
	</form>
	
	
		<%
		Connection conn = DBUtil.getMySQLConnection();
		Statement stmt = conn.createStatement();
		String sql = "select * from ITEM";
		ResultSet rs = stmt.executeQuery(sql);
		String Ino = "";
		String Itemname = "";
		String image = "";
		int Itemprice;
		while(rs.next()){
			Ino = rs.getString("Item_number");
			Itemname = rs.getString("Item_name");
			//�̰� image = rs.getString("Item_image");
			Itemprice = rs.getInt("Price");
		%>
		<div class="box">
			<div class="image-box">
				<a href="Board.jsp?Ino=<%=Ino %>">
					//�̰� <img src="<%=image%>" width="300" height="300">
				</a>
			</div>

	        <div class="box-underimage">
		    	<div class="box-itemname">
			    	<%=Itemname%>
			    </div>
                <div class="box-itemprice">
				 	<%=Itemprice%>��
				</div>
			</div>
		</div>
		<%} %>
</body>
</html>
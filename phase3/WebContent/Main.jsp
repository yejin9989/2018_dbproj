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
	
	<nav id="topMenu" >
	<ul>
	<li class="topMenuLi">
	<a class="menuLink" href="http://unikys.tistory.com/category/Programming%20Lecture">LECTURES</a>
	<ul class="submenu">
	<li>
	<a href="http://unikys.tistory.com/category/Programming%20Lecture/%EC%86%8D%EA%B9%8A%EC%9D%80%20%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%20%EA%B0%95%EC%A2%8C" class="submenuLink longLink">�ӱ��� �ڹٽ�ũ��Ʈ ����</a>
	</li>
	<li>
	<a href="http://unikys.tistory.com/category/Programming%20Lecture/%EB%B0%91%EB%B0%94%EB%8B%A5%EB%B6%80%ED%84%B0%20%ED%99%88%ED%8E%98%EC%9D%B4%EC%A7%80%20%EB%A7%8C%EB%93%A4%EA%B8%B0" class="submenuLink longLink">�عٴں��� Ȩ������ �����</a>
	</li>
	<li>
	<a href="http://unikys.tistory.com/category/Programming%20Lecture/Android%28%EC%95%88%EB%93%9C%EB%A1%9C%EC%9D%B4%EB%93%9C%29%20%EC%95%B1%20%EA%B0%9C%EB%B0%9C" class="submenuLink longLink">�ȵ���̵� �� ����</a>
	</li>
	</ul>
	</li>
	<li>|
	</li>
	<li class="topMenuLi">
	<a class="menuLink" href="http://unikys.tistory.com/guestbook">GUEST BOOK</a>
	</li>
	<li>|
	</li>
	<li class="topMenuLi">
	<a class="menuLink" href="http://unikys.tistory.com/tag">TAG CLOUD</a>
	<ul class="submenu">
	<li>
	<a href="http://unikys.tistory.com/tag/%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8" class="submenuLink">�ڹٽ�ũ��Ʈ</a>
	</li>
	<li>
	<a href="http://unikys.tistory.com/tag/%EA%B0%95%EC%A2%8C" class="submenuLink">����</a>
	</li>
	<li>
	<a href="http://unikys.tistory.com/tag/K100D" class="submenuLink">K100D</a>
	</li>
	</ul>
	</li>
	<li>|
	</li>
	<li class="topMenuLi">
	<a class="menuLink" href="http://unikys.tistory.com/media">MEDIA LOG</a>
	</li> <li>|</li> <li class="topMenuLi">
	<a class="menuLink" href="http://unikys.tistory.com/location">LOCATION LOG</a>
	</li>
	</ul>
	</nav>

	
		<%
		Connection conn = DBUtil.getMySQLConnection();
		Statement stmt = conn.createStatement();
		String sql = "select * from Item";
		ResultSet rs = stmt.executeQuery(sql);
		String Ino = "";
		String Itemname = "";
		String image = "";
		int Itemprice;
		while(rs.next()){
			Ino = rs.getString("Item_number");
			Itemname = rs.getString("Item_name");
			image = rs.getString("Item_image");
			Itemprice = rs.getInt("Price");
		%>
		<div class="box">
			<div class="image-box">
				<a href="Board.jsp?Ino=<%=Ino %>">
					<img src="<%=image%>" width="300" height="300">
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
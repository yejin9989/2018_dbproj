<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Item</title>
</head>
<body>
<%
	String id = request.getParameter("ID");
	out.println(id + "<br/>");
%>
itemlist----<br/>
item1<br/>
item2<br/>
...<br/>
</body>
</html>
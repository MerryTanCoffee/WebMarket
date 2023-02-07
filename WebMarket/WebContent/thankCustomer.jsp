<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLDecoder"%>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" />
<title>주문 완료</title>
</head>
<body>
	<%
		//::TODO
		// 아래 나오는 항목들로 값을 받아서 설정
		String shopping_cartId = "";
		String shopping_shoppingDate = "";
	
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for(int i = 0; i < cookies.length; i++) {
				Cookie thisCookie = cookies[i];
				String n = thisCookie.getName();
				
				if(n.equals("Shopping_cartId")) {
					shopping_cartId = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
				}
				if(n.equals("Shopping_shoppingDate")) {
					shopping_shoppingDate = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
				}
			}
		}
	%>
	<%@ include file="menu.jsp" %>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 완료</h1>
		</div>
	</div>
	<div class="container">
		<h2 class="alert alert-danger">주문해주셔서 감사합니다.</h2>
		<p>주문은	<% out.println(shopping_shoppingDate); %>에 배송될 예정입니다! !	
		<p>주문번호 : <% out.println(shopping_cartId);	%>
	</div>
	<div class="container">
		<p><a href="./products.jsp" class="btn btn-secondary"> &laquo; 상품 목록</a>
	</div>
</body>
</html>
<%
	//:::TODO
	// 주문이 완료되었기 떄문에, 장바구니에 저장된  session과 주문 진행중에 등록된 쿠키를 전부 삭제한다.
	session.invalidate();
	for(int i = 0; i < cookies.length; i++){
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();

		if(n.equals("Shopping_cartId")) {
			thisCookie.setMaxAge(0);
		}
		if(n.equals("Shopping_shoppingDate")) {
			shopping_shoppingDate = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
		}
	}
%>
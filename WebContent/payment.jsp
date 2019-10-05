<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*, java.text.*,java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>결제 페이지</title>
</head>
<body>
<h4>결제 하실 상품의 정보는 다음과 같습니다.</h4>
<form action=payment1.jsp method=post>
<%
 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd");
 String today = formatter.format(new java.util.Date());
 String Price=request.getParameter("Price");
 String Book_name=request.getParameter("Book_name");
 String Count=request.getParameter("Count");
 String Book_id=request.getParameter("Book_id");
 String Point = request.getParameter("Point");
 String C_ssn= (String)session.getAttribute("C_ssn");

 Connection conn =null;
 Statement stmt=null;
 ResultSet rs=null;
 int point = 0;


try
{
	Class.forName("org.gjt.mm.mysql.Driver");
	String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //내 주소와 포트, DB위치
	String userId = "root";
	String userPass = "ehql413";
	
	conn = DriverManager.getConnection(jdbcUrl,userId,userPass);
	if(conn==null)
		throw new Exception("데이터베이스에 연결할 수 없습니다.");
	stmt = conn.createStatement();
	
	
	
	String sql1 = String.format("SELECT Point FROM member WHERE C_ssn = "+C_ssn+";");
	rs = stmt.executeQuery(sql1);
	while(rs.next()){
		point = rs.getInt(1);
	}
	Point = Integer.toString(point);
}

finally
{
	try{
		stmt.close();
	}
	catch(Exception ignored){
		
	}
	try{
		conn.close();
	}
	catch(Exception ignored){
		
	}
	try{
		rs.close();
	}
	catch(Exception ignored){
		
	}
}
	
 
%>
<table border=1>

<tr><td>입금일자 : </td><td><input type=text name=pay_date maxlength="20" size="12" value = <%=today %> readonly = true></td></tr>
<tr><td>책 이름 : </td><td><input type=text name=Book_name maxlength="20" size="12" value = <%=Book_name %> readonly = true></td></tr>
<tr><td>책 아이디 : </td><td><input type=text name=Book_id maxlength="20" size="12" value = <%=Book_id %> readonly = true></td></tr>
<tr><td>남은 책 권수 : </td><td><input type=text name=Count maxlength="20" size="12" value = <%=Count %> readonly = true></td></tr>
<tr><td>책 금액 : </td><td><input type=text name=Price maxlength="20" size="12" value = <%=Price %> readonly = true></td></tr>
<tr><td>사용 가능 포인트 : </td><td><input type=text name=Point maxlength="20" size="12" value = <%=Point %> readonly=true></td></tr>
</table>

<p style="color:blue">* 입금자와 은행명을 입력해주세요.</p>

<table border=1>
<tr><td>입금자 : </td><td><input type=text name=Buyer maxlength="20" size="12" ></td></tr>
<tr><td>은행명 : </td><td><input type=text name=Bank_name maxlength="20" size="12"></td></tr>
<tr><td>사용포인트 : </td><td><input type=text name=Use_point maxlength="20" size="12" value = <%=Point %>></td></tr>
<p style="color:blue">* 포인트를 제외한 금액이 결제됩니다.</p>
</table>
<input type = submit value ="확인">
<input type = reset value ="취소">
</form>
</body>
</html>

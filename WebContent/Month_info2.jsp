<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR" import = "java.sql.*" %>
    <%

String is_manager = (String)session.getAttribute("manager");
if(null == is_manager){
   response.sendRedirect("ManagerLogin.html"); 
}
Class.forName("org.gjt.mm.mysql.Driver");

String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //내 주소와 포트, DB위치
String userId = "root";
String userPass = "ehql413";
String C_ssn= (String)session.getAttribute("C_ssn");
int total_price = 0;
Connection conn=null; //DB 연결 변수
Statement stmt=null;  //Statement 생성 변수
ResultSet rs=null;    //결과값 변수
ResultSet rs2=null; 

String month_info = request.getParameter("month_info");   
if(month_info==null)
throw new Exception("데이터를 입력하세요.");

try {
	conn=DriverManager.getConnection(jdbcUrl,userId,userPass);
	stmt=conn.createStatement();
	
	String date = "SELECT DISTINCT DATE FROM sale_info";
	rs = stmt.executeQuery(date);
	
	while(rs.next()){
		
		String month = rs.getString(1);
		String[] dateArray = month.split("-");
		String year_month = String.format(dateArray[0]+'-'+dateArray[1]);
		if(year_month.equals(month_info)){
			String month_select = String.format("SELECT * FROM sale_info WHERE DATE LIKE '%s-%%'",year_month);
			rs.close();
			rs = stmt.executeQuery(month_select);
			break;
		}
	}
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

		 <table border="1" cellspacing="1">
		 <tr>
		 <td>Sale_number</td>
		 <td>Date</td>
		 <td>Price</td>
		 <td>Book_id</td>
		 <td>M_ssn</td>
		 <TD>비고</TD>

		 </tr>
		 <%
		 while(rs.next()){
		 	

		 %><tr>
		 <td><%=rs.getInt(1) %></td>
		 <td><%=rs.getString(2) %></td>
		 <td><%=rs.getInt(3) %></td>
		 <td><%=rs.getString(4) %></td>
		 <td><%=rs.getString(5) %></td>
<%
total_price += rs.getInt(3);
%>
		 <TD>

		 <A href="">정보</A>

		 </TD>
		 </tr>
		 <%
		 }
		 %></table>
		 
		 <table border=1>

<tr><td>TOTAL PRICE : <%=total_price %></td>
</table>
<%
rs.close();
stmt.close();
conn.close();

}catch(SQLException e){
out.println("err"+e.toString());
}
%>
</body>
</html>
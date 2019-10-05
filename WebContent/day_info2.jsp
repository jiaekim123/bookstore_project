<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR" import = "java.sql.*"%>
   
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
String date_select = "";
String day_info = request.getParameter("date_info");   
if(day_info==null)
throw new Exception("데이터를 입력하세요.");
Connection conn=null; //DB 연결 변수
Statement stmt=null;  //Statement 생성 변수
ResultSet rs=null;    //결과값 변수

try {
	conn=DriverManager.getConnection(jdbcUrl,userId,userPass);
	stmt=conn.createStatement();

String date_info = String.format("SELECT * FROM sale_info WHERE DATE = '%s';",day_info);
rs = stmt.executeQuery(date_info);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h3>일별 지출액</h3>
	 <table border="1" cellspacing="1">
		 <tr>
		 <td>Sale_number</td>
		 <td>Date</td>
		 <td>Price</td>
		 <td>Book_id</td>
		 <td>M_ssn</td>
		 <td>Book_count</td>
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
		 <td><%=rs.getInt(6) %></td>

		 <TD>

		 <A href="">정보</A>

		 </TD>
		 </tr>
		 <%
		 }
		 %></table>
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
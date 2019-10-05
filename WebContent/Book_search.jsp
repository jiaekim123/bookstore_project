<%@ page language="java" contentType="text/html; charset=utf-8"
import = "java.sql.*" %>


<%
Class.forName("org.gjt.mm.mysql.Driver");

String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //내 주소와 포트, DB위치
String userId = "root";
String userPass = "ehql413";

Connection conn=null; //DB 연결 변수
Statement stmt=null;  //Statement 생성 변수
ResultSet rs=null;    //결과값 변수
String sql = null;
String Book_name = request.getParameter("Book_name");
String Book_writer = request.getParameter("writer");
String Book_type = request.getParameter("type");


try {
   conn=DriverManager.getConnection(jdbcUrl,userId,userPass);
   
   stmt=conn.createStatement();
   
   if(Book_name != null&&Book_name!=""){
	  sql = String.format("SELECT * FROM book WHERE Book_name LIKE '%s%%';",Book_name);   
   } 
   if(Book_type!= null){
	   sql = String.format("SELECT * FROM book WHERE Type LIKE '%s%%';", Book_type); 
   }

   if(Book_writer != null&&Book_writer != ""){
	   sql = String.format("SELECT * FROM book WHERE  Writer LIKE '%s%%';", Book_writer); 
   }
   System.out.println(sql);
   rs=stmt.executeQuery(sql);
%>

<table border="1" cellspacing="1">
<tr>
<td>Book_id</td>
<td>Book_name</td>
<td>Price</td>
<td>Type</td>
<td>Company</td>
<td>Writer</td>
<td>Count</td>
<TD>비고</TD>

</tr>
<%
while(rs.next()){
	

%><tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getInt(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>
<td><%=rs.getString(6) %></td>
<td><%=rs.getInt(7) %></td>

<TD>

<A href="Bucketlist.jsp?
Book_id=<%=rs.getString(1)%>&
Book_name=<%=rs.getString(2)%>&
Price=<%=rs.getString(3)%>&
Type=<%=rs.getString(4)%>&
Company=<%=rs.getString(5)%>&
Writer=<%=rs.getString(6)%>&
Count=<%=rs.getString(7)%>&
">장바구니담기</A>

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
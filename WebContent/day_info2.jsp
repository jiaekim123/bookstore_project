<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR" import = "java.sql.*"%>
   
<%
String is_manager = (String)session.getAttribute("manager");
if(null == is_manager){
   response.sendRedirect("ManagerLogin.html"); 
}
Class.forName("org.gjt.mm.mysql.Driver");

String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //�� �ּҿ� ��Ʈ, DB��ġ
String userId = "root";
String userPass = "ehql413";
String C_ssn= (String)session.getAttribute("C_ssn");
String date_select = "";
String day_info = request.getParameter("date_info");   
if(day_info==null)
throw new Exception("�����͸� �Է��ϼ���.");
Connection conn=null; //DB ���� ����
Statement stmt=null;  //Statement ���� ����
ResultSet rs=null;    //����� ����

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
<h3>�Ϻ� �����</h3>
	 <table border="1" cellspacing="1">
		 <tr>
		 <td>Sale_number</td>
		 <td>Date</td>
		 <td>Price</td>
		 <td>Book_id</td>
		 <td>M_ssn</td>
		 <td>Book_count</td>
		 <TD>���</TD>

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

		 <A href="">����</A>

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
<%@ page language="java" contentType="text/html; charset=EUC-KR" errorPage="DBError.jsp"%>
<%@ page import = "java.sql.*" %>
<%
String Id = request.getParameter("Id");
String Password = request.getParameter("Password");
String Ssn= request.getParameter("Ssn");
String Name = request.getParameter("Name");
String Phone_number = request.getParameter("Phone_number");
String E_mail = request.getParameter("E_mail");
String Address = request.getParameter("Address");

if(Id==null||Password==null||Ssn==null||Name==null||Phone_number==null||E_mail==null||Address==null)
throw new Exception("�����͸� �Է��ϼ���.");

Connection conn =null;
Statement stmt=null;

try
{
	Class.forName("org.gjt.mm.mysql.Driver");
	String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //�� �ּҿ� ��Ʈ, DB��ġ
	String userId = "root";
	String userPass = "ehql413";
	
	conn = DriverManager.getConnection(jdbcUrl,userId,userPass);
	if(conn==null)
		throw new Exception("�����ͺ��̽��� ������ �� �����ϴ�.");
	stmt = conn.createStatement();
	String command = String.format("insert into customer(Ssn,Name,Phone_number,E_mail,Address,Is_member) VALUES('%s','%s','%s','%s','%s',1);",Ssn,Name,Phone_number,E_mail,Address);
	String sql = String.format("insert into member(C_ssn,Id,Password,Point) VALUES('%s','%s','%s',0);",Ssn,Id,Password);
	int rowNum=stmt.executeUpdate(command);
	int rowNum1=stmt.executeUpdate(sql);
	if(rowNum<1&&rowNum1<1)
		throw new Exception("�����͸� DB�� �Է��� �� �����ϴ�.");

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
}
response.sendRedirect("SubscriptionResult.jsp");
%>

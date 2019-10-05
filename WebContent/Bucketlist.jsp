<%@ page language="java" contentType="text/html; charset=utf-8"
import = "java.sql.*" %>
<%

String C_ssn= (String)session.getAttribute("C_ssn");//request.getParameter("C_ssn");
String Book_id= request.getParameter("Book_id");
String Book_name = request.getParameter("Book_name");
String Price = request.getParameter("Price");
String Type = request.getParameter("Type");
String Company = request.getParameter("Company");
String Writer = request.getParameter("Writer");
String Count = request.getParameter("Count");

Class.forName("org.gjt.mm.mysql.Driver");

String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //내 주소와 포트, DB위치
String userId = "root";
String userPass = "ehql413";

Connection conn=null; //DB 연결 변수
Statement stmt=null;  //Statement 생성 변수
ResultSet rs=null;    //결과값 변수

try {
	conn=DriverManager.getConnection(jdbcUrl,userId,userPass);
	
	stmt=conn.createStatement();
	
	String sql = String.format("insert into bucketlist(C_ssn,Book_id,Book_name,Price,Type,Company,Writer,Count) VALUES('%s','%s','%s','%s','%s','%s','%s','%s');",C_ssn,Book_id,Book_name,Price,Type,Company,Writer,Count);
	
	int rowNum = stmt.executeUpdate(sql);
	if(rowNum<1)
		throw new Exception("데이터를 DB에 입력할 수 없습니다.");

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
response.sendRedirect("BucketlistResult.jsp");
%>
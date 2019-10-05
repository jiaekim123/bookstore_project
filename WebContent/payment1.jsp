<%@ page language="java" contentType="text/html; charset=EUC-KR"
   %>
<%@ page import = "java.sql.*" %>
<%

int result_price = 0;
int paynumber = 0;
int bookcount = 0;
int require_point = 0;
int now_point=0;
int result_point =0;

String Buyer = request.getParameter("Buyer");
String Bank_name = request.getParameter("Bank_name");
String pay_date= request.getParameter("pay_date");
int pay_price_int = Integer.parseInt(request.getParameter("Price"));
String Book_id = request.getParameter("Book_id");
String C_ssn= (String)session.getAttribute("C_ssn");

now_point = Integer.parseInt((request.getParameter("Point")));
require_point = Integer.parseInt(request.getParameter("Use_point"));

if (require_point < 0 || (require_point > 0 && now_point < require_point)){
	%>
	<script>
	history.go(-1);
	</script>
	<%
}

	result_point =  now_point - require_point;
	result_price =  pay_price_int - require_point;
	result_point += (int)(result_price*0.05);
	//System.out.println(now_point);
	//System.out.println(result_point);
	//System.out.println(require_point);



if(Buyer==null||Bank_name==null||pay_date==null)
throw new Exception("데이터를 입력하세요.");

Connection conn =null;
Statement stmt=null;
ResultSet rs=null;
ResultSet rs2=null;  
ResultSet rs3=null; 

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
	
	String sql = String.format("SELECT MAX(Pay_number) FROM payment;");
	rs=stmt.executeQuery(sql); 
	
	while(rs.next()){
		paynumber = rs.getInt(1);
	}
	paynumber++;
	
	String command = String.format("insert into payment(Pay_number,Buyer,Bank_name,Pay_date,Pay_price,C_ssn) VALUES('%d','%s','%s','%s',%d,'%s');",paynumber,Buyer,Bank_name,pay_date,pay_price_int,C_ssn);
	
	String command1 = String.format("INSERT INTO record(C_ssn,B_id,B_price,P_number) VALUES('%s','%s','%d',%d);",C_ssn,Book_id,pay_price_int,paynumber);
	
	int rowNum=stmt.executeUpdate(command);
	int rowNum1=stmt.executeUpdate(command1);
		if(rowNum<1&&rowNum1<1)
		throw new Exception("데이터를 DB에 입력할 수 없습니다.");
		
	String sql2 = String.format("SELECT Count FROM book WHERE Book_id = "+Book_id+";");
	rs2 = stmt.executeQuery(sql2); 
	while(rs2.next()){
		bookcount = rs2.getInt(1);
	}
	if(bookcount>0){
		bookcount--;
	}

	String sql3 = String.format("UPDATE book SET COUNT = "+bookcount+" WHERE Book_id = "+Book_id+";");
	int rowNum2=stmt.executeUpdate(sql3);
	
	String sql4 = String.format("DELETE FROM bucketlist WHERE Book_id = "+Book_id+";");
	int rowNum3=stmt.executeUpdate(sql4);

	//System.out.println("I'm not yet update point");
	String sql7 = String.format("UPDATE member SET Point = '%d' WHERE C_ssn = '%s';",result_point,C_ssn);
	int rowNum7=stmt.executeUpdate(sql7);
	//if(rowNum7<1)
	//System.out.println("I already update point");
	//System.out.println(result_point);
	
	String sql8 = String.format("insert into sale_info(Sale_number,Date,Price,Book_id,C_ssn,Book_count) VALUES(%d,'%s',%d,'%s','%s',%d);",paynumber,pay_date,pay_price_int,Book_id,C_ssn,bookcount);
	int rowNum8=stmt.executeUpdate(sql8);

	//String sql9 = String.format("UPDATE member SET Point = "+result_point+" WHERE C_ssn = "+C_ssn+";");
	//int rowNum9=stmt.executeUpdate(sql9);

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
		rs2.close();
		rs3.close();
	}
	catch(Exception ignored){
		
	}
}
//response.sendRedirect("payment2.jsp");
%>
<h3>결제완료되었습니다.</h3>
<h3>최종결제금액 : <%=result_price %></h3>

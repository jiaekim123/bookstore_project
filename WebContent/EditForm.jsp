<%@ page contentType="text/html; charset=EUC-KR"%>
<html>
<head>
<title>상품 정보 관리</title>
</head>
<body>
<h3>상품 정보를 수정한 후 수정 버튼을 누르세요</h3>
<form action=Updater.jsp method=post>
Book_id: <input type=text name=Book_id size=30 value='${Book_id}' readonly=true><br>
Book_name: <input type=text name=Book_name size=30 value='${Book_name}'><br>
Price: <input type=text name=Price size=10 value='${Price}'>원<br>
Type: <input type=text name=Type size=30 value='${Type}'><br>
Company: <input type=text name=Company size=30 value='${Company}'><br>
Writer: <input type=text name=Writer size=30 value='${Writer}'><br>
Count: <input type=text name=Count size=1 value='${Count}'>개<br>
<input type=submit value="수정">
</form>
</body>
</html>
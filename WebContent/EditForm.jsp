<%@ page contentType="text/html; charset=EUC-KR"%>
<html>
<head>
<title>��ǰ ���� ����</title>
</head>
<body>
<h3>��ǰ ������ ������ �� ���� ��ư�� ��������</h3>
<form action=Updater.jsp method=post>
Book_id: <input type=text name=Book_id size=30 value='${Book_id}' readonly=true><br>
Book_name: <input type=text name=Book_name size=30 value='${Book_name}'><br>
Price: <input type=text name=Price size=10 value='${Price}'>��<br>
Type: <input type=text name=Type size=30 value='${Type}'><br>
Company: <input type=text name=Company size=30 value='${Company}'><br>
Writer: <input type=text name=Writer size=30 value='${Writer}'><br>
Count: <input type=text name=Count size=1 value='${Count}'>��<br>
<input type=submit value="����">
</form>
</body>
</html>
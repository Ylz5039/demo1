<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title>Change</title>
    <style>
        form {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f4f4f4;
        }

        form input[type="text"],
        form input[type="password"],
        form input[type="submit"] {
            width: 100%;
            margin-bottom: 10px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }

        form input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
        }

        form input[type="submit"]:hover {
            background-color: #45a049;
        }
        .back-button {
            display: block;
            width: 120px;
            margin: 20px auto;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%
    String id = request.getParameter("id");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8", "root", "!Tyh20040801");
    PreparedStatement preparedStatement = connection.prepareStatement("select * from users where id=?");
    preparedStatement.setInt(1, Integer.parseInt(id));
    ResultSet resultSet = preparedStatement.executeQuery();
    if (resultSet.next()) {
        out.print("<form action=\"U_change_do.jsp\" method=\"post\">");
        out.print("<input type=\"hidden\" name=\"id\" value=" + resultSet.getInt(1) + "><br>");
        out.print(("用户名<input type=\"text\" name=\"username\" value=" + resultSet.getString(2) + "><br>"));
        out.print(("密码<input type=\"password\" name=\"userpwd\" value=" + resultSet.getString(3) + "><br>"));
        out.print("<input type=\"submit\" value=\"修改\">");
        out.print("</form>");
    }
    resultSet.close();
    preparedStatement.close();
    connection.close();
%>
<br/><br/>
<input type="button" class="back-button" value="返回上一级" onclick="window.location.href='U_usersMessage.jsp'">
</body>
</html>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>register_do</title>
    <style>
        .container{
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <%
        String username=request.getParameter("username");
        String userpwd=request.getParameter("userpwd");
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8","root","!Tyh20040801");
        PreparedStatement preparedStatement= connection.prepareStatement("SELECT * FROM users WHERE name = ?");
        preparedStatement.setString(1,username);
        ResultSet resultSet = preparedStatement.executeQuery();


        if (resultSet.next()) {
            request.setAttribute("showPopup",false);
            request.getRequestDispatcher("U_register.jsp").forward(request, response);
        } else {
            if(username.isEmpty() &&userpwd.isEmpty()){
                request.setAttribute("uIsEmpty",true);
                request.getRequestDispatcher("U_register.jsp").forward(request,response);
            }
            preparedStatement = connection.prepareStatement("INSERT INTO users (name, pwd, GRADE) VALUES (?, ?, 'visitor')");
            preparedStatement.setString(1,username);
            preparedStatement.setString(2,userpwd);
            preparedStatement.executeUpdate();
            request.setAttribute("showPopup",true);
            request.getRequestDispatcher("U_login.jsp").forward(request, response);
        }
    %>
    <br><br>
    <input type="button" value="重新登录" onclick="window.location.href='index.jsp'">
    <%
        preparedStatement.close();
        connection.close();
    %>
</div>

</body>
</html>

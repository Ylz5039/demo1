<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        h2 {
            text-align: center;
            margin-top: 20px;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f2f2f2;
        }
        .button {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #45a049;
        }
        .container {
            text-align: center;
            margin-top: 20px;
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
<script>
    <%
    if(request.getAttribute("setAdmin")!=null && (Boolean) request.getAttribute("setAdmin")){
        request.setAttribute("setAdmin", false);
    %>alert("设置管理员成功！")
    <%}
    %>
    <%
    if(request.getAttribute("setVisitor")!=null && (Boolean) request.getAttribute("setVisitor")){
        request.setAttribute("setVisitor", false);
    %>alert("设置访客成功！")
    <%}
    %>
</script>
<body>
<div class="container">
    <div>
        <h2>用户信息管理</h2>
    </div>
    <div>
        <table>
            <tr>
                <th>用户名</th>
                <th>密码</th>
                <th colspan="3">可执行操作</th>
            </tr>
            <%
                request.setCharacterEncoding("UTF-8");
                String currentName=(String)session.getAttribute("name");
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8","root","!Tyh20040801");
                Statement preparedStatement =connection.createStatement();
                ResultSet resultSet=preparedStatement.executeQuery("select * from users");
                while(resultSet.next()){
                    String userName=resultSet.getString(2);
                    if(!resultSet.getString(2).equals(currentName) && !userName.equals("admin")){
                        String userGrade=resultSet.getString("GRADE");
            %><tr>
            <td><%= resultSet.getString(2) %></td>
            <td><%= resultSet.getString(3) %></td>
            <td><a href='U_deleteUser.jsp?id=<%= resultSet.getInt(1) %>' class="button">删除</a></td>
            <td><a href='U_change.jsp?id=<%= resultSet.getInt(1) %>' class="button">修改</a></td>
            <%
                if(userGrade.equals("visitor")){%>
            <td><a href='U_setAdmin.jsp?username=<%= resultSet.getString(2) %>' class="button">设置为管理员</a></td>
            <%}
                if(userGrade.equals("admin")){%>
            <td><a href='U_setVisitor.jsp?username=<%= resultSet.getString(2) %>' class="button">设置为访客</a></td>
            <%}
            %>
        </tr>
            <%}
            }
                resultSet.close();
                preparedStatement.close();
                connection.close();
            %>
        </table>
        <br/><br/>
        <input type="button" class="back-button" value="返回上一级" onclick="window.location.href='W_admin.jsp'">
    </div>
</div>
</body>
</html>

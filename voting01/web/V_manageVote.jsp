<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>manageVote</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333333;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #dddddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
            color: #333333;
        }
        a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
            transition: color 0.3s;
        }
        a:hover {
            color: #0056b3;
        }
        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        .button {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<script>
    <%
    if(request.getAttribute("deleteVote")!=null && (Boolean)request.getAttribute("deleteVote")){
        request.setAttribute("deleteVote",false);
       %>alert("删除投票单成功");
    <% } %>
</script>
<body>
<div>
    <div class="container">
        <h2>Manage</h2>
    </div>
    <div>
        <table>
            <tr>
                <th>序号</th>
                <th>名称</th>
                <th colspan="2">操作</th>
            </tr>
            <%
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8","root","!Tyh20040801");
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery("SELECT DISTINCT VOTE_FORM_NAME FROM film");
                int i = 1;
                while(resultSet.next()){
                    out.println("<tr>");
                    out.println("<td>" + i + "</td>");
                    out.println("<td>" + resultSet.getString("VOTE_FORM_NAME") + "</td>");
                    out.println("<td><a href='V_deleteVote.jsp?VOTE_FORM_NAME=" + resultSet.getString("VOTE_FORM_NAME") + "'>删除</a></td>");
                    out.println("<td><a href='V_changeVote.jsp?VOTE_FORM_NAME=" + resultSet.getString("VOTE_FORM_NAME") + "'>修改</a></td>");
                    out.println("</tr>");
                    i++;
                }
                resultSet.close();
                statement.close();
                connection.close();
            %>
        </table>
        <div class="button-container">
            <input type="button" class="button" value="返回上一级" onclick="window.location.href='W_admin.jsp'">
        </div>
    </div>
</div>
</body>
</html>
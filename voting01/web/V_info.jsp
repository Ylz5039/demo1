<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>投票结果</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        a {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
            transition: color 0.3s;
        }
        a:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
<div>
    <h2>投票结果</h2>
</div>
<div>
    <table>
        <thead>
        <tr>
            <th>选项</th>
            <th>票数</th>
            <th>比例</th>
        </tr>
        </thead>
        <tbody>
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8", "root", "!Tyh20040801");
            String voteFormName = request.getParameter("VOTE_FORM_NAME");
            String sumQuery = "SELECT SUM(COUNT) AS totalNum FROM FILM WHERE VOTE_FORM_NAME = ?";
            PreparedStatement sumStatement = connection.prepareStatement(sumQuery);
            sumStatement.setString(1, voteFormName);
            ResultSet resultSet = sumStatement.executeQuery();
            int totalNum = 0;
            if (resultSet.next()) {
                totalNum = resultSet.getInt("totalNum");
            }
            resultSet.close();
            String infoQuery = "SELECT * FROM FILM WHERE VOTE_FORM_NAME=?";
            PreparedStatement infoStatement = connection.prepareStatement(infoQuery);
            infoStatement.setString(1, voteFormName);
            ResultSet resultSet1 = infoStatement.executeQuery();
            while (resultSet1.next()) {
                out.println("<tr>");
                int num = resultSet1.getInt("COUNT");
                out.println("<td>" + resultSet1.getString("ITEM") + "</td>");
                out.println("<td>" + num + " 票</td>");
                out.println("<td>" + String.format("%.2f%%", num * 100.0 / totalNum) + "</td>");
                out.println("</tr>");
            }
            connection.close();
            resultSet1.close();
        %>
        </tbody>
    </table>
    <p><a href="W_voteHall.jsp">返回大厅页面</a></p>
</div>
</body>
</html>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VOTE</title>
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
        h1 {
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
        input[type='radio'] {
            margin-right: 10px;
        }
        input[type='submit'], input[type='button'] {
            padding: 10px 20px;
            border: none;
            background-color: #007bff;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            display: block; /* Ensures button fills entire width */
            margin: 0 auto; /* Centers the button */
            margin-bottom: 10px; /* Adds some space between buttons */
        }
        input[type='submit']:hover, input[type='button']:hover {
            background-color: #0056b3;
        }
        td.vote-option {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <div>
        <h1>VOTE</h1>
    </div>
    <div>
        <table>
            <form action="V_vote_do.jsp" method="post">
                <%
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8", "root", "!Tyh20040801");
                    Statement statement = connection.createStatement();
                    String voteFormName = request.getParameter("VOTE_FORM_NAME");
                    ResultSet resultSet = statement.executeQuery("SELECT * FROM FILM WHERE VOTE_FORM_NAME='" + voteFormName + "'");
                    boolean hasResult = false;
                    while (resultSet.next()) {
                %>
                <tr>
                    <td class="vote-option">
                        <input type='radio' name='id' value="<%= resultSet.getString("id") %>" required>
                        <%= resultSet.getString("item") %>
                    </td>
                </tr>
                <%
                        hasResult = true;
                    }
                    connection.close();
                    statement.close();
                    resultSet.close();
                    session.setMaxInactiveInterval(-1);
                    if (hasResult) {
                %>
                <tr>
                    <td><input type="submit" value="投票"/></td>
                </tr>
                <input type="hidden" name="voteFormName" value="<%= voteFormName %>">
                <%
                    }
                %>
            </form>
        </table>
        <br/><br/>
        <input type="button" value="回到大厅" onclick="window.location.href='W_voteHall.jsp'">
    </div>
</div>
</body>
</html>

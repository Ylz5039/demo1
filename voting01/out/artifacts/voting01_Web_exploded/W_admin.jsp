<%@ page language="java" %>
<%@ page import="java.sql.*" contentType="text/html; charset=UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .message {
            padding: 40px;
            border-radius: 8px;
            text-align: center;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .message h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .message table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .message th, .message td {
            padding: 8px;
            text-align: center;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #ccc;
        }
        .btn-secondary:hover {
            background-color: #bbb;
        }
        h1 {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
        }
    </style>
    <script>
        <%
            if (request.getAttribute("createVote") != null && (Boolean) request.getAttribute("createVote")) {
                request.setAttribute("createVote", false);
            %>
        alert("添加成功辣！");
        <% } %>
    </script>
</head>
<body>
<div class=container>
    <div class="message">
        <h1>管理员操作页面</h1>
        <%
            request.setCharacterEncoding("UTF-8");
            if(session.getAttribute("name") != null){
                String currentName = (String)session.getAttribute("name");
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8", "root", "!Tyh20040801");
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery("SELECT GRADE FROM users WHERE name = '" + currentName + "'");

                if(resultSet.next()){
                    String userGrade = resultSet.getString("GRADE");

                    if(userGrade.equals("admin")){

                    } else {
                        request.setAttribute("NotAdmin", true);
                        request.getRequestDispatcher("W_voteHall.jsp").forward(request, response);
                    }
                } else {

                    response.sendRedirect("W_voteHall.jsp");
                }

                resultSet.close();
                statement.close();
                connection.close();
            }
        %>
        <div>
            <button class="btn" onclick="window.location.href='V_createVote.jsp'">创建新的投票！</button>
            <button class="btn btn-secondary" onclick="window.location.href='U_usersMessage.jsp'">查看用户信息</button>
            <button class="btn" onclick="window.location.href='V_manageVote.jsp'">修改管理内容!</button>
            <button class="btn btn-secondary" onclick="window.location.href='W_voteHall.jsp'">回到大厅</button>
        </div>
    </div>
</div>
</body>
</html>

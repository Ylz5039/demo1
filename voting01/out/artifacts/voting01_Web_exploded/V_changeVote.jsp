<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ChangeVote</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f0f2f5;
            color: #333;
        }
        .container {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin: 20px auto;
            max-width: 600px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            text-align: left;
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        .form-container {
            display: flex;
            flex-direction: column;
            margin-top: 20px;
        }
        .form-container > span {
            margin-bottom: 10px;
        }
        .form-container input, .form-container .link {
            margin: 5px 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-container .link {
            text-decoration: none;
            color: #4CAF50;
            text-align: center;
            display: inline-block;
            background-color: transparent;
        }
    </style>
    <script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
        window.onload = function() {
            <%
            if (request.getAttribute("addMessage") != null && (Boolean) request.getAttribute("addMessage")) {
                request.setAttribute("addMessage", false);
            %>
            alert("添加成功辣！");
            <% }if (request.getAttribute("delMessage") != null && (Boolean) request.getAttribute("delMessage")) {
                request.setAttribute("delMessage", false);
            %>
            alert("删除成功辣！");
            <% }if (request.getAttribute("addMessage01") != null && (Boolean) request.getAttribute("addMessage01")) {
                request.setAttribute("addMessage01", false);
            %>
            alert("添加失败惹......");
            <% } %>
        }
    </script>
<body>
<div class="container">
    <div>
        <h2>修改投票内容</h2>
    </div>
    <div>
        <table>
            <tr>
                <th colspan="3">可修改内容</th>
            </tr>
            <tr>
                <th>ID</th>
                <th>ITEM</th>
                <th>Operation</th>
            </tr>
            <tr>
                <%
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8", "root", "!Tyh20040801");
                    String voteFormName = request.getParameter("VOTE_FORM_NAME");
                    if (voteFormName != null && !voteFormName.isEmpty()) {
                        Statement statement = connection.createStatement();
                        ResultSet resultSet = statement.executeQuery("SELECT * FROM FILM WHERE VOTE_FORM_NAME='" + voteFormName + "'");
                        int i = 1;
                        while (resultSet.next()) {
                            out.println("<tr>");
                            out.println("<td>" + i + "</td>");
                            out.println("<td>" + resultSet.getString("item") + "</td>");
                            out.println("<td><a href='V_deleteMessage.jsp?delid=" + resultSet.getString("id") + "&VOTE_FORM_NAME=" + voteFormName + "'>删除</a><td>");
                            i++;
                        }
                        resultSet.close();
                        statement.close();
                    } else {
                        out.println("VOTE_FORM_NAME");
                    }
                    connection.close();
                %>
            </tr>
        </table>
        <div class="form-container">
            <span>添加投票项</span>
            <form action="V_addMessage.jsp" method="post" style="display: flex; flex-direction: column;">
                <input type="hidden" name="VOTE_FORM_NAME" value="<%= voteFormName %>">
                <label for="additem">内容</label>
                <input type="text" name="additem" id="additem"/>
                <div style="margin-top: 10px; display: flex; justify-content: space-between;">
                    <input type="submit" value="提交" style="flex-grow: 1; margin-right: 5px;"/>
                    <input type="reset" value="重置" style="flex-grow: 1;"/>
                </div>
            </form>
            <a href="V_manageVote.jsp" class="link">返回界面</a>
        </div>
    </div>
</div>
</body>
</html>
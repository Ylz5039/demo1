<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hall</title>
    <style>
        .username-display {
            position: fixed;
            right: 20px;
            top: 20px;
            background-color: #f2f2f2;
            padding: 10px;
            border-radius: 5px;
            font-size: 14px;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        h1 {
            text-align: center;
        }
        .title {
            color: #333;
            font-size: 36px;
            margin-top: 40px;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        .btn-container {
            text-align: center;
            margin-top: 20px;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            border-radius: 5px;
            transition: background-color 0.3s;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        <%
            if (request.getAttribute("TimeSet01") != null && (Boolean) request.getAttribute("TimeSet01")) {
                request.setAttribute("TimeSet01", false);
            %>
        alert("不在指定时间内");
        <% }
            if (request.getAttribute("haveVoted01") != null && (Boolean) request.getAttribute("haveVoted01")) {
                request.setAttribute("haveVoted01", false);
            %>
        alert("你已经投过票");
        <% }
            if(request.getAttribute("NotAdmin")!=null &&(Boolean) request.getAttribute("NotAdmin")){
                request.setAttribute("NotAdmin",false);
            %>
        alert("您不是管理员");
        <% }
            if(request.getAttribute("notVote")!=null &&(Boolean) request.getAttribute("notVote")){
                request.setAttribute("notVote",false);
            %>
        alert("您还未投票");
        <% } %>

    </script>
</head>
<body>
<div class="username-display">
    用户名：<%
    String currentName1= (String) session.getAttribute("name");
    out.print(currentName1!=null?currentName1:"未登录");
%>
</div>
<div class="container">
    <div>
        <h1 class="title">大厅</h1>
    </div>
    <div>
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
                    boolean hasVote=false;
                    while(resultSet.next()){
                        out.println("<tr>");
                        out.println("<td>" + i + "</td>");
                        out.println("<td>" + resultSet.getString("VOTE_FORM_NAME") + "</td>");
                        out.println("<td><a href='V_canVote.jsp?VOTE_FORM_NAME=" + resultSet.getString("VOTE_FORM_NAME") + "'>进入</a></td>");
                        out.println("<td><a href='V_canInfo.jsp?VOTE_FORM_NAME="+resultSet.getString("VOTE_FORM_NAME")+"'>查看</a></td>");
                        out.println("</tr>");
                        i++;
                        hasVote=true;
                    }
                    if(!hasVote){
                        out.println("<tr>");
                        out.println("<td colspan='4'>暂无投票单</td>");
                        out.println("</tr>");
                    }
                    resultSet.close();
                    statement.close();
                    connection.close();
                %>
            </table>
        </div>
        <div class="btn-container">
            <%
                String currentName=(String)session.getAttribute("name");
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8","root","!Tyh20040801");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT GRADE FROM users WHERE name = '"+currentName+"'");
                if(rs.next() && rs.getString("GRADE").equals("admin")) {
            %>
            <form action="W_admin.jsp" method="post">
                <input type="submit" class="btn" value="管理员操作!">
            </form>
            <%
                }
                rs.close();
                stmt.close();
                conn.close();
            %>
            <form action="index.jsp" method="post">
                <input type="submit" class="btn" value="登出">
            </form>
        </div>
    </div>
</div>
</body>
</html>
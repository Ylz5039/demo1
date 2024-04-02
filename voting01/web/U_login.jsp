
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 350px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
        }
        .header h2 {
            margin: 0;
            color: #333;
        }
        table {
            margin: 20px auto;
        }
        td {
            padding: 10px;
        }
        input[type="text"],
        input[type="password"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .register {
            margin-top: 20px;
        }
    </style>
    <script>
        window.onload = function() {
            <% if (request.getAttribute("showPopup") != null && (Boolean)request.getAttribute("showPopup")) { %>
            alert("注册成功，快去登录吧！");
            <% } %>
        }
    </script>
</head>
<body>
<div class="container">
    <div class="header">
        <h2>登录</h2>
    </div>
    <div class="login">
        <form action="U_login_do.jsp" method="post">
            <table>
                <tr>
                    <td>用户名：</td>
                    <td><input type="text" name="username"></td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td><input type="password" name="userpwd"></td>
                </tr>
            </table><br/>
            <input type="submit" value="登录">
        </form>
    </div>
    <div class="register">
        <form action="U_register.jsp" method="post">
            <input type="submit" value="注册">
        </form>
    </div>
</div>
</body>
</html>

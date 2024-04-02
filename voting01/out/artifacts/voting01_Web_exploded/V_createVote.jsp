<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>createVote</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        form {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        label {
            font-weight: bold;
        }
        input[type="text"],
        input[type="datetime-local"],
        button[type="button"],
        input[type="submit"],
        input[type="reset"] {
            width: calc(100% - 6px);
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        button[type="button"],
        input[type="submit"],
        input[type="reset"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
        }
        button[type="button"]:hover,
        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: #45a049;
        }
        button[type="button"],
        input[type="submit"],
        input[type="reset"],
        input[type="button"] {
            outline: none;
            border: none;
        }
        .options-container {
            margin-bottom: 20px;
        }
        .option-input {
            width: calc(100% - 70px);
            display: inline-block;
        }
        .option-remove {
            width: 60px;
            display: inline-block;
            background-color: #f44336;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .option-remove:hover {
            background-color: #d32f2f;
        }
        .btn-container {
            text-align: center;
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
    <script>
        function validateStartTime() {
            var startTime = document.getElementById('startTime').value;
            var endTime=document.getElementById('endTime').value;
            var currentTime = new Date().toISOString().slice(0, 16);
            if (startTime < currentTime) {
                alert('起始时间不能早于当前时间');
                return false;
            }
            if(endTime<=startTime){
                alert('结束时间不能早于起始时间');
                return false;
            }
            return true;
        }
        function addOption() {
            var options = document.getElementById('options');
            var newLabel = document.createElement('label');
            newLabel.for = 'option' + (options.childElementCount/2 + 1);
            newLabel.textContent = '选项名：';

            var newOption = document.createElement('input');
            newOption.type = 'text';
            newOption.id = 'option' + (options.childElementCount/2 + 1);
            newOption.name = 'ITEM';
            newOption.required = true;

            options.appendChild(newLabel);
            options.appendChild(newOption);
            options.appendChild(document.createElement('br'));
        }
        function removeOption() {
            var options = document.getElementById('options');
            if (options.childElementCount > 3) {
                options.removeChild(options.lastChild);
                options.removeChild(options.lastChild);
                options.removeChild(options.lastChild);
            }
        }
        window.onload = function() {
            document.getElementById('voteForm').onsubmit = validateStartTime;
        };
    </script>
</head>
<body>
<h1>创建新投票单</h1>

<form id="voteForm" action="V_submitVote.jsp" method="post">
    <label for="VOTE_FORM_NAME">所属投票单名：</label>
    <input type="text" id="VOTE_FORM_NAME" name="VOTE_FORM_NAME" required><br><br>

    <label for="startTime">起始时间：</label>
    <input type="datetime-local" id="startTime" name="startTime" required><br><br>

    <label for="endTime">结束时间：</label>
    <input type="datetime-local" id="endTime" name="endTime" required><br><br>

    <div class="options-container" id="options">
        <label for="option1">选项名：</label>
        <input type="text" class="option-input" id="option1" name="ITEM" required>
    </div>
    <div class="btn-container">
        <button type="button" onclick="addOption()">增加选项</button>
        <button type="button" class="option-remove" onclick="removeOption()">移除</button>
        <br><br>
        <input type="submit" value="创建投票">
        <input type="reset" value="重置">
    </div>
</form>
<br/><br/>
<input type="button" class="back-button" value="返回上一级" onclick="window.location.href='W_admin.jsp'">
</body>
</html>
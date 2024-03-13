<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>

<%@ include file="header.jsp" %>

    <style>
        table.login {
        width: 40%;
        height: 200px;
        border-collapse: collapse;
        margin: auto;

        th, td {
            border-bottom: 1px solid #444444;
            padding: 10px;
            font-size: 18px;
            }
        }
        
        .container {
        width: 40%; /* 내용의 너비를 조절합니다. */
        height: auto;
        margin: 0 auto; /* 좌우 여백을 설정하여 가운데 정렬합니다. */
        margin-top: 20px;
        margin-bottom: 50px;
        }
        
    </style>

    <form name="loginForm" id="loginForm" onsubmit="return validateForm()" action="login_ok.jsp" method="get">
    
        <table class="login">
            <tr>
                <th>로그인</th>
            </tr>
            <tr>
                <td>아이디*</td>
                <td><input type="text" id="id" name="id" required="required" value="asdfasdf" /></td>
            </tr>
            <tr>
                <td>비밀번호*</td>
                <td><input type="password" id="password" name="password" required="required" value="asdfasdf" /></td>
            </tr>
        </table>
    
        <div class="container" align="center">
        	<input type="button" value="취소" onclick="history.back()'" />
            <input type="submit" value="로그인" />
        </div>
    </form>

    <script>
        function validateForm() {
            var username = document.getElementById("id").value;
            var password = document.getElementById("password").value;

            // 아이디의 길이가 4자 이상인지 확인
            if (username.length < 4) {
                alert("아이디는 최소 4자 이상이어야 합니다.");
                return false;
            }

            // 비밀번호의 길이가 6자 이상인지 확인
            if (password.length < 6) {
                alert("비밀번호는 최소 6자 이상이어야 합니다.");
                return false;
            }

            return true;
        }
    </script>

<%@ include file="foot.jsp" %>
</body>
</html>
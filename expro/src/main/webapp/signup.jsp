<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>

<%@ include file="header.jsp" %>

    <style>
        table.signup {
        width: 60%;
        height: 300px;
        border-collapse: collapse;
        margin: 0 auto;
        
        th, td {
            height: 40px;
            border-bottom: 1px solid #444444;
            padding: 10px;
            font-size: 18px;
            }
        }
        .container {
        width: 60%; /* 내용의 너비를 조절합니다. */
        margin: 0 auto; /* 좌우 여백을 설정하여 가운데 정렬합니다. */
        margin-top: 20px;
        margin-bottom: 50px;
        }
    </style>

    <form name="signup" id="signup" onsubmit="return validateForm()" action="signup_ok.jsp" method="get">
    
        <table class="signup">
            <tr>
                <th>회원 가입</th>
                <td><i>*는 필수 입력입니다.</i></td>
            </tr>
            <tr>
                <td>아이디*</td>
                <td><input type="text" id="id" name="id" required="required" value="asdfasdf" /></td>
            </tr>
            <tr>
                <td>비밀번호*</td>
                <td><input type="password" id="password" name="password" required="required" value="asdfasdf" /></td>
            </tr>
            <tr>
                <td>비밀번호 확인*</td>
                <td><input type="password" id="check_password" name="check_password" required="required" value="asdfasdf" /></td>
            </tr>
            <tr>
                <td>이름*</td>
                <td><input type="text" id="name" name="name" required="required" value="asdfasdf" /></td>
            </tr>
            <tr>
                <td>생년월일</td>
                <td><input type="date" id="birth" name="birth" /></td>
            </tr>
            <tr>
                <td>성별</td>
                <td><label><input type="radio" name="gender" value="선택안함" checked /> 선택안함 </label>
                    <label><input type="radio" name="gender" value="남자" /> 남자 </label>
                    <label><input type="radio" name="gender" value="여자" /> 여자 </label></td>
            </tr>
            <tr>
                <td>e-mail</td>
                <td><input type="email" id="email" name="email" /></td>
            </tr>
        </table>
    
        <div class="container" align="center">
            <input type="button" value="취소" onclick="window.location.href='index.jsp'" />
            <input type="submit" value="가입하기" />
        </div>
    </form>

    <script>
        function validateForm() {
            var username = document.getElementById("id").value;
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("check_password").value;

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

            // 비밀번호가 일치하는지 확인
            if (password !== confirmPassword) {
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }

            return true;
        }
    </script>
    
    <%@ include file="foot.jsp" %>
</body>
</html>
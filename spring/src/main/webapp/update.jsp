<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<%@ page import="java.util.*" %>

<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>
<%!
    String nulStr(String s){
        String ret="";
        if(s!=null) ret=s;
        return ret;
    }
%>

<%@ include file="header.jsp" %>

    <style>
        table.update {
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

                <form onsubmit="return validateForm()" action="update_ok.jsp" method="get">
                <table class="update">
                    <tr>
                        <input type="hidden" id="id" name="id" value="<%=user.getId()%>">
                    </tr><tr>
                        <td>비밀번호*</td>
                        <td><input type="text" id="password" name="password" value="<%= user.getPassword() %>"></td>
                    </tr><tr>
                        <td>이름*</td>
                        <td><input type="text" id="name" name="name" value="<%= user.getName() %>"></td>
                    </tr><tr>
                        <td>생년월일</td>
                        <td><input type="date" id="birth" name="birth" value="<%= user.getBirth() %>"></td>
                    </tr><tr>
                        <td>성별</td>
                        <td><label><input type="radio" name="gender" value="선택안함" <%= user.getGender().equals("선택안함") ? "checked" : "" %>/> 선택안함 </label>
                            <label><input type="radio" name="gender" value="남자" <%= user.getGender().equals("남자") ? "checked" : "" %>/> 남자 </label>
                            <label><input type="radio" name="gender" value="여자" <%= user.getGender().equals("여자") ? "checked" : "" %>/> 여자 </label></td>
                    </tr><tr>
                        <td>e-mail</td>
                        <td><input type="email" id="email" name="email" value="<%= user.getEmail() %>"></td>
                    </tr>
                </table>
                <div class="container" align="center">
                        <input type="button" value="취소" onclick="window.location.href='index.jsp'">
                        <input type="button" value="탈퇴" onclick="confirmAction()">
                        <input type="submit" value="수정">
                </div>
                
                </form>

                <script>
                    function validateForm() {
                        var password = document.getElementById("password").value;
                        // 비밀번호의 길이가 6자 이상인지 확인
                        if (password.length < 6) {
                            alert("비밀번호는 최소 6자 이상이어야 합니다.");
                            return false;
                        }
                        return true;
                    }

                    function confirmAction() {
                        // 확인 팝업을 띄우고 사용자의 선택에 따라 동작 결정
                        var result = confirm("회원을 탈퇴하시겠습니까?");
                        if (result) {
                            // 확인을 눌렀을 때의 동작
                            // 여기에 원하는 동작을 추가하세요
                            window.location.href='resign_ok.jsp'
                            alert("회원 탈퇴가 완료되었습니다.");
                        } else {
                            // 취소를 눌렀을 때의 동작
                            // 여기에 원하는 동작을 추가하세요
                            alert("회원 탈퇴가 취소되었습니다.");
                        }
                    }
                </script>
   

    <%@ include file="foot.jsp" %>
</body>
</html>

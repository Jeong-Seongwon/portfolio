<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ='user.*' %>
<%@ page import="bbs.*" %>
<%@ page import="emp.*" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*" %>
<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>
<%
UserVO user = (UserVO)session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>사이트 이름</title>

    <style>
        body {
            max-width: 1600px; /* 원하는 최대 폭으로 설정 */
            margin: 0 auto; /* 가운데 정렬을 위해 좌우 마진을 auto로 설정 */
            overflow-y: scroll;
            margin-bottom: 50px;
        }
        table.head {
            border-collapse: collapse;
            width: 100%;
            margin: auto;
            border-bottom: 0px;

            background-color: aliceblue;
            background-size: 100%;
            background-repeat: no-repeat;
            background-position: right;
        }
        th.right-align {
            text-align: right;
            width: 800px;
        }
        th.left-align {
            text-align: left;
            width: 300px;
        }
        /* 버튼 스타일 */
        input[type="submit"], input[type="button"] {
		display: inline-block; /* 인라인 요소를 블록 요소로 변경하여 여러 속성이 적용될 수 있게 함 */
	    padding: 5px 10px; /* 위아래 5px, 좌우 10px의 패딩 */
	    background-color: #eeeeee; /* 배경색 */
	    border: 1px solid #dddddd; /* 테두리 */
	    border-radius: 5px; /* 버튼 테두리 모서리 둥글게 */
	    color: rgb(0, 0, 0); /* 글자색 */
	    font-weight: bold; /* 링크의 글꼴을 굵게 설정 */
		float: right;
		cursor: pointer;
	}
        input, select {
            font-size: 16px; /* 글자 크기 조절 */
        }
        .transparent-btn{
            background: none;
            border: none;
        }
        a.header {
            color: rgb(0, 0, 0);
            text-decoration: none; /* 링크의 밑줄 제거 */
            font-weight: bold; /* 링크의 글꼴을 굵게 설정 */
            font-size: 20px; /* 링크의 글꼴 크기 설정 */
        }
        a:hover {
            color: rgb(255, 0, 0); /* 링크의 텍스트 색상을 빨간색으로 변경 */
            text-decoration: underline; /* 링크에 밑줄 추가 */
        }

    </style>

</head>

<body>
    <table class="head">
        <tr>
            <th class="left-align">
                <input type="image" src="/expro/img/blog.jpg" value="사이트 이름" class="transparent-btn" onclick="window.location.href='/expro/index.jsp'" >
            </th>
            <th>
                <a class="header" href="/expro/emp/index.jsp">EMP</a>
            </th>
            <th>
                <a class="header" href="/expro/bbs.jsp">게시판</a>
            </th>
            <th class="right-align">
       
            <% if (user==null) {
            		%>
            		<input type="button" id="signupButton" value="회원가입" onclick="window.location.href='/expro/signup.jsp'" />
            		<input type="button" id="loginButton" value="로그인" onclick="window.location.href='/expro/login.jsp'" />
                	<%
	            } else {
	            	%><%=user.getName()%> 님, 환영합니다.
	            	<input type="button" value="로그아웃" onclick="window.location.href = '/expro/logout.jsp'" />
	                <input type="button" value="내 정보" onclick="window.location.href='/expro/update.jsp'" />
	                <%
	            }
            %>
                
            </th>
        </tr>
    </table>
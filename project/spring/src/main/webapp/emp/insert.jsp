<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>

<%@ include file="main.jsp" %>

    <%
        // 현재 날짜를 가져와서 LocalDate 객체로 변환
        LocalDate currentDate = LocalDate.now();
    %>

<style>
    table.registEmp {
        width: 60%;
        height: 300px;
        border-collapse: collapse;
        margin: 0 auto;
        
        td {
            height: 30px;
            border-bottom: 1px solid #444444;
            padding: 10px;
            font-size: 15px;
            }
        th {
            height: 50px;
        }
    }
</style>

<form action="insert_ok.jsp" method="get">
	<table class="registEmp">
		<tr>
			<td>
				<h3>EMP 정보 추가</h3>
			</td>
		</tr>
		<tr>
			<td><label for="empno">사원번호</label></td>
			<td><input type="number" id="empno" name="empno" value=7001
				required></td>
		</tr>
		<tr>
			<td><label for="eid">아이디</label></td>
			<td><input type="text" id="eid" name="eid" value="hong">
			</td>
		</tr>
		<tr>
			<td><label for="pwd">비밀번호</label></td>
			<td><input type="password" id="pwd" name="pwd" value="1111aaaa!">
			</td>
		</tr>
		<tr>
			<td><label for="ename">사원이름</label></td>
			<td><input type="text" id="ename" name="ename" value="HongGilDong"></td>
		</tr>
		<tr>
			<td><label for="job">사원직급</label></td>
			<td><input type="text" id="job" name="job" autocomplete="on" list="id" value="CLERK"> 
				<datalist id="id">
					<option value="CLERK"></option>
					<option value="SALESMAN"></option>
					<option value="MANAGER"></option>
					<option value="ANALYST"></option>
					<option value="PRESIDENT"></option>
				</datalist></td>
		</tr>
		<tr>
			<td><label for="mgr">매니저 ID</label></td>
			<td><input type="number" id="mgr" name="mgr" value="0"></td>
		</tr>
		<tr>
			<td><label for="hiredate">입사일</label></td>
			<td><input type="date" id="hiredate" name="hiredate" value="<%=currentDate%>"></td>
		</tr>
		<tr>
			<td><label for="sal">급여</label></td>
			<td><input type="number" id="sal" name="sal" value="0"></td>
		</tr>
		<tr>
			<td><label for="comm">커미션</label></td>
			<td><input type="number" id="comm" name="comm" value="0"></td>
		</tr>
		<tr>
			<td><label for="deptno">부서</label></td>
			<td><select id="deptno" name="deptno">
					<option value="10">ACCOUNT(10)</option>
					<option value="20">RESEARCH(20)</option>
					<option value="30">SALES(30)</option>
					<option value="40">OPERATIONS(40)</option>
			</select></td>
		</tr>
		<tr>
			<td><label for="gender">성별</label></td>
			<td><input type="radio" name="gender" value="M" checked>
				남자 <input type="radio" name="gender" value="F"> 여자</td>
		</tr>
		<tr>
			<td><label for="hobby">취미</label></td>
			<td>혼자놀기<input type="checkbox" id="hobby" name="hobby"
				value="혼자놀기" checked>&nbsp; 스포츠<input type="checkbox"
				id="hobby1" name="hobby" value="스포츠">&nbsp; 독서<input
				type="checkbox" id="hobby2" name="hobby" value="독서">&nbsp;
				영화감상<input type="checkbox" id="hobby3" name="hobby" value="영화감상">&nbsp;
				요리<input type="checkbox" id="hobby4" name="hobby" value="요리"><br>
			</td>
		</tr>
		<tr>
			<th colspan="2">
			<input type="button" value="취소" onclick="window.location.href='index.jsp'">
			<input type="submit" value="추가"> 
			</th>
		</tr>
	</table>
</form>


<%@ include file="../foot.jsp" %>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<%
	int empno = Integer.parseInt(request.getParameter("empno"));
	EmpDAO dao = new EmpDAO();
	EmpVO vo = dao.viewEmp(empno);

    String ename = nulStr(vo.getEname());
	String job = nulStr(vo.getJob());
    int mgr = vo.getMgr();
    String hiredate = nulStr(vo.getHiredate()).substring(0, 10);
    float sal = vo.getSal();
    float comm = vo.getComm();
    int deptno = vo.getDeptno();
    String eid = nulStr(vo.getEid());
    String pwd = nulStr(vo.getPwd());
    String gender = nulStr(vo.getGender());
    
    String[] hobby = nulStr(vo.getHobby()).split(",");
    List<String> hobbyList = Arrays.asList(hobby);
%>
<%@ include file="main.jsp" %>

<style>
    table.editEmp {
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

<form action="update.jsp" method="get">
	<table class="editEmp">
		<tr>
			<td>
				<h2>EMP 정보 수정</h2>
			</td>
		</tr>
		<tr>
			<td><label for="empno">사원번호</label></td>
			<td><input type="number" id="empno" name="empno" value="<%= empno %>" readonly="readonly"></td>
		</tr>
		<tr>
			<td><label for="eid">아이디</label></td>
			<td><input type="text" id="eid" name="eid" value="<%= eid %>">
			</td>
		</tr>
		<tr>
			<td><label for="pwd">비밀번호</label></td>
			<td><input type="password" id="pwd" name="pwd"
				value="<%= pwd %>"></td>
		</tr>
		<tr>
			<td><label for="ename">사원이름</label></td>
			<td><input type="text" id="ename" name="ename"
				value="<%= ename %>"></td>
		</tr>
		<tr>
			<td><label for="job">사원직급</label></td>
			<td><input type="text" id="job" name="job" value="<%= job %>"
				autocomplete="on" list="id"> <datalist id="id">
					<option value="CLERK"></option>
					<option value="SALESMAN"></option>
					<option value="MANAGER"></option>
					<option value="ANALYST"></option>
					<option value="PRESIDENT"></option>
				</datalist></td>
		</tr>
		<tr>
			<td><label for="mgr">매니저 ID</label></td>
			<td><input type="number" id="mgr" name="mgr" value="<%= mgr %>">
			</td>
		</tr>
		<tr>
			<td><label for="hiredate">입사일</label></td>
			<td><input type="date" id="hiredate" name="hiredate"
				value="<%= hiredate %>"></td>
		</tr>
		<tr>
			<td><label for="sal">급여</label></td>
			<td><input type="number" id="sal" name="sal" value="<%= sal %>">
			</td>
		</tr>
		<tr>
			<td><label for="comm">커미션</label></td>
			<td><input type="number" id="comm" name="comm"
				value="<%= comm %>"></td>
		</tr>
		<tr>
			<td><label for="deptno">부서</label></td>
			<td><select id="deptno" name="deptno">
					<option value="10" <%= deptno == 10 ? "selected" : "" %>>ACCOUNT(10)</option>
					<option value="20" <%= deptno == 20 ? "selected" : "" %>>RESEARCH(20)</option>
					<option value="30" <%= deptno == 30 ? "selected" : "" %>>SALES(30)</option>
					<option value="40" <%= deptno == 40 ? "selected" : "" %>>OPERATIONS(40)</option>
			</select></td>
		</tr>
		<tr>
			<td><label for="gender">성별</label></td>
			<td><input type="radio" name="gender" value="M"
				<%= gender.equals("M") ? "checked" : "" %>> 남자 <input
				type="radio" name="gender" value="F"
				<%= gender.equals("F") ? "checked" : "" %>> 여자</td>
		</tr>
		<tr>
			<td><label for="hobby">취미</label></td>
			<td>혼자놀기<input type="checkbox" id="hobby" name="hobby"
				value="혼자놀기" <%= hobbyList.contains("혼자놀기") ? "checked" : "" %>>&nbsp;
				스포츠<input type="checkbox" id="hobby1" name="hobby" value="스포츠"
				<%= hobbyList.contains("스포츠") ? "checked" : "" %>>&nbsp; 독서<input
				type="checkbox" id="hobby2" name="hobby" value="독서"
				<%= hobbyList.contains("독서") ? "checked" : "" %>>&nbsp; 영화감상<input
				type="checkbox" id="hobby3" name="hobby" value="영화감상"
				<%= hobbyList.contains("영화감상") ? "checked" : "" %>>&nbsp; 요리<input
				type="checkbox" id="hobby4" name="hobby" value="요리"
				<%= hobbyList.contains("요리") ? "checked" : "" %>><br>
			</td>
		</tr>
		<tr>
			<th colspan="2"><input type="submit" value="수정"> <input
				type="button" value="삭제" onclick="confirmAction()"> <input
				type="button" value="취소" onclick="history.back()">
			</th>
		</tr>
	</table>
</form>

<script>
	function confirmAction() {
    	// 확인 팝업을 띄우고 사용자의 선택에 따라 동작 결정
        var result = confirm("회원 정보를 삭제하시겠습니까?");
        if (result) {
	        // 확인을 눌렀을 때의 동작
	        // 여기에 원하는 동작을 추가하세요
	        window.location.href='delete.jsp?empno=<%=empno%>'
			alert("회원 정보가 삭제되었습니다.");
		} else {
			// 취소를 눌렀을 때의 동작
			// 여기에 원하는 동작을 추가하세요
			alert("회원 정보 삭제가 취소되었습니다.");
		}
	}
</script>


<%@ include file="../foot.jsp" %>
</body>
</html>

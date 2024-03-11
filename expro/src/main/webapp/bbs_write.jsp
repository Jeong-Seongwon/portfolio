<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, javax.servlet.annotation.*" %>
<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>

<%@ include file="header.jsp" %>

<style>
	table.bbs_write {
		width:80%;
		margin:auto;
		text-align: center;
		border: 1px solid #dddddd;
	}
	input[type="text"] {
        width: 100%; /* 너비 조절 */
		font-size: 20px;
    }
    textarea {
        width: 100%; /* 너비 조절 */
		font-size: 16px;
    }
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
</style>

<form method="post" action="bbs_writeAction.jsp" enctype="multipart/form-data">
	<table class="bbs_write">
		<thead>
			<tr>
				<th colspan="2" style="background-color: #eeeeee;">게시판 글쓰기</th>						
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
			</tr>
			<tr>
				<td><textarea placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px"></textarea></td>						
			</tr>
			<tr>
				<td>
				<input type="button" value="취소" onclick="history.back()">
				<input type="submit" value="작성">
				<input type="file" name="bbsFile"> 
				</td>
			</tr>
		</tbody>
	</table>
</form>						


	
<%@ include file="foot.jsp" %>
</body>

</html>

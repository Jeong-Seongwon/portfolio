<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>

<style>
    /* 화면 하단에 내용을 고정하기 위한 스타일 */
    .bottom-content {
        position: fixed;
        bottom: 0;
        right: 0;
        width: 100%;
        font-size: small;
        background-color: #f8f8f8;
        padding: 5px;
        text-align: right;
    }
</style>

<div class="bottom-content">
    copyright by 세종학원
</div>

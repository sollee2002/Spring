<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>Fixed top navbar example · Bootstrap v5.2</title>

	<link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/navbar-fixed/">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<link href="/resources/css/style.css" rel="stylesheet">
	<!-- link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet"> -->

	<script type="text/javascript">
		function requestAction(url){
			// 폼이름을 확인!
			viewForm.action = url;
			viewForm.submit();
		}
		
		window.addEventListener('load', function(){
			btnList.addEventListener('click',function(){
				viewForm.action = "/board/list";
				viewForm.method="get";
				viewForm.submit();
			});
		})
		
	</script>
</head>
<body>

<%@include file="../common/header.jsp" %>


<main class="container">
  <div class="bg-light p-5 rounded">
    <h1>게시판</h1>
    <p class="lead">부트스트랩을 이용한 게시판 만들기</p>
    <a class="btn btn-lg btn-primary" href="#" id="btnList" role="button">리스트 &raquo;</a>
  </div>
  <p></p>
  
  <!-- 글쓰기 -->
  <div class="list-group w-auto">
    <form method="post" action="/board/write" name="viewForm">
    
    <!-- 페이지, 검색 유지 -->
    <input type="text" name="pageNo" value="${param.pageNo }">
    <input type="text" name="searchField" value="${param.searchField }">
    <input type="text" name="searchWord" value="${param.searchWord }">
    
	<div class="mb-3">
	  <label for="title" class="form-label">제목</label>
	  <input name="title" id="title" 
	  type="text" class="form-control" value="${board.title}">
	</div>
	<div class="mb-3">
	  <label for="content" class="form-label">내용</label>
	  <textarea class="form-control" id="content" name="content" rows="3">${board.content}</textarea>
	</div>
	<div class="mb-3">
	  <label for="writer" class="form-label">작성자</label>
	  <input type="text" class="form-control" id="writer" name="writer" value="${board.writer}">
	</div>
	<div class="mb-3">
	  <label for="formFile" class="form-label">Default file input example</label>
	  <input class="form-control" type="file" id="files" name="files">
	</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-center">
		<!-- bno 값이 있으면 수정하기 -->
		<c:if test="${not empty board.bno}" var="res">
	    	<input type="hidden" name="bno" value="${board.bno}">
			<button type="submit" class="btn btn-primary btn-lg" 
					onclick="requestAction('/board/editAction')">수정하기</button>
					
		</c:if>
		<!-- 없으면 등록하기 -->
		<c:if test="${not res}">
			<button type="submit" class="btn btn-primary btn-lg">글쓰기</button>
		</c:if>
		
		
		<button type="reset" class="btn btn-secondary btn-lg">초기화</button>
	</div>
	</form>
    
  </div>
</main>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</body>
</html>

















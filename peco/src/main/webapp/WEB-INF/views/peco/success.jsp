<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<style>
	table, tr, td {
	border : 1px solid black;
	}
	
	th{
	border : 1px solid black;
	background-color : black;
	color : white;
	}
</style>
<body>

<h2>예약내역</h2>
<form name='myresForm' action="" onsubmit="return false">
<table>
<tr>
	<th><input type="checkbox" id="cbx_chkAll"></th>
	<th>예약번호</th>
	<th>펜션명</th>
	<th>객실명</th>
	<th>입실날짜</th>
	<th>퇴실날짜</th>
	<th>결제금액</th>
	<th>예약자명</th>
	<th>이메일</th>
	<th>전화번호</th>
	<th>상태</th>
	<th></th>
</tr>

<c:forEach var="r" items="${getRList }" varStatus="status">
<tr>
<td><input type="checkbox" name="chk"><input type="text" value="${status.index}" style="width:20px; border:none;"></td>
<td>${r.imp_uid }</td> 
<td>${r.pname }</td> 
<td>${r.roomname }</td> 
<td>${r.startdate }</td> 
<td>${r.enddate }</td>
<td>${r.pricecnt }</td>
<td>${r.pr_name }</td>
<td>${r.pr_email }</td>
<td>${r.pr_tel }</td>
<td>예약중</td>
<td><button id="delbtn">예약취소</button></td>
</tr>
</c:forEach>



</table>

</form>

<script>
$(document).ready(function() {
	   //js 간단히 정리
	   //imp_uid와 pay값을 선택해 올 수 있도록(반복문이라 정확하게 선택할 수 없음)
	   //varStatus="status"의 인덱스 값을 체크박스와 연동하여 삭제
	   //선택된 값 만큼 삭제가 가능하도록
	   //예약취소처리한 값 DB에서 삭제 또는 상태변경(업데이트)
	
	
	$("#cbx_chkAll").click(function() { //체크박스 전체 선택 전체 해제
		if($("#cbx_chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
		else $("input[name=chk]").prop("checked", false);
	});

	$("input[name=chk]").click(function() {
		var total = $("input[name=chk]").length;
		var checked = $("input[name=chk]:checked").length;

		if(total != checked) $("#cbx_chkAll").prop("checked", false);
		else $("#cbx_chkAll").prop("checked", true); 
	});
	
	
	
		delbtn.addEventListener('click', function() {
		console.log('삭제실행')
		var imp_uid = 'imp_170965212681';
		var pay = '50000';
		
		console.log(imp_uid);
		console.log(pay);
		
	    $.ajax({

		      url: "payment/cancel", 
		      type: "Post",
		      data: ({
		        imp_uid: imp_uid, //주문번호
		        amount: pay, //결제금액
		        
	      })
	    }).done(function(result) { // 환불 성공시 로직 
	        alert("환불 성공");
	    }).fail(function(error) { // 환불 실패시 로직
	      	alert("환불 실패");
	    });
	  })
	
	
	
	
});
</script>

</body>
</html>
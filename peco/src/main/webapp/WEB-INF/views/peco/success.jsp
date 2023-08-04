<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<th></th>
</tr>

<c:forEach var="r" items="${getRList }" varStatus="status">
<tr>
<td><input type="text" value="${status.index}" style="width:20px; border:none;" id="index"></td>
<c:choose>
	<c:when test="${fn:length(r.imp_uid) > 1}">
		<td><input type="text" id="imp_uid" data-uid="${status.index}" value="${fn:substring(r.imp_uid,4,16)}"></td>
	</c:when>
</c:choose>
<td>${r.pname }</td> 
<td>${r.roomname }</td> 
<td>${r.startdate }</td> 
<td>${r.enddate }</td>
<td><input type="text" id="pcnt" data-pcnt="${status.index}" value="${r.pricecnt }"></td>
<td>${r.pr_name }</td>
<td>${r.pr_email }</td>
<td>${r.pr_tel }</td>
<td><button  onclick="del(${status.index})">예약취소${status.index}</button></td>
</tr>
</c:forEach>



</table>

</form>

<script>
$(document).ready(function() {
	   //js 간단히 정리
	   //imp_uid와 pay값을 선택해 올 수 있도록(반복문이라 정확하게 선택할 수 없음)
	   //예약취소처리한 값 DB에서 삭제


});
		function del(index) {
			var i = index;
			console.log(i);
		
			var imp_uid = 'imp_'+$('input[data-uid="'+index+'"]').val();
			var pay = $('input[data-pcnt="'+index+'"]').val();
		
			console.log(imp_uid);
			console.log(pay);
			console.log('삭제실행');
			
			$.ajax({

			      url: "payment/cancel", 
			      type: "Post",
			      data: ({
			        imp_uid: imp_uid, //주문번호
			        amount: pay, //결제금액
			        
		      })
		    }).done(function(result) { // 환불 성공시 로직 
		        alert("환불 성공");
		    
			        $.ajax({
	
			            url: "delete", 
			            type: "Post",
			            data: ({
			                  imp_uid: imp_uid, //주문번호
			                  
			            })
			        })
		    
		        alert("삭제완료");
		    
		    }).fail(function(error) { // 환불 실패시 로직
		      	alert("환불 실패");
		    });
			
		}
		   

</script>

</body>
</html>
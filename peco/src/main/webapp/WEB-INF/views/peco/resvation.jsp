<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</head>
<style>
    /*달력속성 변경*/
    .hasDatepicker {
        display: inline-block;
    }
    
    /*readonly 백그라운드 색상 설정*/
    
    input:read-only {
    background-color: lightgrey;
    
    }
</style>
<body>
<fieldset>
   <legend>제목</legend>
<form class="resForm" style="width:600px; padding:10px;" onsubmit="return false" action="resAction">
   <div class="user">
   <div class="pention" style="display:inline-block; width:600px; padding:10px;">
   <div style="border: 1px solid black; width:300px; height:200px; display:block">펜션이미지</div><br>
   
   <c:forEach var="p" items="${pList}">
   펜션명 <input type="text" value="${p.pname}" id="pname"><br>
   <input type="hidden" value="${p.p_id}" id="p_id"> <%--hidden 변경 --%>
   객실명 <input type="text" value= "${p.roomname}" id="roomname">
   
   </div><hr>
      <c:forEach var="mem" items="${mList}">
      <button id="btn2">직접입력</button><br>
   	회원번호 <input type="text" value= "${mem.m_id}" id="m_id">
         이름 <input type="text" value="${mem.mname }" id="user_id" readonly><br>
         이메일 <input type="text" value="${mem.email }" id="user_email" readonly><br>
         전화번호 <input type="text" value="${mem.mphone }" id="user_tel" readonly><br>
      
   </div>
      <hr>
      <div class="resvation">
         <div class="datepicker1"></div>
           <div class="datepicker2"></div>
           <br>
         입실날짜 <input type="text" value="" id="date1" readonly><br>
         퇴실날짜 <input type="text" value="" id="date2" readonly><br>
         총 숙박일 수<input type="text" value="" id="period" readonly><br>
         
    1박 금액 <input type="text" value="${p.price}" id="price" readonly>
         결제금액 <input type="text" id="pay" readonly><br>
      </div>
      </c:forEach></c:forEach>
      <br>
   <button id="btn1">예약하기</button>
   <input type="reset" value="뒤로가기">
   
   <button id="payment">결제</button>
</form>
</fieldset>

   <c:forEach var="dis" items="${disabledate}">
   s<input type="hidden" value="${dis.startdate}" name="startDate"> <%--hidden 변경 --%>
   e<input type="hidden" value="${dis.enddate}" name="endDate"> <%--hidden 변경 --%>
   </c:forEach>

    <script>

            let disDays = [];
            let listDate = [];
            
        $(function() {

            //선택불가 날짜 비활성화
            inputDisDays();
         
           
            //날짜선택달력1 생성
            //input을 datepicker로 선언
            $(".datepicker1").datepicker({
                showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
                ,selectOtherMonths: true
                //,changeYear: true //option값 년 선택 가능
                //,changeMonth: true //option값 월 선택 가능                
                //,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
                //,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                //,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
                ,buttonText: "선택" //버튼 호버 텍스트              
                ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
                ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
                ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                ,maxDate: "+1y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후) 
                ,dateFormat: 'yy-mm-dd',
                onSelect: function(date1) {
                $('#date1').val(date1);
                }
                ,beforeShowDay: function(date) {
                    var dateString = $.datepicker.formatDate('yy-mm-dd', date);
                    if(disDays.indexOf(dateString) != -1) {
                        return [false];
                    } else {
                        return [true];
                    }
                }
            });                    
            
            //초기값을 오늘 날짜로 설정해줘야 합니다.
            //$('·datepicker1').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후); 
            
            //날짜선택달력1 생성
            //input을 datepicker로 선언
            $(".datepicker2").datepicker({
                showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
                ,selectOtherMonths: true
                //,changeYear: true //option값 년 선택 가능
                //,changeMonth: true //option값 월 선택 가능                
                //,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
                //,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                //,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
                ,buttonText: "선택" //버튼 호버 텍스트              
                ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
                ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
                ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                ,maxDate: "+1y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후) 
                ,dateFormat: 'yy-mm-dd',
                onSelect: function(date2) { //박스2에 출력
                $('#date2').val(date2);
                 }
                ,beforeShowDay: function(date) { //비활성화 날짜
                    var dateString = $.datepicker.formatDate('yy-mm-dd', date);
                    if(disDays.indexOf(dateString) != -1) {
                        return [false];
                    } else {
                        return [true];
                    }
                } 
            }); 

            
            btn1.addEventListener('click', function() {
                listDate = [];
                let sDay = document.querySelector('#date1').value;
                let eDay = document.querySelector('#date2').value;
                console.log('s'+sDay,length);
                console.log('e'+eDay);

            if(!sDay.length || !eDay.length) { //만약에 input 값이 비었다면
            alert('날짜를 선택해주세요');
             } else {
                //yy-mm-dd로 받은 값을 -를 구분자로 하여 Date 배열로 반환
                var startday = sDay.split('-');
                var endday = eDay.split('-');
                var sArr = new Date(startday[0], startday[1]-1, startday[2]);
                var eArr = new Date(endday[0], endday[1]-1, endday[2]);
                // console.log(sArr);
                // console.log(eArr);

                    getDateRange(sDay, eDay, listDate);
                    console.log('l '+listDate);
                    console.log('d '+disDays)

                    //예약날짜에 예약불가일자가 포함된 경우 알림처리
                    for(var i=0; i<listDate.length; i++) {
                        for(var j=0; j<disDays.length; j++) {
                            if(listDate[i]===disDays[j]) {
                                alert('예약불가 일자가 포함되었습니다\n'+listDate[i]+'일은 예약할 수 없습니다');
                                // console.log('l '+ listDate[i]);
                                // console.log('d '+ disDays[j]);
                                return false;
                            } 
                        }
                    }
                    
                    if(eArr.getTime() <= sArr.getTime()) {
                        alert('하루이상 선택해주세요');
                    } else {
                        const diffDate = eArr.getTime() - sArr.getTime();
                        diffday = Math.abs(diffDate / (1000 * 60 * 60 * 24));
                        //console.log(Math.abs(diffDate / (1000 * 60 * 60 * 24)));
                    
                        if(diffday > 0) {
                            alert('선택되었습니다');
                            $('#period').val(diffday+'박'+(diffday+1)+'일');
                           
                        //총 결제금액 구하기(기간+1)+1박당 가격
                        console.log($('#price').val());
                        let priceCnt = $('#price').val()*diffday;
                        console.log(priceCnt);
                        $('#pay').val(priceCnt);
                        

                         }
                         }

                }
             })


                    //예약자정보 직접입력 전환 기본값:readonly(disable로 설정 시 서브밋할때 안넘어감)
                    btn2.addEventListener('click', function() {
                       $('#user_id').attr('readonly',false);
                       $('#user_email').attr('readonly',false);
                       $('#user_tel').attr('readonly',false);
                       console.log('aaa');
                    })
         
                    $('#payment').click(function () {
                        console.log('aaaa')
                           var IMP = window.IMP;
                           IMP.init('imp07586387');
                          
                           //DOM객체들에서 사용할 데이터 뽑기

                           var p_id = $('#p_id').val();
                           var m_id = $('#m_id').val();
                           var pname = $('#pname').val();
                           var period = $('#period').val();
                           var pay = $('#pay').val();
                           var user_id = $('#user_id').val();
                           var user_email = $('#user_email').val();
                           var user_tel =  $('#user_tel').val();
                           var startdate = $('#date1').val();
                           var enddate = $('#date2').val();
                           var roomname = $('#roomname').val();

                           IMP.request_pay({
                                //카카오페이 결제시 사용할 정보 입력
                               pg: 'kakaopay',
                               pay_method: "card",
                               name: pname,
                               amount: pay,
                               buyer_email: user_email,
                               buyer_name: user_id,
                               buyer_tel: user_tel,
                           }, function (rsp) {
                                
                        	   console.log(rsp);
                   			// 결제검증
                   			$.ajax({
                   	        	type : "POST",
                   	        	url : "/payment/verifyIamport/" + rsp.imp_uid 
                   	        }).done(function(data) {
                   	        	
                   	        	console.log(data);
                   	        	
                   	        	// 결제 유효성 검증
                   	        	// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
                   	        	if(rsp.paid_amount == data.response.amount){
                   	        		var msg = "결제 및 결제검증완료";
                   		        	msg += '\n고유ID : ' + rsp.imp_uid;
                                    msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                                    msg += '\n결제 금액 : ' + rsp.paid_amount+'원';
                                    
                                    if(rsp.apply_num === null || rsp.apply_num === undefined || rsp.apply_num === '') {
                                    	rsp.apply_num = '카카오페이머니';
                                    }
                                    msg += '\n카드 승인번호 : ' + rsp.apply_num;                                    	
                   		        	
                                    $.ajax({
                                        url: "/peco/insert",
                                        type: 'post',
                                        data: {
                                           p_id: p_id,//펜션아이디   
	                                       period: period,//기간
	                                       pricecnt: pay,//결제할 가격
	                                       startdate : startdate, //입실일
	                                       enddate : enddate, //퇴실일
	                                       pr_name: user_id,//예약자명
	                                       pr_email: user_email,//예약자 이메일
	                                       pr_tel: user_tel,//예약자 전화번호
	                                       imp_uid: rsp.imp_uid, //거래고유번호
	                                       pr_id: rsp.merchant_uid, //주문고유번호=펜션예약번호
									 	   pr_pay: rsp.apply_num, //카드승인번호
									 	   m_id : m_id,//회원번호 -예약자명 직접입력 경우 다를 경우
									 	   pname : pname, //펜션명
									 	   roomname : roomname,//객실명
                                        }                               
                                      });
                                    console.log('토큰생성');
                                    $.ajax({
                                    	type : "POST",
                           	        	url : "/payment/complete"
                                    })
                                    console.log('토큰생성완료');
                                    
                                    $('#resForm').submit(); 
                           			alert(msg);
                           			window.location.replace("./redirect");
                   	        	} else {
                   	        		var msg = '결제에 실패하였습니다.';
                                    msg += '에러내용 : ' + rsp.error_msg;
                           			alert(msg);
                   	        	}
                           		
                   	        });
                           });
                           
                       });
                      
                   
               

  });
        
      //시작 날짜와 끝 날짜 사이의 날짜 배열 생성
        let getDateRange = function(startDate, endDate, listDate) {
                var dateMove = new Date(startDate);
                var strDate = startDate;

                if (startDate == endDate) {
                    var strDate = dateMove.toISOString().slice(0,10);
                    listDate.push(strDate);
                } else {

                    while (strDate < endDate)  {
                        var strDate = dateMove.toISOString().slice(0, 10);
                        listDate.push(strDate);
                        dateMove.setDate(dateMove.getDate() + 1);
                    }
                }
                return listDate;
            };
        
        
        //테이블에서 선택불가날짜 가져오기
        let inputDisDays = function() { 
        	
        	let startArr = [];
        	let endArr = [];

	        $("input[name=startDate]").each(function(index, item){
	        	var startDate = $(item).val(); 	
	        	startArr.push(startDate);
	        });

        	$("input[name=endDate]").each(function(index, item){
        		var	endDate = $(item).val();  	
        		endArr.push(endDate);
	        });

   			
			//console.log('s'+startArr);
			//console.log('e'+endArr);
			
			for(i=0; i<startArr.length; i++) {
				getDateRange(startArr[i], endArr[i], listDate);
			}
			
			for(i=0; i<listDate.length; i++) {
				var dis = listDate[i];
				disDays.push(dis);
				
				console.log(dis);
			}
			
			console.log(disDays);
		
        }


     </script>

</body>
</html>
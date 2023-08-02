<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link href="resources/css/base.css" rel="stylesheet">
<link href="resources/css/mypage.css" rel="stylesheet">

<script type="text/javascript">
	$(function(){
// 		console.log("onload....","${param.id}");
		if('${user_id}'===''){
// 			console.log('널입니다.');
			location.href = 'login.do';
		}
		$.ajax({
			url : "jsonMemberSelectOne.do",
			data:{id:"${param.id}"},
			method:'GET',
			dataType:'json',
			success : function(vo2) {
				let tag_vo2 =  `
			    	<tr>
				    	<td>
				     		<div class="mb-3"><img width="200px" src="resources/img/\${vo2.member_savename}"></div>
					        <div>이름: \${vo2.name}</div><br>
					        <div>주소: \${vo2.address}</div><br>
					        <div>
						        <span class="me-4">상품구매: \${vo2.buy_count}회</span>
						        <span class="me-4">상품판매: \${vo2.sell_count}회</span>
						        <span class="me-4">신고누적: \${vo2.member_report}회</span>
					        </div>
			     		</td>
			    	</tr>
				`;
				
				$("#vo2").html(tag_vo2);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...
		
	});//end onload..

</script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="container">
		<div class="row mx-2 my-5">
			<div class="col-6 px-0">
				<h4 class="fw-bold">마이페이지</h4>
			</div>
		</div>
		<div class="row my-3">
			<div class="col-md-3 col-lg-2">
				<ul class="mypage-floating-menu px-0">
					<li class="fw-bolder"><a href="memberSelectOne.do?id=${user_id}" class="text-main-color">마이페이지</a></li>
					<li><a href="memberUpdate.do?id=${user_id}">회원정보수정</a></li>
					<li><a href="qnaSelectAll.do?writer=${user_id}">내 Q&A 목록</a></li>
				</ul>
			</div>
			<div class="col-md-9 col-lg-10 px-5">
				<div class="fs-5 fw-bold mb-3">${user_id}님 마이페이지</div>
				<div class="border-silver p-5">
					<table class="p-5">
						<thead>
						</thead>
						<tbody id="vo2">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>
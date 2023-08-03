<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원정보수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="resources/css/base.css" rel="stylesheet">
<link href="resources/css/mypage.css" rel="stylesheet">
<link href="resources/css/button.css" rel="stylesheet">
<link href="resources/css/size-utilities.css" rel="stylesheet">

<script type="text/javascript">
	function findAddress() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            var roadAddr = data.roadAddress;
	            var extraRoadAddr = '';
	
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
				
	            $("input[name=postcode]").val(data.zonecode);
	            $("input[name=address]").val(roadAddr);
	            $("input[name=detail-address]").focus();
	        }
	    }).open();
	}
	
	const idRegExp = /^[a-zA-Z0-9]{4,12}$/; //아이디 
	const pwRegExp = /^[a-zA-Z0-9]{4,12}$/; //비밀번호
	const nameRegExp = /^[가-힣a-zA-Z]{2,20}$/; //이름
	let box;

	$(function() {
		// 		console.log("onload....");

		$('#update_form').submit(function() {
			if (!validationPw()) {
				return false;
			} else if (!validationName()) {
				return false;
			}
			alert('회원정보수정 성공하셨습니다!');
			return true;
		});//function(),#update_form.submit

		//비밀번호를 체크하는 함수
		function validationPw() {
			box = document.getElementById('pw');
			if (!pwRegExp.test(box.value)) {
				alert('비밀번호를 정확하게 적어주세요.');
				box.value = "";
				box.focus();
				return false;
			} else if (box.value == document.getElementById('id').value) {
				alert('비밀번호는 아이디와 같을 수 없습니다.')
				box.value = "";
				box.focus();
				return false;
			}
			return true;
		}

		//이름체크하는 함수
		function validationName() {
			box = document.getElementById('name');
			if (!nameRegExp.test(box.value)) {
				alert('이름을 정확하게 적어주세요.');
				box.value = "";
				box.focus();
				return false;
			}
			return true;
		}

		$("sidenav").click(function() {
			toggleClass(".active-color");
		});
		

		const fileInput = document.getElementById('multipartFile');
		const previewImage = document.getElementById('preview-image');

		fileInput.addEventListener('change', function(event) {
			const file = event.target.files[0];
			const reader = new FileReader();

			reader.onload = function() {
				previewImage.src = reader.result;
			}

			if (file) {
				reader.readAsDataURL(file);
			}
		});

	});//end onload
</script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="container">
		<div class="row mx-2 my-5">
			<div class="col-6 px-0">
				<h4 class="fw-bold">회원정보수정</h4>
			</div>
		</div>
		<div class="row my-3">
			<div class="col-md-3 col-lg-2">
				<ul class="mypage-floating-menu px-0">
					<li><a href="memberSelectOne.do?id=${user_id}">마이페이지</a></li>
					<li class="fw-bolder"><a href="memberUpdate.do?id=${user_id}" class="text-main-color">회원정보수정</a></li>
					<li><a href="qnaSelectAll.do?writer=${user_id}">내 Q&A 목록</a></li>
				</ul>
			</div>
			<div class="col-md-9 col-lg-10 px-5">
				<div class="fs-5 fw-bold mb-3">${user_id}님 회원정보수정</div>
				<div class="border-silver p-5">
					<form action="memberUpdateOK.do" method="post" enctype="multipart/form-data" id="update_form">
						<div class="fw-bold mb-2">프로필 사진</div>
						<div class="my-3">
							<img class="w-lg-25 w-sm-50" src="resources/img/${vo2.member_savename}" id="preview-image">
							<input type="file" id="multipartFile" name="multipartFile" class="form-control my-2 w-lg-50">
							<input type="hidden" id="member_savename" name="member_savename" value="${vo2.member_savename}">
						</div>
						<hr>
						<div class="my-3">
							<span class="fw-bold me-3">아이디</span>
							<span id="span_id" >${vo2.id}</span>
							<input type="hidden" id="id" name="id" value="${vo2.id}" required>
						</div>
						<hr>
						<div class="my-3">
							<span class="fw-bold my-4">비밀번호</span>
							<input type="password" id="pw" name="pw" value="${vo2.pw}" placeholder="비밀번호" class="form-control w-lg-50 my-2" required>
							<p class="mb-2">4~12자의 영문 대소문자와 숫자로만 입력</p>	
						</div>
						<hr>
						<div>
							<span class="fw-bold my-3">이름</span>
							<input type="text" id="name" name="name" value="${vo2.name}" placeholder="이름" class="form-control w-lg-50 my-2" required>
							<p class="mb-2">2~20자의 영문 대소문자와 한글 입력</p>
						</div>
						<hr>
						<div>
							<span class="fw-bold my-3 me-3">주소</span>
							<c:set var="addressArray" value="${fn:split(vo2.address, ',')}" />
							<button type="button" class="btn button-main-color my-2" onclick="findAddress()">주소 검색</button>
							<input type="text" name="address" placeholder="기본 주소" class="form-control w-lg-50" value="${addressArray[0]}" required readonly>
							<input type="text" name="detail-address" placeholder="나머지 주소(선택 입력 가능)" class="form-control my-2 w-lg-50" value="${fn:trim(addressArray[1])}">										
						</div>
						<div class="text-center my-4">
							<input type="submit" value="회원수정완료" class="btn button-main-color">
						</div>
						<div class="mt-3">
							<h5 class="fw-bold my-3">회원 탈퇴</h5>
							<p>회원 탈퇴시 모든 정보가 삭제되며 되돌릴 수 없습니다.</p>
							<p>정말 탈퇴하시겠습니까?</p>
							<a href="memberDeleteOK.do?id=${param.id}" class="text-main-color fw-bold">회원탈퇴하기</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>
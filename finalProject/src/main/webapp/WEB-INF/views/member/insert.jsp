<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="resources/css/base.css" rel="stylesheet">
<link href="resources/css/button.css" rel="stylesheet">
<script type="text/javascript">
	function findAddress() {
		var width = 500; //팝업의 너비
		var height = 600; //팝업의 높이
		new daum.Postcode({
		    width: width, //생성자에 크기 값을 명시적으로 지정해야 합니다.
		    height: height
		}).open({
		    left: (window.screen.width / 2) - (width / 2),
		    top: (window.screen.height / 2) - (height / 2)
		});	
	}

	const idRegExp = /^[a-zA-Z0-9]{4,12}$/; //아이디 
	const pwRegExp = /^[a-zA-Z0-9]{4,12}$/; //비밀번호
	const nameRegExp = /^[가-힣a-zA-Z]{2,20}$/; //이름
	let box;

	$(function() {
		// 		console.log('onload....');

		$('#insert_form').submit(function() {
			// 					console.log("insert_form!", $("#idCheck_flag").val(), $(
			// 							"#idCheck_flag").val() === '1');
			if (!validationId()) {
				return false;
			} else if (!validationPw()) {
				return false;
			} else if (!validationPwCheck()) {
				return false;
			} else if (!validationName()) {
				return false;
			}

			else if ($("#idCheck_flag").val() === '1') {
				alert("회원가입 완료되었습니다!");
				return true;
			}
			alert("ID중복검사버튼을 눌러 사용가능한 아이디인지 확인해주세요!");
			return false;
		});

		$('#btn_idCheck').click(function() {
			// 			console.log("btn_idCheck!");
			if (!validationId()) {
				return false;
			}
			idCheck();

			return false;
		});
	});

	function idCheck() {
		// 		console.log('idCheck()....');

		// 		console.log('id:', $("#id").val());
		$.ajax({
			url : "jsonIdCheck.do",
			data : {
				id : $("#id").val()
			},
			method : 'GET',
			dataType : 'json',
			success : function(response) {
				// 				console.log('ajax...success:', response);

				let msg = '';
				if (response.result === 'OK') {
					msg = '사용가능한 아이디 입니다';
					$("#idCheck_flag").val(1);
				} else {
					msg = '아이디: 사용할 수 없는 아이디입니다. 다른 아이디를 입력해 주세요.';
					$("#idCheck_flag").val(0);
				}

				$("#demo").html(msg);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end  $.ajax()
	}

	//ID를 체크하는 함수
	function validationId() {
		box = document.getElementById('id');
		if (!idRegExp.test(box.value)) {
			alert('아이디를 정확하게 적어주세요.');
			$("#demo").html("");
			box.value = "";
			box.focus();
			return false;
		}
		return true;
	}

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

	//비밀번호를 한번더 적어서 맞게 썼는지 확인하는 함수
	function validationPwCheck() {
		box = document.getElementById('pwCheck');
		if (box.value != document.getElementById('pw').value) {
			alert('비밀번호가 서로 다릅니다.');
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
</script>
</head>

<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="container">
		<div class="row mx-2 my-5">
			<div class="col px-0">
				<h4 class="fw-bold text-center">회원가입</h4>
			</div>
		</div>
		<div class="row mx-2 justify-content-center">
			<form action="memberInsertOK.do" method="post" enctype="multipart/form-data" id="insert_form" 
				class="col-xl-4 col-lg-6 col-md-7 p-5 border-silver">
				<input type="hidden" id="idCheck_flag" value="0">
				<div><b>아이디</b></div>
				<div>
					<div class="input-group my-2">
						<input type="text" id="id" name="id" placeholder="아이디" class="form-control" required value="">
						<button type="button" id="btn_idCheck" class="btn button-main-color">ID중복검사</button>
					</div>
					<span id="demo"></span>
					<p>4~12자의 영문 대소문자와 숫자로만 입력</p>
				</div>
				<div class="mt-4">
					<div><b>비밀번호</b></div>
					<input type="password" id="pw" name="pw" placeholder="비밀번호" class="form-control my-2" required value="">
					<p>4~12자의 영문 대소문자와 숫자로만 입력</p>
				</div>
				<div class="mt-4">
					<div><b>비밀번호 확인</b></div>
					<input type="password" id="pwCheck" placeholder="비밀번호 확인" class="form-control my-2" required value="">
					<p>4~12자의 영문 대소문자와 숫자로만 입력</p>
				</div>
				<div class="mt-4">
					<div><b>이름</b></div>
					<input type="text" id="name" name="name" placeholder="이름" class="form-control my-2" required value="">
					<p>2~20자의 영문 대소문자와 한글 입력</p>
				</div>
				<div class="mt-4">
					<div><b>주소</b></div>
					<div class="input-group my-2">
						<input type="text" name="postcode" placeholder="우편번호" class="form-control" required disabled>
						<button type="button" class="btn button-main-color" onclick="findAddress()">주소 검색</button>
					</div>
					<input type="text" name="address" placeholder="기본 주소" class="form-control" required disabled>
					<input type="text" name="secondary-address" placeholder="나머지 주소(선택 입력 가능)" class="form-control my-2" required>
				</div>
				<div class="mt-4">
					<div><b>프로필 사진</b></div>
					<input type="file" id="multipartFile" name="multipartFile" class="form-control my-2">
				</div>
				<div class="mt-4"> 
					<input type="submit" value="회원가입" class="btn button-main-color w-100">
				</div>
	<!-- 				<div>
						<label for="address"><b>주소</b></label> <br> <select id="address" name="address" class="">
							<option selected>서울</option>
							<option>부산</option>
							<option>대구</option>
							<option>인천</option>
							<option>광주</option>
							<option>대전</option>
							<option>울산</option>
							<option>강원</option>
							<option>경기</option>
							<option>경남</option>
							<option>경북</option>
							<option>전남</option>
							<option>전북</option>
							<option>제주</option>
							<option>충남</option>
							<option>충북</option>
						</select>
					</div> -->
			</form>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>
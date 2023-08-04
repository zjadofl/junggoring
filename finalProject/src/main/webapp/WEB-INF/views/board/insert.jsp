<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상품 등록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="resources/css/base.css" rel="stylesheet">
<link href="resources/css/size-utilities.css" rel="stylesheet">
<link href="resources/css/button.css" rel="stylesheet">
</head>
<script type="text/javascript">
	$(function() {

		let fileInput = document.getElementById('multipartFiles');
		let max = 3;

		fileInput.addEventListener('change', function(event) {
			if (event.target.files.length > max) {
				alert('최대 ' + max + '개 까지만 선택할 수 있습니다.');
				fileInput.value = '';
			}
		});
	});

	function check() {
		if (document.getElementById("board_title").value == "") {
			alert("제목을 입력하세요.");
			return;
		}
		if (document.getElementById("price").value == "") {
			alert("가격을 입력하세요");
			return;
		}
		board_form.submit();
	}
	
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
				
                $("input[name=address]").val(roadAddr);
                $("input[name=detail-address]").focus();
            }
        }).open();
	}
</script>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="container">
		<div class="row mx-2 my-5">
			<div class="col px-0">
				<h4 class="fw-bold">상품 등록</h4>
			</div>
		</div>
		<div class="row">
			<form action="boardInsertOK.do" method="post" enctype="multipart/form-data" name="board_form">
				<div class="col-12 mb-3">
					<label for="board_title" class="form-label">제목</label>
					<input type="text" name="board_title" class="form-control" id="board_title" placeholder="제목을 입력하세요">
				</div>
				<div class="col-12 mb-3">
					<label for="price" class="form-label">가격</label>
					<input type="number" name="price" class="form-control" id="price" placeholder="가격을 입력하세요" min="0">
				</div>
				<div class="col-12 mb-3">
					<label for="writer" class="form-label">작성자</label>
					<label class="form-control">${user_id}</label>
					<input type="hidden" name="writer" class="form-control" id="writer" value="${user_id}">
				</div>
				<div class="col-12 mb-3">
					<label for="board_content" class="form-label">내용</label>
					<textarea rows="20" cols="40" name="board_content" class="form-control" id="board_content" placeholder="내용을 작성하세요"></textarea>
				</div>
				<div></div>
				<div class="col-md-6 mb-3">
					<label for="category" class="form-label">카테고리</label>
					<select id="category" name="category" class="form-select">
						<option selected>디지털기기</option>
						<option>생활가전</option>
						<option>가구</option>
						<option>주방용품</option>
						<option>유아동</option>
						<option>의류</option>
						<option>잡화</option>
						<option>미용</option>
						<option>스포츠</option>
						<option>게임/음반</option>
						<option>도서</option>
						<option>티켓</option>
						<option>가공식품</option>
						<option>반려동물</option>
						<option>식물</option>
					</select>
				</div>
	
				<div class="col-md-6 mb-3">
					<span class="me-3">거래지역</span>
					<button type="button" class="btn button-main-color my-2" onclick="findAddress()">주소 검색</button>
					<input type="text" name="address" placeholder="기본 주소" class="form-control" required readonly>
					<input type="text" name="detail-address" placeholder="나머지 주소(선택 입력 가능)" class="form-control my-2">
				</div>
				<div class="col-12 mb-3">
					<input type="radio" name="board_type" id="board_type" value="1" class="me-2"/>구해요
					<input type="radio" name="board_type" id="board_type" value="2" checked="checked" class="me-2"/>팔아요
				</div>
	
				<div class="col-12 mb-3">
					<label for="multipartFiles" class="form-label">이미지사진</label>
					<input type="file" name="multipartFiles" id="multipartFiles" multiple="multiple" class="form-control w-md-50" />
				</div>
	
				<div class="col-12 mb-3">
					<input type="hidden" name="board_status" id="board_status" value="1" />
				</div>
	
				<div class="col-12 mb-3">
					<input type="button" class="btn button-main-color" value="등록" onclick="check()" />
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>

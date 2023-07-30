<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link href="resources/css/base.css" rel="stylesheet">
<link href="resources/css/button.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="container min-vh-75">
		<div class="row mx-2 my-5 justify-content-center align-items-center">
			<div class="col-lg-3 col-md-5 col-9">			
				<form action="loginOK.do" method="post">
					<div>
						<input type="text" id="id" name="id" class="form-control" placeholder="아이디" required>
						<input type="password" id="pw" name="pw" class="form-control mt-2" placeholder="비밀번호" required>
						<p>${message}</p>
						<input type="submit" value="로그인" class="btn button-main-color w-100">
					</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>	
</body>
</html>
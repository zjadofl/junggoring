<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<title>공지사항 상세</title>
<link href="resources/css/base.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="container">
		<div class="row mx-2 my-5">
			<div class="col-6 px-0">
				<h4 class="fw-bold">공지사항</h4>
			</div>
		</div>	
		<div class="row mx-2 my-5">
			<table class="table">
				<tbody class="table-group-divider">
					<tr>
						<th class="col-sm-1 col-2 align-middle">제목</th>
						<td class="col-sm-10 col-10 fs-5">${vo2.notice_title}</td>
					</tr>
					<tr>
						<td colspan="2">
							<ul class="d-flex">
								<li class="me-4">관리자</li>
								<li><fmt:formatDate value="${vo2.notice_date}" pattern="yyyy-MM-dd"/></li>
							</ul>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="p-4">${vo2.notice_content}</td>
					</tr>
				</tbody>
			</table>			
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>
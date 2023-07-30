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
<title>공지사항</title>
<link href="resources/css/base.css" rel="stylesheet">
<link href="resources/css/button.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="container">
		<div class="row mx-2 my-5">
			<div class="col-6 px-0">
				<h4 class="fw-bold">공지사항</h4>
			</div>
		</div>
		
	    <div class="row justify-content-md-end">
	      <div class="col-lg-5 col-md-8">
	        <form action="noticeSearchList.do" class="d-flex">
	          <select name="searchKey" id="searchKey" class="form-control form-select me-1 w-50">
	            <option value="notice_title">제목</option>
	            <option value="notice_content">내용</option>
	          </select> 
	          <input type="text" name="searchWord" id="searchWord" class="form-control me-1" placeholder="키워드를 입력하세요.">
	          <input type="submit" value="검색" class="btn button-main-color">
	        </form>
	      </div>
	    </div>
		
			<table class="table mt-3" id="ntable">
				<tbody class="table-group-divider" id="vos">
					<c:forEach var="vo" items="${vos}">
						<tr onClick="location.href='noticeSelectOne.do?notice_num=${vo.notice_num}'">
							<td class="col-md-1 col-1 text-center">${vo.notice_num}</td>
							<td class="col-md-8 col-7 text-ellipsis">${vo.notice_title}</td>
							<!--<td class="col-6 text-ellipsis">${vo.notice_content}</td> -->
							<td class="col-md-3 col-4 text-end"><fmt:formatDate value="${vo.notice_date}" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		
			<div class="pagenation d-flex justify-content-center">
				<c:forEach var="i" begin="1" end="${totalPageCount}" step="1">
					<a href="noticeSelectAll.do?cpage=${i}${params}">${i}</a>&nbsp;
				</c:forEach>
			</div>

	</div>
	<jsp:include page="../footer.jsp"></jsp:include>	
</body>
</html>
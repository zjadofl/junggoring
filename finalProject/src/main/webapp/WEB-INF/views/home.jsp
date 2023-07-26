<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>중고링</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link href="resources/css/base.css" rel="stylesheet">
<link href="resources/css/home.css" rel="stylesheet">
<style type="text/css">
.selling-items-status {
	border-radius: 3px;
	color: white;
	padding: 2px 7px;
}

.background-color-main {
	background-color: #33A1FD; 
}

.background-color-silver {
	background-color: silver; 
}

.selling-item {
	width: 20%;
}

.selling-items-contrainer .item-image {
	width: 100%;
	height: 200px;
	overflow: hidden;
	margin: 0 auto;
	border-radius: 5%;
	text-align: center;
}

.selling-items-contrainer .item-image img {
	width: 100%;
	height: 100%;
}

.selling-items-contrainer .item-content {
	padding: 5px;
	max-width: 230px; /* 제목 컨테이너의 최대 너비 지정 */
	white-space: nowrap; /* 텍스트가 너비를 벗어나도 줄바꿈하지 않음 */
	overflow: hidden; /* 너비를 벗어난 텍스트는 감춤 */
	text-overflow: ellipsis; /* 너비를 벗어난 텍스트에 말 줄임표(...) 추가 */
}

.ellipsis-text {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.no-list {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

</style>
</head>
<body>
	<jsp:include page="top_menu.jsp"></jsp:include>
	<div class="container">
		<div class="row mx-2 my-5">
			<div class="col-6 px-0">
		    	<h3 class="fw-bold">공지사항</h3>
		  	</div>
		  	<div class="col-6 text-end px-0">
		    	<a href="noticeSelectAll.do" class="fw-bold fs-5">더보기</a>
		 	</div>
			<table class="table mt-3" id="ntable">
				<thead>
					<tr>
			            <th scope="col" class="col-7">제목</th>
			            <th scope="col" class="col-2">작성자</th>
			            <th scope="col" class="col-3">작성일</th>
					</tr>
				</thead>
				<tbody class="table-group-divider" id="vos">
					<c:forEach var="vo" items="${nvos}">
						<tr onClick="location.href='noticeSelectOne.do?notice_num=${vo.notice_num}'">
							<td class="col-7">${vo.notice_title}</td>
							<td class="col-2">관리자</td>
							<td class="col-3"><fmt:formatDate value="${vo.notice_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div class="row my-5">
			<div class="col-md-6 col-sm-6 px-0">
		    	<h3 class="fw-bold">최근 중고거래</h3>
		  	</div>
		  	<div class="col-md-6 col-sm-6 text-end px-0">
		    	<a href="boardSelectAll.do" class="fw-bold fs-5">더보기</a>
		 	</div>
			<c:choose>
				<c:when test="${empty vos}">
					<div class="no-list">
						<h4>
							<b>등록된 중고거래 게시글이 없습니다.</b>
						</h4>
					</div>
				</c:when>
				<c:otherwise>
					<div class="selling-items-contrainer">
					<c:forEach var="vo" items="${vos}">
						<c:if test="${vo.board_status != 3}">
								<!-- 상품각각 -->
								<div class="selling-item" onClick="location.href='boardSelectOne.do?board_num=${vo.board_num}'">
									<div class="item-image">
										<img src="resources/img/${vo.board_savename1}" alt=""/>
									</div>
									<div class="item-content">
										<c:choose>
											<c:when test="${vo.board_type eq 2}">
												<c:choose>
													<c:when test="${vo.board_status eq 1}">
														<span class="selling-items-status background-color-main">판매중</span>
													</c:when>
													<c:when test="${vo.board_status eq 2}">
														<span class="selling-items-status background-color-silver">판매완료</span>
													</c:when>
												</c:choose>
											</c:when>
											<c:when test="${vo.board_type eq 1}">
												<c:choose>
													<c:when test="${vo.board_status eq 1}">
														<span class="selling-items-status background-color-main">구매중</span>
													</c:when>
													<c:when test="${vo.board_status eq 2}">
														<span class="selling-items-status background-color-silver">구매완료</span>
													</c:when>
												</c:choose>
											</c:when>
										</c:choose>
										<span>${vo.board_title}</span><br />
										<span><fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</span><br/> 
										<span>${vo.deal_region}</span><br/>
										<span><img width="25px" src="resources/img/view_count.png" alt=""/></span>
										<span>${vo.view_count}</span> <span>♡ ${vo.likecount}</span>
									</div>
								</div>
						</c:if>
					</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		
		
		<div class="selling-items-container">
			<h3 class="hover">
				최근 중고거래<a href="boardSelectAll.do" style="float: right;" class="plushover">더보기</a>
			</h3>
			<c:choose>
				<c:when test="${empty vos}">
					<div class="no-list">
						<h4>
							<b>등록된 중고거래 게시글이 없습니다.</b>
						</h4>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="vo" items="${vos}">
						<c:if test="${vo.board_status != 3}">
							<div class="selling-items-contrainer">
								<!-- 상품각각 -->
								<div class="selling-item " onClick="location.href='boardSelectOne.do?board_num=${vo.board_num}'">
									<div class="item-image">
										<img src="resources/img/${vo.board_savename1}" alt="" />
									</div>
									<div class="item-content">
										<c:choose>
											<c:when test="${vo.board_type eq 2}">
												<c:choose>
													<c:when test="${vo.board_status eq 1}">
														<span class="selling-items-status background-color-main">판매중</span>
													</c:when>
													<c:when test="${vo.board_status eq 2}">
														<span class="selling-items-status background-color-silver">판매완료</span>
													</c:when>
												</c:choose>
											</c:when>
											<c:when test="${vo.board_type eq 1}">
												<c:choose>
													<c:when test="${vo.board_status eq 1}">
														<span class="selling-items-status background-color-main">구매중</span>
													</c:when>
													<c:when test="${vo.board_status eq 2}">
														<span class="selling-items-status background-color-silver">구매완료</span>
													</c:when>
												</c:choose>
											</c:when>
										</c:choose>
										<span>${vo.board_title}</span><br /> <span><fmt:formatNumber value="${vo.price}" pattern="#,###" />원</span><br /> <span>${vo.deal_region}</span><br /> <span><img width="25px" src="resources/img/view_count.png" alt="" /></span><span>${vo.view_count}</span> <span>♡ ${vo.likecount}</span>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="selling-items-container">
			<h3>
				최근 팔아요<a href="boardSelectAll.do?board_type=2" style="float: right;" class="plushover">더보기</a>
			</h3>
			<c:choose>
				<c:when test="${empty vos}">
					<div class="no-list">
						<h4>
							<b>등록된 중고거래 게시글이 없습니다.</b>
						</h4>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="vo" items="${sellvos}">
						<c:if test="${vo.board_status != 3}">
							<div class="selling-items-contrainer">
								<!-- 상품각각 -->
								<div class="selling-item" onClick="location.href='boardSelectOne.do?board_num=${vo.board_num}'">
									<div class="item-image">
										<img src="resources/img/${vo.board_savename1}" alt="" />
									</div>
									<div class="item-content">
										<c:choose>
											<c:when test="${vo.board_type eq 2}">
												<c:choose>
													<c:when test="${vo.board_status eq 1}">
														<span class="selling-items-status background-color-main">판매중</span>
													</c:when>
													<c:when test="${vo.board_status eq 2}">
														<span class="selling-items-status background-color-silver">판매완료</span>
													</c:when>
												</c:choose>
											</c:when>
											<c:when test="${vo.board_type eq 1}">
												<c:choose>
													<c:when test="${vo.board_status eq 1}">
														<span class="selling-items-status background-color-main">구매중</span>
													</c:when>
													<c:when test="${vo.board_status eq 2}">
														<span class="selling-items-status background-color-silver">구매완료</span>
													</c:when>
												</c:choose>
											</c:when>
										</c:choose>
										<span>${vo.board_title}</span><br /> <span><fmt:formatNumber value="${vo.price}" pattern="#,###" />원</span><br /> <span>${vo.deal_region}</span><br /> <span><img width="25px" src="resources/img/view_count.png" alt="" /></span><span>${vo.view_count}</span> <span>♡ ${vo.likecount}</span>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="selling-items-container">
			<h3>
				최근 구해요<a href="boardSelectAll.do?board_type=1" style="float: right;" class="plushover">더보기</a>
			</h3>
			<c:choose>
				<c:when test="${empty vos}">
					<div class="no-list">
						<h4>
							<b>등록된 중고거래 게시글이 없습니다.</b>
						</h4>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="vo" items="${buyvos}">
						<c:if test="${vo.board_status != 3}">
							<div class="selling-items-contrainer">
								<!-- 상품각각 -->
								<div class="selling-item" onClick="location.href='boardSelectOne.do?board_num=${vo.board_num}'">
									<div class="item-image">
										<img src="resources/img/${vo.board_savename1}" alt="" />
									</div>
									<div class="item-content">
										<c:choose>
											<c:when test="${vo.board_type eq 2}">
												<c:choose>
													<c:when test="${vo.board_status eq 1}">
														<span class="selling-items-status background-color-main">판매중</span>
													</c:when>
													<c:when test="${vo.board_status eq 2}">
														<span class="selling-items-status background-color-silver">판매완료</span>
													</c:when>
												</c:choose>
											</c:when>
											<c:when test="${vo.board_type eq 1}">
												<c:choose>
													<c:when test="${vo.board_status eq 1}">
														<span class="selling-items-status background-color-main">구매중</span>
													</c:when>
													<c:when test="${vo.board_status eq 2}">
														<span class="selling-items-status background-color-silver">구매완료</span>
													</c:when>
												</c:choose>
											</c:when>
										</c:choose>
										<span>${vo.board_title}</span><br /> <span><fmt:formatNumber value="${vo.price}" pattern="#,###" />원</span><br /> <span>${vo.deal_region}</span><br /> <span><img width="25px" src="resources/img/view_count.png" alt="" /></span><span>${vo.view_count}</span> <span>♡ ${vo.likecount}</span>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>

</html>

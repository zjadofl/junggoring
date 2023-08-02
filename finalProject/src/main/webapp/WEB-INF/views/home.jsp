<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>중고링</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link href="resources/css/base.css" rel="stylesheet">
<link href="resources/css/home.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="top_menu.jsp"></jsp:include>
	<div class="container">
		<div class="row mx-2 my-5">
			<div class="col-6 px-0">
				<h4 class="fw-bold">공지사항</h4>
			</div>
			<div class="col-6 text-end px-0">
				<a href="noticeSelectAll.do" class="fw-bold fs-5 ">더보기</a>
			</div>
			<table class="table mt-3" id="ntable">
				<tbody class="table-group-divider" id="vos">
					<c:forEach var="vo" items="${nvos}">
						<tr onClick="location.href='noticeSelectOne.do?notice_num=${vo.notice_num}'">
							<td class="col-lg-9 col-md-8 col-6 text-ellipsis">${vo.notice_title}</td>
							<td class="col-lg-1 col-md-2 col-2 text-end">관리자</td>
							<td class="col-lg-2 col-md-2 col-4 text-end"><fmt:formatDate value="${vo.notice_date}" pattern="yyyy-MM-dd" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="row mx-2 my-5">
			<div class="col-6 px-0">
				<h4 class="fw-bold">최근 중고거래</h4>
			</div>
			<c:choose>				
				<c:when test="${empty vos}">
					<div class="no-list my-5">
						<p>등록된 중고거래 게시글이 없습니다.</p>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col-6 text-end px-0">
						<a href="boardSelectAll.do" class="fw-bold fs-5">더보기</a>
					</div>					
					<div class="mt-3 g-0">
						<div class="row g-4">
							<c:forEach var="vo" items="${vos}">
								<c:if test="${vo.board_status != 3}">
									<!-- 상품각각 -->
									<div class="item-container col-lg-3 col-md-3 col-sm-6 col-6" onClick="location.href='boardSelectOne.do?board_num=${vo.board_num}'">
										<div class="item-image">
											<img src="resources/img/${vo.board_savename1}" alt="" />
										</div>
										<div class="item-content">
											<div class="item-title text-ellipsis">
												<c:choose>
													<c:when test="${vo.board_type eq 2}">
														<c:choose>
															<c:when test="${vo.board_status eq 1}">
																<span class="item-status background-main-color">판매중</span>
															</c:when>
															<c:when test="${vo.board_status eq 2}">
																<span class="item-status background-color-silver">판매완료</span>
															</c:when>
														</c:choose>
													</c:when>
													<c:when test="${vo.board_type eq 1}">
														<c:choose>
															<c:when test="${vo.board_status eq 1}">
																<span class="item-status background-main-color">구매중</span>
															</c:when>
															<c:when test="${vo.board_status eq 2}">
																<span class="item-status background-color-silver">구매완료</span>
															</c:when>
														</c:choose>
													</c:when>
												</c:choose>
												<span>${vo.board_title}</span>
											</div>
											<div class="item-price">
												<fmt:formatNumber value="${vo.price}" pattern="#,###원" />
											</div>
											<div class="item-region">${vo.deal_region}</div>
											<div class="item-view-like">
												<img width="25px" src="resources/img/views.png" alt="조회수 아이콘" /> <span class="view-count">${vo.view_count}</span> <img width="18px" src="resources/img/border-like.png" alt="조회수 아이콘" /> <span class="like-count">${vo.likecount}</span>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="row mx-2 my-5">
			<div class="col-6 px-0">
				<h4 class="fw-bold">최근 팔아요</h4>
			</div>
			<c:choose>
				<c:when test="${empty sellvos}">
					<div class="no-list my-5">
						<p>등록된 중고거래 게시글이 없습니다.</p>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col-6 text-end px-0">
						<a href="boardSelectAll.do" class="fw-bold fs-5">더보기</a>
					</div>					
					<div class="mt-3 g-0">
						<div class="row g-4">
							<c:forEach var="vo" items="${sellvos}">
								<c:if test="${vo.board_status != 3}">
									<!-- 상품각각 -->
									<div class="item-container col-lg-3 col-md-3 col-sm-6 col-6" onClick="location.href='boardSelectOne.do?board_num=${vo.board_num}'">
										<div class="item-image">
											<img src="resources/img/${vo.board_savename1}" alt="" />
										</div>
										<div class="item-content">
											<div class="item-title text-ellipsis">
												<c:choose>
													<c:when test="${vo.board_type eq 2}">
														<c:choose>
															<c:when test="${vo.board_status eq 1}">
																<span class="item-status background-main-color">판매중</span>
															</c:when>
															<c:when test="${vo.board_status eq 2}">
																<span class="item-status background-color-silver">판매완료</span>
															</c:when>
														</c:choose>
													</c:when>
													<c:when test="${vo.board_type eq 1}">
														<c:choose>
															<c:when test="${vo.board_status eq 1}">
																<span class="item-status background-main-color">구매중</span>
															</c:when>
															<c:when test="${vo.board_status eq 2}">
																<span class="item-status background-color-silver">구매완료</span>
															</c:when>
														</c:choose>
													</c:when>
												</c:choose>
												<span>${vo.board_title}</span>
											</div>
											<div class="item-price">
												<fmt:formatNumber value="${vo.price}" pattern="#,###원" />
											</div>
											<div class="item-region">${vo.deal_region}</div>
											<div class="item-view-like">
												<img width="25px" src="resources/img/views.png" alt="조회수 아이콘" /> <span class="view-count">${vo.view_count}</span> <img width="18px" src="resources/img/border-like.png" alt="조회수 아이콘" /> <span class="like-count">${vo.likecount}</span>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="row mx-2 my-5">
			<div class="col-6 px-0">
				<h4 class="fw-bold">최근 구해요</h4>
			</div>
			<c:choose>
				<c:when test="${empty buyvos}">
					<div class="no-list my-5">
						<p>등록된 중고거래 게시글이 없습니다.</p>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col-6 text-end px-0">
						<a href="boardSelectAll.do" class="fw-bold fs-5">더보기</a>
					</div>					
					<div class="mt-3 g-0">
						<div class="row g-4">
							<c:forEach var="vo" items="${buyvos}">
								<c:if test="${vo.board_status != 3}">
									<!-- 상품각각 -->
									<div class="item-container col-lg-3 col-md-3 col-sm-6 col-6" onClick="location.href='boardSelectOne.do?board_num=${vo.board_num}'">
										<div class="item-image">
											<img src="resources/img/${vo.board_savename1}" alt="" />
										</div>
										<div class="item-content">
											<div class="item-title text-ellipsis">
												<c:choose>
													<c:when test="${vo.board_type eq 2}">
														<c:choose>
															<c:when test="${vo.board_status eq 1}">
																<span class="item-status background-main-color">판매중</span>
															</c:when>
															<c:when test="${vo.board_status eq 2}">
																<span class="item-status background-color-silver">판매완료</span>
															</c:when>
														</c:choose>
													</c:when>
													<c:when test="${vo.board_type eq 1}">
														<c:choose>
															<c:when test="${vo.board_status eq 1}">
																<span class="item-status background-main-color">구매중</span>
															</c:when>
															<c:when test="${vo.board_status eq 2}">
																<span class="item-status background-color-silver">구매완료</span>
															</c:when>
														</c:choose>
													</c:when>
												</c:choose>
												<span>${vo.board_title}</span>
											</div>
											<div class="item-price">
												<fmt:formatNumber value="${vo.price}" pattern="#,###원" />
											</div>
											<div class="item-region">${vo.deal_region}</div>
											<div class="item-view-like">
												<img width="25px" src="resources/img/views.png" alt="조회수 아이콘" /> <span class="view-count">${vo.view_count}</span> <img width="18px" src="resources/img/border-like.png" alt="조회수 아이콘" /> <span class="like-count">${vo.likecount}</span>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-5">
  <div class="row justify-content-center">
    <c:forEach var="dto" items="${goodsList}">
      <div class="col-md-3 col-sm-6 mb-4">
        <div class="card h-100 border-0 shadow-sm">
          <a href="goodsRetrieve?gCode=${dto.gCode}">
            <img src="${dto.gImage}" class="card-img-top" alt="${dto.gName}">
          </a>
          <div class="card-body">
            <h5 class="card-title">${dto.gName}</h5>
            <p class="card-text">${dto.gContent}</p>
            <p class="card-text font-weight-bold">${dto.gPrice}원</p>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

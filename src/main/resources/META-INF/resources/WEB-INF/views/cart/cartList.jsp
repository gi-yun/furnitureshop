<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="webjars/jquery/3.7.1/jquery.min.js"></script>
    <style>
        .table thead th {
            vertical-align: middle;
        }
        .product-image {
            width: 70px;
            height: 70px;
            object-fit: cover;
        }
        .btn-delete {
            color: #fff;
            background-color: #d9534f;
            border-color: #d43f3a;
        }
        .card {
            margin-bottom: 30px;
        }
        .cart-summary {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
        }
        .cart-summary h4 {
            margin-bottom: 20px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            $(".delete-btn").click(function() {
                var num = $(this).data("num");
                $.ajax({
                    url: "cartDelete",
                    type: "POST",
                    data: { num: num },
                    success: function(data, status, xhr) {
                        alert("삭제되었습니다!");
                        location.reload(); // 페이지 새로고침
                    },
                    error: function(xhr, status, error) {
                        alert("삭제에 실패했습니다: " + xhr.responseText);
                    }
                });
            });

            // 전체 삭제
            $("#deleteAll").click(function() {
                var selectedNums = [];
                $("input[name='check']:checked").each(function() {
                    selectedNums.push($(this).data("num"));
                });
                if (selectedNums.length > 0) {
                    $.ajax({
                        url: "cartDeleteAll",
                        type: "POST",
                        traditional: true,
                        data: { nums: selectedNums },
                        success: function(data, status, xhr) {
                            alert("선택된 항목이 삭제되었습니다!");
                            location.reload(); // 페이지 새로고침
                        },
                        error: function(xhr, status, error) {
                            alert("삭제에 실패했습니다: " + xhr.responseText);
                        }
                    });
                } else {
                    alert("삭제할 항목을 선택하세요.");
                }
            });

            // 전체선택 체크박스 기능
            $("#allCheck").click(function() {
                if ($(this).prop("checked")) {
                    $("input[name='check']").prop("checked", true);
                } else {
                    $("input[name='check']").prop("checked", false);
                }
            });
        });
    </script>
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">장바구니</h2>
        <div class="row">
            <div class="col-md-9">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" name="allCheck" id="allCheck"> 전체선택
                            </th>
                            <th>번호</th>
                            <th>상품이미지</th>
                            <th>상품정보</th>
                            <th>상품가격</th>
                            <th>상품수량</th>
                            <th>합계</th>
                            <th>날짜</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="sum" value="0"/>
                        <c:forEach var="dto" items="${cartList}" varStatus="status">
                            <c:set var="amount" value="${dto.gAmount}"/>
                            <c:set var="sum" value="${dto.goodsList[0].gPrice * amount + sum}"/>
                            <tr>
                                <td><input type="checkbox" name="check" class="check" data-num="${dto.num}"></td>
                                <td>${status.index+1}</td>
                                <td><img src="${dto.goodsList[0].gImage}" class="product-image"></td>
                                <td>${dto.gCode}&nbsp;/&nbsp;${dto.gSize}&nbsp;/&nbsp;${dto.gColor}</td>
                                <td>${dto.goodsList[0].gPrice}</td>
                                <td>${amount}</td>
                                <td>${dto.goodsList[0].gPrice * amount}</td>
                                <td>${dto.gCartDate}</td>
                                <td><button class="btn btn-delete btn-sm delete-btn" data-num="${dto.num}"><i class="fas fa-trash-alt"></i> Delete</button></td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="5"></td>
                            <td colspan="3" class="text-right"><strong>총합: &nbsp; ${sum}</strong></td>
                        </tr>
                    </tbody>
                </table>
                <button class="btn btn-success mt-3" id="deleteAll"><i class="fas fa-trash-alt"></i> 전체삭제</button>
            </div>
            <div class="col-md-3">
                <div class="cart-summary">
                    <h4>요약</h4>
                    <p>총합: &nbsp; ${sum}</p>
                    <button class="btn btn-primary btn-block mt-3">결제하기</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

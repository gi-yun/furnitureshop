
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <script src="webjars/jquery/3.7.1/jquery.min.js"></script>
 
 <script>
    $(document).ready(function() {
        $("#delete").click(function() {
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
    });
</script>
 
 
 
  <div class="TodoApp">
    <div class="container">
            <div>
            >>>> ${cartList} <br>
                <table class="table">
                    <thead>
                            <tr>
                                <th>전체삭제
                                    &nbsp;
                                    <input type="checkbox" name="allCheck" id="allCheck"></th>
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
                      ${status.index+1}, ${status.count}, ${status.first}, ${status.last} <br>
                         <c:set var="amount" value="${dto.gAmount}"/>
                         <c:set var="sum" value="${dto.goodsList[0].gPrice * amount + sum}"/>
						 <tr>
						            <td><input type="checkbox" name="check"  class="check"></td> 
					                <td>${status.index+1}</td> 
                                    <td><img src="${dto.goodsList[0].gImage}" width="50" height="50" ></td>
                                    <td>${dto.gCode}&nbsp;/&nbsp;${dto.gSize}&nbsp;/&nbsp;${dto.gColor}</td>
                                    <td>${dto.goodsList[0].gPrice}</td>
                                    <td>${amount}</td>
                                    <td>${dto.goodsList[0].gPrice * amount}</td>
                                    <td>${dto.gCartDate}</td>
                                    <td><a href="javascript:void(0);" class="btn btn-warning delete-btn" data-num="${dto.num}" id="delete">Delete</a></td>
						</tr>
				      </c:forEach>
					    <tr>
					      <td></td>
					      <td></td>
					      <td></td>
					      <td></td>
					      <td></td>
					      <td colspan="3">총합: &nbsp; ${sum}</td>
					    </tr>
                    </tbody>

                  </table>
              </div>
             <div class="btn btn-success m-5">전체삭제</div>
        </div>
    </div>

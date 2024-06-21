<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jQuery 설치 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- Bootstrap CSS 설치 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript">
    $(document).ready(function(){
        $("#up").on("click", function(){
            var gAmount = Number.parseInt($("#gAmount").val());
            $("#gAmount").val(gAmount + 1);
        });

        $("#down").on("click", function(){
            var gAmount = Number.parseInt($("#gAmount").val());
            if (gAmount == 1) {
                $("#gAmount").val(1);
            } else {
                $("#gAmount").val(gAmount - 1);
            }
        });

        // form 버튼 눌렀을 시
        $("form").on("submit", function(event){
            var action = $(document.activeElement).attr("name");
            if (action == "cartAdd") {
                alert("cartAdd submit");
                this.action = "cartAdd";  // CartAddServlet의 맵핑값
            } else if (action == "cartBuy") {
                alert("cartBuy submit");
                this.action = "cartBuy";  // CartBuyServlet의 맵핑값
            }
            this.method = "post";
        });
    });// ready()
</script>

<div class="container mt-5">
    <form class="row g-3">
        <input type="hidden" name="gCode" value="${goodsRetrieve.gCode}">
        <div class="row">
            <!-- 이미지 섹션 -->
            <div class="col-md-6">
                <img src="${goodsRetrieve.gImage}" class="img-fluid" alt="상품 이미지">
            </div>
            <!-- 정보 및 옵션 섹션 -->
            <div class="col-md-6">
                <div class="card-body">
                    <h5 class="card-title">${goodsRetrieve.gName}</h5>
                    <p class="card-text">제품코드: ${goodsRetrieve.gCode}</p>
                    <p class="card-text">가격: ${goodsRetrieve.gPrice}원</p>
                    <div class="form-group">
                        <label for="gSize" class="font-weight-bold">사이즈</label>
                        <select class="form-control" name="gSize" id="gSize">
                            <option selected value="사이즈선택">사이즈선택</option>
                            <option value="L">L</option>
                            <option value="M">M</option>
                            <option value="S">S</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="gColor" class="font-weight-bold">색상</label>
                        <select class="form-control" name="gColor" id="gColor">
                            <option selected value="색상선택">색상선택</option>
                            <option value="navy">navy</option>
                            <option value="black">black</option>
                            <option value="ivory">ivory</option>
                            <option value="white">white</option>
                            <option value="gray">gray</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="gAmount" class="font-weight-bold">주문수량</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button class="btn btn-outline-secondary" type="button" id="down">-</button>
                            </div>
                            <input type="text" class="form-control text-center" name="gAmount" value="1" id="gAmount" readonly>
                            <div class="input-group-append">
                                <button class="btn btn-outline-secondary" type="button" id="up">+</button>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block mt-3" name="cartBuy">구매</button>
                    <button type="submit" class="btn btn-secondary btn-block mt-3" name="cartAdd">장바구니</button>
                </div>
            </div>
        </div>
    </form>
</div>

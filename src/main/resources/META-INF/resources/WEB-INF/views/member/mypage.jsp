<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function(){
    //업데이트 서브밋
    $("form").on("submit", function(){
        this.action = "updateMember";
        this.method = "post";
    });

    // 선택된 값 업데이트
    function updateSelectedValue() {
        // 선택된 값 가져오기
        var selectedValue = document.getElementById("email3").value;
        // 값을 채워 넣을 칸의 요소 가져오기
        var email2 = document.getElementById("email2");
        // 칸에 값 설정하기
        email2.value = selectedValue;
    }

    // 선택 이벤트 핸들러 등록
    $("#email3").on("change", updateSelectedValue);
});
</script>

<div class="container">
    <form class="row g-3 m-4">
        <div class="row mb-3">
            <label for="userid" class="col-sm-2 col-form-label">아이디</label>
            <div class="col-auto">
                <input type="text" class="form-control" id="userid" name="userid" value="${login.userid}" readonly="readonly">
            </div>
        </div>

        <div class="row mb-3">
            <label for="username" class="col-sm-2 col-form-label">이름</label>
            <div class="col-auto">
                <input type="text" class="form-control" name="username" id="username" value="${login.username}" readonly="readonly">
            </div>
        </div>
        <hr>
        <div class="row mb-3">
            <div class="col-auto">
                <label for="sample4_postcode" class="visually-hidden">post</label>
                <input type="text" name="post" value="${login.post}" class="form-control" id="sample4_postcode" placeholder="우편번호">
            </div>
            <div class="col-auto">
                <button type="button" class="btn btn-primary mb-3" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-sm-5">
                <label for="sample4_roadAddress" class="visually-hidden">도로명주소</label>
                <input type="text" name="addr1" value="${login.addr1}" class="form-control" id="sample4_roadAddress" placeholder="도로명주소">
            </div>
            <div class="col-sm-5">
                <label for="sample4_jibunAddress" class="visually-hidden">지번주소</label>
                <input type="text" name="addr2" value="${login.addr2}" class="form-control" id="sample4_jibunAddress" placeholder="지번주소">
                <span id="guide" style="color:#999"></span>
            </div>
        </div>
        <hr>
        <div class="row mb-3">
            <label for="phone1" class="col-sm-2 col-form-label">전화번호</label>
            <div class="col-auto">
                <select name="phone1" class="form-control" id="phone1">
                    <option value="010" <c:if test="${login.phone1 == '010'}">selected</c:if>>010</option>
                    <option value="011" <c:if test="${login.phone1 == '011'}">selected</c:if>>011</option>
                </select>
            </div>
            <div class="col-auto">
                <label for="phone2" class="visually-hidden">전화번호2</label>
                <input type="text" name="phone2" value="${login.phone2}" class="form-control" id="phone2">
            </div>
            <div class="col-auto">
                <label for="phone3" class="visually-hidden">전화번호3</label>
                <input type="text" name="phone3" value="${login.phone3}" class="form-control" id="phone3">
            </div>
        </div>
        <div class="row mb-3">
            <label for="email1" class="col-sm-2 col-form-label">이메일:</label>
            <div class="col-auto">
                <input type="text" name="email1" value="${login.email1}" class="form-control" id="email1">
            </div>
            <div class="col-auto">
                <label for="xxx" class="visually-hidden">@</label>
                <span>@</span>
            </div>
            <div class="col-auto">
                <input type="text" name="email2" class="form-control" value="${login.email2}" id="email2" placeholder="직접입력">
            </div>
            <div class="col-auto">
                <select name="email3" class="custom-select" id="email3">
                    <option value="daum.net">daum.net</option>
                    <option value="google.com">google.com</option>
                    <option value="naver.com">naver.com</option>
                </select>
            </div>
        </div>
        <div class="col-12">
            <button type="submit" class="btn btn-primary">update</button>
            <button type="reset" class="btn btn-secondary">cancel</button>
        </div>
    </form>
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullRoadAddr = data.roadAddress;
                var extraRoadAddr = '';

                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraRoadAddr !== '') {
                    fullRoadAddr += ' (' + extraRoadAddr + ')';
                }

                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                if (data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                } else if (data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>

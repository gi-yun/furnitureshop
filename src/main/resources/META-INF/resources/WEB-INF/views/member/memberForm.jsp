<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="webjars/jquery/3.7.1/jquery.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript">
    $(document).ready(function(){
        // 비밀번호 확인
        $("#passwd2").on("keyup", function(){
            var passwd = $("#passwd").val();
            var passwd2 = $("#passwd2").val();
            var mesg = "비밀번호 일치";
            if(passwd != passwd2){
                mesg = "비밀번호 불일치";
            }
            $("#pwdcheck").text(mesg).removeClass("text-success text-danger").addClass(passwd === passwd2 ? "text-success" : "text-danger");
        });

        // 아이디 중복 체크
        $("#idDupulicatedcheck").on("click", function(){
            $.ajax({
                method:"get",
                url:"idCheck",
                dataType:'text',
                data: { userid: $("#userid").val() },
                success: function(data, status, xhr){
                    $("#idcheck").text(data);
                },
                error: function(xhr, status, error){
                    console.log("error:", error);
                }
            });
        });
    });
    //select 값 가져오기
    function updateSelectedValue1() {
        // 선택된 값 가져오기
        var selectedValue  = document.getElementById("email3").value;
        // 값을 채워 넣을 칸의 요소 가져오기
        var email2 = document.getElementById("email2");
        // 칸에 값 설정하기
        email2.value = selectedValue;
    }
</script>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div class="container mt-5">
    <h2 class="mb-4">회원가입</h2>
    <form:form modelAttribute="memberDTO" method="post">
        <div class="form-group">
            <label for="userid">*아이디</label>
            <div class="input-group">
                <form:input type="text" class="form-control" path="userid" />
                <div class="input-group-append">
                    <button type="button" class="btn btn-outline-secondary" id="idDupulicatedcheck">아이디 중복</button>
                </div>
            </div>
            <small id="idcheck" class="form-text text-muted"></small>
        </div>

        <div class="form-group">
            <label for="password">*비밀번호</label>
            <form:input type="password" class="form-control" path="passwd" />
            <form:errors path="passwd" class="text-danger"/>
        </div>

        <div class="form-group">
            <label for="passwd2">비밀번호 확인</label>
            <input type="password" class="form-control" id="passwd2">
            <small id="pwdcheck" class="form-text"></small>
        </div>

        <div class="form-group">
            <label for="username">이름</label>
            <form:input type="text" class="form-control" path="username" />
        </div>

        <hr>

        <div class="form-group">
            <label for="sample4_postcode">우편번호</label>
            <div class="input-group">
                <input type="text" name="post" class="form-control" id="sample4_postcode" placeholder="우편번호">
                <div class="input-group-append">
                    <button type="button" class="btn btn-outline-secondary" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
                </div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="sample4_roadAddress">도로명 주소</label>
                <input type="text" name="addr1" class="form-control" id="sample4_roadAddress" placeholder="도로명주소">
            </div>
            <div class="form-group col-md-6">
                <label for="sample4_jibunAddress">지번 주소</label>
                <input type="text" name="addr2" class="form-control" id="sample4_jibunAddress" placeholder="지번주소">
                <small id="guide" class="form-text text-muted"></small>
            </div>
        </div>

        <hr>

        <div class="form-group">
            <label for="phone1">전화번호</label>
            <div class="input-group">
                <select name="phone1" class="custom-select" id="phone1">
                    <option value="010">010</option>
                    <option value="011">011</option>
                </select>
                <input type="text" name="phone2" class="form-control" id="phone2" placeholder="1234">
                <input type="text" name="phone3" class="form-control" id="phone3" placeholder="5678">
            </div>
        </div>

        <div class="form-group">
            <label for="email1">이메일</label>
            <div class="input-group">
                <input type="text" name="email1" class="form-control" id="email1" placeholder="이메일">
                <div class="input-group-append">
                    <span class="input-group-text">@</span>
                </div>
                <input type="text" name="email2" class="form-control" id="email2" placeholder="직접입력">
                <select name="email3" class="custom-select" id="email3" onchange="updateSelectedValue1()">
                    <option value="daum.net">daum.net</option>
                    <option value="google.com">google.com</option>
                    <option value="naver.com">naver.com</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-primary">Sign Up</button>
            <button type="reset" class="btn btn-secondary">Cancel</button>
        </div>
    </form:form>
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullRoadAddr = data.roadAddress;
                var extraRoadAddr = '';

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>

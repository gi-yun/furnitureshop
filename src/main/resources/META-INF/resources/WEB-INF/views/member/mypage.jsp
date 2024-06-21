<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>User Info Update</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="webjars/jquery/3.7.1/jquery.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-section {
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }
        .form-section h2 {
            margin-bottom: 30px;
        }
        .btn-primary, .btn-primary:focus {
            background-color: #0058a3;
            border-color: #0058a3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 form-section">
                <h2 class="text-center">회원 정보 수정</h2>
                <form class="needs-validation" novalidate>
                    <div class="form-group row mb-3">
                        <label for="userid" class="col-sm-2 col-form-label">아이디</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="userid" name="userid" 
                                value="${login.userid}" disabled>
                        </div>
                    </div>
                    <div class="form-group row mb-3">
                        <label for="username" class="col-sm-2 col-form-label">이름</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="username" 
                                id="username" value="${login.username}" disabled>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row mb-3">
                        <label for="sample4_postcode" class="col-sm-2 col-form-label">우편번호</label>
                        <div class="col-sm-8">
                            <input type="text" name="post" value="${login.post}" class="form-control" id="sample4_postcode">
                        </div>
                        <div class="col-sm-2">
                            <button type="button" class="btn btn-primary" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
                        </div>
                    </div>
                    <div class="form-group row mb-3">
                        <label for="sample4_roadAddress" class="col-sm-2 col-form-label">도로명주소</label>
                        <div class="col-sm-10">
                            <input type="text" name="addr1" value="${login.addr1}" class="form-control" id="sample4_roadAddress">
                        </div>
                    </div>
                    <div class="form-group row mb-3">
                        <label for="sample4_jibunAddress" class="col-sm-2 col-form-label">지번주소</label>
                        <div class="col-sm-10">
                            <input type="text" name="addr2" value="${login.addr2}" class="form-control" id="sample4_jibunAddress">
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row mb-3">
                        <label for="phone1" class="col-sm-2 col-form-label">전화번호</label>
                        <div class="col-sm-3">
                            <select name="phone1" class="form-control" id="phone1">
                                <option value="010" <c:if test="${login.phone1 == '010'}">selected</c:if>>010</option>
                                <option value="011" <c:if test="${login.phone1 == '011'}">selected</c:if>>011</option>
                            </select>
                        </div>
                        <div class="col-sm-3">
                            <input type="text" name="phone2" value="${login.phone2}" class="form-control" id="phone2">
                        </div>
                        <div class="col-sm-3">
                            <input type="text" name="phone3" value="${login.phone3}" class="form-control" id="phone3">
                        </div>
                    </div>
                    <div class="form-group row mb-3">
                        <label for="email1" class="col-sm-2 col-form-label">이메일</label>
                        <div class="col-sm-4">
                            <input type="text" name="email1" value="${login.email1}" class="form-control" id="email1">
                        </div>
                        <div class="col-sm-1 text-center">
                            <span>@</span>
                        </div>
                        <div class="col-sm-5">
                            <input type="text" name="email2" value="${login.email2}" class="form-control" id="email2" placeholder="직접입력">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-sm-12 text-center">
                            <button type="submit" class="btn btn-primary">업데이트</button>
                            <button type="reset" class="btn btn-secondary">취소</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
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
</body>
</html>

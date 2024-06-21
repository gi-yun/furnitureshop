<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="webjars/jquery/3.7.1/jquery.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript">
    $(document).ready(function(){
        $("form").on("submit", function(){
            alert("login submit");
            this.action = "auth";
            this.method = "post";
        });
    });
</script>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-primary text-white text-center">
                    <h4>로그인</h4>
                </div>
                <div class="card-body">
                    <form method="post" action="auth" class="row g-3">
                        <div class="col-12 mb-3">
                            <!-- <div class="alert alert-danger" role="alert" <c:if test="${not empty errorMessage}">${errorMessage}</c:if>></div> -->
                        </div>
                        <div class="col-12 mb-3">
                            <label for="userid" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="userid" name="userid" required>
                        </div>
                        <div class="col-12 mb-3">
                            <label for="passwd" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" name="passwd" id="passwd" required>
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary w-100">로그인</button>
                            <button type="reset" class="btn btn-secondary w-100 mt-2">취소</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

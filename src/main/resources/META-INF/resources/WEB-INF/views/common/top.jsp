<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<header class="border-bottom border-light border-5 py-3">
    <div class="container">
        <div class="row justify-content-between align-items-center">
            <div class="col-auto">
                <a class="navbar-brand" href="main">
                    <img src="https://www.ikea.com/kr/ko/static/ikea-logo.3ee105eef6b5939c1269.svg" alt="IKEA Logo">
                </a>
            </div>
            <div class="col">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ml-auto">
                            <!-- 인증이 안된 사용자 -->
                            <sec:authorize access="isAnonymous()">
                                <li class="nav-item">
                                    <a class="nav-link" href="login">Login</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="signup">Signup</a>
                                </li>
                            </sec:authorize>
                            <!-- 인증이 된 사용자 -->
                            <sec:authorize access="isAuthenticated()">
                                <li class="nav-item">
                                    <form id="logoutForm" action="logout" method="post" style="display:inline;">
                                        <a class="nav-link" href="#" id="logoutButton">Logout</a>
                                    </form>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="mypage">Mypage</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="cartList">CartList</a>
                                </li>
                            </sec:authorize>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
    </div>
</header>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $("#logoutButton").click(function(event) {
            event.preventDefault();
            $("#logoutForm").submit();
        });
    });
</script>


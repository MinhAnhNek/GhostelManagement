<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Authentication Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="login.css">
</head>
<body>
<div class="container min-vh-100 d-flex align-items-center justify-content-center">
    <div class="auth-container bg-white p-4 rounded-4 shadow-lg">
        <ul class="nav nav-pills mb-4" id="authTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link ${empty requestScope.toRegister and empty requestScope.toForgotPass ? "active" : ""}" data-bs-toggle="pill" data-bs-target="#login" type="button">Login</button>
            </li>
<%--            <li class="nav-item" role="presentation">--%>
<%--                <button class="nav-link ${not empty requestScope.toRegister ? "active" : ""}" data-bs-toggle="pill" data-bs-target="#register" type="button">Register</button>--%>
<%--            </li>--%>
            <li class="nav-item" role="presentation">
                <button class="nav-link ${not empty requestScope.toForgotPass ? "active" : ""}" data-bs-toggle="pill" data-bs-target="#forgot" type="button">Forgot Password</button>
            </li>
        </ul>
        <div class="tab-content" id="authTabContent">
            <div class="tab-pane fade ${empty requestScope.toRegister and empty requestScope.toForgotPass ? "show active" : ""}" id="login">
                <form action="login" method="post">
<%--                    <c:set var="invalidAcc" value="${requestScope.wrongAccount}"/>--%>
                    <div class="mb-3">
                        <div class="btn-group w-100 mb-3" role="group">
                            <input type="radio" class="btn-check" name="loginMethod" value="Username" id="emailLogin" checked>
                            <label class="btn btn-outline-primary" for="emailLogin">Email</label>
                            <input type="radio" class="btn-check" name="loginMethod" value="phoneNum" id="phoneLogin">
                            <label class="btn btn-outline-primary" for="phoneLogin">Phone</label>
                        </div>
                        <div id="emailInput" class="login-input">
                            <input name="Username" value="${requestScope.Username}" type="email" class="form-control" placeholder="Enter your email" >
                            <c:if test="${not empty requestScope.noLoginValue}">
                                <div class="alert alert-warning">Please enter a valid email</div>
                            </c:if>
                        </div>
                        <div id="phoneInput" class="login-input d-none">
                            <input name="phoneNum" value="${requestScope.phoneNum}" type="number" class="form-control" placeholder="Enter your phone number">
                            <c:if test="${not empty requestScope.noLoginValue}">
                                <div class="alert alert-warning">Please enter a valid phone Number</div>
                            </c:if>
                        </div>
                    </div>
                    <div class="mb-3 password-field">
                        <input type="password" name="password" value="${requestScope.password}" class="form-control" placeholder="Enter password" required>
                        <span class="password-toggle"><i class="bi bi-eye"></i></span>
                        <div class="invalid-feedback">Password is required</div>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">Remember me</label>
                    </div>

                    <div class="text-center mt-3">
                        <c:if test="${not empty requestScope.warningL}">
                            <div class="alert alert-warning" role="alert">${requestScope.warningL}</div>
                        </c:if>
                    </div>
                    <c:if test="${not empty requestScope.deactiveAcc}">
                        <div class="alert alert-danger" role="alert">${requestScope.deactiveAcc}</div>
                    </c:if>
                    <button type="submit" class="btn btn-primary w-100">Login</button>
<%--                    <div class="social-login mt-4">--%>
<%--                        <button class="btn btn-outline-dark w-100 mb-2"><i class="bi bi-google"></i> Continue with Google</button>--%>
<%--                        <button class="btn btn-outline-dark w-100"><i class="bi bi-facebook"></i> Continue with Facebook</button>--%>
<%--                    </div>--%>
                </form>
            </div>
<%--            <div class="tab-pane fade ${not empty requestScope.toRegister ? "show active" : ""}" id="register">--%>
<%--                <form class="needs-validation">--%>
<%--                    <div class="mb-3">--%>
<%--                        <input type="text" class="form-control" placeholder="Full Name" required>--%>
<%--                        <div class="invalid-feedback">Please enter your name</div>--%>
<%--                    </div>--%>
<%--                    <div class="mb-3">--%>
<%--                        <input type="email" class="form-control" placeholder="Email Address" required>--%>
<%--                        <div class="invalid-feedback">Please enter a valid email</div>--%>
<%--                    </div>--%>
<%--                    <div class="mb-3 password-field">--%>
<%--                        <input type="password" class="form-control" placeholder="Password" required>--%>
<%--                        <div class="invalid-feedback">Password is required</div>--%>
<%--                    </div>--%>
<%--                    <div class="mb-3 password-field">--%>
<%--                        <input type="password" class="form-control" placeholder="Confirm Password" required>--%>
<%--                        <div class="invalid-feedback">Passwords must match</div>--%>
<%--                    </div>--%>
<%--                    <div class="mb-3 form-check">--%>
<%--                        <input type="checkbox" class="form-check-input" required>--%>
<%--                        <label class="form-check-label">I agree to Terms & Conditions</label>--%>
<%--                        <div class="invalid-feedback">You must agree before submitting</div>--%>
<%--                    </div>--%>
<%--                    <button type="submit" class="btn btn-primary w-100">Register</button>--%>
<%--                </form>--%>
<%--            </div>--%>

            <div class="tab-pane fade ${not empty requestScope.toForgotPass ? "show active" : ""}" id="forgot">
                <form action="${pageContext.request.contextPath}/ForgotPassword" method="post" class="needs-validation">
                    <div class="mb-3">
<%--                        <label for="username" class="form-label">Username</label>--%>
                        <input name="username" value="${requestScope.usernameFG}" id="username" type="email" class="form-control" placeholder="Enter your email" required>
<%--                        <div class="invalid-feedback">Please enter a valid email</div>--%>
                    </div>
                    <div class="mb-3">
<%--                        <label for="phoneNum" class="form-label">Phone Number</label>--%>
                        <input name="phoneNum" type="tel" value="${requestScope.phoneNumFG}" id="phoneNum" class="form-control" placeholder="Enter your Phone Number" required>
<%--                        <div class="invalid-feedback">Please enter a valid phone number</div>--%>
                    </div>
                    <div class="mb-3">
<%--                        <label for="id" class="form-label">Your ID</label>--%>
                        <input name="id" id="id" type="number" value="${requestScope.idFG}" class="form-control" placeholder="Enter your ID" required>
                    </div>
                    <div class="mb-3">
<%--                        <label for="password" class="form-label">New Password</label>--%>
                        <input name="password" id="password" type="password" class="form-control" placeholder="Enter new password" required>
<%--                        <div class="invalid-feedback">Password is required</div>--%>
                    </div>
                    <div class="mb-3">
<%--                        <label for="confirm_pass" class="form-label">Confirm New Password</label>--%>
                        <input name="cfpass" type="password" id="confirm_pass" class="form-control" placeholder="Confirm password" required>
<%--                        <div class="invalid-feedback">Passwords must match</div>--%>
                    </div>
                    <c:if test="${not empty requestScope.warningFG}">
                        <div class="alert alert-warning" role="alert">${requestScope.warningFG}</div>
                    </c:if>
                    <c:if test="${not empty requestScope.confirmFG}">
                        <div class="alert alert-success">${requestScope.confirmFG}</div>
                    </c:if>
                    <div class="mb-3">
                        <button type="submit" class="btn btn-primary w-100">Reset Password</button>
                    </div>
                    <div class="text-center mt-3">
                        <a href="" class="return-link" data-bs-toggle="pill" data-bs-target="#login">Return to Login</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const emailLogin = document.getElementById('emailLogin');
        const phoneLogin = document.getElementById('phoneLogin');
        const emailInput = document.getElementById('emailInput');
        const phoneInput = document.getElementById('phoneInput');

        emailLogin.addEventListener('change', function() {
            emailInput.classList.remove('d-none');
            phoneInput.classList.add('d-none');
        });

        phoneLogin.addEventListener('change', function() {
            phoneInput.classList.remove('d-none');
            emailInput.classList.add('d-none');
        });
    });
</script>
</body>
</html>
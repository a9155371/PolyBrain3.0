<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>PolyBrain - 會員登入</title>
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

    <style>
    .error-message {
        background-color: #f8d7da; /* 警告背景顏色 */
        border-color: #f5c6cb; /* 警告邊框顏色 */
        color: #721c24; /* 警告文本顏色 */
        padding: 10px; /* 內邊距 */
        border-radius: 5px; /* 邊框圓角 */
        font-weight: bold; /* 文本加粗 */
        text-align: center; /* 文本居中對齊 */
    }
    </style>

</head>
<body>

    <%
        // 检查是否已登录，如果已登录则直接重定向到其他页面
        String account = (String) session.getAttribute("account");
        if (account != null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    %>

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">歡迎回來!</h1>
                                    </div>
                                    <form class="user" method="POST" action="<%= request.getContextPath() %>/loginServlet/do">

                                        <%-- 檢查是否有錯誤訊息 --%>
                                        <% String errorMessage = request.getParameter("error"); %>
                                        <% String message = request.getParameter("message"); %>

                                        <%-- 如果有錯誤，顯示錯誤訊息 --%>
                                        <% if (errorMessage != null && errorMessage.equals("true")) { %>
                                            <div class="error-message">
                                                <strong>錯誤：</strong> 信箱或密碼輸入錯誤
                                            </div>
                                        <% } %>
                                        <br>

                                        <div class="form-group">
                                            <input type="email" class="form-control form-control-user"
                                                id="exampleInputEmail" aria-describedby="emailHelp"
                                                placeholder="輸入信箱" name="email">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                id="exampleInputPassword" placeholder="密碼" name="password">
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="customCheck">
                                                <label class="custom-control-label" for="customCheck">記住我</label>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-user btn-block">
                                            登入
                                        </button>
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="forgot-password.jsp">忘記密碼?</a>
                                    </div>
                                    <div class="text-center">
                                        <a class="small" href="register.jsp">會員註冊</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
</body>
</html>
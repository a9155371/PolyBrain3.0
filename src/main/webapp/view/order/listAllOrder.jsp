<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page import="java.util.*" %>
            <%@ page import="feature.order.dao.*" %>
                <%@ page import="feature.order.vo.*" %>
                    <%@ page import="feature.order.service.*" %>

                        <% OrderService ordSvc=new OrderService(); List<ItemOrderVO> list = ordSvc.getAll();
                            pageContext.setAttribute("orderVOlist",list);
                            %>


                            <!-- <%@ page isELIgnored="false"%> -->

                            <%-- 此頁練習採用 EL 的寫法取值 --%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>所有員工資料 - listAllOrder.jsp</title>
    <link href="http://localhost:8080/PolyBrain/view/member/css/styles.css" rel="stylesheet" />
    <script src="https://kit.fontawesome.com/cb31023646.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
    <style>
        .center-container {
            width: 80%;
            /* 這只是一個例子，你可以根據需要調整寬度 */
            margin: auto;
            padding-top: 50px;
            /* 或使用 margin-top: 50px; 根據你的需求 */
        }






        table#table-1 {
            background-color: #CCCCFF;
            border: 2px solid black;
            text-align: center;
        }

        table#table-1 h4 {
            color: red;
            display: block;
            margin-bottom: 1px;
        }

        h4 {
            color: blue;
            display: inline;
        }
    </style>

    <style>
        table {
            width: 800px;
            background-color: white;
            margin-top: 5px;
            margin-bottom: 5px;
        }

        table,
        th,
        td {
            border: 1px solid #CCCCFF;
        }

        th,
        td {
            padding: 5px;
            text-align: center;
        }
    </style>

</head>

<body id="page-top" style="background-color:rgb(252, 252, 252) ; ">

    <main class="flex-shrink-0">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: black;">
            <div class="container px-5">
                <img src="${pageContext.request.contextPath}/view/logo/PolyBrain_Logo.png"
                    style="width: 110px; height: auto; margin-bottom: 5px;"></a>
            </div>
        </nav>
    </main>
    <!---------------------------------------------以上為頂板--------------------------------------------------------->



    <div id="layoutSidenav"> <!--勿刪到-->
        <!---------------------------------------------以下為側邊攔--------------------------------------------------------->
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">

                        <!-------------會員中心-------------->
                        <br>
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#mem"
                            aria-expanded="false" aria-controls="collapseLayouts">
                            <div class="sb-nav-link-icon"><i class="fas fa-columns"></i>
                            </div>
                            會員
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="mem" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="http://localhost:8080/PolyBrain/view/member/listAllmem.jsp">
                                    <div class="sb-nav-link-icon"></div>所有會員管理
                                </a>
                                <a class="nav-link" href="http://localhost:8080/PolyBrain/view/forum/Listallarti.jsp">
                                    <div class="sb-nav-link-icon"></div>討論區文章管理
                                </a>
                            </nav>
                        </div>
                        <!-------------會員中心-------------->
                        <!--------------商城---------------->
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#item"
                            aria-expanded="false" aria-controls="collapseLayouts">
                            <div class="sb-nav-link-icon"><i class="fas fa-columns"></i>
                            </div>
                            商城
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="item" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="http://localhost:8080/PolyBrain/view/item/itemConsole.html">
                                    <div class="sb-nav-link-icon"></div>商城管理
                                </a>
                                <a class="nav-link"
                                    href="http://localhost:8080/PolyBrain/view/item/itemClassConsole.html">
                                    <div class="sb-nav-link-icon"></div>商品類別管理
                                </a>
                                <a class="nav-link" href="http://localhost:8080/PolyBrain/view/order/listAllOrder.jsp">
                                    <div class="sb-nav-link-icon"></div>訂單管理
                                </a>
                            </nav>
                        </div>
                        <!-------------商城-------------->
                        <!-------------預約-------------->
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#booking"
                            aria-expanded="false" aria-controls="collapseLayouts">
                            <div class="sb-nav-link-icon"><i class="fas fa-columns"></i>
                            </div>
                            預約
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="booking" aria-labelledby="headingOne"
                            data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="http://localhost:8080/PolyBrain/view/book/BookTable.html">
                                    <div class="sb-nav-link-icon"></div>報到管理
                                </a>
                                <a class="nav-link"
                                    href="http://localhost:8080/PolyBrain/view/bookingtast/Modifytimeperiod.jsp">
                                    <div class="sb-nav-link-icon"></div>時段管理
                                </a>
                            </nav>
                        </div>
                        <!-------------預約-------------->
                        <!-------------競標-------------->
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#bid"
                            aria-expanded="false" aria-controls="collapseLayouts">
                            <div class="sb-nav-link-icon"><i class="fas fa-columns"></i>
                            </div>
                            競標
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="bid" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="http://localhost:8080/PolyBrain/view/bid/BidEventList.jsp">
                                    <div class="sb-nav-link-icon"></div>競標活動管理
                                </a>
                                <a class="nav-link" href="http://localhost:8080/PolyBrain/view/bid/BidItemTable.html">
                                    <div class="sb-nav-link-icon"></div>競標商品管理
                                </a>
                                <a class="nav-link"
                                    href="http://localhost:8080/PolyBrain/view/order/bidOrderBackend.html">
                                    <div class="sb-nav-link-icon"></div>競標訂單
                                </a>
                            </nav>
                        </div>
                        <!-------------競標-------------->
                        <a class="nav-link" href="http://localhost:8080/PolyBrain/view/emp/allEmpList.jsp">
                            <div class="sb-nav-link-icon"></div>
                            所有員工管理
                        </a>
                        <hr>
                        <a class="nav-link" href="http://localhost:8080/PolyBrain/view/member/back_logout.jsp">
                            <div class="sb-nav-link-icon"></div>
                            後台登出
                        </a>
                    </div>
                </div>
            </nav>
        </div>
        <!---------------------------------------------以上為側邊攔--------------------------------------------------------->



        <div id="layoutSidenav_content"> <!--勿刪到-->
            <!-----------------------------以下為內容---------------------------->
            <main>
                <div class="center-container">
                    <nav>
                        <table>
                            <tr>
                                <th>訂單編號</th>
                                <th>交易日期</th>
                                <th>取件人姓名</th>
                                <th>取件地址</th>
                                <th>取件人電話</th>
                                <th>寄送方式</th>
                                <th>購買總金額</th>
                                <th>操作</th>
                            </tr>
                            <%@ include file="page1.file" %>
                                <c:forEach var="itemordervo" items="${orderVOlist}" begin="<%=pageIndex%>"
                                    end="<%=pageIndex+rowsPerPage-1%>">
                                    <tr>

                                        <td>${itemordervo.orderNo}</td>
                                        <td>${itemordervo.tranTime}</td>
                                        </td>
                                        <td>${itemordervo.receiverName}</td>
                                        <td>${itemordervo.receiverAddress}</td>
                                        <td>${itemordervo.receiverPhone}</td>
                                        <td class="receiverMethod">${itemordervo.receiverMethod}
                                        <td>${itemordervo.orderTotal}</td>
                                        <td>
                                            <form method="post"
                                                action="<%=request.getContextPath()%>/view/order/order.tw"
                                                style="margin-bottom: 0px;">
                                                <input type="submit" value="修改">
                                                <input type="hidden" name="orderNo" value="${itemordervo.orderNo}">
                                                <input type="hidden" name="test1" value="getOne_For_Update">
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                        </table>
                        <%@ include file="page2.file" %>
                </div>
            </main>
            <!-----------------------------以上為內容---------------------------->
        </div>
    </div>
    <script>
        var receiverMethodElements = document.querySelectorAll('.receiverMethod');
        receiverMethodElements.forEach(function (element) {
            var receiverMethod = element.textContent.trim(); // 获取并去除首尾空格
            if (receiverMethod === '0') {
                element.textContent = '郵寄';
            } else {
                element.textContent = '宅配';
            }
        });
    </script>
</body>

</html>
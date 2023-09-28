<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page import="java.util.*" %>
            <%@ page import="feature.cart.dao.*" %>
                <%@ page import="feature.cart.vo.*" %>
                    <%@ page import="feature.item.vo.*" %>
                        <%@ page import="feature.cart.service.*" %>
                            <%@ page import="feature.item.dao.impl.*" %>

                                <!-- <%@ page isELIgnored="false"%> -->

                                <%-- 此頁練習採用 EL 的寫法取值 --%>
<!DOCTYPE html>
<html lang="zh-Hant">
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <title>PolyBrain購物車</title>


    <style>
        /* 會員名稱調整 */
        #memName {
            line-height: 2.3;
            /* 调整为所需的值 */
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);
            color: white;
            margin-left: 12px;
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

        img {
            max-height: 100px;
            width: auto;
            margin: 0;
        }

        .row {
            --bs-gutter-x: 0;
            --bs-gutter-y: 0;
        }

        body {
            height: 100%;
            overflow-y: auto;
            /* 啟用垂直滾動條 */
        }

        #submitBtn,
        #returnToShop {
            margin-bottom: 20px;
            /* 距離底部的距離 */
            right: 20px;
            /* 距離右側的距離 */
        }

        #cartTotal {
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
        }

        .btn-secondary.canceled {
            background-color: #ccc;
            color: #fff;
            border: none;
            margin-right: 10px;
        }

        .btn-secondary.canceled:hover {
            background-color: #aaa;
        }

        .btn-primary.btn-lg {
            font-size: 18px;
            padding: 10px 20px;
            border-radius: 5px;
        }

        /* 美化購物車項目行 */
        .rowMother {
            background-color: #f5f5f5;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 10px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
        }

        .rowMother:hover {
            background-color: #e0e0e0;
        }

        /* 美化數量輸入框 */
        .quantity {
            width: 60px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
            text-align: center;
        }

        /* 美化刪除按鈕 */
        .deleteBtn {
            background-color: #ff5252;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
            cursor: pointer;
        }

        .deleteBtn:hover {
            background-color: #ff3333;
        }

        /* 按鈕統一外邊距 */
        #returnToShop,
        #submitBtn {
            margin-right: 10px;
        }

        /* 合併行和小計 */
        .product-wrapper {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .product-wrapper img {
            max-height: 100px;
            width: auto;
            margin-right: 10px;
        }

        /* 調整返回商城按鈕的外觀 */
        #canceled {
            margin-right: 10px;
        }

        a {
            text-decoration: none;
            /* 刪除下劃線 */
            color: #007bff;
            /* 設置文字顏色，這裡是藍色 */
        }

        .remaining-quantity {
            font-size: 12px;
            /* 设置所需的字体大小 */
        }

        .input-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
    </style>

</head>

<body class="d-flex flex-column h-100">
    <main class="flex-shrink-0">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container px-5">
                <a class="navbar-brand" href="http://localhost:8080/PolyBrain/view/bid/BidOnHomePage.html">
                    <img src="http://localhost:8080/PolyBrain/view/logo/PolyBrain_Logo.png"
                        style="width: 110px; height: auto; margin-bottom: 5px;"></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation"><span
                        class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <!-- <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0 nav-list"> 添加 nav-list 類別 -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="buyitem" href="#" role="button"
                                data-bs-toggle="dropdown" aria-expanded="false">商城</a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                                <li><a class="dropdown-item" href="../item/search.html">商品資訊</a></li>
                                <li><a class="dropdown-item" href="../order/memberOrder.html">商城訂單查詢</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="buybid" href="#" role="button"
                                data-bs-toggle="dropdown" aria-expanded="false">競標</a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                                <li><a class="dropdown-item" href="../bid/BidOnHomePage.html">熱門競標</a></li>
                                <li><a class="dropdown-item" href="../order/bidOrderFront.html">競標訂單查詢</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="mybooking" href="#" role="button"
                                data-bs-toggle="dropdown" aria-expanded="false">預約場地</a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                                <li><a class="dropdown-item" href="../book/Calendar.html">現在預約</a></li>
                                <li><a class="dropdown-item" href="../book/BookingCheck.html">預約場地查詢</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="discuss" href="../forum/mainpage/BidOnHomePage.jsp"
                                role="button">討論區</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="memberdistrict" href="../member/Member_Information.jsp"
                                role="button">會員中心</a>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="../head/question.html">常見問題</a></li>
                        <li>
                            <a href="http://localhost:8080/PolyBrain/view/CartTrace/Cart.jsp" id="submitLink"
                                class="btn btn-outline-dark" style="color: #ffffff">
                                <i class="bi-cart-fill me-1" style="color: #ffffff"></i>
                                購物車
                            </a>
                        </li>
                        <span id="memName" style="margin-left:12px;"></span>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button"
                                data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                            <ul id="dropdown-menu" class="dropdown-menu dropdown-menu-end"
                                aria-labelledby="navbarDropdown">
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="row">


                <div>
                    <h3 style="margin-top: 20px;">購物車詳情</h3>
                </div>

                <table>
                    <tr>
                        <th>圖片</th>
                        <th>遊戲名稱</th>
                        <th>價格</th>
                        <th>數量</th>
                        <th>小計</th>

                    </tr>
                    <c:forEach var="cartItemImgDTO" items="${cartItemImgDTOList}">
                        <tr class="rowMother">
                            <td><img src="${cartItemImgDTO.itemImg}" style"height: 100px"><a
                                    href="http://localhost:8080/PolyBrain/view/item/itemDetail.html?itemNo=${cartItemImgDTO.itemNo}">
                            </td>
                            <td><a
                                    href="http://localhost:8080/PolyBrain/view/item/itemDetail.html?itemNo=${cartItemImgDTO.itemNo}">${cartItemImgDTO.itemName}</a>
                            </td>
                            <input type="hidden" class="cartPrice" value="${cartItemImgDTO.itemPrice}">
                            <td>${cartItemImgDTO.itemPrice}</td>

                            <td>
                                <div class="form-outline">
                                    <div class="input-container">
                                        <input type="number" name="quantity" value="${cartItemImgDTO.quantity}"
                                            id="cartQuantity" min=" 0 " max="${cartItemImgDTO.itemQty}"
                                            class="quantity form-control" onblur="submitUpdateForm()">
                                    </div>

                                    <input type="hidden" name="itemNo" value="${cartItemImgDTO.itemNo}" class="itemNo">
                                    <input type="hidden" name="itemQty" id="itemQty" class="itemQty"
                                        value="${cartItemImgDTO.itemQty}">
                                    <span class="remaining-quantity">剩餘數量${cartItemImgDTO.itemQty}個</span>
                                </div>
                            </td>

                            <td class="rowTotal" data-value=""></td>
                            <td>
                                <button id="deleteBtn" class="btn btn-primary deleteBtn" value="1">刪除</button>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
                <div id="cartTotal"></div>
                <!-- <form method="post" action="<%=request.getContextPath()%>/view/CartTrace/ConfirmOrder"> -->
                <div class="row justify-content-end">
                    <div class="col-md-6 text-end">
                        <a href="http://localhost:8080/PolyBrain/view/item/search.html"
                            class="btn btn-secondary btn-lg canceled" id="returnToShop">返回商城</a>
                        <button id="submitBtn" type="submit" class="btn btn-primary btn-lg">
                            前往結帳
                        </button>
                    </div>
                </div>
            </div>
            <!-- </form> -->


        </div>

        <script>

            var currentQuantityValue;
            var currentItemNoValue;
            var currentItemQtyValue;
            var deleteBtnValue = 1;
            var cartQuantityElements;

            window.addEventListener('load', function () {

                cartQuantityElements = document.querySelectorAll('.quantity');
                var cartPriceElements = document.querySelectorAll('.cartPrice');
                var rowTotal = document.querySelectorAll('.rowTotal');
                var itemNoElements = document.querySelectorAll('.itemNo');
                var itemQtyElements = document.querySelectorAll('.itemQty');
                var deleteBtnElements = document.querySelectorAll('.deleteBtn');
                var rowMotherElements = document.querySelectorAll('.rowMother');
                var resultDiv = document.getElementById('cartTotal');


                let total = 0;
                let rowTotalVariable = 0;
                var quantity = 0;
                var price = 0;
                // 創建一個物件來存儲每個 input 的先前值
                let previousValues = {};

                if (cartQuantityElements.length == 0) {
                    showEmptyCartAlert();
                }

                function resetTotal() {
                    total = 0;
                    for (var i = 0; i < cartQuantityElements.length; i++) {


                        price = parseInt(cartPriceElements[i].value);
                        var quantity = parseInt(cartQuantityElements[i].value);
                        total += price * quantity;
                        // console.log(total);

                        rowTotalVariable = price * quantity
                        rowTotal[i].textContent = rowTotalVariable;
                        rowTotal[i].setAttribute('data-value', rowTotalVariable);
                    }
                    resultDiv.textContent = '合計：' + total;
                }



                resetTotal();


                for (var i = 0; i < cartQuantityElements.length; i++) {
                    (function (index) {
                        var input = cartQuantityElements[index];
                        var itemNoinput = itemNoElements[index];
                        var itemQtyinput = itemQtyElements[index];
                        var deleteBtn = deleteBtnElements[index];
                        var rowMother = rowMotherElements[index];


                        document.querySelector('#submitBtn').addEventListener('click', function () {
                            console.log("345");
                            console.log('cartQuantityElements.length' + cartQuantityElements.length);
                            if (cartQuantityElements.length != 0) { //情境是: 進來頁面直接按結帳，這是在判斷購物車有沒有商品
                                currentItemNoValue = itemNoinput.value;
                                currentQuantityValue = input.value;
                                submitFormToConfirmOrder();
                            }

                        });

                        deleteBtn.addEventListener('click', function () {
                            Swal.fire({
                                icon: 'question',
                                title: '確認刪除嗎?',
                                showCancelButton: true,
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    deletefunction();
                                }
                            });
                        });

                        function deletefunction() {
                            currentQuantityValue = input.value;
                            currentItemNoValue = itemNoinput.value;
                            deleteBtnValue = 0;

                            console.log('deleteBtnValue' + deleteBtnValue);
                            rowMother.parentElement.removeChild(rowMother);

                            submitUpdateForm();

                        }

                        input.addEventListener('input', function () {

                            // 獲取 input 的當前值
                            currentQuantityValue = input.value; //有抓到當前的quantity
                            console.log('當前的數量' + currentQuantityValue);

                            // 獲取 input 的先前值（如果有的話）
                            var previousValue = previousValues[input.id];
                            // 獲取 itemNOinput 的當前值
                            currentItemNoValue = itemNoinput.value;//有抓到當前的itemNo
                            console.log('當前的商品編號' + currentItemNoValue);

                            // 獲取 itemQtyinput 的當前值
                            currentItemQtyValue = itemQtyinput.value; //有抓到當前的itemQtyinput
                            console.log('hello' + currentItemQtyValue);


                            // 檢查值是否有更動
                            if (currentQuantityValue !== previousValue) {
                                if (parseInt(currentQuantityValue) < 0 || isNaN(currentQuantityValue) || !currentQuantityValue) {
                                    // 顯示警告訊息

                                    Swal.fire({
                                        icon: 'error',
                                        title: '請重新輸入數字!',
                                    });
                                    // 將值設為1
                                    currentQuantityValue = '1';
                                    input.value = currentQuantityValue;
                                }
                                if (parseInt(currentQuantityValue) > currentItemQtyValue) {
                                    // 顯示警告訊息

                                    Swal.fire({
                                        icon: 'error',
                                        title: '抱歉，本商品最多可購買' + currentItemQtyValue + '件!',
                                    });
                                    // 將值設為1
                                    currentQuantityValue = '1';
                                    input.value = currentQuantityValue;

                                }
                                cartQuantityElements[index].value = currentQuantityValue;

                                // 值已更動，執行你想要的操作
                                console.log('值已更動：', input.id, currentQuantityValue);
                                if (parseInt(currentQuantityValue) === 0) {
                                    deletefunction();

                                }

                                // 更新先前值
                                previousValues[input.id] = currentQuantityValue;
                                resetTotal();
                            }

                        });
                    })(i);


                }


            })
            function showEmptyCartAlert() {
                Swal.fire({
                    icon: 'error',
                    title: '你尚未購買東西喔!',
                    confirmButtonText: '確定', // 修改確認按鈕的文字
                }).then((result) => {
                    if (result.isConfirmed) {

                        window.location.href = 'http://localhost:8080/PolyBrain/view/item/search.html';
                    }
                });
            }


            function submitUpdateForm() {
                return new Promise((resolve, reject) => {
                    fetch('/PolyBrain/loginRequired/CartServlet', {
                        method: 'POST',
                        headers: {
                            'content-type': 'application/x-www-form-urlencoded'
                        },
                        body: new URLSearchParams({
                            action: 'UpdateItemQuantity',
                            quantity: parseInt(currentQuantityValue),
                            itemNo: parseInt(currentItemNoValue),
                            deleteARow: parseInt(deleteBtnValue)
                        })
                    })
                        .then(resp => resp.json())
                        .then(data => {
                            console.log(data.message);
                            resolve();
                            location.reload();

                        })
                        .catch(error => {
                            reject(error);
                        });
                });
            }

            function submitFormToConfirmOrder() {
                console.log("in2");

                submitUpdateForm()
                    .then(() => {
                        fetch('/PolyBrain/loginRequired/ConfirmOrder', {
                            method: 'POST',
                            headers: {
                                'content-type': 'application/x-www-form-urlencoded' //
                            },
                            body: new URLSearchParams({
                                action: 'getAll',
                                // quantity: currentQuantityValue,
                                // itemNo: currentItemNoValue
                            })
                        })
                            .then(() => {
                                window.location.href = "http://localhost:8080/PolyBrain/view/CartTrace/CartTrace.jsp";
                            })

                    })
                console.log('currentQuantityValue' + currentQuantityValue)
                console.log('currentItemNoValue' + currentItemNoValue)
                console.log('currentItemQtyValue' + currentItemQtyValue)
                console.log('deleteBtnValue' + deleteBtnValue)
            }







        </script>
        <!-- <script>
        $(document).ready(function(){
            validateMemStatus();
        });
    async function validateMemStatus() {
    const response = await fetch('/PolyBrain/general/validateMemStatus', {
    method: 'POST',
    headers: { 'content-type': 'application/json; charset:utf-8' },
    })
    .then(resp => resp.json())
    .then(data => {
    console.log(data);
    const { memNo, memName, loginStatus } = data;
    $('ul#dropdown-menu').append(`
    <li><a class="dropdown-item" href="#!">會員專區</a></li>
    <li><a class="dropdown-item" href="#!">購物車</a></li>
    <li><hr class="dropdown-divider" /></li>
    `);
    if (loginStatus) {
    $('span#memName').text(memName);
    $('ul#dropdown-menu').append('<li><a id="logOut" class="dropdown-item" href="http://localhost:8080/PolyBrain/view/member/logout.jsp">登出</a></li>');
    let memDetail = [memNo, memName];
    return memDetail;
    } else {
    $('ul#dropdown-menu').append('<li><a id="logOut" class="dropdown-item" href="http://localhost:8080/PolyBrain/view/member/login.html">登入</a></li>');
    }
    });
    return response;
    }

          let bidEventList = document.querySelectorAll('.bidEventList');
        bidEventList.forEach(link => {
            link.addEventListener('click', function (event) {
                event.preventDefault();
                const biddingEvent = link.getAttribute('data-event-id');
                const bidEventURL = 'http://localhost:8080/PolyBrain/view/bid/BidOnItemPage2.jsp';
                const url = `${bidEventURL}?bidEventId=${biddingEvent}`;
                window.location.href = url;
            });
        });
    </script> -->


</body>
<!-- Footer-->
<footer class="bg-dark py-4 mt-auto ">
    <div class="container px-5">
        <div class="row align-items-center justify-content-between flex-column flex-sm-row">
            <div class="col-auto">
                <div class="small m-0 text-white">Copyright © 2023 PolyBrain. All rights reserved. </div>
            </div>
            <div class="col-auto">
                <a class="link-light small" href="Privacy.html">隱私權協定</a>
                <span class="text-white mx-1">&middot;</span>
                <a class="link-light small" href="Forus.html">關於我們</a>
                <span class="text-white mx-1">&middot;</span>
                <a href="mailto:ps66391@gmail.com?subject=聯絡我們的請求&body=請在此寫下您的問題。" title="用 Email 轉寄"
                    onclick="return confirm('您確定要前往email寄信?');">
                    <img src="http://localhost:8080/PolyBrain/view/item/img/%E4%BF%A1%E5%B0%81.jpg">
                </a>
            </div>
        </div>
    </div>
</footer>

</html>
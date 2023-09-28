<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="feature.cart.dao.*"%>
<%@ page import="feature.cart.vo.*"%>
<%@ page import="feature.item.vo.*"%>
<%@ page import="feature.cart.service.*"%>
<%@ page import="feature.cart.vo.*"%>

<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PolyBrain確認訂單</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="crossorigin="anonymous" referrerpolicy="no-referrer" />







    <style>
        .logoImg {
            max-width: 200px;
            height: auto;
            margin: 0;
        }


          /* 會員名稱調整 */
              #memName {
                line-height: 2.35;  /* 调整为所需的值 */
                text-shadow: 2px 2px 2px rgba(0,0,0,0.3);
                color: white;
                margin-left: 12px;
              }
        #btnnnnn{
            margin-top: 100px;
        }      
              
    </style>
</head>

<body>
<body>

    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container px-5">
                <a class="navbar-brand" href="../bid/BidOnHomePage.html">
                    <img src="../logo/PolyBrain_Logo.png" style="width: 110px; height: auto; margin-bottom: 5px;"></a>
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
                            <a class="nav-link" id="discuss" href="../forum/mainpage/index.jsp" role="button">討論區</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="memberdistrict" href="../member/Member_Information.jsp"
                                role="button">會員中心</a>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="../head/question.html">常見問題</a></li>
                        <li>
                            <a href="../CartTrace/Cart.jsp" id="submitLink"
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
                <div class="col-md-4 order-md-2 mb-4 mt-5">
                    <h4 class="d-flex justify-content-between align-items-center mb-3">
                        <span class="text-muted">購物車清單</span>
                    </h4>
                    <ul class="list-group mb-3">
                        <c:forEach var="cartItemImgDTO" items="${cartItemImgDTOList}">
                            <li class="list-group-item d-flex justify-content-between lh-condensed">
                                <div>
                                    <h6 class="my-0">${cartItemImgDTO.itemName}</h6>
                                    <small id="cartQuantity" class="text-muted">${cartItemImgDTO.quantity}</small>
                                </div>
                                <span class="cartPrice" id="cartPrice"
                                    value="${cartItemImgDTO.itemPrice * cartItemImgDTO.quantity}">
                                    $ ${cartItemImgDTO.itemPrice * cartItemImgDTO.quantity}
                                </span>
                            </li>
                        </c:forEach>
                        <li class="list-group-item " style="display: none;" id="transFormPrice">
                        </li>
                        <li class="list-group-item d-flex justify-content-between lh-condensed text-end" id="orderTotal" id="orderTotal" value="">
                        </li>


                    </ul>


                </div>

                <div class="col-md-8 order-md-1 mt-5">
                    
                    <form method="post" action="/PolyBrain/loginRequired/ConfirmOrder" id="confirmOrder">
                        <input type="hidden" id="orderTotal1" name="orderTotal" value="">
                        <div class="container">
                            <h4 class="mb-3">填寫付款資訊</h4>

                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <label for="receiverName">收件人姓名：</label>
                                    <input type="text" id="receiverName" name="receiverName" class="form-control">
                                    <p style="display: block; color: red; padding: 0px 3px;">
                                        ${errorMsgs["receiverName"]}
                                    </p>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label for="receiverPhone">收件人電話：</label>
                                    <input type="text" id="receiverPhone" name="receiverPhone" class="form-control">
                                    <p style="display: block; color: red; padding: 0px 3px">
                                        ${errorMsgs["receiverPhone"]}
                                    </p>
                                </div>
                            </div>

                            <div class=" row twzipcode">
                                <div class="col-md-6 mb-3" data-role="county" data-style="d-block w-100" id="county">
                                    <label for="county">縣市</label>
                                    <div class="invalid-feedback"> Please select a valid country. </div>
                                </div>

                                <div class="col-md-6 mb-3" data-role="district" data-style="d-block w-100" id="state">
                                    <label for="state">地區</label>
                                    <div class="invalid-feedback"> Please provide a valid state. </div>
                                </div>
                                <div>
                                    <label for="receiverAddress">收件人地址：</label>
                                    <input type="text" id="receiverAddress" name="receiverAddress" class="form-control">
                                    <p style="display: block; color: red; padding: 0px 3px">
                                        ${errorMsgs["receiverAddress"]}
                                    </p>
                                </div>
                            </div>



                            <div class="form-row">
                                <label for="receiverMethod">寄送方式：</label>
                            <select id="receiverMethod" class="form-select form-select-sm"  name="receiverMethod" required aria-label="Small select example">
                                <option value="default" selected>請選擇寄送方式...</option>
                                <option value="mail">郵寄</option>
                                <option value="storePickup">超商取貨</option>
                            </select>
                            </div>
                            <div class="row justify-content-end" id="btnnnnn">
                                <div class="col-md-6 text-end">
                                <a href="http://localhost:8080/PolyBrain/view/item/search.html" class="btn btn-secondary btn-lg canceled">返回商城</a>
                                <input type="hidden" name="action" value="orderConfirm" id="actionInput">
                                <button id="submitBtn" type="submit" class="btn btn-primary btn-lg" id="orderConfirmBtn" onsubmit="return validateForm()"">
                                        結帳
                                </button>
                                </div>
                            </div>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>


        $('.twzipcode').twzipcode({
            zipcodeIntoDistrict: true,
            'css': ['county', 'district'],
            // countyName: 'city_name',
            // districtName: 'district_name',
        });
        var selectElement = document.querySelector('select[name="county"]');
        selectElement.classList.add('form-select');
        var selectElementDistrict = document.querySelector('select[name="district"]');
        selectElementDistrict.classList.add('form-select');


        var transFormPriceElement = document.querySelector('#transFormPrice');
        var cartPriceElements = document.querySelectorAll('.cartPrice');
        var orderTotal = document.querySelector('#orderTotal')
        var orderTotal1 = document.querySelector('#orderTotal1')
        var orderConfirmBtn = document.querySelector('#orderConfirmBtn');
        var total = 0;

        for (var i = 0; i < cartPriceElements.length; i++) {
            total += parseInt(cartPriceElements[i].textContent.match(/\d+/));
        }
        orderTotal.textContent = "總計: " + total;
        orderTotal1.value = total ;

        var receiverMethodElement = document.querySelector('#receiverMethod');
        receiverMethodElement.addEventListener('change', function () {
            var selectedOption = receiverMethodElement.options[receiverMethodElement.selectedIndex];

            if (selectedOption.value === 'default') {
                selectedOption.disabled = true;
            } else {
                transFormPriceElement.style.display = 'block';
                transFormPriceElement.textContent = selectedOption.textContent;

            }
        })



        document.addEventListener('DOMContentLoaded', function () {
            var form = document.querySelector('form'); // 获取表单元素
            form.addEventListener('submit', function (event) {
                var countySelect = document.querySelector('select[name="county"]');
                var districtSelect = document.querySelector('select[name="district"]');
                var errorMsgElement = document.querySelector('#errorMsg');

                // 检查是否等于插件的默认值
                if (countySelect.value === '' || districtSelect.value === '0') {
                    event.preventDefault(); // 阻止表单提交
                    errorMsgElement.textContent = '請選擇縣市和地區。'; // 显示错误消息
                } else {
                    errorMsgElement.textContent = ''; // 清除错误消息
                }
            });
        });





    //     $(document).ready(function(){
    //         validateMemStatus();
    //     });
    // async function validateMemStatus() {
    // const response = await fetch('/PolyBrain/general/validateMemStatus', {
    // method: 'POST',
    // headers: { 'content-type': 'application/json; charset:utf-8' },
    // })
    // .then(resp => resp.json())
    // .then(data => {
    // console.log(data);
    // const { memNo, memName, loginStatus } = data;
    // $('ul#dropdown-menu').append(`
    // <li><a class="dropdown-item" href="#!">會員專區</a></li>
    // <li><a class="dropdown-item" href="#!">購物車</a></li>
    // <li><hr class="dropdown-divider" /></li>
    // `);
    // if (loginStatus) {
    // $('span#memName').text(memName);
    // $('ul#dropdown-menu').append('<li><a id="logOut" class="dropdown-item" href="http://localhost:8080/PolyBrain/view/member/logout.jsp">登出</a></li>');
    // let memDetail = [memNo, memName];
    // return memDetail;
    // } else {
    // $('ul#dropdown-menu').append('<li><a id="logOut" class="dropdown-item" href="http://localhost:8080/PolyBrain/view/member/login.html">登入</a></li>');
    // }
    // });
    // return response;
    // }

    //       let bidEventList = document.querySelectorAll('.bidEventList');
    //     bidEventList.forEach(link => {
    //         link.addEventListener('click', function (event) {
    //             event.preventDefault();
    //             const biddingEvent = link.getAttribute('data-event-id');
    //             const bidEventURL = 'http://localhost:8080/PolyBrain/view/bid/BidOnItemPage2.jsp';
    //             const url = `${bidEventURL}?bidEventId=${biddingEvent}`;
    //             window.location.href = url;
    //         });
    //     });

    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>

</html>
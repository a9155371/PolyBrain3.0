<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="feature.bid.vo.*" %>
<%@ page import="feature.bid.service.*" %>
<%@ page import="feature.bid.dao.*" %>

<%
BiddingService biddingService = new BiddingServiceImpl();
List<BidEventVo> list = biddingService.viewAllEvent();
pageContext.setAttribute("list", list);
%>




<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Tables - SB Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>

<body class="sb-nav-fixed">
    <main class="flex-shrink-0">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: black;">
            <div class="container px-5" style="margin-left: -10px;">
                <img src="../logo/PolyBrain_Logo.png" style="width: 110px; height: auto; margin-bottom: 5px;"></a>
            </div>
        </nav>
    </main>
    <div id="layoutSidenav">
        <!---------------------------------------------以下為側邊攔--------------------------------------------------------->
    <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
            <div class="sb-sidenav-menu">
                <div class="nav">

                    <!-------------會員中心-------------->
                    <br>
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                       data-bs-target="#mem" aria-expanded="false" aria-controls="collapseLayouts">
                        <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                        會員
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="mem" aria-labelledby="headingOne"data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="http://localhost:8080/PolyBrain/view/member/listAllmem.jsp"><div class="sb-nav-link-icon"></div>所有會員管理</a>
                            <a class="nav-link" href="http://localhost:8080/PolyBrain/view/forum/Listallarti.jsp"><div class="sb-nav-link-icon"></div>討論區文章管理</a>
                        </nav>
                    </div>
                    <!-------------會員中心-------------->
                    <!--------------商城---------------->
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                       data-bs-target="#item" aria-expanded="false" aria-controls="collapseLayouts">
                        <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                        商城
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="item" aria-labelledby="headingOne"data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="http://localhost:8080/PolyBrain/view/item/itemConsole.html"><div class="sb-nav-link-icon"></div>商城管理</a>
                            <a class="nav-link" href="http://localhost:8080/PolyBrain/view/item/itemClassConsole.html"><div class="sb-nav-link-icon"></div>商品類別管理</a>
                            <a class="nav-link" href="http://localhost:8080/PolyBrain/view/order/listAllOrder.jsp"><div class="sb-nav-link-icon"></div>訂單管理</a>
                        </nav>
                    </div>
                    <!-------------商城-------------->
                    <!-------------預約-------------->
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                       data-bs-target="#booking" aria-expanded="false" aria-controls="collapseLayouts">
                        <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                        預約
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="booking" aria-labelledby="headingOne"data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="http://localhost:8080/PolyBrain/view/book/BookTable.html"><div class="sb-nav-link-icon"></div>報到管理</a>
                            <a class="nav-link" href="http://localhost:8080/PolyBrain/view/bookingtast/Modifytimeperiod.jsp"><div class="sb-nav-link-icon"></div>時段管理</a>
                        </nav>
                    </div>
                    <!-------------預約-------------->
                    <!-------------競標-------------->
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                       data-bs-target="#bid" aria-expanded="false" aria-controls="collapseLayouts">
                        <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                        競標
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="bid" aria-labelledby="headingOne"data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="http://localhost:8080/PolyBrain/view/bid/BidEventList.jsp"><div class="sb-nav-link-icon"></div>競標活動管理</a>
                            <a class="nav-link" href="http://localhost:8080/PolyBrain/view/bid/BidItemTable.html"><div class="sb-nav-link-icon"></div>競標商品管理</a>
                            <a class="nav-link" href="http://localhost:8080/PolyBrain/view/order/bidOrderBackend.html"><div class="sb-nav-link-icon"></div>競標訂單</a>
                        </nav>
                    </div>
                    <!-------------競標-------------->
                    <a class="nav-link" href="http://localhost:8080/PolyBrain/view/emp/allEmpList.jsp"><div class="sb-nav-link-icon"></div>
                        所有員工管理
                    </a>
                    <hr>
                    <a class="nav-link" href="http://localhost:8080/PolyBrain/view/member/back_logout.jsp"><div class="sb-nav-link-icon"></div>
                        後台登出
                    </a>
                </div>
            </div>
        </nav>
    </div>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">後台管理</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">競標活動管理</li>
                    </ol>
                    <div class="card mb-4">
                        <div class="card-body">
                            可以在這邊進行新增競標活動、編輯、移除的操作。
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            新增商品資訊
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>
                                        <th>競標活動編號</th>
                                        <th>競標商品編號</th>
                                        <th>起標時間</th>
                                        <th>結標時間</th>
                                        <th>底價</th>
                                        <th>最小出價</th>
                                        <th>直購價</th>
                                        <th>編輯</th>
                                        <th>刪除</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <% List<BidEventVo> eventlist = (List<BidEventVo>) pageContext.getAttribute("list"); %>
                                            <% if(eventlist !=null ) { %>
                                                <% for(BidEventVo bidEventVo : eventlist) {%>
                                                    <tr>
                                                        <td><%= bidEventVo.getBidEventNo() %></td>
                                                        <td><%= bidEventVo.getBidItemVo().getBidItemNo() %></td>
                                                        <td><%= bidEventVo.getStartTime() %></td>
                                                        <td><%= bidEventVo.getCloseTime() %></td>
                                                        <td><%= bidEventVo.getFloorPrice() %></td>
                                                        <td><%= bidEventVo.getLeastOffers() %></td>
                                                        <td><%= bidEventVo.getDirectivePrice() %></td>
                                                        <td>
                                                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" id="btn_edit"
                                                            data-bs-target="#bidEvent_edit" style="float: right; margin-bottom: 1px;" onclick="bidEventEditByPk(this)">
                                                                編輯
                                                            </button>
                                                            <!-- Modal -->
                                                            <div class="modal fade" id="bidEvent_edit" tabindex="-1" aria-labelledby="exampleModalLabel"
                                                                aria-hidden="true">
                                                                <div class="modal-dialog">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title" id="bidEvent_edit_title">競標商品編輯</h5>
                                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                                aria-label="Close"></button>
                                                                        </div>

                                                                        <div class="modal-body">
                                                                                <div style="margin-bottom: 10px; display: inline-block;">
                                                                                        <label for="bidItemName">競標商品:</label>
                                                                                        <select id="bidItemNo_edit" class="bidItemNo">
                                                                                            <option disabled selected>--請選擇--</option>
                                                                                        </select>
                                                                                </div>
                                                                                <div>
                                                                                    <label for="startTime">起標時間:</label>
                                                                                    <input type="datetime-local" id="startTime_edit">
                                                                                </div>
                                                                                <div style="margin-top: 10px;">
                                                                                    <label for="closeTime">結標時間:</label>
                                                                                    <input type="datetime-local" id="closeTime_edit">
                                                                                </div>
                                                                                <div style="margin-top: 10px; display: inline-block;">
                                                                                    <label for="floorPrice">底價:</label>
                                                                                    <input type="text" id="floorPrice_edit" style="width: 100px;">
                                                                                </div>
                                                                                <div style="margin-top: 10px; margin-left: 10px; display: inline-block;">
                                                                                    <label for="directivePrice">直購價:</label>
                                                                                    <input type="text" id="directivePrice_edit" style="width: 100px;">
                                                                                </div>
                                                                                <div style="margin-top: 10px; margin-bottom: 20px;">
                                                                                    <label for="leastOffers">最小出價金額:</label>
                                                                                    <input type="text" id="leastOffers_edit" style="width: 207px;">
                                                                                </div>
                                                                                <div class="modal-footer">
                                                                                    <button type="button" class="btn btn-secondary"
                                                                                        data-bs-dismiss="modal">取消</button>
                                                                                    <button type="button" onclick="insert()" class="btn btn-primary">儲存</button>
                                                                                </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </td>
                                                        <td>
                                                            <!-- Button trigger modal -->
                                                            <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#bidEvent_delete_<%= bidEventVo.getBidEventNo() %>" onclick="deleteByPk(this)">
                                                                刪除
                                                            </button>
                                                            
                                                            <!-- Modal -->
                                                            <div class="modal fade" id="bidEvent_delete_<%= bidEventVo.getBidEventNo() %>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                <div class="modal-dialog">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            確定刪除嗎?
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                                                                            <button type="button" class="btn btn-primary" onclick="deleteEvent(this)">確認刪除</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            </td>
                                                    </tr>
                                                    <% } %>
                                                        <% } %>
                                </tbody>
                            </table>
                            <!-- 新增一筆競標商品資料 -->
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                data-bs-target="#exampleModal" style="float: right; margin-bottom: 1px;">
                                新增
                            </button>

                            <!-- Modal -->
                            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                                aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLabel">競標商品新增</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                        </div>

                                        <div class="modal-body">
                                                <div style="margin-bottom: 10px; display: inline-block;">
                                                        <label for="bidItemNo">競標商品:</label>
                                                        <select id="bidItemNo_insert" class="bidItemNo">
                                                            <option disabled selected>--請選擇--</option>
                                                        </select>
                                                </div>
                                                <div>
                                                    <label for="startTime">起標時間:</label>
                                                    <input type="datetime-local" id="startTime">
                                                </div>
                                                <div style="margin-top: 10px;">
                                                    <label for="closeTime">結標時間:</label>
                                                    <input type="datetime-local" id="closeTime">
                                                </div>
                                                <div style="margin-top: 10px; display: inline-block;">
                                                    <label for="floorPrice">底價:</label>
                                                    <input type="text" id="floorPrice" style="width: 100px;">
                                                </div>
                                                <div style="margin-top: 10px; margin-left: 10px; display: inline-block;">
                                                    <label for="directivePrice">直購價:</label>
                                                    <input type="text" id="directivePrice" style="width: 100px;">
                                                </div>
                                                <div style="margin-top: 10px; margin-bottom: 20px;">
                                                    <label for="leastOffers">最小出價金額:</label>
                                                    <input type="text" id="leastOffers" style="width: 207px;">
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary"
                                                        data-bs-dismiss="modal">取消</button>
                                                    <button type="submit" onclick="insert()" class="btn btn-primary">儲存</button>
                                                </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <footer class="py-4 bg-light mt-auto">
                <div class="container-fluid px-4">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted">Copyright &copy; Your Website 2023</div>
                        <div>
                            <a href="#">Privacy Policy</a>
                            &middot;
                            <a href="#">Terms &amp; Conditions</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    <script>

        let bidItemNo = document.querySelector('#bidItemNo_insert');
        let startTime = document.querySelector('#startTime');
        let closeTime = document.querySelector('#closeTime');
        let floorPrice = document.querySelector('#floorPrice');
        let leastOffers = document.querySelector('#leastOffers');
        let directivePrice = document.querySelector('#directivePrice');

        $(document).ready(function(){
            selectItem();
            console.log('reload');

        });

        function deleteByPk(button){
            let parent_ele = button.closest('tr');
            let bidEventNo = parent_ele.querySelector('td:first-child').textContent;
            console.log(bidEventNo);

        }
        function deleteEvent(button){
            let parent_ele = button.closest('tr');
            let bidEventNo = parent_ele.querySelector('td:first-child').textContent;
            console.log(bidEventNo);
            console.log(parent_ele);
            
            fetch('http://localhost:8080/PolyBrain/general/test',{
                method: 'POST',
                headers: {
                    'content-type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    message: 'deleteEvent',
                    bidEventNo: bidEventNo
                })
            })
            .then(resp => resp.json())
            .then(data => {
                console.log(data);
                window.location.reload();
            })
            .catch(error => {
                console.log("error", error);
            });
        }

        function bidEventEditByPk(button){

            let parent_ele = button.closest('tr');
            let bidEventNo = parent_ele.querySelector('td:first-child').textContent;

            fetch('http://localhost:8080/PolyBrain/general/test',{
                method: 'POST',
                headers: {
                    'content-type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    message: 'bidEventEditByPk',
                    bidEventNo: bidEventNo
                })
            })
            .then(resp => resp.json())
            .then(data => {
                $('#bidItme_edit').val(data.bidItemNo);
                $('#startTime_edit').val(data.startTime);
                $('#closeTime_edit').val(data.closeTime);
                $('#floorPrice_edit').val(data.floorPrice);
                $('#leastOffers_edit').val(data.leastOffers);
                $('#directivePrice_edit').val(data.directivePrice);
            })
            .catch(error => {
                console.log("error", error);
            });
        }

        function selectItem(){
            // $('.bidItemNo').html('<option disabled selected>--請選擇--</option>');
            console.log("111");
            fetch('/PolyBrain/general/bidding',{
                method: 'POST',
                headers: {
                    'content-type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    message: 'selectItem'
                })
            })
            .then(resp => resp.json())
            .then(data => {

                for(let item of data){
                    var select = document.querySelectorAll('.bidItemNo');
                    let option = document.createElement('option');
                    option.value = item.bidItemNo;
                    option.innerHTML = item.bidItemName;
                    for(let i = 0; i < select.length; i++){
                        select[i].appendChild(option.cloneNode(true));
                    }
                }
            })
            .catch(error => {
                console.log("error", error);
            });
        }
        // function selectAllEvent(){
        //     fetch('http://localhost:8080/PolyBrain/general/test',{
        //         method: 'POST',
        //         headers: {
        //             'content-type': 'application/x-www-form-urlencoded'
        //         },
        //         body: new URLSearchParams({
        //             message: 'selectAllEvent'
        //         })
        //     })
        //     .then(resp => resp.json())
        //     .then(data => {
        //         data.forEach(bidEventVo => {
        //             let tableRow = document.createElement('tr');
        //             tableRow.innerHTML = `
        //             <td>${bidEventVo.bidEventNo}</td>
        //             <td>${bidEventVo.bidItemNo}</td>
        //             <td>${bidEventVo.startTime}</td>
        //             <td>${bidEventVo.closeTime}</td>
        //             <td>${bidEventVo.floorPrice}</td>
        //             <td>${bidEventVo.leastOffers}</td>
        //             <td>${bidEventVo.directivePrice}</td>
        //             `;
        //             $('.datatable-table').children('tbody').append(tableRow);
        //         });
        //     })
        //     .catch(error => {
        //         console.log('error', error);
        //     })
        // }
        function insert(){
            let bidItemVo = {
                bidItemNo: bidItemNo.value
            };
            console.log(startTime.value);
            console.log(closeTime.value);
            
            fetch('/PolyBrain/general/bidding',{
                method: 'POST',
                headers: {
                    'content-type': 'application/json'
                },
                body: JSON.stringify({
                        // message: 'addAnEvent',
                        // bidItemNo: bidItemNo.value,
                        bidItemVo: bidItemVo,
                        startTime: new Date(startTime.value),
                        closeTime: new Date(closeTime.value),
                        floorPrice: floorPrice.value,
                        leastOffers: leastOffers.value,
                        directivePrice: directivePrice.value
                    }),
            })
            .then(resp => resp.json())
            .then(data => {
                window.location.reload();
            })
            .catch(error => {
                console.log('error', error);
            })
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"crossorigin="anonymous"></script>
    <script src="js/datatables-simple-demo.js"></script>
</body>

</html>
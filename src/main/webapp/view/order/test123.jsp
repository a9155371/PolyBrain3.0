<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page import="java.util.*" %>


            <!-- <%@ page isELIgnored="false"%> -->
<html>

<head>
    <title>所有員工資料 - listAllOrder.jsp</title>

    <style>
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

<body>
    <form method="post" action="<%=request.getContextPath()%>/view/order/order.tw">
        <input type="hidden" name="test1" value="getAllOrder">
        <button type="submit" class="btn btn-primary btn-lg">
            送出
        </button>
    </form>


        <button type="submit" class="btn btn-primary btn-lg" id="bidOrderConfirmBtn">
            送出
        </button>
    </form>





</body>
<script>
var total = 100;

var bidOrderConfirmBtn = document.querySelector('#bidOrderConfirmBtn');

bidOrderConfirmBtn.addEventListener("click",function (){

    window.location.href = "http://localhost:8080/PolyBrain/view/order/bidOrderFront.html";
    
})


</script>




</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.*"%>
<%@page import="feature.forum.service.ArtService"%>
<%@page import="feature.forum.vo.ArtVo"%>

<%
    ArtService artSvc = new ArtService();
    List<ArtVo> list = artSvc.findByItemNo(Integer.valueOf(request.getParameter("itemNo")));
    if(request.getAttribute("ArtListData")==null) pageContext.setAttribute("ArtListData",list);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>討論區內頁</title>

    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>                                    <!-- ●●js  for jquery datatables 用 -->
    <script	src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>              <!-- ●●js  for jquery datatables 用 -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/dataTables.jqueryui.min.css" /> <!-- ●●css for jquery datatables 用 -->
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="css/styles.css" rel="stylesheet" />
    <style>
        nav.navbar{
            position: sticky;
            top:0;
            z-index: 1;
        }
    </style>
    <style>
        .wrap{
            overflow:hidden;
            border-radius:10px 10px 0px 0px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.35);
        }

        table{
            font-family: 'Oswald', sans-serif;
            border-collapse:collapse;
        }

        th{
            background-color:#009879;
            color:#ffffff;
            width:25vw;
            height:75px;
        }

        td{
            background-color:#ffffff;
            width:25vw;
            height:50px;
            text-align:center;
        }

        tr{
            border-bottom: 1px solid #dddddd;
            text-align:center;
        }

        tr:last-of-type{
            border-bottom: 2px solid #009879;
        }

        tr:nth-of-type(even) td{
            background-color:#f3f3f3;
        }
    </style><!-- ●● jquery datatables 設定 -->
            <script>
            	$(document).ready(function() {
            		$('#example').DataTable({
            			"lengthMenu": [3,5,10,20],
            			"searching": true,  //搜尋功能, 預設是開啟
            		    "paging": true,     //分頁功能, 預設是開啟
            		    "ordering": true,   //排序功能, 預設是開啟
            		    "language": {
            		        "processing": "處理中...",
            		        "loadingRecords": "載入中...",
            		        "lengthMenu": "顯示 _MENU_ 筆結果",
            		        "zeroRecords": "沒有符合的結果",
            		        "info": "顯示第 _START_ 至 _END_ 筆結果，共<font color=red> _TOTAL_ </font>筆",
            		        "infoEmpty": "顯示第 0 至 0 筆結果，共 0 筆",
            		        "infoFiltered": "(從 _MAX_ 筆結果中過濾)",
            		        "infoPostFix": "",
            		        "search": "搜尋:",
            		        "paginate": {
            		            "first": "第一頁",
            		            "previous": "上一頁",
            		            "next": "下一頁",
            		            "last": "最後一頁"
            		        },
            		        "aria": {
            		            "sortAscending":  ": 升冪排列",
            		            "sortDescending": ": 降冪排列"
            		        }
            		    }
            		});
            	});
            </script>
          

</head>
<body>
<!-- Responsive navbar-->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#!">PolyBrain</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="#">首頁</a></li>
                <li class="nav-item"><a class="nav-link" href="#!">商品專區</a></li>
                <li class="nav-item"><a class="nav-link" href="#!">競標專區</a></li>
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="#">會員中心</a></li>
            </ul>
        </div>
    </div>
</nav>
    <a class="btn btn-primary" href="../addnewpage.jsp">新增貼文</a>

<table id="example" class="display" style="width: 100%">
  <thead >
	<tr style="background-color:#CCCCFF">
	    <th>計數</th>
		<th>文章編號</th>
		<th>會員編號</th>
		<th>貼文主題</th>
		<th>發布時間</th>
		<th>圖片</th>
	</tr>
  </thead>

 <tbody>
	<c:forEach var="ArtVo" items="${ArtListData}" varStatus="s">
		<tr>
            <td>${s.count}</td>
			<td>${ArtVo.artNo}</td>
			<td>${ArtVo.memNo}</td>
			<td><a href="../innerpage/detail.jsp?artNo=${ArtVo.artNo}">${ArtVo.artTitle}</a></td>
			<td>
                <fmt:formatDate value="${ArtVo.artTime}" pattern="yyyy-MM-dd HH:mm:ss" />
            </td>

			<td><img src="<%=request.getContextPath()%>/Art/DBGifReader?artNo=${ArtVo.artNo}" width="100px"></td>
		</tr>
	</c:forEach>
  </tbody>
</table>
<!-- Footer-->
<footer class="py-5 bg-dark">
    <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
</footer>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
</body>
</html>
let newData = [];//全局範圍內定義了一個名為newData的變數
//一進頁面渲染
window.addEventListener("load", function () {
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', event => {
            event.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
    }
    // fetchAndBuildTable();
    sendToController();
})


//動態取出訂單
function fetchAndBuildTable() {


    // fetch(config.url + `/manager/getallProduct`, {
    //     method: "GET",
    //     headers: {
    //         Authorization_M: token, // 使用Manager Token
    //         "Content-Type": "application/json"
    //     }
    // })
    //     .then(response => response.json())
    //     .then(data => {
    //         console.log(data);
    //     });
}


function sendToController() {
    fetch("/PolyBrain/loginRequired/bidSearchMemOrder", {
        method: 'POST',
        headers: {
            "Content-Type": "application/json"
        }
    })
        .then(response => response.json())
        .then(data => {
            console.log(data);
            newData = data;
            buildTable();
        });
}



//動態填表格
function buildTable() {

    table = $("#memberBidOrder").DataTable({
        id: "memberBidOrder",
        "lengthMenu": [[5, 10, 15, 20, -1], [5, 10, 15, 20, "全部"]],
        "processing": true,
        "destroy": true,
        "autoWidth": false
        , responsive: {
            breakpoints: [                        //設定五種螢幕尺寸的type
                { name: 'desktop', width: Infinity },
                { name: 'tablet-l', width: 1024 },//原本是768~1024不含768
                { name: 'tablet-p', width: 767 },//
                { name: 'mobile-l', width: 480 },
                { name: 'mobile-p', width: 320 },
                { name: 'none', width: 100 }     //隱藏
            ]
        },
        data: newData,
        columns: [
            {
                data: "bidOrderNo",
            },
            {
                data: "receiverName",
            },
            {
                data: "receiverAddress",
            },
            {
                data: "receiverPhone",
            },
            {
                data: "receiverMethod",
                render: function (data, type, row) {
                    // 根据receiverMethod的值返回相应的文本
                    return data === 0 ? "郵寄" : "宅配";
                }
            },
            {
                data: "bidOrderVo.finalPrice",
            },
        ],
        language: {      // 語言設定
            "url": "//cdn.datatables.net/plug-ins/1.13.6/i18n/zh-HANT.json"
        },
        columnDefs: [
            {
                targets: '_all',
                className: 'text-center'
            }
        ]

    });








    // $(document).on('click', '.orderDetailBtn', function () {
    //     fetch("http://localhost:8080/PolyBrain/findAllOrderDetail", {
    //         headers: {
    //             "Content-Type": "application/json"
    //         }
    //     })
    //         .then(response => response.json())
    //         .then(data => {
    //             console.log(data);

    //             let customHtml = '<div>';
    //             data.forEach(item => {
    //                 customHtml += `<div class="custom-item">`;
    //                 customHtml += `<p><strong>商品名稱：</strong><strong>${item.itemName}</strong></p>`;
    //                 customHtml += `<span class="item-label">商品價格：</span><span class="item-value">${item.itemPrice}</span>`;
    //                 customHtml += `&nbsp;`
    //                 customHtml += `<span class="item-label">數量：</span><span class="item-value">${item.itemSales}</span>`;
    //                 customHtml += `&nbsp;`
    //                 customHtml += `<span class="item-label">合計：</span><span class="item-value">${item.itemPrice * item.itemSales}</span>`;
    //                 customHtml += `&nbsp;`
    //                 customHtml += `<span class="item-label">訂購日期：</span><span class="item-value">${item.itemOrderVO.tranTime}</span>`;
    //                 customHtml += '</div>'; // 结束商品信息的<div>
    //                 customHtml += `<br>`;
    //             });
    //             customHtml += '</div>';

    //             // 使用 SweetAlert 弹窗显示订单详情
    //             Swal.fire({
    //                 title: '訂單明细',
    //                 html: customHtml,
    //                 customClass: {
    //                     content: 'custom-swal-content' // 添加自定义CSS类
    //                 }
    //             });
    //         });
    // });












    //     // 动态添加按钮点击事件监听器
    //     $('#PdCollectTable tbody').on('click', 'button.up-button', function () {
    //         const pdNo = $(this).data('pdno'); // 获取按钮上的pdno属性值
    //         console.log("按钮被点击");
    //         // updateProductStatus(pdNo, 0); // 0 表示上架状态
    //     });

    //     $('#PdCollectTable tbody').on('click', 'button.down-button', function () {
    //         const pdNo = $(this).data('pdno'); // 获取按钮上的pdno属性值
    //         console.log("按钮被点击");
    //         // updateProductStatus(pdNo, 1); // 1 表示下架状态
    //     });
    // }




    // // 更新商品状态的函数
    // function updateProductStatus(pdNo, newStatus) {
    //     const updateStatusRequest = {
    //         pdNo: pdNo,
    //         pdStatus: newStatus
    //     };

    //     fetch(config.url + `/manager/updateOneProductStatus`, {
    //         method: 'PUT',
    //         headers: {
    //             Authorization_M: token,
    //             "Content-Type": "application/json"
    //         },
    //         body: JSON.stringify(updateStatusRequest)
    //     })
    //         .then(response => response.json())
    //         .then(data => {
    //             console.log(data);
    //             if (data.code === 200) {
    //                 // 更新状态成功
    //                 console.log('商品狀態更新成功');
    //                 // 这里可以根据需要刷新数据表格等
    //                 console.log(data);
    //                 fetchAndBuildTable(); //重載入

    //             } else {
    //                 console.error('商品狀態更新失敗');
    //             }
    //         })
    //         .catch(error => {
    //             console.error('請求更新時發生錯誤:', error);
    //         });

}
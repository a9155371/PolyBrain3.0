window.addEventListener('DOMContentLoaded', event => {
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', event => {
            event.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
    }
});

let dataTable = null; // 声明 DataTables 变量

$(document).ready(function () {
    // 初始化 DataTable，首次加载 ，否則刪除與編輯無法使用
    initializeDataTable();

    // 點擊删除觸發燈箱及執行刪除
    $('#itemTable tbody').on('click', '.btn-remove', function () {
        const rowData = dataTable.row($(this).closest('tr')).data();
        itemNo = rowData.itemNo;

        // 使用燈箱效果顯示確認取消對話框
        Swal.fire({
            title: '確認要取消追蹤該項商品？',
            text: "點擊確認後將取消追蹤商品資料。",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '確定',
            cancelButtonText: '取消'
        }).then(async (result) => {
            if (result.isConfirmed) {
                // 发送删除请求
                await fetch('http://localhost:8080/PolyBrain/loginRequired/DeleteTrace?itemNo=' + itemNo, {
                    method: 'GET',
                })
                .then(resp => {
                    if (resp.ok) {
                        alert("移除成功");
                        // 刷新数据
                        refreshDataTable();
                    }
                })
                .then(body => {
                    console.log(body);
                });
            }
        });
    });
});

// 初始化 DataTable
function initializeDataTable() {
    dataTable = $('#itemTable').DataTable({
        "searching": false,
        "data": [], // 初始为空数据
        "columns": [
            { "data": "itemNo" },
            {
                "data": "itemImg",
                "render": function (data, type, row) {
                    // 如果是显示类型，返回包含图像的 HTML
                    if (type === 'display' && data && data.length > 0) {
                        var imagesHTML = '';
                        imagesHTML += `<img src="${data}" alt="Image"><br>`;
                        return imagesHTML;
                    }
                    // 如果是排序或其他类型，返回原始数据
                    return data;
                }
            },
            {
                data: 'itemName', width: '180px',
                render: function (data, type, row) {
                    const itemNo = row.itemNo; // 取得 itemNo 的值
                    const link = `http://localhost:8080/PolyBrain/view/item/itemDetail.html?itemNo=${itemNo}`;
                    return `<a href="${link}" target="_blank">${data}</a>`;
                }
            },
            { "data": "itemPrice" },
            {
                "data": null,
                "render": function (data, type, row) {
                    return '<button type="button" class="btn btn-danger btn-sm btn-remove">取消追蹤</button>'
                }
            },
        ],
        language: {
            url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/zh-HANT.json',  // DATATABLE 設定為中文
        },
        columnDefs: [
            {
                targets: [0], // 第一欄 
                createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                },
            },
            {
                targets: [0, 1, 2, 3, 4], // _all 才是全部欄
                className: 'text-center' // 置中
            }
        ],
        // 其他设置...
        createdRow: function (row, data, dataIndex) {
            // 在此回调函数中，为每个单元格设置高度
            $(row).find('td').css('height', '100px'); // 将所有列的高度设置为 150 像素
        }
    });

    // 加载数据
    refreshDataTable();
}

// 刷新 DataTable 数据
function refreshDataTable() {
    $.ajax({
        url: 'http://localhost:8080/PolyBrain/loginRequired/Trace',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            console.log(data);
            dataTable.clear().rows.add(data).draw();
        },
        error: function(error) {
            console.error(error);
        }
    });
}

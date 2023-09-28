// 綁定所有價格按钮
var PriceButtons = document.querySelectorAll(".form-Price .btn-default");
// 綁定所有遊戲類型按钮
var typeButtons = document.querySelectorAll(".form-type .btn-default");
// 綁定所有玩家人数按钮
var playerButtons = document.querySelectorAll(".form-player .btn-default");
// 綁定所有時間按钮
var timeButtons = document.querySelectorAll(".form-time .btn-default");
// 綁定所有排序按鈕
var orderButtons = document.querySelectorAll(".form-order .btn-default");


function getProduct(move, numberpage, set) {
    // 清除原有商品列表
    const itemList = document.getElementById('itemList');
    while (itemList.firstChild) {
        itemList.removeChild(itemList.firstChild);
    }

    // 清除原有頁碼列表
    const pageList = document.getElementById('pageList');
    while (pageList.firstChild) {
        pageList.removeChild(pageList.firstChild);
    }

    // 以下為翻頁邏輯

    scrollTo({
        top: 0,
        behavior: 'smooth'
    }); // 點擊頁碼後平滑移動到頁面最上方

    switch (move) {
        case "page":
            // 處理點擊頁碼的邏輯
            currentPage = numberpage;
            break;
        case "prev":
            // 處理點擊上一頁的邏輯
            currentPage--;
            if (currentPage < 1) {
                currentPage = 1;
            }
            break;
        case "next":
            // 處理點擊下一頁的邏輯
            currentPage++;
            break;

    }

    // 發送請求獲取商品數據
    fetch("http://localhost:8080/PolyBrain/general/selectServlet?value=selectpage&page=" + currentPage + "&set=" + set, {
        method: 'GET',
        headers: { 'Content-Type': 'application/json;charset=UTF-8' },
    })
        .then(response => response.json()) // 解析JSON響應
        .then(data => {
            const totalPages = data.totalPages;
            const items = data.items;

            // 遍歷商品數據並渲染每個商品卡片
            items.forEach(item => {
                const cardColumn = document.createElement('div');
                cardColumn.classList.add('col', 'mb-5'); // 添加class
                cardColumn.innerHTML = `
                    <div class="card">
                        <div class="image-container">
                            <a href="http://localhost:8080/PolyBrain/view/item/itemDetail.html?itemNo=${item.itemNo}">
                                <img class="card-img-top" src="${item.itemImg[0].itemImg}" alt="商品圖片" itemState ="${item.itemState}" itemSales="${item.itemSales}">
                            </a>
                        </div>
                        <div class="card-body p-4">
                            <div class="text-center">
                                <h5 class="fw-bolder">${item.itemName}</h5>
                                類別：${item.itemClass.itemClassName}類
                                <span>$${item.itemPrice}</span>
                            </div>
                            <div class="text-center">
                            遊戲人數：${item.minPlayer}人到${item.maxPlayer}人
                            </div>
                            <div class="text-center">
                            銷售量：${item.itemSales} 個
                            </div>
                        </div>
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                            <div class="text-center">
                                <button onclick="addCart(${item.itemNo})" class="btn btn-outline-dark mt-auto">加入購物車</button>
                                <button onclick="getItem(${item.itemNo})" class="btn btn-outline-dark mt-auto">收藏</button>
                            </div>
                        </div>
                    </div>
                `;
                itemList.appendChild(cardColumn);

                // 取得插入的 card-img-top 元素
                const cardImgTop = cardColumn.querySelector('.card-img-top');
                // 取得 itemState 属性的值
                const itemState = cardImgTop.getAttribute('itemState');
                // 取得 itemSales 属性的值
                const itemSales = parseInt(cardImgTop.getAttribute('itemSales'));

                // 如果是已售完狀態，插入 Sale 符號
                if (itemState === '2') {
                    cardImgTop.insertAdjacentHTML('beforebegin', '<div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem" >已售完</div>');
                }
                if (itemSales >= 100){
                    cardImgTop.insertAdjacentHTML('beforebegin', '<div class="badge bg-danger text-white position-absolute" style="top: 0.5rem; right: 0.5rem" >HOT!</div>');
                }
            });

            getPage(totalPages, currentPage);
        })
        .catch(error => {
            // 處理錯誤
            console.error('獲取數據時出現問題:', error);
        });
}

//加入購物車
function addCart(itemNo) {
    console.log("加入購物車");
    quantity = "1";

    const cartItem = {
        itemNo: parseInt(itemNo),
        quantity: parseInt(quantity)
    };

    sessionStorage.setItem('currentPage', window.location.href);
    fetch("http://localhost:8080/PolyBrain/loginRequired/CartInsert", {
        method: 'POST',
        headers: { 'Content-Type': 'application/json;charset=UTF-8' },
        body: JSON.stringify(cartItem)
    })
        .then(resp => {
            console.log(resp.status);
            if (resp.status == 401) {
                alert('帳號未登入，跳轉至登入頁面');
                window.location.href = 'http://localhost:8080/PolyBrain/view/member/login.html';
                throw new Error('錯誤訊息');
            } else if (resp.ok) {
                // 請求成功
                return resp.json();
            }
        }) // 解析JSON響應
        .then(data => {
            if (data.success) {
                Swal.fire({
                    position: 'center',
                    icon: 'success',
                    title: '成功加入購物車',
                    showConfirmButton: false,
                    timer: 1500
                })
            }
        })
        .catch(error => {
            // 處理錯誤
            console.error('獲取數據時出現問題:', error);
        });
}

// 獲取需收藏的商品資訊
function getItem(itemNo) {
    console.log("收藏前收集資料");
    console.log(itemNo);
    Trace = {};
    // 發送請求獲取商品數據
    fetch("http://localhost:8080/PolyBrain/general/selectServlet?value=selectID&itemID=" + itemNo, {
        method: 'GET',
        headers: { 'Content-Type': 'application/json;charset=UTF-8' },
    })
        .then(response => response.json()) // 解析JSON響應
        .then(data => {
            Trace.itemNo = data.itemNo;
            Trace.itemImg = data.itemImg[0].itemImg;
            Trace.itemName = data.itemName;
            Trace.itemPrice = data.itemPrice;
            console.log(Trace);
            addTrace(Trace)
        })
        .catch(error => {
            // 處理錯誤
            console.error('獲取數據時出現問題:', error);
        });
}
//收到商品數據丟入資料庫收藏
function addTrace(Trace) {
    console.log("開始將資料加入收藏");
    console.log(Trace);
    // 發送請求獲取商品數據
    fetch("http://localhost:8080/PolyBrain/loginRequired/Trace", {
        method: 'POST',
        headers: { 'Content-Type': 'application/json;charset=UTF-8' },
        body: JSON.stringify(Trace),
    })
        .then(resp => {
            console.log(resp.status);
            if (resp.status == 401) {
                alert('帳號未登入，跳轉至登入頁面');
                window.location.href = 'http://localhost:8080/PolyBrain/view/member/login.html';
                throw new Error('錯誤訊息');
            } else if (resp.ok) {
                // 請求成功
                return resp.json();
            }
        }) // 解析JSON響應
        .then(data => {
            Trace.itemNo = data.itemNo;
            Trace.itemImg = data.itemImg[0].itemImg;
            Trace.itemName = data.itemName;
            Trace.itemPrice = data.itemPrice;
            console.log(Trace);
        })
        .catch(error => {
            // 處理錯誤
            console.error('獲取數據時出現問題:', error);
        });
}


// 生成頁碼的函數
function getPage(totalPages, currentPage) {
    const pageList = document.getElementById('pageList');

    // 上一頁按鈕
    if (currentPage > 1) {
        const prevItem = document.createElement('li');
        prevItem.innerHTML = `<a href="javascript:TurnPage('prev');"><</a>`;
        pageList.appendChild(prevItem, pageList.firstChild);
    }

    // 生成頁碼按鈕
    for (let i = 1; i <= totalPages; i++) {
        const listItem = document.createElement('li');
        if (i === currentPage) {
            listItem.classList.add('active');
        }
        listItem.innerHTML = `<a href="javascript:getProduct('page', ${i},set);">${i}</a>`;
        pageList.appendChild(listItem);
    }

    // 下一頁按鈕
    if (currentPage < totalPages) {
        const nextItem = document.createElement('li');
        nextItem.innerHTML = `<a href="javascript:TurnPage('next');">></a>`;
        pageList.appendChild(nextItem);
    }
}

function TurnPage(move, numberpage) {
    getProduct(move, numberpage, set)
}

// 頁面加載完成後執行獲取第一頁商品
window.addEventListener('DOMContentLoaded', event => {
    // 動態生成各個按鈕
    getProduct("page", 1, set);
});


// 串接指令區

queryParams = {};

//調整價格按鈕CSS
function PriceActive(value) {
    // 遍历所有按钮，移除 active 类
    PriceButtons.forEach(function (button) {
        button.classList.remove("active");
    });

    // 为被点击的按钮添加 active 类
    PriceButtons[value].classList.add("active");

}
//價格條件設定
function PriceClick(minPrice, maxPrice) {
    // 如果minPrice和maxPrice已經存在，將數值移除
    if (minPrice === 0 && queryParams.hasOwnProperty('minPrice')) {
        delete queryParams.minPrice;
    }
    if (maxPrice === 0 && queryParams.hasOwnProperty('maxPrice')) {
        delete queryParams.maxPrice;
    }

    // 设置minPrice和maxPrice属性为新的值
    if (maxPrice != 0 || minPrice != 0) {
        queryParams.minPrice = minPrice;
        queryParams.maxPrice = maxPrice;
    }

    searchItem(queryParams);
}

//遊戲類型條件設定
function TypeClick(ItemClassNo) {
    // 遍历所有按钮，移除 active 类
    typeButtons.forEach(function (button) {
        button.classList.remove("active");
    });

    // 为被点击的按钮添加 active 类
    typeButtons[ItemClassNo].classList.add("active");

    // 如果類型已經存在，將數值移除
    if (queryParams.hasOwnProperty('ItemClassNo')) {
        delete queryParams.ItemClassNo;
    }
    // 將ItemClassNo設置進去
    if (ItemClassNo != 0) {
        queryParams.ItemClassNo = ItemClassNo;
    }

    searchItem(queryParams);
}

//遊戲人數條件設定
function PlayerClick(playerCount) {
    // 遍历所有按钮，移除 active 类
    playerButtons.forEach(function (button) {
        button.classList.remove("active");
    });

    // 为被点击的按钮添加 active 类
    playerButtons[playerCount].classList.add("active");

    // 如果類型已經存在，將數值移除
    if (queryParams.hasOwnProperty('playerCount')) {
        delete queryParams.playerCount;
    }
    // 將ItemClassNo設置進去
    if (playerCount != 0) {
        queryParams.playerCount = playerCount;
    }

    searchItem(queryParams);
}

//調整時間按鈕CSS
function TimeActive(value) {
    console.log();
    // 遍历所有按钮，移除 active 类
    timeButtons.forEach(function (button) {
        button.classList.remove("active");
    });

    // 为被点击的按钮添加 active 类
    timeButtons[value].classList.add("active");

}
//遊戲時間條件設定
function TimeClick(gameTime) {
    if (queryParams.hasOwnProperty('gameTime')) {
        delete queryParams.gameTime;
    }
    // 將ItemClassNo設置進去
    if (gameTime != 0) {
        queryParams.gameTime = gameTime;
    }
    searchItem(queryParams);

}

// 綁定輸入框
const inputElement = document.getElementById('myInput');
inputElement.addEventListener('click', function () {
    // 清空輸入框的值
    inputElement.value = '';
});
//文字輸入條件設定
function NameCilck(gameName) {
    if (queryParams.hasOwnProperty('gameName')) {
        delete queryParams.gameName;
    }
    // 設置gameName並送出 避免在空白時也送出搜尋
    const trimmedGameName = gameName.trim();
    if (trimmedGameName.length > 0) {
        queryParams.gameName = trimmedGameName;
    }
    searchItem(queryParams);
}

//排序方式條件設定
function OrderBy(orderBy) {
    // 遍历所有按钮，移除 active 类
    orderButtons.forEach(function (button) {
        button.classList.remove("active");
    });

    // 为被点击的按钮添加 active 类
    orderButtons[orderBy].classList.add("active");

    // 如果類型已經存在，將數值移除
    if (queryParams.hasOwnProperty('orderBy')) {
        delete queryParams.orderBy;
    }
    // 將排序指令設置進去
    switch (orderBy) {
        case 0:
            queryParams.orderBy = "itemNo ASC";
            break;
        case 1:
            queryParams.orderBy = "itemNo DESC";
            break;
        case 2:
            queryParams.orderBy = "itemSales DESC";
            break;
    }

    searchItem(queryParams);
}

let set = '';   //放在外面讓她成為實體變數 以便翻頁使用
//文字串接區
function searchItem(queryParams) {
    set = '';   //新設的搜尋條件進來初始化
    // 串接價格範圍
    if (queryParams.minPrice !== undefined && queryParams.maxPrice !== undefined) {
        set += ` AND itemPrice BETWEEN ${queryParams.minPrice} AND ${queryParams.maxPrice} `;
    }

    // 串接遊戲類別
    if (queryParams.ItemClassNo !== undefined) {
        set += ` AND itemClassNo = ${queryParams.ItemClassNo} `;
    }

    // 串接遊戲人數
    if (queryParams.playerCount !== undefined) {
        set += ` AND minPlayer <= ${queryParams.playerCount} AND maxPlayer >= ${queryParams.playerCount} `;
    }

    // 串接遊戲時間
    if (queryParams.gameTime !== undefined) {
        set += ` AND gameTime = ${queryParams.gameTime} `;
    }

    // 串接遊戲名稱
    if (queryParams.gameName !== undefined) {
        set += ` AND itemName LIKE '%${queryParams.gameName}%' `;
    }

    if (queryParams.orderBy !== undefined) {
        set += ` ORDER BY ${queryParams.orderBy} `;
    }

    console.log(set);
    // return set;
    var enset = encodeURIComponent(encodeURIComponent(set));
    console.log(enset);
    //啟動條件搜尋 並到第一頁
    getProduct("page", 1, enset);
}

// 在點擊加入購物車按鈕時觸發的事件處理程序(尚未處理完成)
$('.my-cart-btn').on('click', function () {
    // 獲取當前購物車數量
    var currentItemCount = parseInt($('#cartItemCount').text(), 10);

    // 將購物車數量增加 1
    currentItemCount++;

    // 更新購物車數字
    $('#cartItemCount').text(currentItemCount);

    // 執行商品圖片的飛入動畫
    var $addTocartBtn = $(this);
    var $cartIcon = $(".my-cart-icon");
    var $image = $('<img width="30px" height="30px" src="' + $addTocartBtn.data("image") + '"/>').css({ "position": "fixed", "z-index": "999" });
    $addTocartBtn.prepend($image);
    var position = $cartIcon.position();
    $image.animate({
        top: position.top,
        left: position.left
    }, 500, "linear", function () {
        $image.remove();
    });
});


$(document).ready(function () {
    //叫用會員資料
    validateMemStatus();
    //以下為輪撥
    $(".owl-carousel").owlCarousel({
        center: true,
        loop: true, // 循環播放
        autoplay: true,
        autoplayTimeout: 5000,
        autoplayHoverPause: true,
        smartSpeed: 500,
        margin: 10, // 外距 10px
        nav: true,
        dots: true,
        responsive: {
            0: {
                items: 1 // 螢幕大小為 0~600 顯示 1 個項目
            },
            600: {
                items: 1 // 螢幕大小為 600~1000 顯示 3 個項目
            },
            1000: {
                items: 1 // 螢幕大小為 1000 以上 顯示 5 個項目
            }
        }
    });
    //點擊搜尋列表 展開費時0.6s
    $("#productSearch summary").click(function () {
        $("#productSearch div.col-md-12").slideToggle(1000);
    });

});


//會員列表展開用
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
            <li><a class="dropdown-item" href="http://localhost:8080/PolyBrain/view/member/Member_Information.jsp">會員專區</a></li>
            <li><a class="dropdown-item" href="http://localhost:8080/PolyBrain/view/CartTrace/Cart.jsp">購物車</a></li>
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


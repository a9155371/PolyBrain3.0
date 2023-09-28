let bidEventId = new URLSearchParams(window.location.search).get('bidEventId');
let myEndPoint = `/BidOnePage/yoooche/${bidEventId}`; //yoooche是進到頁面的使用者id，不能寫死
let host = window.location.host;
let path = window.location.pathname;
let webctx = path.substring(0, path.indexOf("/", 1));
let endPointURL = "ws://" + window.location.host + webctx + myEndPoint;
let statusOutput = document.querySelector("#statusOutput");
let webSocket;

$(document).ready(function(){
    getRangeOfRangeBar();
    getBiddingTimer();
    getBiddingItemPics();
    getBiddingItemInfo();
});

async function connect() {
    
    webSocket = new WebSocket(endPointURL);
    webSocket.onopen = function (event) {
        updateStatus("Bidding Room");
        document.querySelector("#bidding").disabled = false;
    }
    webSocket.onmessage = function (event) {
        let biddingRoom = document.querySelector("#biddingRoom");
        let newBidRecord = document.createElement('li');
        newBidRecord.classList.add('list-group-item');
        newBidRecord.classList.add('list-group-item-action');
        let jsonObj = JSON.parse(event.data);
        newBidRecord.innerHTML = jsonObj.bidder + ":" + jsonObj.biddingRange;
        biddingRoom.appendChild(newBidRecord);

        let biddingBtn = document.querySelector("#bidding");
        biddingBtn.innerHTML = '當前最高價＄' + jsonObj.biddingRange;

        biddingRoom.scrollTop = biddingRoom.scrollHeight;
    }
    webSocket.onclose = function (event) {
        updateStatus("Websocket Disconnected");
    }
}
function bidding() {
    sessionStorage.setItem('currentPage', window.location.href);
    let bidderName = $('span#bidder').text();
    if (bidderName == "") {
        var confirmation = confirm("若要繼續競標，請先登入");
        if (confirmation) {
            window.location.href = "http://localhost:8080/PolyBrain/view/member/login.html";
            return;
        }
        return;
    }
    let biddingRange = document.querySelector("#biddingRange");
    let biddingRangeValue = biddingRange.value;
    let urlParams = new URLSearchParams(window.location.search);
    let bidEventId = urlParams.get('bidEventId');
    let jsonObj = {
        "bidder": bidderName,
        "biddingRange": biddingRangeValue,
        "bidEventId": bidEventId
    }
    webSocket.send(JSON.stringify(jsonObj));
}
    function disconnect() {
        webSocket.close();
    }

function updateStatus(newStatus) {
    statusOutput.innerHTML = newStatus;
}
async function getBiddingItemPics(){
    fetch('/PolyBrain/general/bidding', {
        method: 'POST',
        headers: {
            'content-type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
            message: 'getBiddingItemPics',
            bidEventId: bidEventId
        })
    })
    .then(resp => resp.json())
    .then(data => {
        const imgArea = document.getElementById('img-showcase'); //大圖
        
        let j = 1;
        for(let bidItemPic of data){ 
            const imgEle = document.createElement('img'); //從資料庫拿多張圖，每次迭代生成一張
            imgEle.src = "data:image/jpeg;base64,"+ bidItemPic; //這是一張完整的img標籤圖片
            imgEle.style.borderRadius = "20px";

            imgArea.appendChild(imgEle); //串接放到大圖的區塊獨自展示

            let str = `
                <div class="img-item">
                    <a href="#" data-id="${j}">
                        <img src="data:image/jpeg;base64,${bidItemPic}" style="border-radius: 20px;">
                    </a>
                </div>
            `;
            $('.img-select').append(str);

            j++;
        }
            
    })
    .catch(error => {
        console.log("error", error);
    });
}
const imgs = document.querySelectorAll('.img-select a');
    const imgBtns = [...imgs];
    let imgId = 1;

    imgBtns.forEach((imgItem) => {
        imgItem.addEventListener('click', (event) => {
            console.log('xxx');
            event.preventDefault();
            imgId = imgItem.dataset.id;
            slideImage();
        });
    });

    function slideImage() {
        const displayWidth = document.querySelector('.img-showcase img:first-child').clientWidth;
        document.querySelector('.img-showcase').style.transform = `translateX(${- (imgId - 1) * displayWidth}px)`;
    }
    window.addEventListener('resize', slideImage);
    
function getBiddingTimer(){
    fetch('/PolyBrain/general/bidding', {
        method: 'POST',
        headers: {
            'content-type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
            message: 'getBiddingTimer',
            bidEventId: bidEventId
        })
    })
    .then(resp => resp.json())
    .then(data => {
        let startTime = data.startTime;
        let closeTime = data.closeTime;
        updateTimer(closeTime);
    })
    .catch(error => {
        console.log("error", error);
    });
}
async function getBiddingItemInfo(){
    fetch('/PolyBrain/general/bidding', {
        method: 'POST',
        headers: {
            'content-type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
            message: 'getBiddingItemInfo',
            bidEventId: bidEventId
            //取得競標事件的VO
            //取得競標商品的VO
        })
    })
    .then(resp => resp.json())
    .then(data => {
        console.log(data);
        //競標商品名稱
        //遊戲發行商
        //商品描述
        //直購價
        //底價
        // 商品類別
        $('.product-content h2').text(data.bidItemName);
        $('.product-content h3').text(data.gamePublisher);
        $('#bidItemDescribeArea').val(data.bidItemDescribe);
        $('#btn_class').text(`底價 $ ${data.floorPrice}`);
        $('#btn_directivePrice').text(`直購價 $ ${data.directivePrice}`);
        
    })
    .catch(error => {
        console.log("error", error);
    });
}
function buyWithoutBidding(){
    let bidEventId = new URLSearchParams(window.location.search).get('bidEventId');
    sessionStorage.setItem('currentPage', window.location.href);
    let bidderName = $('span#bidder').text();
    if (bidderName == "") {
        var confirmation = confirm("若要繼續競標，請先登入");
        if (confirmation) {
            window.location.href = "http://localhost:8080/PolyBrain/view/member/login.html";
            return;
        }
        return;
    }
    fetch('/PolyBrain/loginRequired/bidOrderCreate', {
        method: 'POST',
        headers: {'content-type': 'application/x-www-form-urlencoded'},
        body: new URLSearchParams({
            bidEventId: bidEventId
        })
    })
    .then(resp => resp.json())
    .then(data => {
        console.log(data);
        sessionStorage.setItem("bidOrderVo", JSON.stringify(data));
        window.location.href = 'http://localhost:8080/PolyBrain/view/order/bidOrderConfirm.html';
    })
    .catch(error => {
        console.log("error", error);
    });
}

async function getRangeOfRangeBar(){
    fetch('/PolyBrain/general/bidding', {
        method: 'POST',
        headers: {
            'content-type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
            message: 'rangeBarSetting',
            bidEventId: bidEventId
        })
    })
    .then(resp => resp.json())
    .then(data => {

        let floorPrice = data.floorPrice;
        let directivePrice = data.directivePrice;
        let leastOffers = data.leastOffers;
        $("#biddingRange").attr("min", floorPrice);
        $("#biddingRange").attr("max", directivePrice);
        $("#biddingRange").attr("value", floorPrice);
        $("#biddingRange").attr("step", leastOffers);
        $('#bidding').html('底價開標＄' + floorPrice);

    })
    .catch(error => {
        console.log("error", error);
    });
}

function updateBiddingValue() { 
    const biddingRange = document.querySelector("#biddingRange");
    const bidding = document.querySelector("#bidding");
    const biddingRoomList = document.querySelector("#biddingRoom");
    
    if(biddingRoomList.childNodes.length >= 2){
        let previousPrice =  biddingRoomList.lastChild.textContent.split(':');
        
        if(previousPrice[1] !== null){

            biddingRange.value = (parseInt(biddingRange.value) + parseInt(previousPrice[1].trim()));
            bidding.innerHTML = '出價＄' + biddingRange.value;
            bidding.classList.add('readyToBidding');
        }

    }else{
        console.log('出價設定錯誤');
    }

}

function updateTimer(time) {
future = Date.parse(time); //時間要從資料庫撈出來，要判斷是哪一場競標（編號），不能寫死
let bidTimer = setInterval(function(){

now = new Date();
diff = future - now;
days = Math.floor(diff / (1000 * 60 * 60 * 24));
hours = Math.floor(diff / (1000 * 60 * 60));
mins = Math.floor(diff / (1000 * 60));
secs = Math.floor(diff / 1000);

d = days;
h = hours - days * 24;
m = mins - hours * 60;
s = secs - mins * 60;

d = (d < 10) ? "0" + d : d;
h = (h < 10) ? "0" + h : h;
m = (m < 10) ? "0" + m : m;
s = (s < 10) ? "0" + s : s;

document.getElementById('timer')
.innerHTML =
'<div>' + d + '</div>' + '<span class="bidunit">天</span>' +
'<div>' + h + '</div>' + '<span class="bidunit">時</span>' +
'<div>' + m + '</div>' + '<span class="bidunit">分</span>' +
'<div>' + s + '</div>' + '<span class="bidunit">秒</span>';

if (d == 0 && h == 0 && m == 0 && s == 0) {
bidClose();
let urlParams = new URLSearchParams(window.location.search);
let bidEventId = urlParams.get('bidEventId');
console.log(bidEventId);

fetch('/PolyBrain/general/bidding', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: new URLSearchParams({
        message : 'closed',
        bidEventId: bidEventId
    })
});
clearInterval(bidTimer);
}
}, 1000);
}
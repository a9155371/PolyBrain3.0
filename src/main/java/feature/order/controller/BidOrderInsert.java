package feature.order.controller;

import core.util.CommonUtil;
import feature.bid.vo.BidOrderDetailVo;
import feature.order.service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/loginRequired/insertBidOrderDetail")
public class BidOrderInsert extends HttpServlet {
    private static final long serialVersionUID = 1L;
    CommonUtil commonUtil = new CommonUtil();
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        doPost(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String county = req.getParameter("county");
        String district = req.getParameter("district");
        String receiverAddress = req.getParameter("receiverAddress");
        String receiverPhone = req.getParameter("receiverPhone");
        String receiverName = req.getParameter("receiverName");
        Integer orderNo = Integer.valueOf(req.getParameter("orderNo"));
        Integer receiverMethod = Integer.valueOf(req.getParameter("receiverMethod"));

        receiverAddress = county + district + receiverAddress;

        BidOrderDetailVo bidOrderDetailVo = new BidOrderDetailVo();
        bidOrderDetailVo.setBidOrderNo(orderNo);
        bidOrderDetailVo.setReceiverName(receiverName);
        bidOrderDetailVo.setReceiverMethod(receiverMethod);
        bidOrderDetailVo.setReceiverAddress(receiverAddress);
        bidOrderDetailVo.setReceiverPhone(receiverPhone);

        new OrderService().addBidOrderDetail(bidOrderDetailVo);
        Integer bodNo = bidOrderDetailVo.getBodNo();


    }
}

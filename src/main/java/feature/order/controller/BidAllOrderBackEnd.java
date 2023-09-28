package feature.order.controller;

import core.util.CommonUtil;
import feature.bid.vo.BidOrderDetailVo;
import feature.order.service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
@WebServlet("/loginRequired/bidAllOrderBackEnd")
public class BidAllOrderBackEnd extends HttpServlet {
    private static final long serialVersionUID = 1L;
    CommonUtil commonUtil = new CommonUtil();

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer memNo = (Integer)session.getAttribute("memNo");

        List<BidOrderDetailVo> bidOrderDetailVoList =  new OrderService().getBidAllOrder();
        System.out.println(bidOrderDetailVoList);
        commonUtil.writePojo2Json(res, bidOrderDetailVoList);

    }
}



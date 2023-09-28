package feature.order.controller;

import core.util.CommonUtil;
import feature.bid.vo.BidOrderDetailVo;
import feature.bid.vo.BidOrderVo;
import feature.order.service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/loginRequired/bidSearchMemOrder")
public class BidSearchMemOrder extends HttpServlet {
    private static final long serialVersionUID = 1L;
    CommonUtil commonUtil = new CommonUtil();

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer memNo = (Integer)session.getAttribute("memNo");

        List<BidOrderDetailVo> bidOrderDetailVoList =  new OrderService().getBidOrderByMem(memNo); //有拿到bidOrderDetail
        System.out.println(bidOrderDetailVoList);
        commonUtil.writePojo2Json(res, bidOrderDetailVoList);

    }
}

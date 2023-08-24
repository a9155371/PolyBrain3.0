package feature.bid.controller;

import feature.bid.service.BiddingService;
import feature.bid.service.BiddingServiceImpl;
import feature.bid.vo.BidItemVo;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/bid/BidItemList")
public class BidItemListServlet extends HttpServlet {
    private BiddingService biddingService = new BiddingServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        //---------- insert an item into bid_item table ----------

        if("insert".equals(action)){
            String bidItemName = req.getParameter("bidItemName");
            Integer itemClassNo = Integer.valueOf(req.getParameter("itemClassNo"));
            String gamePublisher = req.getParameter("gamePublisher");
            String bidItemDescribe = req.getParameter("bidItemDescribe");

            BidItemVo bidItemVo = new BidItemVo();
            bidItemVo.setBidItemName(bidItemName);
            bidItemVo.setItemClassNo(itemClassNo);
            bidItemVo.setGamePublisher(gamePublisher);
            bidItemVo.setBidItemDescribe(bidItemDescribe);

            biddingService = new BiddingServiceImpl();
            biddingService.addAnItem(bidItemVo);

//            String url = "/view/bid/BidItemList.jsp";
//            RequestDispatcher bidItemList = req.getRequestDispatcher(url);
//            bidItemList.forward(req, resp);

            resp.sendRedirect(req.getContextPath() + "/view/bid/BidItemList.jsp");
        }
    }
}
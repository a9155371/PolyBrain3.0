package feature.trace.comtroller;

import feature.trace.service.TraceService;
import feature.trace.vo.traceVO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static core.util.CommonUtil.json2Pojo;

@WebServlet("/loginRequired/DeleteTrace")
public class RemoveServlet extends HttpServlet {
    private TraceService service = new TraceService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer memNo = (Integer) session.getAttribute("memNo");
        System.out.println("進入刪除收藏Servlet");
//        final Integer itemNo = json2Pojo(req, traceVO.class).getItemNo();
        String itemNo = req.getParameter("itemNo");
        // 检查 memNo 参数是否存在
        if (memNo != null) {
            // 尝试将 itemNoParam 转换为整数
            // 调用服务方法删除相应的数据
            service.removeTrace(memNo, itemNo);
            // 设置HTTP响应状态码为成功
            res.setStatus(HttpServletResponse.SC_OK);
        } else {
            // 如果 memNo 参数不存在，返回适当的响应
            res.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
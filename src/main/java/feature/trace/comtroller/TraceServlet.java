package feature.trace.comtroller;

import com.google.gson.Gson;
import feature.trace.service.TraceService;
import feature.trace.vo.traceVO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets; // 添加这一行

@WebServlet("/loginRequired/Trace")
public class TraceServlet extends HttpServlet {
    private TraceService service = new TraceService();

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer memNo = (Integer) session.getAttribute("memNo");

        // 检查 memNo 参数是否存在
        if (memNo != null) {
            // 调用服务方法获取与 memNo 相关的所有数据
            String jsonData = service.getAllTraceData(memNo);
//            System.out.println(jsonData);
            // 设置响应类型为 JSON
            res.setContentType("application/json");

            // 设置字符编码为UTF-8
            res.setCharacterEncoding("UTF-8");

            // 返回 JSON 数据给前端
            res.getWriter().write(jsonData);
        } else {
            // 如果 memNo 参数不存在，返回适当的响应
            res.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer memNo = (Integer) session.getAttribute("memNo");
        StringBuilder jsonBuilder = new StringBuilder();

        try (InputStream inputStream = req.getInputStream();
             BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) { // 设置字符编码为UTF-8
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 设置HTTP响应状态码
            return;
        }
        String itemTrace = jsonBuilder.toString();
        // 创建Gson对象
        Gson gson = new Gson();
        // 解析JSON字符串为traceVO对象
        traceVO trace = gson.fromJson(itemTrace, traceVO.class);
        service.addTrace(memNo, trace);

        // 设置HTTP响应
        res.setStatus(HttpServletResponse.SC_OK);
    }
}

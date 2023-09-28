package feature.trace.service;

import com.google.gson.Gson;
import feature.trace.vo.traceVO;
import redis.clients.jedis.Jedis;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class TraceService {
//    private final Jedis jedis;
//
//    public TraceService() {
//        this.jedis = new Jedis("localhost", 6379);
//    }

    public void addTrace(Integer memNo, traceVO trace) {
        Jedis jedis = new Jedis("localhost", 6379);
        try {
            String memNoKey = "memNo:" + memNo;
            String itemNoKey = "memtrace:" + memNo + ":" + trace.getItemNo();

            // 使用 Redis HSET 命令逐个设置字段和字段值
            jedis.hset(itemNoKey, "itemNo", String.valueOf(trace.getItemNo()));
            jedis.hset(itemNoKey, "itemName", trace.getItemName());
            jedis.hset(itemNoKey, "itemPrice", String.valueOf(trace.getItemPrice()));
            jedis.hset(itemNoKey, "itemImg", trace.getItemImg());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 在方法结束时关闭连接
            jedis.close();
        }
    }


    public String getAllTraceData(Integer memNo) {
        Jedis jedis = new Jedis("localhost", 6379);
        try {
            String memtracePrefix = "memtrace:" + memNo + ":";
            Set<String> itemNoKeys = jedis.keys(memtracePrefix + "*");

            List<Map<String, String>> itemDetails = new ArrayList<>();

            for (String itemNoKey : itemNoKeys) {
                Map<String, String> traceData = jedis.hgetAll(itemNoKey);

                // 添加调试语句
                System.out.println("itemNoKey: " + itemNoKey);
//                System.out.println("traceData: " + traceData);

                itemDetails.add(traceData);
            }

            // 将所有 itemNo 数据组合成一个 JSON 结构
            String jsonData = listToJSON(itemDetails);

            return jsonData;
        } catch (Exception e) {
            e.printStackTrace();
            return ""; // 处理异常情况，您可以自行决定返回值
        } finally {
            // 在方法结束时关闭连接
            jedis.close();
        }
    }
    private String listToJSON(List<Map<String, String>> dataList) {
        // 将 List<Map<String, String>> 转换为 JSON 字符串
        return new Gson().toJson(dataList);
    }

    public void removeTrace(Integer memNo, String itemNo) {
        Jedis jedis = new Jedis("localhost", 6379);
        try {
            System.out.println("執行刪除收藏 itemNo= " + itemNo);
            // 检查 itemNo 是否有效
            if (itemNo != null) {
                String memtraceKey = "memtrace:" + memNo + ":" + itemNo;
//                String itemNoKey = String.valueOf(itemNo);

                // 使用 Redis HDEL 命令删除指定字段
                jedis.del(memtraceKey);
            } else {
                // 如果 itemNo 无效，您可以选择如何处理
                // 例如，可以抛出异常，返回错误消息，或者执行其他操作
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 在方法结束时关闭连接
            jedis.close();
        }
    }
}
package feature.order.dao.impl;

import feature.bid.vo.BidOrderDetailVo;
import feature.bid.vo.BidOrderVo;
import feature.item.vo.ItemClass;
import feature.order.vo.ItemOrderDetailVO;
import org.hibernate.Session;
import feature.order.dao.ItemOrderDAO;
import feature.order.vo.ItemOrderVO;
import org.hibernate.query.Query;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.util.List;

public class ItemOrderDAOImpl implements ItemOrderDAO {
//    private static DataSource ds = null;
//
//    static {
//        try {
//            Context ctx = new InitialContext();
//            ds = (DataSource) ctx.lookup("java:comp/env/jdbc/polybrain");
//        } catch (NamingException e) {
//            e.printStackTrace();
//        }
//    }

    public Integer insert(ItemOrderVO itemOrderVO) {
        getSession().persist(itemOrderVO);
        return itemOrderVO.getOrderNo();
    }

    public Integer deleteById(Integer orderNo) {
        Session session = getSession();
        ItemOrderVO pojo = session.get(ItemOrderVO.class, orderNo);
        session.remove(pojo);
        return 1;
    }

    public Integer deleteDetailById(Integer orderNo) {
        Session session = getSession();
        ItemOrderVO pojo = session.get(ItemOrderVO.class, orderNo);
        session.remove(pojo);
        return 1;
    }

    public Integer update(ItemOrderVO itemOrderVO) {
        return null;
    }

    public ItemOrderVO selectById(Integer orderNo) {
        return getSession().get(ItemOrderVO.class, orderNo);
    }

    @Override
    public List<ItemOrderVO> selectAll() {
        final String hql = "FROM ItemOrderVO ORDER BY ORDER_NO";
        return getSession().createQuery(hql, ItemOrderVO.class).getResultList();

    }


    public List<ItemOrderVO> selectByMemberNumber(Integer memNo) {
        final String hql = "FROM ItemOrderVO WHERE MEM_NO =" + memNo + "ORDER BY ORDER_NO";
        return getSession().createQuery(hql, ItemOrderVO.class).getResultList();
    }

    public ItemOrderVO updateAnOrder(ItemOrderVO itemordervo) {
        getSession().update(itemordervo);
        return itemordervo;
    }

    public void insertAnDetail(ItemOrderDetailVO itemOrderDetailVO) {
        getSession().persist(itemOrderDetailVO);
        System.out.println("新增訂單明細成功");
    }

    @Override
    public List<ItemOrderDetailVO> getDetailByOrderNumber(Integer orderNo) {
        final String hql = "FROM ItemOrderDetailVO WHERE order_No =" + orderNo + "ORDER BY ITEM_NO";
        return getSession().createQuery(hql, ItemOrderDetailVO.class).getResultList();
    }

    public List<BidOrderDetailVo> findBidOrderDetailsByMemNo(Integer memNo) {
        String hql = "FROM BidOrderDetailVo bod WHERE bod.bidOrderVo.memNo = :memNo";
        Query<BidOrderDetailVo> query = getSession().createQuery(hql, BidOrderDetailVo.class);
        return query.setParameter("memNo", memNo).getResultList();
    }

    public Integer insertBidOrderDetail(BidOrderDetailVo bidOrderDetailVo) {
        getSession().persist(bidOrderDetailVo);
        return 1 ;
    }
    public List<BidOrderDetailVo> selectBidOrder() {
        final String hql = "FROM BidOrderDetailVo ORDER BY bod_no";
        return getSession().createQuery(hql, BidOrderDetailVo.class).getResultList();
    }


    public static void main(String[] args) {
        BidOrderDetailVo bidOrderDetailVo = new BidOrderDetailVo();
        bidOrderDetailVo.setBidOrderNo(7002);
        bidOrderDetailVo.setReceiverPhone("0960888888");
        bidOrderDetailVo.setReceiverMethod(0);
        bidOrderDetailVo.setReceiverAddress("你要改喔");
        bidOrderDetailVo.setReceiverName("這麼狠喔");

        new ItemOrderDAOImpl().insertBidOrderDetail(bidOrderDetailVo);
    }
}

package feature.mem.dao;
import feature.mem.vo.MemVo;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import core.util.HibernateUtil;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.jetbrains.annotations.NotNull;

import javax.servlet.ServletException;
import java.util.List;

public class MemDaoImpl implements MemDao {

    Session session = HibernateUtil.getSessionFactory().getCurrentSession();

    public Integer insert(MemVo memVo) {
        return (Integer) session.save(memVo);
    }

    public Integer deleteById(Integer memNo) {
        MemVo memVo = session.get(MemVo.class, memNo);
        session.remove(memVo);
        return -1;
    }

    public Integer update(MemVo memVo) {
        try {
            session.merge(memVo);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }


    public MemVo selectById(Integer memNo) {
        return session.get(MemVo.class, memNo);
    }

    public boolean updateById(@NotNull MemVo newMemVo) {
        MemVo oldMemVO = session.get(MemVo.class, newMemVo.getMemNo());
        try {
            final String name = newMemVo.getMemName();
            if (name != null) {
                oldMemVO.setMemName(name);
            }
            final Byte[] pic = newMemVo.getMemPic();
            if (pic != null) {
                oldMemVO.setMemPic(pic);
            }
            final String email = newMemVo.getMemEmail();
            if (email != null) {
                oldMemVO.setMemEmail(email);
            }
            final String password = newMemVo.getMemPwd();
            if (password != null) {
                oldMemVO.setMemPwd(password);
            }
            final String phone = newMemVo.getMemPh();
            if (phone != null) {
                oldMemVO.setMemPh(phone);
            }
            final String address = newMemVo.getMemAddress();
            if (address != null) {
                oldMemVO.setMemAddress(address);
            }
            final Byte authority = newMemVo.getMemAuth();
            if (authority != null) {
                oldMemVO.setMemAuth(authority);
            }
            final Byte violation = newMemVo.getMemVio();
            if (violation != null) {
                oldMemVO.setMemVio(violation);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<MemVo> selectAll() {
        final String hql = "FROM MemVo ORDER BY memNo";
        return session.createQuery(hql, MemVo.class).getResultList();
    }

    public MemVo selectByMemName(String memName) {
        final String hql = "FROM MemVo WHERE memName = :memName";
        return session.createQuery(hql, MemVo.class)
                .setParameter("memName", memName)
                .uniqueResult();
    }

    public MemVo selectForLogin(String memEmail, String memPwd) {
        final String sql = "select * from MEMBER where MEM_EMAIL = :memEmail and MEM_PWD = :memPwd";

        return session
                .createNativeQuery(sql, MemVo.class)
                .setParameter("memEmail", memEmail)
                .setParameter("memPwd", memPwd)
                .uniqueResult();
    }

    public List<MemVo> selectByVio(MemVo memVo) {
        final String sql = "select * from MEMBER where MEM_VIO = 3";
        return session
                .createNativeQuery(sql, MemVo.class)
                .getResultList();
    }


    @Override
    public void createMember(MemVo member) {
            session.save(member);
    }

    @Override
    public MemVo getMemberById(Integer memNo) {
        return session.get(MemVo.class, memNo);
    }

    @Override
    public void updateMember(MemVo member) {
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(member);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMember(Integer memNo) {
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            MemVo member = session.get(MemVo.class, memNo);
            if (member != null) {
                session.delete(member);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public List<MemVo> getAllMembers() {
        try {
            String hql = "FROM MemVo";
            Query<MemVo> query = session.createQuery(hql, MemVo.class);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public MemVo selectByMemEmailAndPwd(String memEmail, String memPwd) {
        final String hql = "FROM MemVo WHERE memEmail = :memEmail AND memPwd = :memPwd ORDER BY memNo";
        return session
                .createQuery(hql, MemVo.class)
                .setParameter("memEmail", memEmail)
                .setParameter("memPwd", memPwd)
                .uniqueResult();
    }


    public void closeSession() {
        if (session != null && session.isOpen()) {
            session.close();
        }
    }












































    String driver = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/polybrain_new?serverTimezone=Asia/Taipei";
    String userid = "root";
    String passwd = "asd347asd";
    private static DataSource ds = null;
    static {
        try {
            Context ctx = new InitialContext();
            ds = (DataSource) ctx.lookup("java:comp/env/jdbc/polybrain_new");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }


    private static final String GET_ALL_MEM =  //查詢全部會員資料(不包含照片、密碼、性別、黑名單)
            "SELECT MEM_NO,MEM_NAME,MEM_PID,MEM_EMAIL,MEM_PH,MEM_ADDRS,MEM_BIRTH,MEM_AUTH FROM member order by MEM_NO";
    private static final String GET_ONE_MEM =  //查詢全部會員資料(不包含照片、密碼、性別、黑名單)
            "SELECT MEM_NO,MEM_NAME,MEM_PID,MEM_EMAIL,MEM_PH,MEM_ADDRS,MEM_BIRTH,MEM_AUTH FROM member where MEM_NO = ?";
    private static final String DELETE =         //透過編號刪除
            "DELETE FROM member where MEM_NO = ?";
    private static final String UPDATE =         //透過編號更新資料
            "UPDATE member set MEM_NAME=?, MEM_PID=?, MEM_EMAIL=?, MEM_PH=?, MEM_ADDRS=?, MEM_BIRTH=?, MEM_AUTH=? where MEM_NO = ?";

    private static final String GET_Email_PWD =
            "SELECT MEM_EMAIL,MEM_PWD FROM member";

    private static final String GET_EMAIL =
            "SELECT MEM_EMAIL FROM member";
    private static final String GET_PID =
            "SELECT MEM_PID FROM member";
    private static final String GET_PHONE =
            "SELECT MEM_PH FROM member";
    private static final String REGIST=
            "INSERT INTO member (MEM_NAME, MEM_PID, MEM_GENDER, MEM_EMAIL, MEM_PWD, MEM_PH, MEM_ADDRS, MEM_BIRTH) " +
                    "VALUES (?,?,?,?,?,?,?,?)";

    private static final String GET_ALL_BY_MEMNO =
            "SELECT MEM_NO,MEM_NAME,MEM_EMAIL,MEM_PH,MEM_PWD,MEM_PID,MEM_ADDRS,MEM_BIRTH,MEM_GENDER FROM member where MEM_NO = ?";

    private static final String updateInformation =         //透過編號更新資料
            "UPDATE member set MEM_NAME=?, MEM_EMAIL=?, MEM_PH=?, MEM_PWD=? , MEM_PID=?, MEM_ADDRS=?, MEM_BIRTH=?, MEM_GENDER=? where MEM_NO = ?";




    @Override
    public List<MemVo> getAll() {
        List<MemVo> list = new ArrayList<MemVo>();
        MemVo memVo = null;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_ALL_MEM);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                // empVO 也稱為 Domain objects
                memVo = new MemVo();
                memVo.setMemNo(rs.getInt("MEM_NO"));
                memVo.setMemName(rs.getString("MEM_NAME"));
                memVo.setMemPid(rs.getString("MEM_PID"));
                memVo.setMemEmail(rs.getString("MEM_EMAIL"));
                memVo.setMemPh(rs.getString("MEM_PH"));
                memVo.setMemAddress(rs.getString("MEM_ADDRS"));
                memVo.setMemBirth(rs.getDate("MEM_BIRTH"));
                memVo.setMemAuth(rs.getByte("MEM_AUTH"));
                list.add(memVo); // Store the row in the list
            }

            // Handle any driver errors
        } catch (SQLException se) {
            throw new RuntimeException("A database error occured. "
                    + se.getMessage());
            // Clean up JDBC resources
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }

        }
        return list;
    }

    @Override
    public MemVo findByPrimaryKey(Integer memNo) {

        MemVo memVo = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_ONE_MEM);
            pstmt.setInt(1, memNo);
            rs = pstmt.executeQuery();

            while (rs.next()) {

                memVo = new MemVo();
                memVo.setMemNo(rs.getInt("MEM_NO"));
                memVo.setMemName(rs.getString("MEM_NAME"));
                memVo.setMemPid(rs.getString("MEM_PID"));
                memVo.setMemEmail(rs.getString("MEM_EMAIL"));
                memVo.setMemPh(rs.getString("MEM_PH"));
                memVo.setMemAddress(rs.getString("MEM_ADDRS"));
                memVo.setMemBirth(rs.getDate("MEM_BIRTH"));
                memVo.setMemAuth(rs.getByte("MEM_AUTH"));
            }

            // Handle any driver errors
        } catch (SQLException | ClassNotFoundException se) {
            throw new RuntimeException("A database error occured. "
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }
        return memVo;
    }

    @Override
    public void delete(Integer memNo) {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(DELETE);

            pstmt.setInt(1, memNo);

            pstmt.executeUpdate();

            // Handle any driver errors
        } catch (SQLException | ClassNotFoundException se) {
            throw new RuntimeException("A database error occured. "
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }

    }



    @Override
    public void updateJDBC(MemVo memVo) {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(UPDATE);


            pstmt.setString(1, memVo.getMemName());
            pstmt.setString(2, memVo.getMemPid());
            pstmt.setString(3, memVo.getMemEmail());
            pstmt.setString(4, memVo.getMemPh());
            pstmt.setString(5, memVo.getMemAddress());
            pstmt.setDate(6, memVo.getMemBirth());
            pstmt.setInt(7, memVo.getMemAuth());
            pstmt.setInt(8, memVo.getMemNo());

            pstmt.executeUpdate();

            // Handle any driver errors
        } catch (SQLException | ClassNotFoundException se) {
            throw new RuntimeException("A database error occured. "
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }

    }

    @Override
    public List<MemVo> GETEmailPwd(){
        List<MemVo> list = new ArrayList<MemVo>();
        MemVo memVo = null;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_Email_PWD);
            rs = pstmt.executeQuery();


            while (rs.next()) {
                memVo = new MemVo();
                memVo.setMemEmail(rs.getString("MEM_EMAIL"));
                memVo.setMemPwd(rs.getString("MEM_PWD"));
                list.add(memVo);
            }
        }catch (SQLException | ClassNotFoundException e) {
            // 處理數據庫錯誤
            e.printStackTrace();
        } finally {
            // 關閉資源，釋放連接
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return list;
    }

    @Override
    public boolean isEmailExists(String email) {


        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        boolean exists = false;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_EMAIL);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String storedEmail = rs.getString("MEM_EMAIL");
                if (email.equals(storedEmail)) {
                    exists = true;
                    break;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            // 關閉連接、PreparedStatement 和 ResultSet
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return exists;
    }



    @Override
    public boolean isPidExists(String pid) {


        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        boolean exists = false;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_PID);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String storedEmail = rs.getString("MEM_PID");
                if (pid.equals(storedEmail)) {
                    exists = true;
                    break;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            // 關閉連接、PreparedStatement 和 ResultSet
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return exists;
    }


    @Override
    public boolean isPhoneExists(String phone) {


        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        boolean exists = false;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_PHONE);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String storedEmail = rs.getString("MEM_PH");
                if (phone.equals(storedEmail)) {
                    exists = true;
                    break;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            // 關閉連接、PreparedStatement 和 ResultSet
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return exists;
    }


    @Override
    public void createMemberJDBC(MemVo member) {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(REGIST);

            pstmt.setString(1, member.getMemName());
            pstmt.setString(2, member.getMemPid());
            pstmt.setByte(3, member.getMemGender());
            pstmt.setString(4, member.getMemEmail());
            pstmt.setString(5, member.getMemPwd());
            pstmt.setString(6, member.getMemPh());
            pstmt.setString(7, member.getMemAddress());
            pstmt.setDate(8, member.getMemBirth());

            pstmt.executeUpdate();

            // Handle any driver errors
        } catch (SQLException | ClassNotFoundException se) {
            throw new RuntimeException("A database error occured. "
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }

    }

    @Override
    public void updateInformation(MemVo memVo) {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(updateInformation);


            pstmt.setString(1, memVo.getMemName());
            pstmt.setString(2, memVo.getMemEmail());
            pstmt.setString(3, memVo.getMemPh());
            pstmt.setString(4, memVo.getMemPwd());
            pstmt.setString(5, memVo.getMemPid());
            pstmt.setString(6, memVo.getMemAddress());
            pstmt.setDate(7, memVo.getMemBirth());
            pstmt.setInt(8, memVo.getMemGender());
            pstmt.setInt(9, memVo.getMemNo());

            pstmt.executeUpdate();

            // Handle any driver errors
        } catch (SQLException | ClassNotFoundException se) {
            throw new RuntimeException("A database error occured. "
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }

    }


    @Override
    public MemVo getMemberByMemNo(Integer memNo) {

        MemVo memVo = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_ALL_BY_MEMNO);
            pstmt.setInt(1, memNo);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                memVo = new MemVo();
                memVo.setMemNo(rs.getInt("MEM_NO"));
                memVo.setMemName(rs.getString("MEM_NAME"));
                memVo.setMemEmail(rs.getString("MEM_EMAIL"));
                memVo.setMemPh(rs.getString("MEM_PH"));
                memVo.setMemPwd(rs.getString("MEM_PWD"));
                memVo.setMemPid(rs.getString("MEM_PID"));
                memVo.setMemAddress(rs.getString("MEM_ADDRS"));
                memVo.setMemBirth(rs.getDate("MEM_BIRTH"));
                memVo.setMemGender(rs.getByte("MEM_GENDER"));
            }

            // Handle any driver errors
        } catch (SQLException | ClassNotFoundException se) {
            throw new RuntimeException("A database error occured. "
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }
        return memVo;
    }

























}

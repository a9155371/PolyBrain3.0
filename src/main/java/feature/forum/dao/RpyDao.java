package feature.forum.dao;

import feature.forum.vo.ArtVo;
import feature.forum.vo.RpyVo;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RpyDao implements RpyDaoImpl {
    private  static DataSource ds =null;
    static {
        try {
            Context ctx =new InitialContext();
            ds =(DataSource) ctx.lookup("java:comp/env/jdbc/polybrain");

        }catch (NamingException e){
            e.printStackTrace();
        }
    }
    private static final String INSERT_STMT =
            "INSERT INTO reply (ARTICLE_NO,MEM_NO,REPLY_CONTENT,REPLY_STATE,REPLY_TIME) VALUES (?, ?, ?, 1, NOW())";
    private static final String GET_ALL_STMT =
            "SELECT REPLY_NO,MEM_NO,ARTICLE_NO,REPLY_CONTENT,REPLY_TIME,REPLY_STATE FROM reply order by REPLY_NO";
    private static final String GET_ONE_STMT =
            "SELECT  REPLY_NO,MEM_NO,ARTICLE_NO,REPLY_CONTENT,REPLY_TIME,REPLY_STATE FROM reply where REPLY_NO = ?";
    private static final String GET_ONE_ART =
            "SELECT REPLY_NO,MEM_NO,REPLY_CONTENT,REPLY_TIME,REPLY_STATE,ARTICLE_NO FROM reply where ARTICLE_NO = ?";
    private static final String DELETE =
            "DELETE FROM reply where REPLY_NO = ?";
    private static final String UPDATE =
            "UPDATE reply set ARTICLE_NO=?, MEM_NO=?, REPLY_CONTENT=?, REPLY_STATE=1  where REPLY_NO = ?";

    @Override
    public void insert(RpyVo rpyvo) {
        Connection con =null;
        PreparedStatement pstmt =null;

        try {
            con = ds.getConnection();
            pstmt = con.prepareStatement(INSERT_STMT);

            pstmt.setInt(1, rpyvo.getArtNo());
            pstmt.setInt(2,rpyvo.getMemNo());
            pstmt.setString(3, rpyvo.getRpyCon());


            pstmt.executeUpdate();

        }catch (SQLException e) {
            throw new RuntimeException("A database error occurred. "
                    + e.getMessage());
        }finally {
            if(pstmt !=null){
                try {
                    pstmt.close();
                }catch (SQLException e){
                    e.printStackTrace(System.err);
                }
            }
            if(con !=null){
                try {
                    con.close();
                }catch (Exception e){
                    e.printStackTrace(System.err);
                }
            }
        }

    }



    @Override
    public void update(RpyVo rpyvo) {
        Connection con =null;
        PreparedStatement pstmt =null;

        try {
            con = ds.getConnection();
            pstmt = con.prepareStatement(UPDATE);

            pstmt.setInt(1,rpyvo.getArtNo());
            pstmt.setInt(2,rpyvo.getMemNo());
            pstmt.setString(3,rpyvo.getRpyCon());
            pstmt.setInt(4,rpyvo.getRpyNo());



            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("A database error occurred. "
                    + e.getMessage());
        }finally {
            if (pstmt != null){
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace(System.err);
                }
            }
            if (con !=null){
                try {
                    con.close();
                }catch (Exception e){
                    e.printStackTrace(System.err);
                }

            }
        }
    }


    @Override
    public void delete(Integer rpyNo) {
        Connection con =null;
        PreparedStatement pstmt =null;

        try {

            con = ds.getConnection();
            pstmt =con.prepareStatement(DELETE);

            pstmt.setInt(1,rpyNo);

            pstmt.executeUpdate();

        }  catch (SQLException e) {
            throw new RuntimeException("A database error occurred. "
                    + e.getMessage());
        }finally {
            if (pstmt != null){
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace(System.err);
                }
            }
            if (con !=null){
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace(System.err);
                }
            }
        }
    }

    @Override
    public RpyVo findByPrimaryKey(Integer rpyNo) {
        RpyVo rpyVo =null;
        Connection con =null;
        PreparedStatement pstmt =null;
        ResultSet rs =null;

        try {
            con =ds.getConnection();
            pstmt =con.prepareStatement(GET_ONE_STMT);

            pstmt.setInt(1,rpyNo);

            rs =pstmt.executeQuery();

            while (rs.next()) {
                rpyVo = new RpyVo();
                rpyVo.setRpyNo(rs.getInt("REPLY_NO"));
                rpyVo.setMemNo(rs.getInt("MEM_NO"));
                rpyVo.setArtNo(rs.getInt("ARTICLE_NO"));
                rpyVo.setRpyCon(rs.getString("REPLY_CONTENT"));
                rpyVo.setRpyTime(rs.getTimestamp("REPLY_TIME"));
                rpyVo.setRpyState(rs.getByte("REPLY_STATE"));
            }
        } catch (SQLException e) {
            throw new RuntimeException("A database error occurred. "
                    + e.getMessage());
        }finally {
            if(rs !=null){
                try {
                    rs.close();
                }catch (SQLException e){
                    e.printStackTrace(System.err);
                }
            }
            if (pstmt !=null){
                try {
                    pstmt.close();
                }catch (SQLException e){
                    e.printStackTrace(System.err);
                }
            }
            if (con !=null){
                try {
                    con.close();
                }catch (Exception e){
                    e.printStackTrace(System.err);
                }
            }
        }
        return rpyVo;
    }


    @Override
    public List<RpyVo> getAll() {
        List<RpyVo> list =new ArrayList<RpyVo>();
        RpyVo rpyVo = null ;

        Connection con =null;
        PreparedStatement pstmt =null;
        ResultSet rs =null;

        try {
            con =ds.getConnection();
            pstmt =con.prepareStatement(GET_ALL_STMT);
            rs =pstmt.executeQuery();

            while (rs.next()) {
                rpyVo = new RpyVo();
                rpyVo.setRpyNo(rs.getInt("REPLY_NO"));
                rpyVo.setMemNo(rs.getInt("MEM_NO"));
                rpyVo.setArtNo(rs.getInt("ARTICLE_NO"));
                rpyVo.setRpyCon(rs.getString("REPLY_CONTENT"));
                rpyVo.setRpyTime(rs.getTimestamp("REPLY_TIME"));
                rpyVo.setRpyState(rs.getByte("REPLY_STATE"));
                list.add(rpyVo);
            }
        } catch (SQLException e) {
            throw new RuntimeException("A database error occurred. "
                    + e.getMessage());
        }finally {
            if(rs !=null){
                try {
                    rs.close();
                }catch (SQLException e){
                    e.printStackTrace(System.err);
                }
            }
            if (pstmt !=null){
                try {
                    pstmt.close();
                }catch (SQLException e){
                    e.printStackTrace(System.err);
                }
            }
            if (con !=null){
                try {
                    con.close();
                }catch (Exception e){
                    e.printStackTrace(System.err);
                }
            }
        }
        return list;
    }


    @Override
    public List<RpyVo> findByArt(Integer artNo) {
        List<RpyVo> list = new ArrayList<RpyVo>();
        RpyVo rpyVo = null;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = ds.getConnection();
            pstmt = con.prepareStatement(GET_ONE_ART);

            pstmt.setInt(1, artNo);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                rpyVo = new RpyVo();
                rpyVo.setRpyNo(rs.getInt("REPLY_NO"));
                rpyVo.setMemNo(rs.getInt("MEM_NO"));
                rpyVo.setArtNo(rs.getInt("ARTICLE_NO"));
                rpyVo.setRpyCon(rs.getString("REPLY_CONTENT"));
                rpyVo.setRpyTime(rs.getTimestamp("REPLY_TIME"));
                rpyVo.setRpyState(rs.getByte("REPLY_STATE"));
                list.add(rpyVo);
            }
        } catch (SQLException e) {
            throw new RuntimeException("A database error occurred. " + e.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace(System.err);
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace(System.err);
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
}

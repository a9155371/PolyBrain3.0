package feature.emp.dao;

import feature.emp.vo.EmpVo;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpListDao implements EmpListDaoImpl{
    String driver = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/polybrain?serverTimezone=Asia/Taipei";
    String userid = "root";
    String passwd = "06494784";

    private static DataSource ds = null;
    static {
        try {
            Context ctx = new InitialContext();
            ds = (DataSource) ctx.lookup("java:comp/env/jdbc/polybrain");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    private static final String GET_ALL_EMP =  //查詢全部員工資料(不包含照片)
            "SELECT EMP_NO,EMP_NAME,EMP_GENDER,EMP_EMAIL,EMP_PWD,EMP_PH,EMP_STATE FROM employee order by EMP_NO";

    private static final String GET_ONE_EMP =
            "SELECT EMP_NO,EMP_NAME,EMP_GENDER,EMP_EMAIL,EMP_PWD,EMP_PH,EMP_STATE FROM employee where EMP_NO = ?";

    private static final String DELETE =         //透過編號刪除
            "DELETE FROM employee where EMP_NO = ?";

    private static final String UPDATE =         //透過編號更新資料
            "UPDATE employee set EMP_NAME=?, EMP_GENDER=?, EMP_EMAIL=?, EMP_PWD=?, EMP_PH=?, EMP_STATE=? where EMP_NO = ?";

    private static final String REGIST=
            "INSERT INTO employee (EMP_NAME, EMP_GENDER, EMP_EMAIL, EMP_PWD, EMP_PH, EMP_STATE) " +
                    "VALUES (?,?,?,?,?,?)";


    public List<EmpVo> getAll() {
        List<EmpVo> list = new ArrayList<EmpVo>();
        EmpVo empVo = null;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_ALL_EMP);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                // empVO 也稱為 Domain objects
                empVo = new EmpVo();
                empVo.setEmpNo(rs.getInt("EMP_NO"));
                empVo.setEmpName(rs.getString("EMP_NAME"));
                empVo.setEmpGender(rs.getByte("EMP_GENDER"));
                empVo.setEmpEmail(rs.getString("EMP_EMAIL"));
                empVo.setEmpPwd(rs.getString("EMP_PWD"));
                empVo.setEmpPh(rs.getString("EMP_PH"));
                empVo.setEmpState(rs.getByte("EMP_STATE"));
                list.add(empVo); // Store the row in the list
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
    public EmpVo findByPrimaryKey(Integer empNo) {

        EmpVo empVo = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_ONE_EMP);
            pstmt.setInt(1, empNo);
            rs = pstmt.executeQuery();

            while (rs.next()) {

                empVo = new EmpVo();
                empVo.setEmpNo(rs.getInt("EMP_NO"));
                empVo.setEmpName(rs.getString("EMP_NAME"));
                empVo.setEmpGender(rs.getByte("EMP_GENDER"));
                empVo.setEmpEmail(rs.getString("EMP_EMAIL"));
                empVo.setEmpPwd(rs.getString("EMP_PWD"));
                empVo.setEmpPh(rs.getString("EMP_PH"));
                empVo.setEmpState(rs.getByte("EMP_STATE"));
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
        return empVo;
    }

    @Override
    public void delete(Integer empNo) {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(DELETE);

            pstmt.setInt(1, empNo);

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
    public void update(EmpVo empVo) {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {

            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(UPDATE);

            pstmt.setString(1, empVo.getEmpName());
            pstmt.setByte(2, empVo.getEmpGender());
            pstmt.setString(3, empVo.getEmpEmail());
            pstmt.setString(4, empVo.getEmpPwd());
            pstmt.setString(5, empVo.getEmpPh());
            pstmt.setByte(6, empVo.getEmpState());
            pstmt.setInt(7, empVo.getEmpNo());


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

    public void createEmp(EmpVo emp) {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(REGIST);

            pstmt.setString(1, emp.getEmpName());
            pstmt.setByte(2, emp.getEmpGender());
            pstmt.setString(3, emp.getEmpEmail());
            pstmt.setString(4, emp.getEmpPwd());
            pstmt.setString(5, emp.getEmpPh());
            pstmt.setByte(6, emp.getEmpState());


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


}

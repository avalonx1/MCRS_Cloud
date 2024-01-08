package Database;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author irwan
 */

import java.sql.*;
import javax.naming.*;
import javax.sql.*;


public class Database {
     private InitialContext inCtx;
     private DataSource ds;
     private String dbname;
     private Connection conn;
     private ResultSet rs;
     private PreparedStatement stmt;    
     private boolean isSelect = false;

    public Database() throws NamingException,SQLException{
        
        //ds = (DataSource)inCtx.lookup("java:/mondwh");
        
        
    }
    

    public Connection getConnection(){
        return conn;
    }

    public void connect(int dbid) throws NamingException,SQLException {
        
        inCtx = new InitialContext();
        if ( dbid==1 ) {
            dbname="MCRS-APP-DEV";
            //dbname ="MCRS-APP";
        }else if ( dbid==2 ){
            dbname="DWHPRD.BMIDWH";
        } else if ( dbid==3 ){
            dbname="UNK";
        }
            
        
        ds = (DataSource)inCtx.lookup(dbname);
        inCtx.close();
        conn = ds.getConnection();
        
    }

    public ResultSet executeQuery(String sql)throws SQLException {
        isSelect = true;
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        return rs;
    }

     public void executeUpdate(String sql)throws SQLException {
        isSelect = false;
        stmt = conn.prepareStatement(sql);
        stmt.executeUpdate();
    }

    public void close() throws SQLException {
        
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();  // return to pool
            if (conn != null) conn.close();  // return to pool
        
    }

}

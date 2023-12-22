/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Engines;
import java.sql.*;
import javax.naming.NamingException;
import Database.*;
import java.io.IOException;
        

/**
 *
 * @author irwan
 */
public class ReportTracking extends Database{
    public String ipAddr;
    
    
    public ReportTracking(String ip_addr) throws NamingException, SQLException{
        if (ip_addr.equals("127.0.0.1")){
            this.ipAddr="ADMIN";
            }else{
            this.ipAddr=ip_addr;
            }
        this.connect(1); 
        
    }
    
    
    public void updateRptDownload(int reportID,int userid,String filename )throws SQLException,NamingException, IOException
    {
            String sql;
            sql="update t_report_item set report_download=report_download+1 where id="+reportID+"  ";       
            executeUpdate(sql);
            
             String acctype="DOWNLOAD";
            sql = "insert into t_report_item_download_log ("
                    +"id, report_id,Access_code,created_userid,created_time,report_filename) "
                    +"values ( "
                    + "nextval('t_report_item_download_log_seq'),"
                    + ""+reportID+","
                    + "'"+acctype+"',"
                    + ""+userid+", "
                    + "CURRENT_TIMESTAMP, "
                    + "'"+filename+"' "
                    + " )";
             
             executeUpdate(sql);
            
            
    }
    
    public void updateRptView(int reportID,int userid,String filename )throws SQLException,NamingException, IOException
    {
            String sql;
            sql="update t_report_item set report_view=report_view+1 where id="+reportID+"  ";       
            executeUpdate(sql);
            
            String acctype="SWFVIEW";
            sql = "insert into t_report_item_download_log ("
                    +"id, report_id,Access_code,created_userid,created_time,report_filename) "
                    +"values ( "
                    + "nextval('t_report_item_download_log_seq'),"
                    + ""+reportID+","
                    + "'"+acctype+"',"
                    + ""+userid+", "
                    + "CURRENT_TIMESTAMP, "
                    + "'"+filename+"' "
                    + " )";
             
             executeUpdate(sql);
             
             
    }
    
    
    public int getPopularity(int reportID )throws SQLException,NamingException, IOException
    {
           String sql;
           ResultSet resultSet=null;
           int jmlPop=0;
           
            sql="select report_download+report_view jml from t_report_item where id="+reportID+"  ";
            try {
            resultSet = executeQuery(sql);
            while(resultSet.next()){
            jmlPop=resultSet.getInt(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            
            return jmlPop;
    }
    
    
}




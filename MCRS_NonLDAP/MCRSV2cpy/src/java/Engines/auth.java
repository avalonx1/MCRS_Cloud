/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Engines;
import java.sql.*;
import javax.naming.NamingException;
import Database.*;
import java.io.IOException;
import java.security.SecureRandom;
        

/**
 *
 * @author irwan
 */
public class auth extends Database{

    /**
     *
     */
    public String ipAddr;

static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
static SecureRandom rnd = new SecureRandom();

    /**
     *
     * @param ip_addr
     * @throws NamingException
     * @throws SQLException
     */
    public auth(String ip_addr) throws NamingException, SQLException{
        if (ip_addr.equals("127.0.0.1")){
            this.ipAddr="ADMIN";
//            }else{
//            this.ipAddr=ip_addr;
            }
        this.connect(1); 
        
    }
    
    /**
     *
     * @throws NamingException
     * @throws SQLException
     */
    public auth() throws NamingException, SQLException{
        this.connect(1);
    }

    /**
     *
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public int isMaintenance()throws SQLException,NamingException
    {
            int stat_maintenance=0;
            String IP_Admin="";
            String query;
            ResultSet resultSet=null;
            try {
            query="select a.value stat_maintenance,b.value ip from t_param a join t_param b on a.name='stat_maintenance' and b.name='ip_admin'";
            resultSet = executeQuery(query);
            while(resultSet.next()){
            stat_maintenance=resultSet.getInt(1);
            IP_Admin=resultSet.getString(2);
            }
            
            } finally {
            if (resultSet != null) resultSet.close();
            }
            
            
            String IP_client=ipAddr;
            if(stat_maintenance==1 && (!IP_Admin.equalsIgnoreCase(IP_client)) && !IP_client.equalsIgnoreCase("127.0.0.1") ){
                return 1;
                }else{
                return 0;
                }
    }

    /**
     *
     * @param userid
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public int getHomescreenNotifStat(String userid)throws SQLException,NamingException
    {
            int result=0;
            String query;
            ResultSet resultSet=null;
            query="select homescreen_notif from t_user where id='"+userid+"'  ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            result=resultSet.getInt(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return result;        
    }
    
    /**
     *
     * @param userid
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public int getFirstTimeLoginStat(String userid)throws SQLException,NamingException
    {
            int result=0;
            String query;
            ResultSet resultSet=null;
            query="select first_time_login from t_user where id='"+userid+"'  ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            result=resultSet.getInt(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return result;        
    }
    
    /**
     *
     * @param userid
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public int getNDAConfirmedStat(String userid)throws SQLException,NamingException
    {
            int result=0;
            String query;
            ResultSet resultSet=null;
            query="select nda_confirmed from t_user where id='"+userid+"'  ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            result=resultSet.getInt(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return result;        
    }
    
    /**
     *
     * @param userid
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public int getChangePasswdNotifStat(String userid)throws SQLException,NamingException
    {
           int result=0;
            String query;
            ResultSet resultSet=null;
            query="select change_paswd_notif from t_user where id='"+userid+"'  ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
             result=resultSet.getInt(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return result;          
    }
    
    /**
     *
     * @param userid
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public String getName(String userid)throws SQLException,NamingException
    {
            String user="unknown";
            String query;
            ResultSet resultSet=null;
            query="select first_name||' '||last_name from t_user where id='"+userid+"'  ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            user=resultSet.getString(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return user;        
    }
    
    /**
     *
     * @param userid
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public String getIPAddr(String userid)throws SQLException,NamingException
    {
            String result="unknown";
            String query;
            ResultSet resultSet=null;
            query="select ip_address from t_user where id='"+userid+"'  ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            result=resultSet.getString(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return result;        
    }
     
    /**
     *
     * @param userid
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public String getRemoteHost(String userid)throws SQLException,NamingException
    {
            String result="unknown";
            String query;
            ResultSet resultSet=null;
            query="select remote_host from t_user where id='"+userid+"'  ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            result=resultSet.getString(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return result;        
    }
    
    /**
     *
     * @param paramName
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public String getParamValue( String paramName)throws SQLException,NamingException
    {
            String paramValue="UNK";
            String query;
            ResultSet resultSet=null;
            query="select value from t_param where name='"+paramName+"'";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            paramValue=resultSet.getString(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return paramValue;        
    }
    
    /**
     *
     * @param url
     * @param usr_lev
     * @param usr_group
     * @param modul
     * @param appName
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public String geturltree(String url,String usr_lev, String usr_group, String modul, String appName)throws SQLException,NamingException
    {
            String idtree="notree";
            
            String query;
            ResultSet resultSet=null;
            query="select menu_id from v_menu_matrix where user_group_id="+usr_group+" and user_level_id="+usr_lev+" and modul="+modul+" and url=substring('"+url+"' from char_length('"+appName+"')+2 for char_length(url) ) ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            idtree=resultSet.getString(1);
            }
                               
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return idtree;        
    }
    
    /**
     *
     * @param rptid
     * @param usrid
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public int isEligibleAccessReport(String rptid,String usrid)throws SQLException,NamingException
    {
            int vstatus=0;
            
            String query;
            ResultSet resultSet=null;
            query="select count(1) from t_report_item a, t_report_permission_matrix b, t_user c, t_user_level d, t_user_group e " +
                    "where a.id=b.report_id and b.user_group_id=e.id and b.user_level_id=d.id and  c.level_id=d.id and c.group_id=e.id and a.id="+rptid+" and c.id="+usrid+" ";
            
            
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            vstatus=resultSet.getInt(1);
            }
                               
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            
            if (vstatus==0) {
            System.out.println("tidak eligible akses report : Reportid: "+rptid+";UserID : "+usrid);
                
            }
            
            return vstatus;        
    }
    
    /**
     *
     * @param rptid
     * @param usrid
     * @param vTanggal
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public String getFullPathReport(String rptid,String usrid,String vTanggal)throws SQLException,NamingException
    {
            String vFullPath="0";
            
            String vBasePath=getParamValue("DOK_DIR_PATH");
            String query;
            ResultSet resultSet=null;
            query="select "+vBasePath+"'/'"+vTanggal+"||c.group_code||'/RPT_'||a.report_code||'_"+vTanggal+"_'|| from t_report_item a, t_report_permission_matrix b, t_user c, t_user_level d, t_user_group e " +
                    "where a.id=b.report_id and b.user_group_id=e.id and b.user_level_id=d.id and  c.level_id=d.id and c.group_id=e.id and c.id="+rptid+" and a.id="+usrid+" ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            vFullPath=resultSet.getString(1);
            }
                               
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return vFullPath;        
    }
      
    /**
     *
     * @param rptid
     * @param usrid
     * @param vTanggal
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public String getFilename(String rptid,String usrid,String vTanggal)throws SQLException,NamingException
    {
            String vFullPath="0";
            
            String vBasePath=getParamValue("DOK_DIR_PATH");
            String query;
            ResultSet resultSet=null;
            query="select RPT_'||a.report_code||'_"+vTanggal+"_'|| from t_report_item a, t_report_permission_matrix b, t_user c, t_user_level d, t_user_group e " +
                    "where a.id=b.report_id and b.user_group_id=e.id and b.user_level_id=d.id and  c.level_id=d.id and c.group_id=e.id and c.id="+rptid+" and a.id="+usrid+" ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            vFullPath=resultSet.getString(1);
            }
                               
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return vFullPath;        
    }
    
    /**
     *
     * @param branchID
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public String getCabangNameByID( int branchID)throws SQLException,NamingException
    {
            String returnValue="";
            String query;
            ResultSet resultSet=null;
            query="select branch_code from T_BRANCH " +
                    "where id="+branchID;
                    
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            returnValue=resultSet.getString(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return returnValue;        
    }

    /**
     *
     * @param userid
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public int getFirstTimeLoginStatus(String userid)throws SQLException,NamingException
    {
            int user=0;
            String query;
            ResultSet resultSet=null;
            query="select first_time_login from t_user where id='"+userid+"'  ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            user=resultSet.getInt(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return user;        
    }
    
    /**
     *
     * @param userid
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public int getChangePasswdStatus(String userid)throws SQLException,NamingException
    {
            int user=0;
            String query;
            ResultSet resultSet=null;
            query="select change_paswd_notif from t_user where id='"+userid+"'  ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            user=resultSet.getInt(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return user;        
    }
    
    /**
     *
     * @param userid
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public int getNDAConfirmedStatus(String userid)throws SQLException,NamingException
    {
            int user=0;
            String query;
            ResultSet resultSet=null;
            query="select nda_confirmed from t_user where id='"+userid+"'  ";
            try {
            resultSet = executeQuery(query);
            while(resultSet.next()){
            user=resultSet.getInt(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            return user;        
    }
    
    /**
     *
     * @param fullpath
     * @param filename
     * @return
     * @throws SQLException
     * @throws NamingException
     * @throws IOException
     */
    public String execPDF2SWF(String fullpath,String filename)throws SQLException,NamingException, IOException
    {
            String extSWF="swf";
            
            String dirSWFViewer=getParamValue("DIR_SWF_VIEWER");
            String pdf2SwfScript=getParamValue("PDF2SWF_SCRIPT_FULLPATH");
            
            String targetSWFFilename=filename+"."+extSWF;
            
                    
            String unixCommand = "sh "+pdf2SwfScript+" "+fullpath+" "+dirSWFViewer+"/"+targetSWFFilename;
            Runtime rt = Runtime.getRuntime();
            rt.exec(unixCommand);
            System.out.println("Linux Command executed by "+ipAddr+" :  "+unixCommand);

            return targetSWFFilename;        
    }
     
    /**
     *
     * @param filename
     * @throws SQLException
     * @throws NamingException
     * @throws IOException
     */
    public void execCleanupPDF2SWF(String filename)throws SQLException,NamingException, IOException
    {
            String extSWF="swf";
            
            
            String dirSWFViewer=getParamValue("DIR_SWF_VIEWER");
            String pdf2SwfScript=getParamValue("PDF2SWF_CLEANUP_SCRIPT_FULLPATH");
            String targetSWFFilename=filename+"."+extSWF;
                    
            String unixCommand = "sh "+pdf2SwfScript+" "+dirSWFViewer+"/"+targetSWFFilename;
            Runtime rt = Runtime.getRuntime();
            rt.exec(unixCommand);
            System.out.println("Linux Command executed "+ipAddr+" :  "+unixCommand);

            
    }
      
    /**
     *
     * @param id
     * @throws SQLException
     * @throws NamingException
     * @throws IOException
     */
    public void execRunDsJob(String id)throws SQLException,NamingException, IOException
    {
            
            String runScript=getParamValue("RUNDSJOB_SCRIPT_JNRLADJ");
            String runScriptRemote=getParamValue("RUNDSJOB_SCRIPT_JNRLADJ_DS");
            String ENV=getParamValue("RUNDSJOB_ENV");
            String JOBNAME=getParamValue("RUNDSJOB_JOBNAME_JNRLADJ");
            String USERSSH=getParamValue("RUNDSJOB_USERSSH");
            String PWDSSH=getParamValue("RUNDSJOB_PWDSSH");
            String HOSTSSH=getParamValue("RUNDSJOB_HOSTSSH");
            
                    
            String unixCommand = "sh "+runScript+" "+USERSSH+" "+PWDSSH+" "+HOSTSSH+" "+id+" "+ENV+" "+JOBNAME+" "+runScriptRemote;

            Runtime rt = Runtime.getRuntime();
            rt.exec(unixCommand);
            System.out.println("Linux Command executed "+ipAddr+" :  "+unixCommand);

            
    }
       
    /**
     *
     * @param id
     * @param JOBNAME
     * @throws SQLException
     * @throws NamingException
     * @throws IOException
     */
    public void execRunDsJob(String id,String JOBNAME)throws SQLException,NamingException, IOException
    {
            
            String runScript=getParamValue("RUNDSJOB_SCRIPT_JNRLADJ");
            String runScriptRemote=getParamValue("RUNDSJOB_SCRIPT_JNRLADJ_DS");
            String ENV=getParamValue("RUNDSJOB_ENV");
            String USERSSH=getParamValue("RUNDSJOB_USERSSH");
            String PWDSSH=getParamValue("RUNDSJOB_PWDSSH");
            String HOSTSSH=getParamValue("RUNDSJOB_HOSTSSH");
            
                    
            String unixCommand = "sh "+runScript+" "+USERSSH+" "+PWDSSH+" "+HOSTSSH+" "+id+" "+ENV+" "+JOBNAME+" "+runScriptRemote;
            Runtime rt = Runtime.getRuntime();
            rt.exec(unixCommand);
            System.out.println("Linux Command executed "+ipAddr+" :  "+unixCommand);

            
    }
     
    /**
     *
     * @param filename
     * @return
     * @throws SQLException
     * @throws NamingException
     * @throws IOException
     */
    public String execDeleteFile(String filename)throws SQLException,NamingException, IOException
    {
            
            
            String dirDOC=getParamValue("DIR_FILE_UPLOAD");
            String delScript=getParamValue("DELFILE_SCRIPT_FULLPATH");
            
                    
            String unixCommand = "sh "+delScript+" "+dirDOC+" "+filename;
            Runtime rt = Runtime.getRuntime();
            rt.exec(unixCommand);
            System.out.println("Linux Command executed by "+ipAddr+" :  "+unixCommand);

            return unixCommand;        
    }
     
    /**
     *
     * @param len
     * @return
     */
    public String randomString( int len ){
           StringBuilder sb = new StringBuilder( len );
           for( int i = 0; i < len; i++ ) 
              sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
           return sb.toString();
        }
        
    /**
     *
     * @param username
     * @param randomPasswd
     * @return
     * @throws SQLException
     * @throws NamingException
     * @throws IOException
     */
    public String execForgetPasswdSendMail(String username,String randomPasswd )throws SQLException,NamingException, IOException
    {
            String msgResetForm="";
            String sql;
            
            sql="update t_user set change_paswd_notif=1 where username='"+username+"'  ";
            
            executeUpdate(sql);
            
            
            sql="update t_user set password=upper(md5('"+randomPasswd+"')) where username='"+username+"'  ";
            
            executeUpdate(sql);
            
            String emailAddr="";
            ResultSet resultSet=null;
            sql="select email from t_user where username='"+username+"'  ";
            try {
            resultSet = executeQuery(sql);
            while(resultSet.next()){
            emailAddr=resultSet.getString(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            
            String sendMailScript=getParamValue("SENDMAIL_SCRIPT_FULLPATH");
            
            String unixCommand = "sh "+sendMailScript+" "+randomPasswd+" "+emailAddr+" "+username;
            Runtime rt = Runtime.getRuntime();
            rt.exec(unixCommand);
            System.out.println("Linux Command executed "+ipAddr+" :  "+unixCommand);

            msgResetForm="Reset Password Succes for username <b>"+username+"</b>, Please check your email at "+emailAddr+" ";
            
                    
            return msgResetForm;
            
            
    }
    
    /**
     *
     * @param pic_to
     * @param itemname
     * @param msgmail
     * @return
     * @throws SQLException
     * @throws NamingException
     * @throws IOException
     */
    public String execSendMailNotif(String pic_to,String itemname,String msgmail)throws SQLException,NamingException, IOException
    {
            String msg="default";
            String sql;
            String sendMailScript=getParamValue("SENDMAIL_SCRIPT_NOTIF_FULLPATH");
           
            String emailAddr="";
            String username="";
            String fullname="";
            String linkstat="1";
            
            ResultSet resultSet=null;
            try {
            
                sql="select username,email,first_name||' '||last_name fullname from t_user where id="+pic_to+"  ";
            
            resultSet = executeQuery(sql);
            while(resultSet.next()){
            username=resultSet.getString(1);
            emailAddr=resultSet.getString(2);
            fullname=resultSet.getString(3);
            }       
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            
            Runtime rt = Runtime.getRuntime();       
            rt.exec(new String[] {"sh", sendMailScript, emailAddr, fullname, itemname,msgmail,linkstat });
            //System.out.println("Linux Command executed "+ipAddr+" :  "+unixCommand);
            return msg;
            
    }
        
    /**
     *
     * @param email_to
     * @param name_to
     * @param itemname
     * @param msgmail
     * @return
     * @throws SQLException
     * @throws NamingException
     * @throws IOException
     */
    public String execSendMailNotifToRequester(String email_to,String name_to, String itemname,String msgmail)throws SQLException,NamingException, IOException
    {
            String msg="default"; 
            String sendMailScript=getParamValue("SENDMAIL_SCRIPT_NOTIF_FULLPATH");
            String emailAddr=email_to;
            String fullname=name_to;
            String linkstat="0";
            
            Runtime rt = Runtime.getRuntime();
            rt.exec(new String[] {"sh", sendMailScript, emailAddr, fullname, itemname,msgmail,linkstat });
            //System.out.println("Linux Command executed "+ipAddr+" :  "+unixCommand);
            return msg;
    }
    
    /**
     *
     * @param id
     * @return
     * @throws SQLException
     * @throws NamingException
     * @throws IOException
     */
    public String getItemName(String id)throws SQLException,NamingException, IOException
    {
            
            String sql;
            String itemname="";
            ResultSet resultSet=null;
            sql="select act_items_name from t_act_his where id="+id+"  ";
            try {
            resultSet = executeQuery(sql);
            while(resultSet.next()){
            itemname=resultSet.getString(1);
            }            
            
            } finally {
            if (resultSet != null) resultSet.close(); 
            }
            
            
            return itemname;
            
            
    }
    



}



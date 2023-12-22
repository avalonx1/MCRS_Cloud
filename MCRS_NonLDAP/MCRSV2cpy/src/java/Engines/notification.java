/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Engines;

import java.sql.*;
import javax.naming.NamingException;
import Database.*;

/**
 *
 * @author irwan
 */
public class notification extends Database {

    /**
     *
     * @throws NamingException
     * @throws SQLException
     */
    public notification() throws NamingException, SQLException {

        this.connect(1);
    }

    /**
     *
     * @param user_id
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public int isNewsActive(int user_id) throws SQLException, NamingException {
        int stat_news = 0;
         
        String query;
        ResultSet resultSet=null;
        query = "select count(1) from T_USER where id="+user_id+" and flag=1 and NOTIFICATION_MSG is not null ";
        try {
        resultSet = executeQuery(query);
        while (resultSet.next()) {
            stat_news = resultSet.getInt(1);
        }
        } finally {
            if (resultSet != null) resultSet.close(); 
        }
        
        
        if (stat_news == 1) {
            return 1;
        } else {
            return 0;
        }
        
    }

    /**
     *
     * @param user_id
     * @param group_id
     * @param level_id
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public String getMessage(int user_id,int group_id,int level_id) throws SQLException, NamingException {
        
        String news = " ";
        ResultSet resultSet = null;
        String query;
        
        
        try {
        query = "select 'Assalamualaikum, '||first_name||' '||last_name||' ' from T_USER where id="+user_id+" and flag=1 ";    
        resultSet = executeQuery(query);
        while (resultSet.next()) {
            news = resultSet.getString(1);
        }
        news += ".:: ";
        
        query = "select NOTIFICATION_MSG from T_USER where id="+user_id+" and flag=1";    
        resultSet = executeQuery(query);
        while (resultSet.next()) {
            news +=" "+resultSet.getString(1)+" ";
        }
        
        query = "select MESSAGE from t_notification "
                + "where (group_id="+group_id+" and level_id="+level_id+") "
                + "OR (group_id=0 and level_id="+level_id+") "
                + "OR  (group_id="+group_id+" and level_id=0)"
                + "OR  (group_id=0 and level_id=0) and status=1 order by inorder";    
        resultSet = executeQuery(query);
        while (resultSet.next()) {
            news += " "+resultSet.getString(1)+" ";
        }
        
         news += " ::. ";
        } finally {
            if (resultSet != null) resultSet.close(); 
        }
        
        return news;
    }

    /**
     *
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public String getMsgMaintenance() throws SQLException, NamingException {
        String news = " ";
        ResultSet resultSet = null;
        String query;
        query = "select value from t_param where name='msg_maintenance'";
        try {
        resultSet = executeQuery(query);
        while (resultSet.next()) {
            news = resultSet.getString(1);
        }
        } finally {
            if (resultSet != null) resultSet.close(); 
        }
        return news;
    }
    
    /**
     *
     * @return
     * @throws SQLException
     * @throws NamingException
     */
    public String getSpeedMarquee() throws SQLException, NamingException {
        String hasil = " ";
        ResultSet resultSet = null;
        String query;
        query = "select value from t_param where name='RUNNINGTEXT_SPEED'";
        try {
        resultSet = executeQuery(query);
        while (resultSet.next()) {
            hasil = resultSet.getString(1);
        }
        } finally {
            if (resultSet != null) resultSet.close(); 
        }
        return hasil;
    }
}

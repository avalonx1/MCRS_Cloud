/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Engines;

import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSessionEvent;

/**
 *
 * @author 20131254
 */
public class sessioncounter implements HttpSessionListener {
   
    
  private static int activeSessions = 0;

    /**
     *
     * @param se
     */
    @Override
  public void sessionCreated(HttpSessionEvent se) {
    activeSessions++;
  }

    /**
     *
     * @param se
     */
    @Override
  public void sessionDestroyed(HttpSessionEvent se) {
    if(activeSessions > 0)
      activeSessions--;
  }

    /**
     *
     * @return
     */
    public static int getActiveSessions() {
    return activeSessions;
  }
  
}

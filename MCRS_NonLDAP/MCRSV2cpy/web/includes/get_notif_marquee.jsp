<%@include file="check_auth_layer1.jsp"%>

<%

int user_id_int=Integer.parseInt(v_userID);
int user_gid_int=Integer.parseInt(v_userGroup);
int user_lid_int=Integer.parseInt(v_userLevel);

                notification notif = new notification();
                int stat_news=0;
                String msg="";
                String speed="20000";
                try {
                stat_news=notif.isNewsActive(user_id_int);
                msg=notif.getMessage(user_id_int,user_gid_int,user_lid_int);
                    speed=notif.getSpeedMarquee();
                    } catch (SQLException Sqlex) {
                    out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                    } finally {
                    notif.close();
                    
                    }
                    
                if (stat_news==1){
                    
                    
                    
                    
                    %>
               
                     
                    <script type="text/javascript">
                        $(document).ready(function() {
                           
                            $('#info_news').show();
                            
                             $('#info_news').marquee({
                            duration: <%=speed%>,
                            //gap in pixels between the tickers
                            gap: 50,
                            //time in milliseconds before the marquee will start animating
                            delayBeforeStart: 10,
                            //'left' or 'right'
                            direction: 'left',
                            //true or false - should the marquee be duplicated to show an effect of continues flow
                            duplicated: false,
                            pauseOnHover: true
                            });
                            

                        });
                        </script>
                        
                   
                                                  <%=msg%>
                   
                   
                   

                      <%
                      }else {
                        %><script type="text/javascript">
                        $(document).ready(function() {
                            $('#info_news').hide();
                        });
                        </script><%
                       
                    }
                    
%>
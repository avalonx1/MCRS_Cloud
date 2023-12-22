<%@include file="../../../includes/check_auth_layer_notif.jsp"%>
<%
    String notifcode = request.getParameter("notifcode");
    String act = request.getParameter("act");
    String notifcolumn = request.getParameter("notifcolumn");
    String addlinfo = request.getParameter("addlinfo");

    
    String userID = v_userID;
    String username = v_userName;
 
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
   
 
    if (act.equals("1")) {
            if (validate) {
                try {
                    ResultSet resultSet=null;
                    Database db = new Database();
                    try {

                        db.connect(1);
                        String sql;

                         sql = "update t_user SET "
                            +notifcolumn+"=0 "
                            +" where id="+userID;

                          db.executeUpdate(sql);


                          %><script> window.location.href="<%=v_mainPath%>"; </script><%

                    } catch (SQLException Sqlex) {
                        out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                    } finally {
                        db.close();
                        if (resultSet != null) resultSet.close(); 
                    }
                } catch (Exception except) {
                    out.println("<div class=sql>" + except.getMessage() + "</div>");
                }


            } else {
                out.println("<div class=alert>" + errorMessage + "</div>");
            }

    } else {
        %><script> window.location.href="<%=v_mainPath%>"; </script><%
    }
    

    
    
%>


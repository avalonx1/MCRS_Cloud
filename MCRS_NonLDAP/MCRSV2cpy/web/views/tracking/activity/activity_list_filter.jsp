<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%            
      String filter_itemname = request.getParameter("filter_itemname");
      String filter_status = request.getParameter("filter_status");
      String filter_actDate_start = request.getParameter("filter_actDate_start");
      String filter_actDate_end = request.getParameter("filter_actDate_end");
      String filter_groupName = request.getParameter("filter_groupName");
      String filter_userName = request.getParameter("filter_userName");
      String filter_SLA = request.getParameter("filter_SLA");
      String filter_priority = request.getParameter("filter_priority");
      String filter_act_auth = request.getParameter("filter_act_auth");
        
         if (filter_itemname==null) {
           filter_itemname="";
         }
      
         if (filter_status==null) {
             filter_status="-1";
         }
         if (filter_actDate_start == null) {
            filter_actDate_start = "";
         }
         if (filter_actDate_end == null) {
            filter_actDate_end = "";
         }
      
         if (filter_groupName==null) {
           filter_groupName="0";
         }
         if (filter_userName==null) {
           filter_userName=v_userID;
         }
         
         if (filter_SLA==null) {
           filter_SLA="0";
         }
      
       if (filter_priority==null) {
           filter_priority="0";
         }
       
       if (filter_act_auth == null) {
            filter_act_auth = "0";
        }
      
      
      
%>
<div  class="myformfilter">
    <form  id="filter_form" method="post" action="#">

        <table >
            <tr><th colspan="2">Filter </th></tr>
            <tr><td width="120px">Items Name </td><td>:<input id="filter_itemname" type="text" name="filter_itemname" value="<%=filter_itemname%>" size="20" maxlength="500" /></td></tr>
            <tr><td>Activity Date Start </td><td>:<input readonly="true"  id="filter_actDate_start" type="text" name="filter_actDate_start" value="<%=filter_actDate_start%>" size="20" maxlength="20" /></td></tr>
            <tr><td>Activity Date End </td><td>:<input readonly="true" id="filter_actDate_end" type="text" name="filter_actDate_end" value="<%=filter_actDate_end%>" size="20" maxlength="20" /></td></tr>
            <tr><td>Group Name </td><td>:
            <select id="filter_groupName" name="filter_groupName">

            <%
                
                try {
                    ResultSet resultSet=null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "select 0 id,'-All Group Name-' GROUP_NAME "
                                + "union all "
                                + "SELECT id,GROUP_NAME  FROM t_itemgroup "
                                + "ORDER BY 2";
                        resultSet = db.executeQuery(sql);
                        while (resultSet.next()) {
                            
                            if (filter_groupName != null) {
                                    if (filter_groupName.equalsIgnoreCase(resultSet.getString(1))) {
                                        out.println("<option value='" + resultSet.getString(1) + "' selected=selected >" + resultSet.getString(2) + "</option>");
                                    } else {
                                        out.println("<option value='" + resultSet.getString(1) + "' >" + resultSet.getString(2) + "</option>");
                                    }
                                } else {
                                    out.println("<option value='" + resultSet.getString(1) + "' >" + resultSet.getString(2) + "</option>");
                                }
                            
                          
                        }
                        
                    } catch (SQLException Sqlex) {
                        out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                    } finally {
                        db.close();
                            if (resultSet != null) resultSet.close(); 
                        
                    }
                } catch (Exception except) {
                    out.println("<div class=sql>" + except.getMessage() + "</div>");
                }
            %>

        </select>
            </td></tr>
            
            <tr><td>Username </td><td>:
            <select id="filter_userName" name="filter_userName">

            <%
               
                try {
                    ResultSet resultSet=null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "SELECT * FROM (select 0 id,'-All User Name-' USER_NAME, 1 AS ORD "
                                + "union all "
                                + "select distinct a.id id,case when first_name is null then 'N/A' else first_name||' '||last_name end||' ('||username||')' AS USER_NAME, 2 AS ORD "
                                + "from t_user a join T_ITEMGROUPUNIT_USER b on a.id=b.ITEMGROUP2USER "
                                + "where ITEMGROUP2GROUPUNIT in ( "
                                + "select ITEMGROUP2GROUPUNIT from T_ITEMGROUPUNIT_USER "
                                + "where ITEMGROUP2USER="+v_userID+") ) a "
                                + "ORDER BY 3,2";
                         resultSet = db.executeQuery(sql);
                        while (resultSet.next()) {
                            
                            if (filter_userName != null) {
                                    if (filter_userName.equalsIgnoreCase(resultSet.getString(1))) {
                                        out.println("<option value='" + resultSet.getString(1) + "' selected=selected >" + resultSet.getString(2) + "</option>");
                                    } else {
                                        out.println("<option value='" + resultSet.getString(1) + "' >" + resultSet.getString(2) + "</option>");
                                    }
                                } else {
                                    out.println("<option value='" + resultSet.getString(1) + "' >" + resultSet.getString(2) + "</option>");
                                }
                            
                          
                        }
                      
                    } catch (SQLException Sqlex) {
                        out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                    } finally {
                        db.close();
                               if (resultSet != null) resultSet.close(); 
                      
                    }
                } catch (Exception except) {
                    out.println("<div class=sql>" + except.getMessage() + "</div>");
                }
            %>

        </select>
            </td></tr>
            
            <tr><td>Status </td><td>:
            <select id="filter_status" name="filter_status">

            <%
                
                try {
                    ResultSet resultSet=null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "SELECT * FROM ( select 0 id,'-All Status-' AS DESC, 1 AS ORD "
                                + "union all "
                                + "select -1 id,'-Not Done-' AS DESC, 2 AS ORD "
                                + "union all "
                                + "SELECT id,T_NAME AS DESC, 3 AS ORD FROM t_actstatus ) a "
                                + "ORDER BY 3,1";
                        resultSet= db.executeQuery(sql);
                        while (resultSet.next()) {
                            
                            if (filter_status != null) {
                                    if (filter_status.equalsIgnoreCase(resultSet.getString(1))) {
                                        out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                    } else {
                                        out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                    }
                                } else {
                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                }
                            
                          
                        }
                       
                    } catch (SQLException Sqlex) {
                        out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                    } finally {
                        db.close();
                            if (resultSet != null)     if (resultSet != null) resultSet.close();  
                    }
                } catch (Exception except) {
                    out.println("<div class=sql>" + except.getMessage() + "</div>");
                }
            %>

        </select>
            </td></tr>
            
            <tr><td>Priority </td><td>:
            <select id="filter_priority" name="filter_priority">

            <%
                
                try {
                    ResultSet resultSet=null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "SELECT * FROM ( select 0 id,'-All-' AS DESC, -1 AS INORDER "
                                + "union all "
                                + "SELECT id,T_NAME AS DESC, INORDER FROM T_ACTPRIORITY ) a "
                                + "ORDER BY 3,2";
                        resultSet= db.executeQuery(sql);
                        while (resultSet.next()) {
                            
                            if (filter_status != null) {
                                    if (filter_priority.equalsIgnoreCase(resultSet.getString(1))) {
                                        out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                    } else {
                                        out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                    }
                                } else {
                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                }
                            
                        }
                       
                    } catch (SQLException Sqlex) {
                        out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                    } finally {
                        db.close();
                            if (resultSet != null)     if (resultSet != null) resultSet.close();  
                    }
                } catch (Exception except) {
                    out.println("<div class=sql>" + except.getMessage() + "</div>");
                }
            %>

        </select>
            </td></tr>
            
            
            <tr><td>SLA </td><td>:
            <select id="filter_SLA" name="filter_SLA">
                <option value="0">-All-</option>
                <option value="NO SLA">No SLA</option>
                 <option value="green">Still Good (Green)</option>
                 <option value="yellow">Warning (Yellow)</option>
                 <option value="red">Breach (Red)</option>
                
            </select>
            </td></tr>
            
            
            
            <tr><td>Auth Stat </td><td>:
            <select id="filter_act_auth" name="filter_act_auth">

            <%
                
                try {
                    ResultSet resultSet=null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "SELECT '0' ID , '-All-' AS DESC, 0 AS ORD UNION ALL SELECT 'Y' ID, 'Y' AS DESC,1 AS ORD UNION ALL SELECT 'N' ID, 'N' AS DESC,2 AS ORD ORDER BY 3,2";
                                
                        resultSet= db.executeQuery(sql);
                        while (resultSet.next()) {
                            
                            if (filter_status != null) {
                                    if (filter_act_auth.equalsIgnoreCase(resultSet.getString(1))) {
                                        out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                    } else {
                                        out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                    }
                                } else {
                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                }
                            
                        }
                       
                    } catch (SQLException Sqlex) {
                        out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                    } finally {
                        db.close();
                            if (resultSet != null)     if (resultSet != null) resultSet.close();  
                    }
                } catch (Exception except) {
                    out.println("<div class=sql>" + except.getMessage() + "</div>");
                }
            %>

        </select>
            </td></tr>
            
            
            
            
            
            
            <tr><td colspan="2"><button type="submit">GO</button></td></tr>
        </table>
  
    </form>
</div>
<script type="text/javascript">
    //$('#tr_filter_actDate_start').hide();
    //$('#tr_filter_actDate_end').hide();
    $("#filter_actDate_start" ).datepicker({
                     dateFormat: 'yy-mm-dd',
                     timeFormat: 'hh:mm',
                     buttonImage: '../images/date.png',
                     buttonImageOnly: true,
                     showOn:'button',
                     buttonText: 'Click to show the calendar'
    });
    $('#ui-datepicker-div').css('display','none');
    $("#filter_actDate_end" ).datepicker({
        dateFormat: 'yy-mm-dd',
                     timeFormat: 'hh:mm',
                     buttonImage: '../images/date.png',
                     buttonImageOnly: true,
                     showOn:'button',
                     buttonText: 'Click to show the calendar'
    });
    
    filter_actDate_start= document.getElementById("filter_actDate_start").value;
    filter_actDate_end= document.getElementById("filter_actDate_end").value;
    
   
    
    $('#filter_form').submit(function(){
        //alert(stat_actDate);
      
     
        
        $("#status_msg").hide();
        $("#data").hide();
        $('#loading').show();
        $.ajax({
            type: 'POST',
            url: "tracking/activity/activity_list_data.jsp",
            data: $(this).serialize(),
            success: function(data) {
                $("#data_inner").empty();
                $('#icon_panel_show_filter').fadeIn('slow');
                $('#icon_panel_hide_filter').fadeOut('slow');
                $('#filter_box_data').slideUp();
                $("#data_inner").html(data);
                $("#data_inner").show();
            },
            complete: function(){
                $('#loading').hide();
            }
                        
        });
            
        return false;
    });

</script>


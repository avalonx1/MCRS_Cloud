<%@include file="../../../includes/check_auth_layer1.jsp"%>
<%
                     
      String filter_itemname = request.getParameter("filter_itemname");
       String filter_status = request.getParameter("filter_status");
        
         if (filter_itemname==null) {
           filter_itemname="";
         }
      
         if (filter_status==null) {
             filter_status="0";
         }
    
%>
<div  class="myformfilter">
    <form  id="filter_form" method="post" action="#">

        <table >
            <tr><th colspan="2">Filter </th></tr>
            <tr><td width="80px">Username </td><td>:<input id="filter_username" type="text" name="filter_username" value="<%=filter_itemname%>" size="20" maxlength="200" /></td>
             <tr><td>Status </td><td>:
             <select id="filter_status" name="filter_status">

            <%
                            
                            
                               if (filter_status.equalsIgnoreCase("0")) {
                                        out.println("<option value=0 selected=selected >-All Status-</option>");
                                        out.println("<option value='Active' >Active</option>");
                                        out.println("<option value='Not Active' >Not Active</option>");
                                    } else if (filter_status.equalsIgnoreCase("Active")) {
                                        out.println("<option value=0  >-All Status-</option>");
                                        out.println("<option value='Active' selected=selected >Active</option>");
                                        out.println("<option value='Not Active' >Not Active</option>");
                                    }else {
                                        out.println("<option value='0'  >-All Status-</option>");
                                        out.println("<option value='Active'  >Active</option>");
                                        out.println("<option value='Not Active' selected=selected >Not Active</option>");
           
                                    }
                               
            %>

            </select>
            </td></tr>
             <tr><td colspan="2"><button type="submit">GO</button></td></tr>
        </table>
  
    </form>
</div>
<script type="text/javascript">

    $('#filter_form').submit(function(){
        $("#data").hide();
        $('#loading').show();
        $.ajax({
            type: 'POST',
            url: "administration/user_management/user_list_data.jsp",
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
                        
        })
        return false;
    });

    
</script>


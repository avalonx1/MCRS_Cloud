<%@include file="../../../includes/check_auth_layer2.jsp"%>
<%
           
    String act_id = request.getParameter("act_id");
    String filter_itemname = request.getParameter("filter_itemname");
    String filter_status = request.getParameter("filter_status");

    if (act_id == null) {
            act_id = "0";
        }
    
    if (filter_itemname == null) {
            filter_itemname = "";
        }
    if (filter_status == null) {
            filter_status = "0";
        }
    
    int i = 0;
    
%>
        

        
    <script type="text/javascript">
         $(document).ready(function() {
          
            $("#title_box").empty();
            $("#title_box").html("<h1>Items List  </h1><p>All items/activity/task</p>");
            $("#title_box").show();
           
            
            $('#filter_box').show();
            $('#filter_box_data').slideUp('fast');
            $('#icon_panel_hide_filter').fadeOut('slow');
            $('#icon_panel_show_filter').fadeIn('slow');
            
            $('#icon_panel_hide_action').hide();
            $('#icon_panel_show_action').hide();
            $('#action_box_data').empty();
            $('#action_box_data').hide();
            
            
            $('#loading_filter').show();
            $.ajax({
                    type: 'POST',
                    url: "tracking/items/items_list_filter.jsp",
                    data: "",
                    success: function(data) {
                        $('#filter_box_data').empty();
                        $('#filter_box_data').html(data);

                    },
                    complete: function(){
                        $('#loading_filter').hide();
                    }
                });
            

            $('#loading_inner').show();
            $.ajax({
                    type: 'POST',
                    url: "tracking/items/items_list_data.jsp",
                    data: "",
                    success: function(data) {
                        
                        $('#data_inner').empty();
                        $('#data_inner').html(data);
                        $('#data_inner').show();
                    },
                    complete: function(){
                        $('#loading_inner').hide();
                    }
                });
           
           
           //filter box
            //show
            $('#icon_panel_show_filter').click(function(e){
            e.stopPropagation();
            e.preventDefault();
            $('#icon_panel_show_filter').fadeOut('slow');
            $('#icon_panel_hide_filter').fadeIn('slow');
            $('#filter_box_data').slideDown('fast');
            
            
            setFocusto('filter_itemname');
            });
            
            //hide
            $('#icon_panel_hide_filter').click(function(e){
            e.stopPropagation();
            e.preventDefault();    
           
            $('#icon_panel_hide_filter').fadeOut('slow');
            $('#icon_panel_show_filter').fadeIn('slow');
            $('#filter_box_data').slideUp('fast');
            });

           });

    </script>


<%@include file="../../includes/check_auth_layer3.jsp"%>
<%  
      
String objid = request.getParameter("objid");
String docfilenamefull =request.getParameter("filenamefull");
String docfilename = request.getParameter("filename");



%>
        <script type="text/javascript">

                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "file_management/run_swfconverter.jsp",
                            data: {objid:<%=objid%>,docfilenamefull:<%=docfilenamefull%>,docfilename:<%=docfilename%>},
                            success: function(data) {
                                $('#data_inner').show();
                                
                                
                            },
                            complete: function(){
                                $('#loading').hide(); 
                            }
                        });  
    
    window.open('docviewer.jsp','open_window','menubar, toolbar, location, directories, status, scrollbars, resizable, dependent, width=640, height=480, left=0, top=0');
        </script>

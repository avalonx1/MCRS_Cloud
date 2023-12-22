<%@page import="java.nio.file.Files"%>
<%@include file="../../includes/check_auth_layer3.jsp"%>
<%  
      
String objid = request.getParameter("objid");
String docfilenamefull =request.getParameter("filenamefull");
String docfilename = request.getParameter("filename");
String SWFFilename="";
String SWFDocRoot="";

        int vCheckEligible = 0;
        auth checkFile = new auth(v_clientIP);
        try { 
         vCheckEligible=checkFile.isEligibleAccessReport(objid,v_userID);
         //filename_full=checkFile.getFullPathReport(objid,v_userID,tglrpt);
         SWFFilename=checkFile.getParamValue("DEFAULT_SWF_REPORT");
         SWFDocRoot=checkFile.getParamValue("SWF_DOCROOT_RELATIVE");
         
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         checkFile.close();
         }
         
  if (vCheckEligible != 0) {

        
        
        auth runSwfConf = new auth(v_clientIP);
        try { 
         
         SWFFilename=runSwfConf.execPDF2SWF(docfilenamefull, docfilename); 
         
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } 
        catch (IOException ioex) {
         out.println("<div class=sql>" + ioex.getMessage() + "</div>");
         SWFFilename=runSwfConf.getParamValue("DEFAULT_SWF_REPORT");
         }
        finally {
         runSwfConf.close();
         }

    String SWFFilefull=SWFDocRoot+SWFFilename;     
    
    
              //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql> path to doc swf : " + SWFFilefull + "</div>");
                        }
                        
                        
%>

<div class="tablelist_wrap">
    <div id="back" class="add_optional">[back] </div>
</div>
<div class="small_font">File Report : <%=docfilename%> </div>
<div style="position:relative;left:10px;top:10px;">

<div id="documentViewer" class="flexpaper_viewer" style="width:770px;height:500px"></div>
<script type="text/javascript">
$(document).ready(function() {
    var startDocument = "Paper";

    $('#documentViewer').FlexPaperViewer(
            { config : {

                SWFFile : '<%=SWFFilefull%>',

                Scale : 0.6,
                ZoomTransition : 'easeOut',
                ZoomTime : 0.5,
                ZoomInterval : 0.2,
                FitPageOnLoad : true,
                FitWidthOnLoad : false,
                FullScreenAsMaxWindow : false,
                ProgressiveLoading : false,
                MinZoomSize : 0.2,
                MaxZoomSize : 5,
                SearchMatchAll : false,
                InitViewMode : 'Portrait',
                RenderingOrder : 'flash',
                StartAtPage : '',

                ViewModeToolsVisible : true,
                ZoomToolsVisible : true,
                NavToolsVisible : true,
                CursorToolsVisible : true,
                SearchToolsVisible : true,
                WMode : 'window',
                localeChain: 'en_US'
            }}
    );


 $('#back').click(function() {
                    
                     filter_itemname= document.getElementById("filter_itemname").value;
                     filter_tanggal= document.getElementById("filter_tanggal").value;
                     filter_group_child_id= document.getElementById("filter_group_child_id").value;
                   
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "report/daily/daily_report_list_data.jsp",
                            data: {filter_itemname:filter_itemname,
                                 filter_tanggal:filter_tanggal,filter_group_child_id:filter_group_child_id},
                            success: function(data) {
                                $('#data_inner').empty();
                                $('#data_inner').html(data);
                                $('#data_inner').show();
                            },
                            complete: function(){
                                $('#loading').hide(); 
                            }
                        });        
             });
             
     }); 
</script>

</div>
                
                <%
                
                
                 } else { 
            
            response.sendRedirect("insufficient.jsp");
            
        };
        
        
        %>

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

        System.out.println("masuk eligible...");
        
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
                        
out.println(SWFFilefull);
%>

                
                <%
                
                
                 } else { 
            
            response.sendRedirect("insufficient.jsp");
            
        };
        
        
        %>

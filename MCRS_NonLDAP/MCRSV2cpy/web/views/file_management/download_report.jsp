<%@include file="../../includes/check_auth_layer3.jsp"%>
<%

String objid = request.getParameter("objid");
String tglrpt = request.getParameter("tglrpt");
String filenamefull =request.getParameter("filenamefull");
String filename = request.getParameter("filename");

        int vCheckEligible = 0;
        String filename_full = filenamefull;
        auth checkFile = new auth(v_clientIP);
        try { 
         vCheckEligible=checkFile.isEligibleAccessReport(objid,v_userID);
         
         //filename_full=checkFile.getFullPathReport(objid,v_userID,tglrpt);
                 
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         checkFile.close();
         }
         
        if (vCheckEligible != 0) {
/*
String filename="000RPT_EOD077_D_20160127_000_LAPORAN_PEMBUKAAN_REK_TABUNGAN_CAB.pdf";
String vDir_path="/data/report";
String vTanggal ="20160201";
String vGroupCode="000";

        

String filename="MCB_DATA_N_VALUELESS_ZERO.xlsx";
String vDir_path="F:/WORK/PENTAHO";
String vTanggal ="OUTPUT20151231";
String vGroupCode="000";


String filename_full=vDir_path+"/"+vTanggal+"/"+vGroupCode+"/"+filename;
 */
         
response.setContentType("application/octet-stream");
String disHeader = "Attachment; Filename=\""+filename+"\"";
response.setHeader("Content-Disposition", disHeader);


File fileToDownload = new File(filename_full);

InputStream in = null;
ServletOutputStream outs = response.getOutputStream();

try {
in = new BufferedInputStream
(new FileInputStream(fileToDownload));
int ch;
while ((ch = in.read()) != -1) {
outs.print((char) ch);
}
}
finally {
if (in != null) in.close(); // very important
}

outs.flush();
outs.close();
in.close();


//count download

ReportTracking rp = new ReportTracking(v_clientIP);
rp.updateRptDownload(Integer.parseInt(objid),Integer.parseInt(v_userID),filename);
rp.close();



        } else { 
            
            response.sendRedirect("insufficient.jsp");
            
        };

    
%>
        
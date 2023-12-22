/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Engines;

import java.sql.*;
import javax.naming.*;
import javax.sql.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
  
@WebServlet(name = "DownloadServlet", urlPatterns = {"/DownloadServlet"})
@MultipartConfig(fileSizeThreshold=1024*1024*10,    // 10 MB 
                 maxFileSize=1024*1024*50,          // 50 MB
                 maxRequestSize=1024*1024*100,      // 100 MB
                 location="C:\\DATA\\upload")      
public class DownloadServlet extends HttpServlet  {
  
    private static final long serialVersionUID = 205242440643911308L;
     
    /**
     * Directory where uploaded files will be saved, its relative to
     * the web application directory.
     */
    
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                String objid = request.getParameter("objid");
                String filenamefull =request.getParameter("filenamefull");
                String fileName = request.getParameter("filename");
                String userid = request.getParameter("userid");
                String dflag = request.getParameter("downloadflag");
                
                int vCheckEligible = 0;
                try {
                    auth checkFile = new auth("123");
                    try {
                    vCheckEligible=checkFile.isEligibleAccessReport(objid,userid);
                    
                    //vCheckEligible = 1;
                    }catch (Exception e) {
                            System.out.println("Exception Servlet: " +e.getMessage());
                    } finally {
                        checkFile.close();       
                    }
                    
                } catch (Exception e) {
                        System.out.println("Exception Servlet: " +e.getMessage());
                }
                  
                
                 if (vCheckEligible != 0) {
        
		if(fileName == null || fileName.equals("")){
			throw new ServletException("File Name can't be null or empty");
		}
		
                //File file = new File("C:\\DATA\\upload"+File.separator+fileName);
                
                File file = new File(filenamefull);
                
                
		if(!file.exists()){
			throw new ServletException("File doesn't exists on server.");
		}
		System.out.println("File location on server::"+file.getAbsolutePath());
		ServletContext ctx = getServletContext();
		InputStream fis = new FileInputStream(file);
		String mimeType = ctx.getMimeType(file.getAbsolutePath());
		response.setContentType(mimeType != null? mimeType:"application/octet-stream");
		response.setContentLength((int) file.length());
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
		
		ServletOutputStream os       = response.getOutputStream();
		byte[] bufferData = new byte[1024];
		int read=0;
		while((read = fis.read(bufferData))!= -1){
			os.write(bufferData, 0, read);
		}
                
                
		os.flush();
		os.close();
		fis.close();
		System.out.println("File downloaded at client successfully");
                
                if (dflag.equals("1")) {
                //count download
                try {
                    ReportTracking rp = new ReportTracking("123");
                    rp.updateRptDownload(Integer.parseInt(objid),Integer.parseInt(userid),fileName);
                    rp.close();
                  } catch (Exception e) {
                        System.out.println("Exception Servlet: " +e.getMessage());
                }

                }
                
                
                } else {
            response.sendRedirect("views/file_management/insufficient.jsp");
                 }
        };

                 
}

    
    
  
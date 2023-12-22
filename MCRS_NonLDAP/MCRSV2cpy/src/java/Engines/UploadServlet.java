/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Engines;


import java.sql.*;

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
import javax.naming.*;
import javax.sql.*;
  
/**
 *
 * @author siskohat
 */
@WebServlet(name = "UploadServlet", urlPatterns = {"/UploadServlet"})
@MultipartConfig(fileSizeThreshold=1024*1024*10,    // 10 MB 
                 maxFileSize=1024*1024*50,          // 50 MB
                 maxRequestSize=1024*1024*100,      // 100 MB
                 location="C:\\DATA\\upload")      
public class UploadServlet extends HttpServlet  {
  
    private static final long serialVersionUID = 205242440643911308L;
     
    /**
     * Directory where uploaded files will be saved, its relative to
     * the web application directory.
     */
    
    private String tag_code = "DOCFSHARE";
    private String NAMEFILE_PATTERN_UPLOAD;
    private String UPLOAD_DIR = "upload";
    private long MAXSIZE_MB = 50;
    
    /**
     *
     * @throws NamingException
     * @throws SQLException
     */
    public UploadServlet() throws NamingException, SQLException{
     
        
         auth au = new auth();
         try{
           UPLOAD_DIR=au.getParamValue("DIR_FILE_UPLOAD");
           MAXSIZE_MB = Long.parseLong(au.getParamValue("MAXSIZE_UPLOAD_MB"));
           NAMEFILE_PATTERN_UPLOAD=au.getParamValue("FILE_FORMAT_UPLOAD");
           
         } catch (SQLException Sqlex) {
         System.out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         } 
         
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
       
        
        // constructs path of the directory to save uploaded file
        String uploadFilePath = UPLOAD_DIR;
          
        // creates the save directory if it does not exists
        File fileSaveDir = new File(uploadFilePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }
        System.out.println("Upload File Directory="+fileSaveDir.getAbsolutePath());
         
        String fileName = null;
        String fileExt;
        String StatusMessage = " ";
        
        String IDUNQFILE = request.getParameter("id");
        
        
        long filesize;
        boolean reachMaxFilesize = false;
        
        //Get all the parts from request and write it to the file on server
        for (Part part : request.getParts()) {
            
            fileName = getFileName(part);
            fileName = fileName.replace(" ", "_");
            fileExt = fileName.substring(fileName.indexOf(".")+1);
            filesize = part.getSize();
            
            
            fileName = tag_code+"_"+IDUNQFILE+"_"+fileName;
            
            
            if ((filesize/1024/1024)>MAXSIZE_MB) {
                reachMaxFilesize = true;
                StatusMessage += "File too large.. Maximum Size Allowed : "+MAXSIZE_MB+ "MB, Your File Size : "+Math.round(filesize/1024/1024)+" MB";
                                    
            }
            
            
            if (!reachMaxFilesize) {
            part.write(fileName);
            }
            
        }
  
        request.setAttribute("message", fileName + " File uploaded successfully!");
        request.setAttribute("filename", fileName);
        
        getServletContext().getRequestDispatcher("/getParts.jsp").forward(
                request, response);
    }
  
    /**
     * Utility method to get file name from HTTP header content-disposition
     */
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        System.out.println("content-disposition header= "+contentDisp);
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length()-1);
            }
        }
        return "";
    }
    
    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileName = request.getParameter("fileName");
		if(fileName == null || fileName.equals("")){
			throw new ServletException("File Name can't be null or empty");
		}
		File file = new File("C:/Program Files/glassfish-4.1/glassfish/domains/domain1/generated/jsp/MCRS"+File.separator+fileName);
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
	}

    
    
    
}
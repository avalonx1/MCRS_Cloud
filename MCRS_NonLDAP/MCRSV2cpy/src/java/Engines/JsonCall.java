/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Engines;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 *
 * @author 20160038
 */
public class JsonCall {
    

/**
 *
 * @author 20160038
 */

	public static void  main(String[] args) {
    
    
    
    		try {
//			URL url = new URL("http://10.81.27.97:19177/ldap/authlogin");
                        URL url = new URL("https://reqres.in/api/login");
                        
//			String postData = "userid=20160038&password=Rafsanjan1";
                        String postData = "email=eve.holt@reqres.in&password=cityslicka";

			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                        conn.addRequestProperty("User-Agent", "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36");
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
//                        conn.setRequestProperty("Authorization", "Basic " + Base64.getEncoder().encodeToString((userName + ":" + password).getBytes()));
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setRequestProperty("Content-Length", Integer.toString(postData.length()));
			conn.setUseCaches(false);

			try (DataOutputStream dos = new DataOutputStream(conn.getOutputStream())) {
				dos.writeBytes(postData);
			}

			try (BufferedReader br = new BufferedReader(new InputStreamReader(
												conn.getInputStream())))
			{
				String line;
				while ((line = br.readLine()) != null) {
					System.out.println(line);
				}
			}
		} catch (IOException e) {
		}
        }
}
  


                
                
                
                
                
                
                
                
                
                
                
  
        
    


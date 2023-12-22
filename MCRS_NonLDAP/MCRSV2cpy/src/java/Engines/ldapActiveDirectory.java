/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Engines;


import java.util.Hashtable;
import java.sql.*;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attributes;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;

/**
 *
 * @author 20131254
 */

public class ldapActiveDirectory {
        
        private static LdapContext ctxldap = null;
        private String OutputLdap = "";
        private final String context_factory="com.sun.jndi.ldap.LdapCtxFactory";
        private static String url="ldap://10.55.60.223:389"; //default
        private static String paramDistinguishName="OU=Users,OU=Accounts,DC=bankmuamalat,DC=co,DC=id"; //default
    
    /**
     *
     * @param ipaddr
     * @throws NamingException
     * @throws SQLException
     */
    public ldapActiveDirectory(String ipaddr) throws NamingException, SQLException {
        
            ctxldap=this.getLdapContext(ipaddr);
            
             auth au = new auth(ipaddr);
              try{
                url=au.getParamValue("LDAP_URL");
                paramDistinguishName=au.getParamValue("LDAP_DISTINGUISHED_NAME");
              }catch (SQLException Sqlex){
               
             }finally {
                    au.close();
             }
                    
        }

	private LdapContext getLdapContext(String ipaddr) throws NamingException, SQLException {
            
		LdapContext ctx = null;
//                String Dname="";
//                String passwd="";
//                String nik="";
//                String domain= "@bankmuamalat.co.id";
                
                String Dname="";
                String passwd=""; 
                String nik="";
                String domain= "@bankmuamalat.co.id";
                
                auth au = new auth(ipaddr);
              try{
                    Dname=au.getParamValue("LDAP_SEC_PRINCIPAL");
                    passwd=au.getParamValue("LDAP_SEC_CREDENTIALS"); 
                }catch (SQLException Sqlex){
                    Dname="";  
                }finally {
                    au.close();
                }
                     try {
                        
			Hashtable<String, String> env = new Hashtable<String, String>();
                        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
//			env.put(Context.INITIAL_CONTEXT_FACTORY,context_factory);
                        env.put(Context.PROVIDER_URL, "ldap://10.55.60.223:389"); //MUJAIR
//                        env.put(Context.PROVIDER_URL, "ldap://10.81.0.99:389"); //MT
//                        env.put(Context.PROVIDER_URL, "ldap://localhost:5432"); //DEV
			env.put(Context.SECURITY_AUTHENTICATION, "Simple");
                        env.put(Context.SECURITY_PRINCIPAL, "mcrs@bankmuamalat.co.id");
//                        env.put(Context.SECURITY_PRINCIPAL, "join.ad@bankmuamalat.co.id");
//                        env.put(Context.SECURITY_PRINCIPAL, "20160038@bankmuamalat.co.id");
			env.put(Context.SECURITY_CREDENTIALS, "Muamalat123#");
//                        env.put(Context.SECURITY_CREDENTIALS, "Muamalat*$");
//                        env.put(Context.SECURITY_CREDENTIALS, "Rafsanjan1");
//                        env.put(Context.SECURITY_CREDENTIALS, passwd);
//			env.put(Context.PROVIDER_URL,url );
                        

			OutputLdap+= "Connect Using [ "+env.get(Context.SECURITY_PRINCIPAL)+"] ";
                        
                        ctx = new InitialLdapContext(env, null);
			System.out.println("LDAP Connection Successful via "+env.get(Context.SECURITY_PRINCIPAL));
                        OutputLdap+="LDAP Connection Successful";
                       
		} catch(NamingException nex ){
			System.out.println("LDAP Connection: FAILED. ");
                        OutputLdap+="LDAP Connection: FAILED. ";
		}
		return ctx;
	}

    /**
     *
     * @return
     * @throws NamingException
     */
    public String getErr() throws NamingException{
            return OutputLdap;
        }
        
    /**
     *
     * @param username
     * @return
     */
    public boolean isRegisterLDAP(String username) {
		 boolean statLDAP=false;
                 String DName="UNK";
		try {

			SearchControls constraints = new SearchControls();
			constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
			String[] attrIDs = {"distinguishedName"};
                        
			constraints.setReturningAttributes(attrIDs);
			//First input parameter is search bas, it can be "CN=Users,DC=YourDomain,DC=com"
			//Second Attribute can be uid=username
			NamingEnumeration answer = ctxldap.search(paramDistinguishName, "sAMAccountName="
					+ username, constraints);
			if (answer.hasMore()) {
				Attributes attrs = ((SearchResult) answer.next()).getAttributes();
                                DName = attrs.get("distinguishedName").toString().substring(19);
			}else{
				throw new Exception("Invalid User");
			}

		} catch (Exception ex) {
		}
                
                
                if (DName.equals("UNK")) {
                    statLDAP= false;
                } else {
                    statLDAP= true;
                }
                
		return statLDAP;
	}
       
    /**
     *
     * @param username
     * @return
     */
    public String getDistinguishName(String username) {
		 String DName="";
		try {

			SearchControls constraints = new SearchControls();
			constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
			String[] attrIDs = {"distinguishedName"};
                        
			constraints.setReturningAttributes(attrIDs);
			//First input parameter is search bas, it can be "CN=Users,DC=YourDomain,DC=com"
			//Second Attribute can be uid=username
			NamingEnumeration answer = ctxldap.search(paramDistinguishName, "sAMAccountName="
					+ username, constraints);
			if (answer.hasMore()) {
				Attributes attrs = ((SearchResult) answer.next()).getAttributes();
                                DName = attrs.get("distinguishedName").toString().substring(19);
			}else{
				throw new Exception("Invalid User");
			}

		} catch (Exception ex) {
		}
		return DName;
	}
        
    /**
     *
     * @param username
     * @param password
     * @return
     */
    public boolean getAuthByDName(String username,String password){
		String Dname="";
                boolean statAD=false;
                
                Dname=getDistinguishName(username);
                
                LdapContext ctx = null;
        
		try{
			Hashtable<String, String> env = new Hashtable<String, String>();
			env.put(Context.INITIAL_CONTEXT_FACTORY,context_factory);
			env.put(Context.SECURITY_AUTHENTICATION, "Simple");
			env.put(Context.SECURITY_PRINCIPAL, Dname);
			env.put(Context.SECURITY_CREDENTIALS, password);
			env.put(Context.PROVIDER_URL,url );
                        
			OutputLdap+= "Connect Using [ "+env.get(Context.SECURITY_PRINCIPAL)+" pdw "+env.get(Context.SECURITY_CREDENTIALS)+"] ";
                        
                        ctx = new InitialLdapContext(env, null);
			System.out.println("LDAP Connection Successful using "+env.get(Context.SECURITY_PRINCIPAL));
                        statAD=true;
                        OutputLdap+="LDAP Connection Successful";
                       
		}catch(NamingException nex){
			System.out.println("LDAP Connection: FAILED");
                        OutputLdap+="LDAP Connection: FAILED" +username+" "+password;
                        statAD=false;
		}
		return statAD;
	}
        
    /**
     *
     * @param username
     * @return
     */
    public String getEmail(String username) {
		 String DName="";
                 String attr="mail";
                 int lengthAttr = attr.length();
		try {

			SearchControls constraints = new SearchControls();
			constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
			String[] attrIDs = {attr};
                        
			constraints.setReturningAttributes(attrIDs);
			//First input parameter is search bas, it can be "CN=Users,DC=YourDomain,DC=com"
			//Second Attribute can be uid=username
			NamingEnumeration answer = ctxldap.search(paramDistinguishName, "sAMAccountName="
					+ username, constraints);
			if (answer.hasMore()) {
				Attributes attrs = ((SearchResult) answer.next()).getAttributes();
                                DName = attrs.get(attr).toString().substring(lengthAttr+2);
			}else{
				throw new Exception("Invalid User");
			}

		} catch (Exception ex) {
		}
		return DName;
	}
        
    /**
     *
     * @param username
     * @return
     */
    public String getIPPhone(String username) {
		 String DName="";
                 String attr="ipPhone";
                 int lengthAttr = attr.length();
		try {

			SearchControls constraints = new SearchControls();
			constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
			String[] attrIDs = {attr};
                        
			constraints.setReturningAttributes(attrIDs);
			//First input parameter is search bas, it can be "CN=Users,DC=YourDomain,DC=com"
			//Second Attribute can be uid=username
			NamingEnumeration answer = ctxldap.search(paramDistinguishName, "sAMAccountName="
					+ username, constraints);
			if (answer.hasMore()) {
				Attributes attrs = ((SearchResult) answer.next()).getAttributes();
                                DName = attrs.get(attr).toString().substring(lengthAttr+2);
			}else{
				throw new Exception("Invalid User");
			}

		} catch (Exception ex) {
		}
		return DName;
	}
        
    /**
     *
     * @param username
     * @return
     */
    public String getName(String username) {
		 String DName="";
                 String attr="displayName";
                 int lengthAttr = attr.length();
		try {

			SearchControls constraints = new SearchControls();
			constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
			String[] attrIDs = {attr};
                        
			constraints.setReturningAttributes(attrIDs);
			//First input parameter is search bas, it can be "CN=Users,DC=YourDomain,DC=com"
			//Second Attribute can be uid=username
			NamingEnumeration answer = ctxldap.search(paramDistinguishName, "sAMAccountName="
					+ username, constraints);
			if (answer.hasMore()) {
				Attributes attrs = ((SearchResult) answer.next()).getAttributes();
                                DName = attrs.get(attr).toString().substring(lengthAttr+2);
			}else{
				throw new Exception("Invalid User");
			}

		} catch (Exception ex) {
		}
		return DName;
	}
        
    /**
     *
     * @param username
     * @return
     */
    public String getFirstName(String username) {
		 String DName="";
                 String attr="givenName";
                 int lengthAttr = attr.length();
		try {

			SearchControls constraints = new SearchControls();
			constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
			String[] attrIDs = {attr};
                        
			constraints.setReturningAttributes(attrIDs);
			//First input parameter is search bas, it can be "CN=Users,DC=YourDomain,DC=com"
			//Second Attribute can be uid=username
			NamingEnumeration answer = ctxldap.search(paramDistinguishName, "sAMAccountName="
					+ username, constraints);
			if (answer.hasMore()) {
				Attributes attrs = ((SearchResult) answer.next()).getAttributes();
                                DName = attrs.get(attr).toString().substring(lengthAttr+2);
			}else{
				throw new Exception("Invalid User");
			}

		} catch (Exception ex) {
		}
		return DName;
	}
        
    /**
     *
     * @param username
     * @return
     */
    public String getLastName(String username) {
		 String DName="";
                 String attr="sn";
                 int lengthAttr = attr.length();
		try {

			SearchControls constraints = new SearchControls();
			constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
			String[] attrIDs = {attr};
                        
			constraints.setReturningAttributes(attrIDs);
			//First input parameter is search bas, it can be "CN=Users,DC=YourDomain,DC=com"
			//Second Attribute can be uid=username
			NamingEnumeration answer = ctxldap.search(paramDistinguishName, "sAMAccountName="
					+ username, constraints);
			if (answer.hasMore()) {
				Attributes attrs = ((SearchResult) answer.next()).getAttributes();
                                DName = attrs.get(attr).toString().substring(lengthAttr+2);
			}else{
				throw new Exception("Invalid User");
			}

		} catch (Exception ex) {
		}
		return DName;
	}
        
    /**
     *
     * @param username
     * @return
     */
    public String getTitle(String username) {
		 String DName="";
                 String attr="title";
                 int lengthAttr = attr.length();
		try {

			SearchControls constraints = new SearchControls();
			constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
			String[] attrIDs = {attr};
                        
			constraints.setReturningAttributes(attrIDs);
			//First input parameter is search bas, it can be "CN=Users,DC=YourDomain,DC=com"
			//Second Attribute can be uid=username
			NamingEnumeration answer = ctxldap.search(paramDistinguishName, "sAMAccountName="
					+ username, constraints);
			if (answer.hasMore()) {
				Attributes attrs = ((SearchResult) answer.next()).getAttributes();
                                DName = attrs.get(attr).toString().substring(lengthAttr+2);
			}else{
				throw new Exception("Invalid User");
			}

		} catch (Exception ex) {
		}
		return DName;
	}
        
        

}
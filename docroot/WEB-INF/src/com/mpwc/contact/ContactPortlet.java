/*

Copyright (c) 2012 Roger Sicart. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    (1) Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer. 

    (2) Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in
    the documentation and/or other materials provided with the
    distribution.  
    
    (3)The name of the author may not be used to
    endorse or promote products derived from this software without
    specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
 
 */

/*
 * @author R.Sicart
 */

package com.mpwc.contact;

import java.io.IOException;
import java.util.Date;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;
import javax.portlet.PortletSession;

import com.liferay.counter.service.CounterLocalServiceUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.util.bridges.mvc.MVCPortlet;
import com.mpwc.model.Contacto;
import com.mpwc.model.Project;
import com.mpwc.service.ContactoLocalServiceUtil;
import com.mpwc.service.ProjectLocalServiceUtil;

/**
 * Portlet implementation class ContactPortlet
 */
public class ContactPortlet extends MVCPortlet {

   public void addContact(ActionRequest actionRequest, ActionResponse actionResponse)
   	       throws IOException, PortletException{
     	
    	ThemeDisplay themeDisplay = (ThemeDisplay) actionRequest.getAttribute(WebKeys.THEME_DISPLAY);
    	
     	String firmname = actionRequest.getParameter("firmname");
     	String nif = actionRequest.getParameter("nif");
     	String email = actionRequest.getParameter("email");
     	String phone = actionRequest.getParameter("phone");
     	long status = Long.parseLong(actionRequest.getParameter("status"));
     	String comments = actionRequest.getParameter("comments");
     	String phone2 = actionRequest.getParameter("phone2");
     	String city = actionRequest.getParameter("city");
     	String country = actionRequest.getParameter("country");
     	String address = actionRequest.getParameter("address");
     	String zipcode = actionRequest.getParameter("zipcode");
     	String ctype = actionRequest.getParameter("ctype");
     	
     	Date now = new Date();
     	
     	if(		firmname != null && !firmname.isEmpty() &&
     			email != null && !email.isEmpty() && email.indexOf("@") > 0 &&
     			nif != null && !nif.isEmpty() &&
     			city != null && !city.isEmpty() &&
     			country != null && !country.isEmpty() &&
     			address != null && !address.isEmpty() &&
     			zipcode != null && !zipcode.isEmpty() &&
     			ctype != null && !ctype.isEmpty()
     		){
     		
 	    	Contacto c;
 			try {
 				long contactoId = CounterLocalServiceUtil.increment(Contacto.class.getName());
 				c = ContactoLocalServiceUtil.createContacto(contactoId);
 				c.setFirmname(firmname);
 		    	c.setNif(nif);
 		    	c.setEmail(email);
 		    	if( phone != null && !phone.isEmpty() ){ c.setPhone(phone); }
 		    	if( status > 0 ){ c.setContactoStatusId(status); }
 		    	if( comments != null && !comments.isEmpty() ){ c.setComments(comments); }
 		    	c.setCity(city);
 		    	c.setCountry(country);
 		    	c.setAddress(address);
 		    	c.setZipcode(zipcode);
 		    	c.setCtype(ctype);
 		    	if( phone2 != null && !phone2.isEmpty() ){ c.setPhone2(phone2); }
 		    	c.setCreateDate(now);
 		    	
 				//c.setUserName(themeDisplay.getUserName());
 				c.setCompanyId(themeDisplay.getCompanyId());
 				c.setGroupId(themeDisplay.getScopeGroupId());
 				
 				//write changes to db
 		    	ContactoLocalServiceUtil.addContacto(c);
 		    	
 		    	System.out.println("addContacto " + "groupId:" + c.getGroupId() + "companyId:" + c.getCompanyId());
 		    	
 			} catch (SystemException e) {
 				System.out.println("addContacto exception:" + e.getMessage());
 			}

     	}

     	// gracefully redirecting to the default portlet view
     	String redirectURL = actionRequest.getParameter("redirectURL");
     	actionResponse.sendRedirect(redirectURL);     	
   }
   
   public void editContact(ActionRequest actionRequest, ActionResponse actionResponse)
 	       throws IOException, PortletException {
 	
	 	long contactoId = Long.valueOf( actionRequest.getParameter("contactoId") );
	 	String firmname = actionRequest.getParameter("firmname");
	 	String nif = actionRequest.getParameter("nif");
	 	String email = actionRequest.getParameter("email");
	 	String phone = actionRequest.getParameter("phone");
	 	long status = Long.parseLong(actionRequest.getParameter("status"));
	 	String comments = actionRequest.getParameter("comments");
	 	String phone2 = actionRequest.getParameter("phone2");
	 	String city = actionRequest.getParameter("city");
	 	String country = actionRequest.getParameter("country");
	 	String address = actionRequest.getParameter("address");
	 	String zipcode = actionRequest.getParameter("zipcode");
	 	String ctype = actionRequest.getParameter("ctype");
	 	
	 	Date now = new Date();
	 	
	 	if( contactoId > 0 ){
	 		
		    	Contacto c;
				try {			
					c = ContactoLocalServiceUtil.getContacto(contactoId);
					if( firmname != null && !firmname.isEmpty() ){ c.setFirmname(firmname); }
					if( nif != null && !nif.isEmpty() ){ c.setNif(nif); }
					if( email != null && !email.isEmpty() && email.indexOf("@") > 0 ){ c.setEmail(email); }
			    	if( phone != null && !phone.isEmpty() ){ c.setPhone(phone); }
			    	if( status > 0 ){ c.setContactoStatusId(status); }
			    	if( comments != null && !comments.isEmpty() ){ c.setComments(comments); }
			    	if( city != null && !city.isEmpty() ){ c.setCity(city); }
			    	if( country != null && !country.isEmpty() ){ c.setCountry(country); }
			    	if( address != null && !address.isEmpty() ){ c.setAddress(address); }
			    	if( zipcode != null && !zipcode.isEmpty() ){ c.setZipcode(zipcode); }
			    	if( ctype != null && !ctype.isEmpty() ){ c.setCtype(ctype); }
			    	if( phone2 != null && !phone2.isEmpty() ){ c.setPhone2(phone2); }
			    	c.setModifiedDate(now);
			    	ContactoLocalServiceUtil.updateContacto(c);
				} catch (SystemException e) {
					System.out.println("editContact exception:" + e.getMessage());
				} catch (PortalException e) {
					System.out.println("editContact exception:" + e.getMessage());
				}
	
	 	}
	
	 	// gracefully redirecting to the default portlet view
	 	String redirectURL = actionRequest.getParameter("redirectURL");
	 	actionResponse.sendRedirect(redirectURL);
   }
   
   public void deleteContact(ActionRequest actionRequest, ActionResponse actionResponse)
  	       throws IOException, PortletException, PortalException, SystemException {
     	
 	 	long contactoId = Long.valueOf( actionRequest.getParameter("contactoId") );
 	 	
 	 	if( contactoId > 0 ){
 			try{
 				ContactoLocalServiceUtil.deleteContacto(contactoId);
 			} catch (SystemException e) {
 				System.out.println("deleteContact exception:" + e.getMessage());
 			}
 	 	}
 	
 	 	// gracefully redirecting to the default portlet view
 	 	String redirectURL = actionRequest.getParameter("redirectURL");
 	 	actionResponse.sendRedirect(redirectURL);

     }
   
   public void getContactosByFilters(ActionRequest actionRequest, ActionResponse actionResponse)
 	       throws IOException, PortletException{
	 try{
		//get params
		String desc = actionRequest.getParameter("ftrdesc");
		String nif = actionRequest.getParameter("ftrnif");
		String firmname = actionRequest.getParameter("ftrfirmname");
		String email = actionRequest.getParameter("ftremail");
		String phone = actionRequest.getParameter("ftrphone");
     	String city = actionRequest.getParameter("ftrcity");
     	String country = actionRequest.getParameter("ftrcountry");
     	String address = actionRequest.getParameter("ftraddress");
     	String zipcode = actionRequest.getParameter("ftrzipcode");
     	String ctype = actionRequest.getParameter("ftrctype");
		
		System.out.println("getContactosByFilters params-> desc:"+desc+" - nif:"+nif+" - firmname:"+firmname+" - email:"+email+" - phone:"+phone+" - city:"+city+" - country:"+country+" - address:"+address+" - zipcode:"+zipcode+" - ctype:"+ctype);
		
		//set session params
		actionRequest.getPortletSession().setAttribute("ftrDesc", desc, PortletSession.PORTLET_SCOPE);
		actionRequest.getPortletSession().setAttribute("ftrNif", nif, PortletSession.PORTLET_SCOPE);
		actionRequest.getPortletSession().setAttribute("ftrFirmname", firmname, PortletSession.PORTLET_SCOPE);
		actionRequest.getPortletSession().setAttribute("ftrEmail", email, PortletSession.PORTLET_SCOPE);
		actionRequest.getPortletSession().setAttribute("ftrPhone", phone, PortletSession.PORTLET_SCOPE);
		actionRequest.getPortletSession().setAttribute("ftrCity", city, PortletSession.PORTLET_SCOPE);
		actionRequest.getPortletSession().setAttribute("ftrCountry", country, PortletSession.PORTLET_SCOPE);
		actionRequest.getPortletSession().setAttribute("ftrAddress", address, PortletSession.PORTLET_SCOPE);
		actionRequest.getPortletSession().setAttribute("ftrZipcode", zipcode, PortletSession.PORTLET_SCOPE);
		actionRequest.getPortletSession().setAttribute("ftrCtype", ctype, PortletSession.PORTLET_SCOPE);
			
	 } catch (Exception e) {
     		System.out.println("Action getContactosByFilters Error: " + e.getMessage() );
     }
   }
   
   public void addProjectContact(ActionRequest actionRequest, ActionResponse actionResponse)
   	       throws IOException, PortletException{
	   
	   long contactoId = Long.valueOf( actionRequest.getParameter("contactoId") );
	   long projectId = Long.valueOf( actionRequest.getParameter("projectId") );
	   
	   try {
		   Project p = ProjectLocalServiceUtil.getProject(projectId);
		   p.setContactoId(contactoId);
		   ProjectLocalServiceUtil.updateProject(p);
		   System.out.println("Action addProjectContact adding " + contactoId +" to project" + projectId );
	   } catch (Exception e) {
		   System.out.println("Action addProjectContact Error: " + e.getMessage() );
	   }
	   
		//go to edit page
		actionResponse.setRenderParameter("contactoId", String.valueOf(contactoId));
		actionResponse.setRenderParameter("jspPage", "/jsp/edit.jsp");
	   
   }
   
   public void delProjectContact(ActionRequest actionRequest, ActionResponse actionResponse)
   	       throws IOException, PortletException{
	   
	   long contactoId = Long.valueOf( actionRequest.getParameter("contactoId") );
	   long projectId = Long.valueOf( actionRequest.getParameter("projectId") );
	   
	   try {
		   Project p = ProjectLocalServiceUtil.getProject(projectId);
		   if(p.getContactoId() == contactoId){
			   p.setContactoId(0);
			   ProjectLocalServiceUtil.updateProject(p);
		   }
	   } catch (Exception e) {
		   System.out.println("Action delProjectContact Error: " + e.getMessage() );
	   }
	   
		//go to edit page
		actionResponse.setRenderParameter("contactoId", String.valueOf(contactoId));
		actionResponse.setRenderParameter("jspPage", "/jsp/edit.jsp");
	   
   }

}

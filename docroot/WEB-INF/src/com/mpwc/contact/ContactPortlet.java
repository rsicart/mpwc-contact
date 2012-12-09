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

import com.liferay.counter.service.CounterLocalServiceUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.util.bridges.mvc.MVCPortlet;
import com.mpwc.model.Contacto;
import com.mpwc.service.ContactoLocalServiceUtil;

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
     	
     	Date now = new Date();
     	
     	if(		firmname != null && !firmname.isEmpty() &&
     			email != null && !email.isEmpty() && email.indexOf("@") > 0 &&
     			nif != null && !nif.isEmpty() &&
     			city != null && !city.isEmpty() &&
     			country != null && !country.isEmpty() &&
     			address != null && !address.isEmpty() &&
     			zipcode != null && !zipcode.isEmpty()
     		){
     		
 	    	Contacto c;
 			try {
 				long contactId = CounterLocalServiceUtil.increment(Contacto.class.getName());
 				c = ContactoLocalServiceUtil.createContacto(contactId);
 				c.setFirmname(firmname);
 		    	c.setNif(nif);
 		    	c.setEmail(email);
 		    	if( phone != null && !phone.isEmpty() ){ c.setPhone(phone); }
 		    	if( status > 0 ){ c.setContactStatusId(status); }
 		    	if( comments != null && !comments.isEmpty() ){ c.setComments(comments); }
 		    	c.setCity(city);
 		    	c.setCountry(country);
 		    	c.setAddress(address);
 		    	c.setZipcode(zipcode);
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
 	
	 	long contactId = Long.valueOf( actionRequest.getParameter("contactId") );
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
	 	
	 	Date now = new Date();
	 	
	 	if( contactId > 0 ){
	 		
		    	Contacto c;
				try {			
					c = ContactoLocalServiceUtil.getContacto(contactId);
					if( firmname != null && !firmname.isEmpty() ){ c.setFirmname(firmname); }
					if( nif != null && !nif.isEmpty() ){ c.setNif(nif); }
					if( email != null && !email.isEmpty() && email.indexOf("@") > 0 ){ c.setEmail(email); }
			    	if( phone != null && !phone.isEmpty() ){ c.setPhone(phone); }
			    	if( status > 0 ){ c.setContactStatusId(status); }
			    	if( comments != null && !comments.isEmpty() ){ c.setComments(comments); }
			    	if( city != null && !city.isEmpty() ){ c.setCity(city); }
			    	if( country != null && !country.isEmpty() ){ c.setCountry(country); }
			    	if( address != null && !address.isEmpty() ){ c.setAddress(address); }
			    	if( zipcode != null && !zipcode.isEmpty() ){ c.setZipcode(zipcode); }
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
     	
 	 	long contactId = Long.valueOf( actionRequest.getParameter("contactId") );
 	 	
 	 	if( contactId > 0 ){
 			try{
 				ContactoLocalServiceUtil.deleteContacto(contactId);
 			} catch (SystemException e) {
 				System.out.println("deleteContact exception:" + e.getMessage());
 			}
 	 	}
 	
 	 	// gracefully redirecting to the default portlet view
 	 	String redirectURL = actionRequest.getParameter("redirectURL");
 	 	actionResponse.sendRedirect(redirectURL);

     }

}

<!--  
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
-->

<%@include file="/jsp/init.jsp" %>

<% 
locale = request.getLocale();
String language = locale.getLanguage();
String country = locale.getCountry();

ResourceBundle res = ResourceBundle.getBundle("content.Language-ext", new Locale(language, country));
%>

<%
	long contactoId = Long.valueOf( renderRequest.getParameter("contactoId") );

	Contacto c = ContactoLocalServiceUtil.getContacto(contactoId);

%>


	<aui:layout>
	
	<h2 class="cooler-label"><%= c.getFirmname() %></h2>
 		
 	<aui:column columnWidth="25" first="true">
 	
 		<aui:fieldset>
	
	    <p class="cooler-label"><%= res.getString("formlabel.city") %></p><p class="cooler-field"><%= c.getCity() %></p>
		
		<p class="cooler-label"><%= res.getString("formlabel.country") %></p><p class="cooler-field"><%= c.getCountry() %></p>
		
		<p class="cooler-label"><%= res.getString("formlabel.address") %></p><p class="cooler-field"><%= c.getAddress() %></p>
		
		<p class="cooler-label"><%= res.getString("formlabel.zipcode") %></p><p class="cooler-field"><%= c.getZipcode() %></p>
		
		<p class="cooler-label"><%= res.getString("formlabel.phone") %></p><p class="cooler-field"><%= c.getPhone() %></p>

		<p class="cooler-label"><%= res.getString("formlabel.phone2") %></p><p class="cooler-field"><%= c.getPhone2() %></p>

		</aui:fieldset>
	
	</aui:column>
	
	<aui:column columnWidth="25" >
	
		<aui:fieldset>
		
	    <p class="cooler-label"><%= res.getString("formlabel.nif") %></p><p class="cooler-field"><%= c.getNif() %></p>

	    <p class="cooler-label"><%= res.getString("formlabel.email") %></p><p class="cooler-field"><%= c.getEmail() %></p>
		
		<% 
			String status = "";
			ContactoStatus cs = ContactoStatusLocalServiceUtil.getContactoStatus(c.getContactoStatusId());
			if( locale.toString().equals("es_ES") ){
				status = cs.getDesc_es_ES();
			} else if( locale.equals("ca_ES") ){
				status = cs.getDesc_ca_ES();
			} else {
				status = cs.getDesc_en_US();
			}
		%>
		<p class="cooler-label"><%= res.getString("formlabel.status") %></p><p class="cooler-field"><%= status %></p>
		
		<% 
			String ctype = "";
			if( c.getCtype().equals("customer") ){
				ctype = res.getString("form-option-type-customer");
			} else if( c.getCtype().equals("provider") ) {
				ctype = res.getString("form-option-type-provider");
			} else{
				ctype = res.getString("please-choose");
			}
		%>
		<p class="cooler-label"><%= res.getString("formlabel.contacttype") %></p><p class="cooler-field"><%= ctype %></p>
		
		<p class="cooler-label"><%= res.getString("formlabel.comments") %></p><p class="cooler-field"><%= c.getComments() %></p>
		
		</aui:fieldset>
		    
	</aui:column>
	
   </aui:layout>

<% 
	if(c.getCtype().equals("customer")){
%>
   
	<aui:layout>
	
	<aui:column columnWidth="45" first="true">
	
	<h2 class="cooler-label"><%= res.getString("jspedit.contact.projectlist") %></h2>
	
	<!-- contact project list grid -->
	 
	<liferay-ui:search-container curParam="cntCp" delta="5" emptyResultsMessage="jspview.message.nocontacts">
	
	<liferay-ui:search-container-results>
	<% 
	try{
		List<Project> contactoResults = ContactoLocalServiceUtil.getProjects(c.getContactoId());
		results = ListUtil.subList(contactoResults, searchContainer.getStart(),searchContainer.getEnd());
		total = contactoResults.size();
		pageContext.setAttribute("results", results);
		pageContext.setAttribute("total",total);
		System.out.println("edit.jsp total: "+total+"locale:"+locale.toString());
	} catch(Exception e){
		System.out.println("edit.jsp exception: "+e.getMessage());
		e.printStackTrace();
	}
	 %>	
	 </liferay-ui:search-container-results>
	 
	 <liferay-ui:search-container-row className="com.mpwc.model.Project" keyProperty="projectId" modelVar="project">
	 	<liferay-ui:search-container-column-text name='<%= res.getString("formlabel.name") %>' property="name" />
	 	<liferay-ui:search-container-column-text name='<%= res.getString("formlabel.type") %>' property="type" />
	 </liferay-ui:search-container-row>
	 
	 <liferay-ui:search-iterator />
	 
	 </liferay-ui:search-container>
	 
	 <!-- end contact project list grid -->
 	
 	</aui:column>		
 	
 	<aui:column columnWidth="45" last="true">
 	
 	</aui:column>
 	
 	</aui:layout>
 	
<% 
	}
%>

   <aui:button-row>
   	
   	<portlet:renderURL var="listURL">
    	<portlet:param name="mvcPath" value="/jsp/view.jsp" />
	</portlet:renderURL>
	<aui:button type="cancel" onClick="<%= listURL.toString() %>" />
   </aui:button-row>
   
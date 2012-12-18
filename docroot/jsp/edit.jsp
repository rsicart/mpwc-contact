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

<h1 class="cooler-label"> <%= res.getString("jspedit.maintitle") %></h1>

<%
	long contactoId = Long.valueOf( renderRequest.getParameter("contactoId") );

	Contacto c = ContactoLocalServiceUtil.getContacto(contactoId);
	
	//searchContainer iteratorURL
	PortletURL iteratorURL = renderResponse.createRenderURL();
	iteratorURL.setParameter("jspPage", "/jsp/edit.jsp");
	iteratorURL.setParameter("contactoId", Long.toString(contactoId));
%>

<portlet:actionURL var="editContactoURL" name="editContact">
    <portlet:param name="jspPage" value="/jsp/edit.jsp" />
    <portlet:param name="contactoId" value="<%= String.valueOf( c.getContactoId() ) %>" />
</portlet:actionURL>

<portlet:renderURL var="redirectURL">
    <portlet:param name="jspPage" value="/jsp/view.jsp" />
    <portlet:param name="contactoId" value="<%= String.valueOf( c.getContactoId() ) %>" />
</portlet:renderURL>

<aui:form action="<%= editContactoURL %>" method="post">
	
	<aui:input type="hidden" name="redirectURL" value="<%= redirectURL.toString() %>"/>

	<aui:layout>
 		
 	<aui:column columnWidth="25" first="true">
 	
 		<aui:fieldset>
 		
 		<liferay-ui:error key="error-firmname-notvalid" message="error-firmname-notvalid" />
 		
		<aui:input label='<%= res.getString("formlabel.firmname") %>' name="firmname" type="text" value="<%= c.getFirmname() %>" >
			<aui:validator name="required" />
			<!-- Only allow alphabetical characters -->
     		<aui:validator name="custom" errorMessage="error-character-not-valid">
				function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{1,100}/g; return (patt.test(val) ) }
			</aui:validator>
		</aui:input>
		
		<liferay-ui:error key="error-city-notvalid" message="error-city-notvalid" />
		
	    <aui:input label='<%= res.getString("formlabel.city") %>' name="city" type="text" value="<%= c.getCity() %>" >
			<aui:validator name="required" />
			<!-- Only allow alphabetical characters -->
     		<aui:validator name="custom" errorMessage="error-character-not-valid">
				function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{1,100}/g; return (patt.test(val) ) }
			</aui:validator>
		</aui:input>
		
		<liferay-ui:error key="error-country-notvalid" message="error-country-notvalid" />
		
		<aui:input label='<%= res.getString("formlabel.country") %>' name="country" type="text" value="<%= c.getCountry() %>" >
			<aui:validator name="required" />
			<!-- Only allow alphabetical characters -->
     		<aui:validator name="custom" errorMessage="error-character-not-valid">
				function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{1,100}/g; return (patt.test(val) ) }
			</aui:validator>
		</aui:input>
		
		<liferay-ui:error key="error-address-notvalid" message="error-address-notvalid" />
		
		<aui:input label='<%= res.getString("formlabel.address") %>' name="address" type="text" value="<%= c.getAddress() %>" >
			<aui:validator name="required" />
			<!-- Only allow alphabetical characters -->
     		<aui:validator name="custom" errorMessage="error-character-not-valid">
				function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{1,100}/g; return (patt.test(val) ) }
			</aui:validator>
		</aui:input>
		
		<liferay-ui:error key="error-zipcode-notvalid" message="error-zipcode-notvalid" />
		
		<aui:input label='<%= res.getString("formlabel.zipcode") %>' name="zipcode" type="text" value="<%= c.getZipcode() %>" >
			<aui:validator name="required" />
			<!-- Only allow numbers -->
     		<aui:validator name="digits" />
		</aui:input>
		
		
		
		<aui:input label='<%= res.getString("formlabel.phone") %>' name="phone" type="text" value="<%= c.getPhone() %>" >
			<!-- Only allow numbers -->
     		<aui:validator name="digits" />
		</aui:input>
		
		<aui:input label='<%= res.getString("formlabel.phone2") %>' name="phone2" type="text" value="<%= c.getPhone2() %>" >
			<!-- Only allow numbers -->
     		<aui:validator name="digits" />
		</aui:input>
		
		</aui:fieldset>
	
	</aui:column>
	
	<aui:column columnWidth="25" >
	
		<aui:fieldset>
		
		<liferay-ui:error key="error-nif-notvalid" message="error-nif-notvalid" />
		
	    <aui:input label='<%= res.getString("formlabel.nif") %>' name="nif" type="text" value="<%= c.getNif() %>" >
			<aui:validator name="required" />
			<!-- Only allow alphabetical characters -->
     		<aui:validator name="alphanum" />
		</aui:input>
		
		<liferay-ui:error key="error-email-notvalid" message="error-email-notvalid" />
		
	    <aui:input label='<%= res.getString("formlabel.email") %>' name="email" type="text" value="<%= c.getEmail() %>" >
			<aui:validator name="required" />
			<!-- Only allow email format -->
     		<aui:validator name="email" />
		</aui:input>  
		
		<liferay-ui:error key="error-status-notvalid" message="error-status-notvalid" />
		
		<aui:select label='<%= res.getString("formlabel.status") %>' name="status">
			<aui:option label='<%= res.getString("formlabel.option.active") %>' value="1" selected='<%= ( c.getContactoStatusId() > 0 && c.getContactoStatusId() == 1 ? true : false ) %>'></aui:option>
			<aui:option label='<%= res.getString("formlabel.option.inactive") %>' value="2" selected='<%= ( c.getContactoStatusId() > 0 && c.getContactoStatusId() == 2 ? true : false ) %>'></aui:option>
			<aui:option label='<%= res.getString("formlabel.option.bloqued") %>' value="3" selected='<%= ( c.getContactoStatusId() > 0 && c.getContactoStatusId() == 3 ? true : false ) %>'></aui:option>
		</aui:select>  
		
		<liferay-ui:error key="error-ctype-notvalid" message="error-ctype-notvalid" />
		
		<aui:select label='<%= res.getString("formlabel.contacttype") %>' id="ctype" name="ctype">
			<aui:option value="">
				<liferay-ui:message key="please-choose" />
			</aui:option>
			<aui:option value="customer" selected='<%= ( c.getCtype() != null && c.getCtype().equals("customer") ? true : false ) %>'>
				<liferay-ui:message key="form-option-type-customer" />
			</aui:option>
			<aui:option value="provider" selected='<%= ( c.getCtype() != null && c.getCtype().equals("provider") ? true : false ) %>'>
				<liferay-ui:message key="form-option-type-provider" />
			</aui:option>
		</aui:select>
		
		<liferay-ui:error key="error-comments-notvalid" message="error-comments-notvalid" />
		
		<aui:input type="textarea" name="comments" value="<%= c.getComments() %>" >
			<!-- Only allow alphabetical characters -->
     		<aui:validator name="custom" errorMessage="error-character-not-valid">
				function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{1,100}/g; return (patt.test(val) ) }
			</aui:validator>
		</aui:input>
	
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
	 
	<liferay-ui:search-container iteratorURL="<%= iteratorURL %>" curParam="cntCp" delta="5" emptyResultsMessage="jspview.message.noprojects">
	
	<liferay-ui:search-container-results>
	<% 
	try{
		//List<Project> contactoResults = ContactoLocalServiceUtil.getProjects(c.getPrimaryKey());
		List<Project> contactoResults = ProjectLocalServiceUtil.findByContactoId(c.getPrimaryKey());
		results = ListUtil.subList(contactoResults, searchContainer.getStart(),searchContainer.getEnd());
		total = contactoResults.size();
		pageContext.setAttribute("results", results);
		pageContext.setAttribute("total",total);
		System.out.println("edit.jsp total: "+total+"projects of contact"+c.getContactoId()+" with PK "+ c.getPrimaryKey());
	} catch(Exception e){
		System.out.println("edit.jsp exception: "+e.getMessage());
		e.printStackTrace();
	}
	 %>	
	 </liferay-ui:search-container-results>
	 
	 <liferay-ui:search-container-row className="com.mpwc.model.Project" keyProperty="projectId" modelVar="project">
	 	<liferay-ui:search-container-column-text name='<%= res.getString("formlabel.projectname") %>' property="name" />
	 	<liferay-ui:search-container-column-text name='<%= res.getString("formlabel.projecttype") %>' property="type" />
		<liferay-ui:search-container-column-jsp path="/jsp/list_actions_edit_assigned.jsp" align="right" />
	 </liferay-ui:search-container-row>
	 
	 <liferay-ui:search-iterator />
	 
	 </liferay-ui:search-container>
	 
	 <!-- end contact project list grid -->
 	
 	</aui:column>
 	
 	
 	<!-- ONLY IF HAS PERMISSIONS TO ASSIGN PROJECTS -->		
 	
	<c:if test='<%= PortletPermissionUtil.contains(permissionChecker, portletDisplay.getId(), "ADD_CONTACT_PROJECT") %>'>
	
		
		<aui:column columnWidth="45" first="true">
		
		<h2 class="cooler-label"><%= res.getString("jspedit.contact.fullprojectlist") %></h2>
		
		<!-- contact project list grid -->
		 
		<liferay-ui:search-container iteratorURL="<%= iteratorURL %>" curParam="fullProjCp" delta="5" emptyResultsMessage="jspview.message.noprojects">
		
		<liferay-ui:search-container-results>
		<% 
		try{
			int max = ProjectLocalServiceUtil.getProjectsCount();
			List<Project> projectResult = ProjectLocalServiceUtil.getProjects(0, max);
			results = ListUtil.subList(projectResult, searchContainer.getStart(),searchContainer.getEnd());
			total = projectResult.size();
			pageContext.setAttribute("results", results);
			pageContext.setAttribute("total",total);
			System.out.println("edit.jsp total: "+total);
		} catch(Exception e){
			System.out.println("edit.jsp exception: "+e.getMessage());
			e.printStackTrace();
		}
		 %>	
		 </liferay-ui:search-container-results>
		 
		 <liferay-ui:search-container-row className="com.mpwc.model.Project" keyProperty="projectId" modelVar="project">
		 	<liferay-ui:search-container-column-text name='<%= res.getString("formlabel.projectname") %>' property="name" />
		 	<liferay-ui:search-container-column-text name='<%= res.getString("formlabel.projecttype") %>' property="type" />
			<liferay-ui:search-container-column-jsp path="/jsp/list_actions_edit.jsp" align="right" />
		 </liferay-ui:search-container-row>
		 
		 <liferay-ui:search-iterator />
		 
		 </liferay-ui:search-container>
		 
		 <!-- end contact project list grid -->
	 	
	 	</aui:column>		
	
	</c:if>
	
	</aui:layout>
 	
<% 
	}
%>


   <aui:button-row>
   	<aui:button type="submit" />
   	
   	<portlet:renderURL var="listURL">
    	<portlet:param name="mvcPath" value="/jsp/view.jsp" />
	</portlet:renderURL>
	<aui:button type="cancel" onClick="<%= listURL.toString() %>" />
   </aui:button-row>
   
</aui:form>

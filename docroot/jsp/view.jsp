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
 
 long groupId = themeDisplay.getLayout().getGroupId();
 //portlet permissions
 String namePortlet = portletDisplay.getId(); //default value
 String primKeyPortlet = "contactportlet"; //portlet name
 
 //portlet actions available (see resource-actions/default.xml)
 String permAddContact = "ADD_CONTACT";
 String permUpdateContact = "UPDATE_CONTACT";
 String permDeleteContact = "DELETE_CONTACT";
 
 //get search filters if necessary
 String ftrDesc = "";
 String ftrNif = "";
 String ftrFirmname = "";
 String ftrEmail = "";
 String ftrPhone = "";
 String ftrCity = "";
 String ftrCountry = "";
 String ftrZipcode = "";
 String ftrAddress = "";
 String ftrCtype = "";

 
 Enumeration<String> sessionParams = request.getSession().getAttributeNames();
 while(sessionParams.hasMoreElements()){
	 String attributeName = (String) sessionParams.nextElement();
	 String decodedName = PortletSessionUtil.decodeAttributeName(attributeName);
	 if(decodedName.equals("ftrDesc") && PortletSessionUtil.decodeScope(attributeName)==PortletSession.PORTLET_SCOPE){
		 ftrDesc = (String)session.getAttribute(attributeName);
	 }
	 if(decodedName.equals("ftrNif") && PortletSessionUtil.decodeScope(attributeName)==PortletSession.PORTLET_SCOPE){
		 ftrNif = (String)session.getAttribute(attributeName);
	 }
	 if(decodedName.equals("ftrFirmname") && PortletSessionUtil.decodeScope(attributeName)==PortletSession.PORTLET_SCOPE){
		 ftrFirmname = (String)session.getAttribute(attributeName);
	 }
	 if(decodedName.equals("ftrEmail") && PortletSessionUtil.decodeScope(attributeName)==PortletSession.PORTLET_SCOPE){
		 ftrEmail = (String)session.getAttribute(attributeName);
	 }
	 if(decodedName.equals("ftrPhone") && PortletSessionUtil.decodeScope(attributeName)==PortletSession.PORTLET_SCOPE){
		 ftrPhone = (String)session.getAttribute(attributeName);
	 }
	 if(decodedName.equals("ftrCity") && PortletSessionUtil.decodeScope(attributeName)==PortletSession.PORTLET_SCOPE){
		 ftrCity = (String)session.getAttribute(attributeName);
	 }
	 if(decodedName.equals("ftrCountry") && PortletSessionUtil.decodeScope(attributeName)==PortletSession.PORTLET_SCOPE){
		 ftrCountry = (String)session.getAttribute(attributeName);
	 }
	 if(decodedName.equals("ftrAddress") && PortletSessionUtil.decodeScope(attributeName)==PortletSession.PORTLET_SCOPE){
		 ftrAddress = (String)session.getAttribute(attributeName);
	 }
	 if(decodedName.equals("ftrZipcode") && PortletSessionUtil.decodeScope(attributeName)==PortletSession.PORTLET_SCOPE){
		 ftrZipcode = (String)session.getAttribute(attributeName);
	 }
	 if(decodedName.equals("ftrCtype") && PortletSessionUtil.decodeScope(attributeName)==PortletSession.PORTLET_SCOPE){
		 ftrCtype = (String)session.getAttribute(attributeName);
	 }
 }
 
 
 String error2 = "";
 try{
	 %>
	
	<portlet:renderURL var="addContactURL">
	   <portlet:param name="mvcPath" value="/jsp/add.jsp" />
	</portlet:renderURL>
	
	<portlet:actionURL var="filterURL" name="getContactosByFilters">
	   <portlet:param name="mvcPath" value="/jsp/view.jsp" />
	</portlet:actionURL>
	
	<aui:form name="frm_list_contacts" action="<%= filterURL %>" method="post">
	
		<aui:input type="hidden" name="redirectURL" value="<%= renderResponse.createRenderURL().toString() %>"/>
			
		<aui:layout>
		
		<aui:column columnWidth="20" first="true">
		
		<aui:fieldset>
		
			<aui:input label='<%= res.getString("formlabel.firmname") %>' id="ftrfirmname" name="ftrfirmname" type="text" value="<%= ftrFirmname %>">
				<!-- Only allow alphabetical characters -->
	     		<aui:validator name="custom" errorMessage="error-character-not-valid">
				    function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{0,100}/g; return (patt.test(val) ) }
				</aui:validator>
			</aui:input>
			
			<aui:input label='<%= res.getString("formlabel.email") %>' id="ftremail" name="ftremail" type="text" value="<%= ftrEmail %>" >
				<!-- Only allow email format -->
	     		<aui:validator name="custom" errorMessage="error-character-not-valid">
				    function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-@.]{0,100}/g; return (patt.test(val) ) }
				</aui:validator>
			</aui:input>
		
		</aui:fieldset>
		
		</aui:column>

		<aui:column columnWidth="20">
		
		<aui:fieldset>
		    
		    <aui:input label='<%= res.getString("formlabel.address") %>' id="ftraddress" name="ftraddress" type="text" value="<%= ftrAddress %>">
				<!-- Only allow alphabetical characters -->
	     		<aui:validator name="custom" errorMessage="error-character-not-valid">
				    function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{0,100}/g; return (patt.test(val) ) }
				</aui:validator>
		    </aui:input>
		    
		    <aui:input label='<%= res.getString("formlabel.zipcode") %>' id="ftrzipcode" name="ftrzipcode" type="text" value="<%= ftrZipcode %>">
				<!-- Only allow numeric characters -->
	     		<aui:validator name="digits" />
		    </aui:input>
		    
		</aui:fieldset>
		
		</aui:column>
		
		<aui:column columnWidth="20">
		<aui:fieldset>
			<aui:input label='<%= res.getString("formlabel.phone") %>' id="ftrphone" name="ftrphone" type="text" value="<%= ftrPhone %>" >
				<!-- Only allow numeric format -->
	     		<aui:validator name="digits" />
			</aui:input>
			
		    <aui:input label='<%= res.getString("formlabel.nif") %>' id="ftrnif" name="ftrnif" type="text" value="<%= ftrNif %>" >
				<!-- Only allow alphabetical characters -->
	     		<aui:validator name="alphanum" />	     		
			</aui:input>
			
		</aui:fieldset>
		</aui:column>

		<aui:column columnWidth="20">
		<aui:fieldset>
		    
		    <aui:input label='<%= res.getString("formlabel.city") %>' id="ftrcity" name="ftrcity" type="text" value="<%= ftrCity %>">
				<!-- Only allow alphabetical characters -->
	     		<aui:validator name="custom" errorMessage="error-character-not-valid">
				    function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{0,100}/g; return (patt.test(val) ) }
				</aui:validator>
		    </aui:input>
		    
		    <aui:input label='<%= res.getString("formlabel.country") %>' id="ftrcountry" name="ftrcountry" type="text" value="<%= ftrCountry %>">
				<!-- Only allow alphabetical characters -->
	     		<aui:validator name="custom" errorMessage="error-character-not-valid">
				    function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{0,100}/g; return (patt.test(val) ) }
				</aui:validator>
		    </aui:input>
		
		</aui:fieldset>
		</aui:column>
		
		<aui:column columnWidth="20" last="true">
		<aui:fieldset>
			<aui:select label='<%= res.getString("formlabel.contacttype") %>' id="ftrctype" name="ftrctype">
				<aui:option value="">
					<liferay-ui:message key="please-choose" />
				</aui:option>
				<aui:option value="customer" selected='<%= ( ftrCtype != null && ftrCtype.equals("customer") ? true : false ) %>'>
					<liferay-ui:message key="form-option-type-customer" />
				</aui:option>
				<aui:option value="provider" selected='<%= ( ftrCtype != null && ftrCtype.equals("provider") ? true : false ) %>'>
					<liferay-ui:message key="form-option-type-provider" />
				</aui:option>
			</aui:select>
			
			<aui:select label='<%= res.getString("formlabel.status") %>' name="ftrdesc">
				<aui:option value="">
					<liferay-ui:message key="please-choose" />
				</aui:option>
				<aui:option label='<%= res.getString("formlabel.option.active") %>' value='<%= res.getString("formlabel.option.active") %>' selected='<%= (ftrDesc != null && ftrDesc.equals(res.getString("formlabel.option.active")) ? true : false ) %>'></aui:option>
				<aui:option label='<%= res.getString("formlabel.option.inactive") %>' value='<%= res.getString("formlabel.option.inactive") %>' selected='<%= (ftrDesc != null && ftrDesc.equals(res.getString("formlabel.option.inactive")) ? true : false ) %>'></aui:option>
				<aui:option label='<%= res.getString("formlabel.option.bloqued") %>' value='<%= res.getString("formlabel.option.bloqued") %>' selected='<%= (ftrDesc != null && ftrDesc.equals(res.getString("formlabel.option.bloqued")) ? true : false ) %>'></aui:option>
			</aui:select>  
			
			<aui:button-row>
				<aui:button type="submit" id="btn_filter" value='<%= res.getString("formlabel.actionfilter") %>' />
				<c:if test="<%= permissionChecker.hasPermission(groupId, namePortlet, primKeyPortlet, permAddContact) %>">
					<aui:button type="button" name="btn_add" value='<%= res.getString("formlabel.actionadd") %>' onClick="<%= addContactURL.toString() %>" />
				</c:if>
			</aui:button-row>
			
		</aui:fieldset>
		</aui:column>
			
	</aui:layout>
	
	</aui:form>
	
	<aui:layout>
	
	<aui:column columnWidth="80" first="true">
	
	<!-- grid -->
	 
	<liferay-ui:search-container curParam="contactCp" delta="10" emptyResultsMessage="jspview.message.nocontacts">
	
	<liferay-ui:search-container-results>
	<% 
		//List<Contact> tempResults = WorkerLocalServiceUtil.getWorkersByFilters(ftrDesc, ftrNif, ftrName, ftrSurname, ftrEmail, ftrPhone);
		List<Contacto> tempResults = ContactoLocalServiceUtil.getContactosByFilters(ftrDesc, ftrNif, ftrFirmname, ftrEmail, ftrPhone, ftrCity, ftrCountry, ftrAddress, ftrZipcode, ftrCtype);
		results = ListUtil.subList(tempResults, searchContainer.getStart(),searchContainer.getEnd());
		total = tempResults.size();
		pageContext.setAttribute("results", results);
		pageContext.setAttribute("total",total);
	 %>	
	 </liferay-ui:search-container-results>
	 
	 <liferay-ui:search-container-row className="com.mpwc.model.Contacto" keyProperty="contactoId" modelVar="contacto">
	 	<liferay-ui:search-container-column-text name='<%= res.getString("formlabel.firmname") %>' property="firmname" />
	 	<liferay-ui:search-container-column-text name='<%= res.getString("formlabel.address") %>' property="address" />
	 	<liferay-ui:search-container-column-text name='<%= res.getString("formlabel.nif") %>' property="nif" />
	 	<liferay-ui:search-container-column-text name='<%= res.getString("formlabel.email") %>' property="email" />
	 	<liferay-ui:search-container-column-text name='<%= res.getString("formlabel.city") %>' property="city" />
	 	<liferay-ui:search-container-column-text name='<%= res.getString("formlabel.country") %>' property="country" />
	 	<!--
	 		<liferay-ui:search-container-column-jsp path="/jsp/list_actions.jsp" align="right" />
	 	-->
	 </liferay-ui:search-container-row>
	 
	 <liferay-ui:search-iterator />
	 
	 </liferay-ui:search-container>
	 
	 <!-- end grid -->
 	
 	</aui:column>	
 	
 	</aui:layout>
 	
 	<aui:layout>	
 	
 	<aui:column columnWidth="20" last="true">
 	
 	</aui:column>
 	
 	</aui:layout>	

	 <%
 } catch (Exception e2) {
		error2 = e2.getMessage();
		System.out.println("Error2 view.jsp: "+error2);
 }
%>
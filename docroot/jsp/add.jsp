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

<h1 class="cooler-label"><b><%= res.getString("jspadd.maintitle") %></b></h1>

<portlet:actionURL var="addContactURL" name="addContact">
    <portlet:param name="mvcPath" value="/jsp/view.jsp" />
</portlet:actionURL>


<aui:form name="frm_add_worker" action="<%= addContactURL %>" method="post">
	
	<aui:input type="hidden" name="redirectURL" value="<%= renderResponse.createRenderURL().toString() %>"/>

	<aui:layout>
 		
 	<aui:column columnWidth="25" first="true">
 	
 		<aui:fieldset>
 		
 			<liferay-ui:error key="error-firmname-notvalid" message="error-firmname-notvalid" />

			<aui:input label='<%= res.getString("formlabel.firmname") %>' name="firmname" type="text" value="">
				<aui:validator name="required" />
				<aui:validator name="custom" errorMessage="error-character-not-valid">
				    function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{1,100}/g; return (patt.test(val) ) }
				</aui:validator>
			</aui:input>
			
			<liferay-ui:error key="error-city-notvalid" message="error-city-notvalid" />
			
			<aui:input label='<%= res.getString("formlabel.city") %>' name="city" type="text" value="">
		    	<aui:validator name="required" />
				<aui:validator name="custom" errorMessage="error-character-not-valid">
				    function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{1,100}/g; return (patt.test(val) ) }
				</aui:validator>
		    </aui:input>
		    
		    <liferay-ui:error key="error-country-notvalid" message="error-country-notvalid" />
		    
		    <aui:input label='<%= res.getString("formlabel.country") %>' name="country" type="text" value="">
		    	<aui:validator name="required" />
				<aui:validator name="custom" errorMessage="error-character-not-valid">
				    function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{1,100}/g; return (patt.test(val) ) }
				</aui:validator>
		    </aui:input>
		    
		    <liferay-ui:error key="error-address-notvalid" message="error-address-notvalid" />
		    
		    <aui:input label='<%= res.getString("formlabel.address") %>' name="address" type="text" value="">
		    	<aui:validator name="required" />
				<aui:validator name="custom" errorMessage="error-character-not-valid">
				    function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{1,100}/g; return (patt.test(val) ) }
				</aui:validator>
		    </aui:input>
		    
		    <liferay-ui:error key="error-zipcode-notvalid" message="error-zipcode-notvalid" />
		    
		    <aui:input label='<%= res.getString("formlabel.zipcode") %>' name="zipcode" type="text" value="" >
				<!-- Only allow numeric format -->
	     		<aui:validator name="digits" />
			</aui:input>
	
			<aui:input label='<%= res.getString("formlabel.phone") %>' name="phone" type="text" value="" >
				<!-- Only allow numeric format -->
	     		<aui:validator name="digits" />
			</aui:input>
			
			<aui:input label='<%= res.getString("formlabel.phone2") %>' name="phone2" type="text" value="" >
				<!-- Only allow numeric format -->
	     		<aui:validator name="digits" />
			</aui:input>
			
			<liferay-ui:error key="error-comments-notvalid" message="error-comments-notvalid" />
			
	   		<aui:input type="textarea" name="comments" value="" >
				<aui:validator name="custom" errorMessage="error-character-not-valid">
				    function(val, fieldNode, ruleValue) { var patt=/[a-zA-Z0-9 ,'-]{0,100}/g; return (patt.test(val) ) }
				</aui:validator>
			</aui:input>
			
		</aui:fieldset>
	
	</aui:column>
	
	<aui:column columnWidth="25" first="true">
	
		<aui:fieldset>
		
			<liferay-ui:error key="error-nif-notvalid" message="error-nif-notvalid" />
	
		    <aui:input label='<%= res.getString("formlabel.nif") %>' name="nif" type="text" value="" >
				<aui:validator name="required" />
				<!-- Only allow alphabetical characters -->
	     		<aui:validator name="alphanum" />	     		
			</aui:input>
			
			<liferay-ui:error key="error-email-notvalid" message="error-email-notvalid" />
			
		    <aui:input label='<%= res.getString("formlabel.email") %>' name="email" type="text" value="" >
				<aui:validator name="required" />
				<!-- Only allow email format -->
	     		<aui:validator name="email" />
			</aui:input>
			
			<liferay-ui:error key="error-status-notvalid" message="error-status-notvalid" />
			
			<aui:select label='<%= res.getString("formlabel.status") %>' name="status">
				<aui:option value="-1">
					<liferay-ui:message key="please-choose" />
				</aui:option>
				<aui:option label='<%= res.getString("formlabel.option.active") %>' value="1"></aui:option>
				<aui:option label='<%= res.getString("formlabel.option.inactive") %>' value="2"></aui:option>
				<aui:option label='<%= res.getString("formlabel.option.bloqued") %>' value="3"></aui:option>
			</aui:select>
			
			<liferay-ui:error key="error-contacttype-notvalid" message="error-contacttype-notvalid" />
			
			<aui:select label='<%= res.getString("formlabel.contacttype") %>' id="ctype" name="ctype">
				<aui:option value="">
					<liferay-ui:message key="please-choose" />
				</aui:option>
				<aui:option value="customer">
					<liferay-ui:message key="form-option-type-customer" />
				</aui:option>
				<aui:option value="provider">
					<liferay-ui:message key="form-option-type-provider" />
				</aui:option>
			</aui:select>
			
		</aui:fieldset>
		    
	</aui:column>
	
   </aui:layout>
   
   <aui:button-row>
   	<aui:button type="submit" />
   	
   	<portlet:renderURL var="listURL">
    	<portlet:param name="mvcPath" value="/jsp/view.jsp" />
	</portlet:renderURL>
	<aui:button type="cancel" onClick="<%= listURL.toString() %>" />
   </aui:button-row>
   
   
</aui:form>
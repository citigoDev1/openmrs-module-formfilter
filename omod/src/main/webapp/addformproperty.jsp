<%@ include file="/WEB-INF/template/include.jsp" %>
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include file="template/localHeader.jsp"%>

<script type="text/javascript">

	/*Javascript to validate form*/
	function validate_form() {
		validate = true;
		if (document.formfilter_form.filterName.value == "") {
			document.getElementById("filterName_error").innerHTML = "<span class='error'><spring:message code='formfilter.cannotBeEmpty' /></span>";
			validate = false;
		} else {
			document.getElementById("filterName_error").innerHTML = "";
		}		

		if (document.formfilter_form.propertyType.value == "Select") {
			document.getElementById("propertyType_error").innerHTML = "<span class='error'><spring:message code='formfilter.selectAOption' /></span>";
			validate = false;
		} else {
			document.getElementById("propertyType_error").innerHTML = "";

			if (document.formfilter_form.propertyType.value == "GenderProperty") {
				var genderValue="";
				 var radioButtons = document.getElementsByName("gender");
				      for (var x = 0; x < radioButtons.length; x ++) {
				         if (radioButtons[x].checked) {
				           genderValue=radioButtons[x].value;
				         }
				      }
				
				if (genderValue == "") {
					document.getElementById("gender_error").innerHTML = "<span class='error'><spring:message code='formfilter.chooseAOption' /></span>";
					validate = false;
				} else {
					document.getElementById("gender_error").innerHTML = "";
				}
			}

			if (document.formfilter_form.propertyType.value == "AgeProperty") {
				
				if (!document.formfilter_form.maximumAge.value.match("^[0-9]+") || !document.formfilter_form.minimumAge.value.match("^[0-9]+")) {
					document.getElementById("age_error").innerHTML = "<span class='error'><spring:message code='formfilter.cannotBeEmptyAndOnlyNumbers' /></span>";
					validate = false;
				} else {

					if (document.formfilter_form.minimumAge.value <= document.formfilter_form.maximumAge.value) {
						document.getElementById("age_error").innerHTML = "";
					} else {
						document.getElementById("age_error").innerHTML = "<span class='error'><spring:message code='formfilter.minimumAgeLessThanMaximumAge' /></span>";
						validate = false;

					}
				}
			}
		}

		return validate;
	}
</script>



<h2>
<spring:message code="formfilter.formFilter" />
</h2>


<form method="POST" name="formfilter_form" id="formfilter_form" onsubmit="return validate_form();">
	<table>
		<tr>
			<td>${formFilter.form.name}			
			<input type="hidden" name="formFilterId" value="${formFilter.formFilterId}" />
			<input type="hidden" name="formFilterPropertyId" value="${formFilterProperty.formFilterPropertyId}" />
			</td>
		</tr>

		<tr>
			<td><spring:message code="formfilter.name" /></td>
			<td> 
				<input type="text" name="filterName" value="${formFilterProperty.filterName}" />
				<span id="filterName_error" ></span>			
			</td>			
		</tr>
		<tr>
			<td><spring:message code="formfilter.description" /></td>
			<td>
				<textarea name="filterDescription" >${formFilterProperty.filterDescription}</textarea>
				
			</td>
		</tr>
			
		<tr>
			<td><spring:message code="formfilter.selectFilterType" /></td>
			<td>
				<select name="propertyType" id="propertyType" >
					<option value="Select" ><spring:message code="formfilter.select" /></option> 
					<option value="AgeProperty"><spring:message code="formfilter.age" /></option>
					<option value="GenderProperty"><spring:message code="formfilter.gender" /></option>
				</select>
				<span id="propertyType_error" ></span>
			</td>
		</tr>
		
 
		<tr id="AgeProperty" >
		  <td><spring:message code="formfilter.ageRange" /></td>
		  <td>
		  <table>
		  	<tr><td><spring:message code="formfilter.minimumAge" /></td><td><input type="text" name="minimumAge" value="${properties.minimumAge}" /></td></tr>
		  	<tr><td><spring:message code="formfilter.maximumAge" /></td><td><input type="text" name="maximumAge" value="${properties.maximumAge}" /></td></tr>
		  </table>
		  <div id="age_error" ></div>
		  </td>	  
		</tr>
		

		<tr id="GenderProperty" >
			<td><spring:message code="formfilter.gender" /></td>
			<td>
			<input type="radio" name="gender" value="M" <c:if test="${properties.gender == 'M'}">checked="true"</c:if> /><spring:message code="formfilter.male" />
			<input type="radio" name="gender" value="F" <c:if test="${properties.gender == 'F'}">checked="true"</c:if> /><spring:message code="formfilter.female" />
			<input type="radio" name="gender" value="U" <c:if test="${properties.gender == 'U'}">checked="true"</c:if> /><spring:message code="formfilter.unknown" />
			<span id="gender_error"  ></span>  
			</td>
		</tr>
		
		<tr>
			<td><input type="submit"  value="Save" /></td>
			<td><input type="button"  value="Cancel" onclick="location.href='viewformfilter.form?formFilterId=${formFilter.formFilterId}'" /></td>
		</tr>


	</table>
	
</form>	
<script>
    /*This script holds the functionality of showing properties as user select from dropdown list#propertyType*/
    
    //Stores current visible row id.
    var temp;
    
    //When page loads all the Filter properties are hidden.
    $j(document).ready(function() {
    	
    	
		<c:choose>
			<c:when test="${empty properties.minimumAge && empty properties.maximumAge }">
				$j('#AgeProperty').hide();
			</c:when>
			<c:otherwise>
			  temp='AgeProperty';
			  $j('#propertyType').val("AgeProperty");
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${empty properties.gender }" >
				$j('#GenderProperty').hide();
			</c:when>
			<c:otherwise>
		  		temp='AgeProperty';
		  		$j('#propertyType').val("GenderProperty");
			</c:otherwise>
		</c:choose>	
		

	});

	//When filter property type is changed it hides the previous and shows selected one. 
	$j('#propertyType').change(function() {
		$j('#' + temp).hide();
		temp = $j('#propertyType').val();
		$j('#' + temp).show();
	});
</script>
	




<%@ include file="/WEB-INF/template/footer.jsp"%>
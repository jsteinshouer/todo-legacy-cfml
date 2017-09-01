 <!---
	PROGRAM: form.cfm
	FOLDER: 
	SECTION: 
	AUTHOR: Jason Steinshouer
	DATE: 
	PURPOSE: Form for adding new ToDo items
	PARAMETERS: 
			
	USAGE NOTES:
			
	
	MODIFICATION LOG:
	DATE:			AUTHOR:			  MODIFICATION:
 	========		========		  ================
--->
<form class="form-inline" action="index.cfm?action=add" method="POST">
	<div class="col-7">
	<cfif structKeyExists(request,"message") and len(request.message)>
		<div class="alert alert-danger"><cfoutput>#request.message#</cfoutput></div>
	</cfif>
	</div>
	<div class="col-7">
  		<input type="text" class="form-control" placeholder="ToDo" name="description">
  	</div>
	<!--- <div class="col-1 checkbox">
		<label>
		  <input type="checkbox">Important
		</label>
	</div> --->
	<div class="col-1">
		<button type="submit" class="btn btn-default">Add</button>
	</div>
</form>

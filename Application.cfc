 <!---
	PROGRAM: Application.cfc
	FOLDER: 
	SECTION: 
	AUTHOR: Jason Steinshouer
	DATE: 
	PURPOSE: 
	PARAMETERS: 
			
	USAGE NOTES:
			
	
	MODIFICATION LOG:
	DATE:			AUTHOR:			  MODIFICATION:
 	========		========		  ================
--->

<cfcomponent output="false">
	<cfset this.name = "TODO_APP">

	<cfset this.datasources[ "todo" ] = {
		class: 'org.h2.Driver',
		connectionString: 'jdbc:h2:./db/todo;MODE=MySQL'
	}>

	<cfset this.datasource = "todo">
	
	<!--- 	onApplicationLoad() as boolean
			Description:  Event handler for application start
	---> 
	<cffunction name="onApplicationStart" output="false">

		<cfquery>
			CREATE TABLE IF NOT EXISTS ToDo (
				p_todo_id bigint IDENTITY(1,1), 
				description VARCHAR(150) NOT NULL,
				completed_date datetime NULL,
				PRIMARY KEY (p_todo_id)
			);
		</cfquery>

		<cfreturn true>
	</cffunction>
	
</cfcomponent>
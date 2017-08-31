<cfsilent>
	<cfparam name="url.action" default="todo">

	<cfswitch expression="#url.action#">
		<!--- Add a new todo  --->
		<cfcase value="add">
			<cfif structKeyExists(form, "description") and len(form.description)>
				<cfquery result="qAddItem">
					INSERT INTO ToDo (description)
					VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">)
				</cfquery>
			<cfelse>
				<cfset request.message = "Description is required!">	
			</cfif>
			<cfquery name="qItems">
				SELECT p_todo_id, description
				FROM ToDo 
				WHERE completed_date IS NULL
			</cfquery>
		</cfcase>
		<cfcase value="complete-todo">
			<!-- Mark todo complete -->
			<cfif structKeyExists(url, "id") and len(url.id)>
				<cfquery name="qCompleteItem">
					UPDATE ToDo
					SET completed_date = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
					WHERE p_todo_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
				</cfquery>
			</cfif>
			<!-- Get new list of todo items -->
			<cfquery name="qItems">
				SELECT p_todo_id, description
				FROM ToDo 
				WHERE completed_date IS NULL
			</cfquery>
		</cfcase>
		<!-- Get the completed todo items -->
		<cfcase value="completed">
			<cfquery name="qItems">
				SELECT p_todo_id, description
				FROM ToDo 
				WHERE completed_date IS NOT NULL
			</cfquery>
		</cfcase>
		<cfdefaultcase>
			<cfquery name="qItems">
				SELECT p_todo_id, description
				FROM ToDo 
				WHERE completed_date IS NULL
			</cfquery>
		</cfdefaultcase>
	</cfswitch>
</cfsilent>
<!DOCTYPE html>
<html>
  <head>
    <title>ToDo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--- Latest compiled and minified CSS --->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.3.2/css/mdb.min.css">
    <!--- <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/css/bootstrap.min.css"> --->
    <link rel="stylesheet" href="/assets/css/style.css">
  </head>
  <body>
    <cfoutput>
    <div class="navbar navbar-dark indigo">

        <a class="navbar-brand" href="##">ToDo</a>
        <ul class="nav navbar-nav mr-auto">
	        <li class="nav-item <cfif url.action neq "completed">active</cfif>"><a href="/" class="nav-link">My ToDo's</a></li>
	        <li class="nav-item <cfif url.action eq "completed">active</cfif>"><a href="/index.cfm?action=completed" class="nav-link">Completed</a></li>
        </ul>
      
    </div>
    </cfoutput>
    <div class="container">
    <cfoutput>
	<div class="col-8">
		<table class="table">
			<thead>
				<tr>
					<th>ToDo</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="qItems">
				<tr>
					<td>#qItems.description#</td>
					<td>
						<cfif url.action neq "completed">
							<a href="/?action=complete-todo&id=#qItems.p_todo_id#" class="btn btn-default btn-sm pull-right">Complete</a></td>
						</cfif>
				</tr>
				</cfloop>
			</tbody>
		</table>
		<cfinclude template="includes/form.cfm">
	</div>
</cfoutput>
	</div>
    <!--- JavaScript plugins (requires jQuery) --->
  	<script src="http://code.jquery.com/jquery.js"></script>
	<!--- Latest compiled and minified JavaScript --->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.3.2/js/mdb.min.js"></script>
  </body>
</html>
/**
* Copyright Since 2005 Ortus Solutions, Corp
* www.ortussolutions.com
**************************************************************************************
*/
component{
	this.name = "TODO_APP_TEST";

	/* Uses an in memory database for testing */
	this.datasources[ "todo" ] = {
		class: 'org.h2.Driver',
		connectionString: 'jdbc:h2:mem:todo;MODE=MySQL'
	};

	this.datasource = "todo";

	// any other application.cfc stuff goes below:
	this.sessionManagement = true;

	// any mappings go here, we create one that points to the root called test.
	this.mappings[ "/tests" ] = getDirectoryFromPath( getCurrentTemplatePath() );

	public boolean function onRequestStart( String targetPage ){

		/* Create table */
		queryExecute("
			CREATE TABLE IF NOT EXISTS ToDo (
				p_todo_id bigint IDENTITY(1,1), 
				description VARCHAR(150) NOT NULL,
				completed_date datetime NULL,
				PRIMARY KEY (p_todo_id)
			);
		");

		return true;
	}
}
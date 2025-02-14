﻿/**
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
*/
component{

	// APPLICATION CFC PROPERTIES
	this.name 				= "ColdBoxTestingSuite" & hash(getCurrentTemplatePath());
	this.sessionManagement 	= true;
	this.sessionTimeout 	= createTimeSpan( 0, 0, 15, 0 );
	this.applicationTimeout = createTimeSpan( 0, 0, 15, 0 );
	this.setClientCookies 	= true;
	
	// Create testing mapping
	this.mappings[ "/tests" ] = getDirectoryFromPath( getCurrentTemplatePath() );
	// Map back to its root
	rootPath = REReplaceNoCase( this.mappings[ "/tests" ], "tests(\\|/)", "" );
	this.mappings["/root"]   = rootPath;
 
	

	public void function onRequestEnd() { 
		structDelete( application, "cbController" );
		structDelete( application, "wirebox" );
	}
	// Locate the cborm module for events
	this.mappings[ "/cborm" ] = rootPath & "modules/cborm";

	// App datasource
	this.datasource = "cms";

	// ORM Settings + Datasource
	this.ormEnabled = "true";
	this.ormSettings = {
		cfclocation = [ "models" ], // Where our entities exist
		logSQL = true, // Remove after development to false.
		dbcreate = "update", // Generate our DB
		automanageSession = false, // Let cborm manage it
		flushAtRequestEnd = false, // Never do this! Let cborm manage it
		eventhandling = true, // Enable events
		eventHandler = "cborm.models.EventHandler", // Who handles the events
		skipcfcWithError = true // Yes, because we must work in all CFML engines
	};

	// request start
	public boolean function onRequestStart( string targetPage ){
		// If we reinit our app, reinit the ORM too
		//if( application.cbBootstrap.isFWReinit() )
			ormReload();

		// Process ColdBox Request
		//application.cbBootstrap.onRequestStart( arguments.targetPage );

		return true;
	}


}
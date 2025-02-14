component{

	function configure(){
		// Set Full Rewrites
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 *
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 *
		 */

		// A nice healthcheck route example
		route("/healthcheck",function(event,rc,prc){
			return "Ok!";
		});

		// API Echo
		get( "/api/echo", "Echo.index" );
		resources( "sessions" );
		resources( "registration" );
		resources( "sessions" );
		resources( "content" );
		// Conventions based routing
		route( ":handler/:action?" ).end();

		
	}

}
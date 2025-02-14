/**
* I am a new handler
*/
component extends="BaseHandler"{
	
	property name="contentService" inject="contentService";
		
	/**
	* index
	*/
	function index( event, rc, prc ){
		//writeDump("Stop"); abort;
		prc.response.setData(
			contentService.list()
				.map( ( item ) => { return item.getMemento(); } )
		);
	}

	/**
	* create
	*/
	function create( event, rc, prc ){
		var oContent = populateModel( "Content" );
		
		oContent.setId(rc.id);
		oContent.setSlug(rc.slug);
		oContent.setTitle(rc.title);
		oContent.setBody(rc.body);
		oContent.setIsPublished(true);
		oContent.setPublishedDate(now());
		oContent.setCreatedDate(now());
		oContent.setModifiedDate(now());
		oContent.setUser(2);
		var response = contentService.create(oContent);
		prc.response.setData(response);
	}

	/**
	* show
	*/
	function show( event, rc, prc ){
		event.paramValue( "id", "" );
		prc.response.setData(
			contentService.findBySlug( rc.id ).getMemento()
		);
	}

	/**
	* update
	*/
	function update( event, rc, prc ){
		var oContent = populateModel( "Content" );
		oContent.setSlug(rc.slug);
		oContent.setBody(rc.body);
		var response = contentService.update( oContent );
		prc.response.setData( response );
	}

	/**
	* delete
	*/
	function delete( event, rc, prc ){
		var response = contentService.deleteBySlug(rc.id);
		if(response != 0){
		  prc.response.setData(response);
		}else{
			prc.response.setError(true).addMessage("Registro no encontrado");	
		}
		
	}


	
}


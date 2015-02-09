component extends="commandbox.system.BaseCommand" {
    
    property name="settingsObj";
         
    /**
	* @websitePath.hint Path to the Website Directory - .\ for current directory
	* @websiteURL.hint The Website URL
	* @engine.hint The CFML Engine you want the Website to run on - lucee, railo or cf11
	* @engine.options Lucee,Railo,CF11
	*/
    function run( required string websitePath, required string websiteURL, required string engine ){
        this.settingsObj = createObject( "component", "set.settings");
        
        ARGUMENTS.websitePath = validateWebsitePath( ARGUMENTS.websitePath );
		
		validateRequiredSettings( ARGUMENTS.websiteURL, ARGUMENTS.websitePath, ARGUMENTS.engine );
		if ( hasError() ) { return; }
			
		var apacheConf = generateApacheConf( ARGUMENTS.websiteURL, ARGUMENTS.websitePath, ARGUMENTS.engine );
		if ( hasError() ) { return; }
		
		outputConfToFile( apacheConf, websiteURL );
		if ( hasError() ) { return; }
		
		runCommand( "kiwiSays restartApache" );
        //runCommand( "kiwiSays stopLucee" );
        //runCommand( "kiwiSays startLucee" );
    }
    
    function validateWebsitePath( websitePath ){
    	
    	websitePath = fileSystemUtil.resolvePath( ARGUMENTS.websitePath );
		if( !directoryExists( ARGUMENTS.websitePath ) ) {
			error( "#ARGUMENTS.websitePath#: No such directory - Please enter a valid relative or full path" );
		}
		return websitePath;
    	
    }
    
    function validateRequiredSettings( required string websiteURL, required string websitePath, required string engine ){
    	
    	if ( validateEngine( ARGUMENTS.engine ) != ""){
    		return error( validateEngine( ARGUMENTS.engine ) );
    		
    	}
    	
    	
    	
    	return "";
    	
    }
    
    function validateEngine( engine ){
    	
    	if ( listFind( "lucee,railo,cf11", ARGUMENTS.engine) == false ){
			return 'Please select a valid Engine - Lucee, Railo or CF11';
		}
    	
    }
    
    function generateApacheConf( required string websiteURL, required string websitePath, required string engine ){
    	
    	var apacheConf = "";
    	
		apacheConf = apacheConf & '<VirtualHost *:80>' & CR;
		apacheConf = apacheConf & getServerAdmin();
		apacheConf = apacheConf & 'DocumentRoot "#websitePath#"' & CR;
		apacheConf = apacheConf & 'ServerName #websiteURL#' & CR;
		apacheConf = apacheConf & getEngineConnection( engine, websitePath );
		apacheConf = apacheConf & '</VirtualHost>' & CR;
		
		print.line().blueLine( apacheConf );
		
		return apacheConf;
    	
    }
    
    function outputConfToFile( required string apacheConf, required string websiteURL ){
    	var apacheConfPath = this.settingsObj.get("apacheConfPath");
    	print.line( 'apacheConfPath = ' & apacheConfPath );
    	if( apacheConfPath == '' ) {
				return error( "#apacheConfPath#: No such directory" );
			}
    	
    	apacheConfPath = fileSystemUtil.resolvePath( apacheConfPath );
    	print.line( 'apacheConfPath = ' & apacheConfPath );
    	if( !directoryExists( apacheConfPath ) ) {
				return error( "#apacheConfPath#: No such directory" );
			}
		print.line( 'Writing Conf to File: ' & apacheConfPath & '/' & websiteURL & '.conf' );
    	fileWrite( apacheConfPath & '/' & websiteURL & '.conf', apacheConf );
    }
    
    function getEngineConnection( engine, websitePath ){
    	var returnConf = '';
    	
    	if ( engine == 'CF11'){
			returnConf = returnConf & 'Include "' & this.settingsObj.get("cf11ConnFile") & '"' & CR;	
		}
		else {
			
			returnConf = returnConf & '<Proxy *>' & CR;
			returnConf = returnConf & 'Allow from 127.0.0.1' & CR;
			returnConf = returnConf & '</Proxy>' & CR;
			returnConf = returnConf & 'ProxyPreserveHost On' & CR;
			returnConf = returnConf & 'ProxyPassMatch ^/(.+\.cf[cm])(/.*)?$ ajp://localhost:';
			returnConf = returnConf & getEnginePort( engine );
			returnConf = returnConf & getProxyPath( websitePath ) & '/$1$2' & CR;

		}
    	return returnConf;
    }
    
    
    
    function getEnginePort( engine ){
    	if ( engine == "Railo" ){
    		return this.settingsObj.get("railoAJPPort");
    	}
    	else {
    		return this.settingsObj.get("luceeAJPPort");
    	}
    }
    
    function getServerAdmin(){
    	if ( this.settingsObj.get("ApacheAdminEmail") GT ""){
			return 'ServerAdmin ' & this.settingsObj.get("ApacheAdminEmail") & CR;	
		}
		else {
			return '';
		}
    }
    
    function getProxyPath( required string websitePath ) {
    	return replacenocase( websitePath, this.settingsObj.get("tomcatRootPath"), "" );
    	
    }
}
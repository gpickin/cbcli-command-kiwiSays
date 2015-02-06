component extends="commandbox.system.BaseCommand" {
         
    /**
	* @websiteURL.hint The Website URL
	* @websitePath.hint Path to the Website Directory
	*/
    function run( required string websiteURL, required string websitePath ){
        ARGUMENTS.websitePath = fileSystemUtil.resolvePath( ARGUMENTS.websitePath );
		
		generateApacheConf( ARGUMENTS.websiteURL, ARGUMENTS.websitePath);
		
        runCommand( "run 'sudo apachectl restart’" );
        runCommand( "kiwiSays stopLucee" );
        runCommand( "kiwiSays startLucee" );
    }
    
    function generateApacheConf( required string websiteURL, required string websitePath ){
    	
    	var apacheConf = "";
		apacheConf = apacheConf & '<VirtualHost *:80>#CR#';
		apacheConf = apacheConf & 'ServerAdmin myemail@mydomain.com#CR#';
		apacheConf = apacheConf & 'DocumentRoot "#websitePath#"#CR#';
		apacheConf = apacheConf & 'ServerName #websiteURL##CR#';
		apacheConf = apacheConf & 'Include /www/_servers/conf/inc_lucee_conn.inc#CR#';
		apacheConf = apacheConf & '</VirtualHost>#CR#';
		
		print.line().line( apacheConf );
		fileWrite( '/www/apacheconfs/#websiteURL#.conf', apacheConf );
    	
    }
}
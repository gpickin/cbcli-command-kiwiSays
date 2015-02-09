component extends="commandbox.system.BaseCommand" {

	/**
	* @tomcatRootPath.hint This is the Root Path that matches your Tomcat Context. This is used for Lucee / Railo Context Proxy Connection. 
	*/
     function run( required string tomcatRootPath ) {
          ARGUMENTS.tomcatRootPath = fileSystemUtil.resolvePath( ARGUMENTS.tomcatRootPath );
          
          if( !directoryExists( ARGUMENTS.tomcatRootPath ) ) {
				return error( "#ARGUMENTS.tomcatRootPath#: No such directory" );
			}
			
          print.line('Setting tomcatRootPath to - ' & tomcatRootPath);
          new settings().set( "tomcatRootPath", tomcatRootPath );
     }
}
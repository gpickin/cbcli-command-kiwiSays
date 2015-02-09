component extends="commandbox.system.BaseCommand" {

	/**
	* @luceeBinPath.hint The Full Path to your Lucee Bin Folder
	* @luceeHTTPPort.hint The Port Used by Lucee for HTTP Requests - Defaults to 8888
	* @luceeAJPPort.hint The Port Used by Lucee for AJP Requests - Defaults to 8009
	*/
     function run( required string luceeBinPath, string luceeHTTPPort="", string luceeAJPPort="" ) {
          
          ARGUMENTS.luceeBinPath = fileSystemUtil.resolvePath( ARGUMENTS.luceeBinPath );
          if( !directoryExists( arguments.luceeBinPath ) ) {
				return error( "#arguments.luceeBinPath#: No such directory" );
			}
			
          print.line('Setting luceeBinPath to - ' & luceeBinPath);
          new settings().set( "luceeBinPath", luceeBinPath );
          
          if ( luceeHTTPPort > ""){
          	print.line('Setting luceeHTTPPort to - ' & luceeHTTPPort);
          	new settings().set( "luceeHTTPPort", luceeHTTPPort );
          }
          
          if ( luceeAJPPort > ""){
          	print.line('Setting luceeAJPPort to - ' & luceeAJPPort);
          	new settings().set( "luceeAJPPort", luceeAJPPort );
          }
     }
}
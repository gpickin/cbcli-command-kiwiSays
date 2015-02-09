component extends="commandbox.system.BaseCommand" {

	/**
	* @ApacheAdminEmail.hint The Email Address to use in Apache Virtual Host Conf files for ServerAdmin 
	*/
     function run( required string ApacheAdminEmail ) {
          print.line('Setting Apache ServerAdmin to - ' & ApacheAdminEmail);
          new settings().set( "ApacheAdminEmail", ApacheAdminEmail );
     }
}
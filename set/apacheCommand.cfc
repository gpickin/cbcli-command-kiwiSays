component extends="commandbox.system.BaseCommand" {

	/**
	* @commandString.hint The command required to restart apache - sudo apachectl restart. 
	*/
     function run( required string commandString ) {
          print.line('Setting Apache Command to - ' & commandString);
          new settings().set( "ApacheCommand", commandString );
     }
}
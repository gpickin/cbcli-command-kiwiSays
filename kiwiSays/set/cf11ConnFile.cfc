component extends="commandbox.system.BaseCommand" {

	/**
	* @cf11ConnFile.hint The CF11 Connection File to be included in Apache Virtual Host 
	*/
     function run( required string cf11ConnFile ) {
          print.line('Setting cf11ConnFile to - ' & cf11ConnFile);
          new settings().set( "cf11ConnFile", cf11ConnFile );
     }
}

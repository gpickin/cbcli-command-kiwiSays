component extends="commandbox.system.BaseCommand" {

     function run() {
          
          var settingsObj = createObject( 'component', "set.settings").loadSettings();
          if ( settingsObj.get("apacheCommand") > "" ){
          	runRestartApache( settingsObj );
          }
          else {
          	outputMissingSettingError();
          }	
     }
     
     function runRestartApache( required struct settingsObj ) {
     	print.line('Restarting Apache');
      	 try {
      	 	runCommand( "run '" & settingsObj.get("apacheCommand") & "'" );
      	 }
      	 catch ( any e ) {
      	 	print.redBoldLine('Restarting Apache Failed - Please check your Command');
      	 }
     }
     
     function outputMissingSettingError() {
     	print.redBoldLine('Restarting Apache failed');
		print.line('Please set Apache command using the following command:');
		print.magentatext('kiwiSays set apacheCommand "sudo apachectl restart"');
     }
     
}
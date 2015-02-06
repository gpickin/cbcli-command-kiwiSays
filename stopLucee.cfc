component extends="commandbox.system.BaseCommand" {

     function run() {
          var serverPath = '/www/_servers/lucee';
          
          print.line('Stopping Lucee - ' & serverPath);
          runCommand( "run '#serverPath#/bin/shutdown.sh'" );
          
     }

}
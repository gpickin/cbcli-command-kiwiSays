component extends="commandbox.system.BaseCommand" {

     function run() {
          var serverPath = '/www/_servers/lucee';
          
          print.line('Starting Lucee - ' & serverPath);
          var result = runCommand( "run '#serverPath#/bin/startup.sh'");
          print.line( result );
     }

}
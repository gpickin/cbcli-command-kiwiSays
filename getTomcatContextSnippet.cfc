component extends="commandbox.system.BaseCommand" {

	function run( string contextName="catchallContext", string appBase="webapps" ) {
		var xmlSnippet = "";
    	var settingsObj = createObject( "component", "set.settings");
    	
		xmlSnippet = xmlSnippet & '<Host name="#contextName#" appBase="#appBase#">' & CR;
		xmlSnippet = xmlSnippet & '<Context path="" docBase="' & settingsObj.get("tomcatRootPath") & '" />' & CR;
		xmlSnippet = xmlSnippet & '</Host>' & CR;
		
		print.line().line( xmlSnippet );
	}

}    
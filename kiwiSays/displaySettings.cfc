component extends="commandbox.system.BaseCommand" {

     function run() {
		settingsObj = createObject( 'component', "set.settings").loadSettings();
		
		for  ( settings in settingsObj ){
			print.line( settings & ' : ' & settingsObj[settings]);
		}
	}

}	
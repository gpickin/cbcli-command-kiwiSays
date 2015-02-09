component {
	
	function init() {
		return this;
	}
	
	function loadSettings(){
		var jsonObj = fileRead( 'settings.json' );
		return DeserializeJSON( jsonObj );
		
	}
	
	function loadDefaultSettings(){
		var jsonObj = fileRead( 'defaultSettings.json' );
		return DeserializeJSON( jsonObj );
		
	}
	
	function saveSettings( required struct settingsObj ){
		fileWrite( 'settings.json', SerializeJSON( settingsObj ) );
	}
	
	function set( required string settingName, required string settingValue ){
		settingsObj = loadSettings();
		settingsObj[settingName] = settingValue;
		
		saveSettings( settingsObj );
	}
	
	function get( required string settingName ){
		settingsObj = loadSettings();
		defaultsettingsObj = loadDefaultSettings();
		
		if ( structKeyExists( settingsObj, settingName ) ) {
			return settingsObj[settingName];
		}
		else if ( structKeyExists( defaultsettingsObj, settingName ) ) {
			return defaultsettingsObj[settingName];
		}
		else {
			return '';
		}
			
		
	}
	
}
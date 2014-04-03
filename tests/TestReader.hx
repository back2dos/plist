package ;

class TestReader extends Base {
	function testRead() {

		assertStructEq({
			Author : 'William Shakespeare',
			Lines : ['It is a tale told by an idiot,', 'Full of sound and fury, signifying nothing.'],
			Birthdate : 1564,
		}, plist.Reader.read(SHAKESPEARE));
		
		assertStructEq({
			author: 'foobar',
			displayName: 'Manuscript',
			enabled: true,
			identifier: 'manuscript',
			styleSheet: 'blabla',
			type: 'richText',
		}, plist.Reader.read(OTHER));
	}
	
	static public var SHAKESPEARE = 
		'<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist SYSTEM "file://localhost/System/Library/DTDs/PropertyList.dtd">
		<plist version="1.0">
		<dict>
		    <key>Author</key>
		    <string>William Shakespeare</string>
		    <key>Lines</key>
		    <array>
		        <string>It is a tale told by an idiot,</string>
		        <string>Full of sound and fury, signifying nothing.</string>
		    </array>
		    <key>Birthdate</key>
		    <integer>1564</integer>
		</dict>
		</plist>';

	static public var OTHER = 
		'<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
		<dict>
			<key>author</key>
			<string>foobar</string>
			<key>displayName</key>
			<string>Manuscript</string>
			<key>enabled</key>
			<true/>
			<key>identifier</key>
			<string>manuscript</string>
			<key>styleSheet</key>
			<string>blabla</string>
			<key>type</key>
			<string>richText</string>
		</dict>
		</plist>';


}
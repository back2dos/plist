package ;

import plist.Reader.read;
import plist.Writer.write;

using tink.CoreApi;

class TestWriter extends Base {
	function testWrite() {
		function roundtrip(data:String) {
			var data = read(data);
			assertStructEq(data, read(write(data).sure()));
		}
		
		roundtrip(TestReader.SHAKESPEARE);
		// roundtrip(TestReader.OTHER);
		// assertStructEq({
		// 	Author : 'William Shakespeare',
		// 	Lines : ['It is a tale told by an idiot,', 'Full of sound and fury, signifying nothing.'],
		// 	Birthdate : 1564,
		// }, plist.Reader.read(SHAKESPEARE));
		
		// assertStructEq({
		// 	author: 'foobar',
		// 	displayName: 'Manuscript',
		// 	enabled: true,
		// 	identifier: 'manuscript',
		// 	styleSheet: 'blabla',
		// 	type: 'richText',
		// }, plist.Reader.read(OTHER));
	}

}
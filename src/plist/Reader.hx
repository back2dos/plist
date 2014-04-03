package plist;

using tink.CoreApi;

class Reader {
	static public function read(s:String):Dynamic 
		return parseNode(Xml.parse(s).firstElement());
	
	static function val(x:Xml)
		return x.firstChild().nodeValue;
		
	static function parseNode(x:Xml):Dynamic 
		return
			switch x.nodeName {
				case 'plist': parseNode(x.firstElement());
				case 'data': Date.fromString(val(x));
				case 'dict': 
					var elts = x.elements(),
						ret:Dynamic = {};
						
					while (elts.hasNext()) 
						Reflect.setField(ret, val(elts.next()), parseNode(elts.next()));
					ret;
				case 'true': true;
				case 'false': false;
				case 'array': [for (c in x.elements()) parseNode(c)];
				case 'string': val(x);
				case 'integer': Std.parseInt(val(x));
				case 'real': Std.parseFloat(val(x));
				case v: null;
			}
}
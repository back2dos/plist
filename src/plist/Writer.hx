package plist;

using tink.CoreApi;

private abstract Content(Array<Xml>) from Array<Xml> to Array<Xml> {
	@:from static function ofXml(x:Xml):Content
		return [x];
		
	@:from static function ofAny<A>(data:A):Content
		return [Xml.createPCData(Std.string(data))];
}

class Writer {
	static public function write(data:Dynamic) 
		return
			try {
				var ret = marshall(data);
				var x = Xml.createDocument();
				x.addChild(Xml.createProcessingInstruction('xml version="1.0" encoding="UTF-8"'));
				var doctype = Xml.createDocType('plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"');
				x.addChild(doctype);
				x.addChild(node('plist', ret));
				
				Success(x.toString());
			}
			catch (e:Dynamic) 
				Failure(Error.withData('PLIST:DATA_NOT_SERIALIZABLE', { error: e, data: data }));
		
	
	static function node(tag:String, c:Content):Xml {
		var ret = Xml.createElement(tag);
		for (n in (c : Array<Xml>))
			ret.addChild(n);
		return ret;
	}
		
	static function marshall<A>(value:A):Xml {
		return
			switch Type.typeof(value) {
				case TObject:
					var pairs = [];
					for (f in Reflect.fields(value)) {
						if (Reflect.field(value, f) != null) {
							pairs.push(node('key', f));
							pairs.push(marshall(Reflect.field(value, f)));
						}
					}
					node('dict', pairs);
				case TBool:
					node(Std.string(value), []);
				case TClass(Date):
					node('date', value);
				case TClass(String):
					node('string', value);
				case TInt:
					node('integer', value);
				case TFloat:
					node('real', value);
				case TClass(Array):
					node('array', [for (value in (cast value : Array<Dynamic>)) if (value != null) marshall(value)]);
				case v: 
					throw 'cannot encode $v';
			}
	}
}
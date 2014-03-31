package ;

import haxe.unit.*;


class Run {
	static var tests:Array<TestCase> = [
		new TestParser(),
	];
	static function main() {	
		#if js//works for nodejs and browsers alike
		var buf = [];
		TestRunner.print = function (s:String) {
			var parts = s.split('\n');
			if (parts.length > 1) {
				parts[0] = buf.join('') + parts[0];
				buf = [];
				while (parts.length > 1)
					untyped console.log(parts.shift());
			}
			buf.push(parts[0]);
		}
		#end	
		
		var r = new TestRunner();
		for (c in tests)
			r.add(c);
		r.run();
	}
}
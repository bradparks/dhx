/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

package dhx;
import dhx.Namespace;
import js.html.Element;
import dhx.Selection;
import dhx.Transition;

class AccessTweenAttribute<That : BaseTransition<Dynamic>> extends AccessTween<That>
{
	var name : String;
	var qname : NSQualifier;
	public function new(name : String, transition : BaseTransition<That>, tweens : Map<String, Element -> Int -> (Float -> Void)>)
	{
		super(transition, tweens);
		this.name = name;
		this.qname = Namespace.qualify(name);
	}

	public function stringNodef(f : Element -> Int -> String)
	{
		return stringTweenNodef(transitionStringTweenf(f));
	}

	public function string(value : String)
	{
		return stringTweenNodef(transitionStringTween(value));
	}

	public function stringTweenNodef(tween : Element -> Int -> String -> (Float -> String))
	{
		var name = this.name;

		function attrTween(d : Element, i : Int) : Float -> Void
		{
			var f = tween(d, i, d.getAttribute(name));
			return function(t) {
				d.setAttribute(name, f(t));
			};
		}

		function attrTweenNS(d : Element, i : Int) : Float -> Void
		{
			var f = tween(d, i, untyped d.getAttributeNS(name.space, name.local));
			return function(t) {
				untyped d.setAttributeNS(name.space, name.local, f(t));
			};
		}

		tweens.set("attr." + name, null == qname ? attrTween : attrTweenNS);
		return _that();
	}

	public function floatNodef(f : Element -> Int -> Float)
	{
		return floatTweenNodef(transitionFloatTweenf(f));
	}

	public function float(value : Float)
	{
		return floatTweenNodef(transitionFloatTween(value));
	}

	public function floatTweenNodef(tween : Element -> Int -> Float -> (Float -> Float))
	{
		var name = this.name;

		function attrTween(d : Element, i : Int) : Float -> Void
		{
			var f = tween(d, i, Std.parseFloat(d.getAttribute(name)));
			return function(t) {
				d.setAttribute(name, "" + f(t));
			};
		}

		function attrTweenNS(d : Element, i : Int) : Float -> Void
		{
			var f = tween(d, i, Std.parseFloat(untyped d.getAttributeNS(name.space, name.local)));
			return function(t) {
				untyped d.setAttributeNS(name.space, name.local, ""  + f(t));
			};
		}

		tweens.set("attr." + name, null == qname ? attrTween : attrTweenNS);
		return _that();
	}
}

class AccessDataTweenAttribute<T, That : BaseTransition<Dynamic>> extends AccessTweenAttribute<That>
{
	public function new(name : String, transition : BoundTransition<T>, tweens : Map<String, Element -> Int -> (Float -> Void)>)
	{
		super(name, cast transition, tweens);
	}

	public function stringf(f : T -> Int -> String)
	{
		return stringTweenNodef(transitionStringTweenf(function(n,i) return f(Access.getData(n),i)));
	}

	public function floatf(f : T -> Int -> Float)
	{
		return floatTweenNodef(transitionFloatTweenf(function(n,i) return f(Access.getData(n),i)));
	}

	public function stringTweenf(tween : T -> Int -> String -> (Float -> String))
	{
		var name = this.name;

		function attrTween(n : Element, i : Int) : Float -> Void
		{
			var f = tween(Access.getData(n), i, n.getAttribute(name));
			return function(t) {
				n.setAttribute(name, f(t));
			};
		}

		function attrTweenNS(n : Element, i : Int) : Float -> Void
		{
			var f = tween(Access.getData(n), i, untyped n.getAttributeNS(name.space, name.local));
			return function(t) {
				untyped n.setAttributeNS(name.space, name.local, f(t));
			};
		}

		tweens.set("attr." + name, null == qname ? attrTween : attrTweenNS);
		return _that();
	}

	public function floatTweenf(tween : T -> Int -> Float -> (Float -> Float))
	{
		var name = this.name;

		function attrTween(n : Element, i : Int) : Float -> Void
		{
			var f = tween(Access.getData(n), i, Std.parseFloat(n.getAttribute(name)));
			return function(t) {
				n.setAttribute(name, "" + f(t));
			};
		}

		function attrTweenNS(n : Element, i : Int) : Float -> Void
		{
			var f = tween(Access.getData(n), i, Std.parseFloat(untyped n.getAttributeNS(name.space, name.local)));
			return function(t) {
				untyped n.setAttributeNS(name.space, name.local, ""  + f(t));
			};
		}

		tweens.set("attr." + name, null == qname ? attrTween : attrTweenNS);
		return _that();
	}
}
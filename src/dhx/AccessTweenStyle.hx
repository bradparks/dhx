/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

package dhx;
import js.html.Element;
import dhx.Selection;
import dhx.Transition;

class AccessTweenStyle<That : BaseTransition<Dynamic>> extends AccessTween<That>
{
	var name : String;
	public function new(name : String, transition : BaseTransition<That>, tweens : Map<String, Element -> Int -> (Float -> Void)>)
	{
		super(transition, tweens);
		this.name = name;
	}

	public function floatNodef(f : Element -> Int -> Float, ?priority : String)
	{
		return floatTweenNodef(transitionFloatTweenf(f), priority);
	}

	public function float(value : Float, ?priority : String)
	{
		return floatTweenNodef(transitionFloatTween(value), priority);
	}

	public function floatTweenNodef(tween : Element -> Int -> Float -> (Float -> Float), ?priority : String)
	{
		var name = this.name;
		function styleTween(d : Element, i : Int) : Float -> Void
		{
			var f = tween(d, i, Std.parseFloat(AccessStyle.getComputedStyleValue(d, name)));
			return function(t)
			{
				AccessStyle.setStyleProperty(d, name, "" + f(t), priority);
			}
		}
		tweens.set("style." + name, styleTween);
		return _that();
	}

	public function stringNodef(f : Element -> Int -> String, ?priority : String)
	{
		return stringTweenNodef(transitionStringTweenf(f), priority);
	}

	public function string(value : String, ?priority : String)
	{
		return stringTweenNodef(transitionStringTween(value), priority);
	}

	public function stringTweenNodef(tween : Element -> Int -> String -> (Float -> String), ?priority : String)
	{
		if (null == priority)
			priority = null; // FF fix
		var name = this.name;
		function styleTween(d : Element, i : Int) : Float -> Void
		{
			var f = tween(d, i, AccessStyle.getComputedStyleValue(d, name));
			return function(t)
			{
				AccessStyle.setStyleProperty(d, name, f(t), priority);
			}
		}
		tweens.set("style." + name, styleTween);
		return _that();
	}
#if thx
	public function colorNodef(f : Element -> Int -> thx.color.Rgb, ?priority : String)
	{
		return colorTweenNodef(transitionColorTweenf(f), priority);
	}

	public function color(value : String, ?priority : String)
	{
		return colorTweenNodef(transitionColorTween(thx.color.Colors.parse(value)), priority);
	}

	public function colorTweenNodef(tween : Element -> Int -> thx.color.Rgb -> (Float -> thx.color.Rgb), ?priority : String)
	{
		if (null == priority)
			priority = null; // FF fix
		var name = this.name;
		function styleTween(d : Element, i : Int) : Float -> Void
		{
			var f = tween(d, i, thx.color.Colors.parse(AccessStyle.getComputedStyleValue(d, name)));
			return function(t)
			{
				AccessStyle.setStyleProperty(d, name, f(t).toRgbString(), priority);
			}
		}
		tweens.set("style." + name, styleTween);
		return _that();
	}
#end
}

class AccessDataTweenStyle<T, That : BaseTransition<Dynamic>> extends AccessTweenStyle<That>
{
	public function new(name : String, transition : BoundTransition<T>, tweens : Map<String, Element -> Int -> (Float -> Void)>)
	{
		super(name, cast transition, tweens);
	}

	public function floatf(f : T -> Int -> Float, ?priority : String)
	{
		return floatTweenNodef(transitionFloatTweenf(function(n,i) return f(Access.getData(n),i)), priority);
	}

	public function floatTweenf(tween : T -> Int -> Float -> (Float -> Float), ?priority : String)
	{
		if (null == priority)
			priority = null; // FF fix
		var name = this.name;
		function styleTween(d : Element, i : Int) : Float -> Void
		{
			var f = tween(Access.getData(d), i, Std.parseFloat(AccessStyle.getComputedStyleValue(d, name)));
			return function(t)
			{
				AccessStyle.setStyleProperty(d, name, "" + f(t), priority);
			}
		}
		tweens.set("style." + name, styleTween);
		return _that();
	}

	public function stringf(f : T -> Int -> String, ?priority : String)
	{
		return stringTweenNodef(transitionStringTweenf(function(n,i) return f(Access.getData(n),i)), priority);
	}

	public function stringTweenf(tween : T -> Int -> String -> (Float -> String), ?priority : String)
	{
		if (null == priority)
			priority = null; // FF fix
		var name = this.name;
		function styleTween(d : Element, i : Int) : Float -> Void
		{
			var f = tween(Access.getData(d), i, AccessStyle.getComputedStyleValue(d, name));
			return function(t)
			{
				AccessStyle.setStyleProperty(d, name, f(t), priority);
			}
		}
		tweens.set("style." + name, styleTween);
		return _that();
	}
#if thx
	public function colorf(f : T -> Int -> thx.color.Rgb, ?priority : String)
	{
		return colorTweenNodef(transitionColorTweenf(function(n,i) return f(Access.getData(n),i)), priority);
	}

	public function colorTweenf(tween : T -> Int -> thx.color.Rgb -> (Float -> thx.color.Rgb), ?priority : String)
	{
		if (null == priority)
			priority = null; // FF fix
		var name = this.name;
		function styleTween(d : Element, i : Int) : Float -> Void
		{
			var f = tween(Access.getData(d), i, thx.color.Colors.parse(AccessStyle.getComputedStyleValue(d, name)));
			return function(t)
			{
				AccessStyle.setStyleProperty(d, name, f(t).toRgbString(), priority);
			}
		}
		tweens.set("style." + name, styleTween);
		return _that();
	}
#end
}
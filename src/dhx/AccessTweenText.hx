/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

package dhx;
import js.html.Element;
import dhx.Namespace;
import dhx.Selection;
import dhx.Transition;

class AccessTweenText<That : BaseTransition<Dynamic>> extends AccessTween<That>
{
	public function new(transition : BaseTransition<That>, tweens : Map<String, Element -> Int -> (Float -> Void)>)
	{
		super(transition, tweens);
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
		function handler(d : Element, i : Int) : Float -> Void
		{
			var f = tween(d, i, untyped d.textContent);
			return function(t)
			{
				untyped d.textContent = f(t);
			}
		}

		tweens.set("text", handler);
		return _that();
	}

	public function charsNodef(f : Element -> Int -> String)
	{
		return stringTweenNodef(transitionCharsTweenf(f));
	}

	public function chars(value : String)
	{
		return stringTweenNodef(transitionCharsTween(value));
	}
}

class AccessDataTweenText<T, That : BaseTransition<Dynamic>> extends AccessTweenText<That>
{
	public function new(transition : BoundTransition<T>, tweens : Map<String, Element -> Int -> (Float -> Void)>)
	{
		super(cast transition, tweens);
	}

	public function stringf(f : T -> Int -> String)
	{
		return stringTweenNodef(transitionStringTweenf(function(n,i) return f(Access.getData(n),i)));
	}

	public function charsf(f : T -> Int -> String)
	{
		return stringTweenNodef(transitionCharsTweenf(function(n,i) return f(Access.getData(n),i)));
	}

	public function stringTweenf(tween : T -> Int -> String -> (Float -> String))
	{
		function handler(n : Element, i : Int) : Float -> Void
		{
			var f = tween(Access.getData(n), i, untyped d.textContent);
			return function(t)
			{
				untyped d.textContent = f(t);
			}
		}

		tweens.set("text", handler);
		return _that();
	}
}
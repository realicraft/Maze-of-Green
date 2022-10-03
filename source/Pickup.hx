package;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Pickup extends FlxSprite
{
	public var pickup_type = 0;

	public function new(x:Float, y:Float, t:Int)
	{
		pickup_type = t;
		super(x, y);
		loadGraphic(AssetPaths.tiles__png, true, 16, 16);
		animation.add("c1", [24], 6, false);
		animation.add("c2", [25], 6, false);
		animation.add("c3", [26], 6, false);
		animation.add("c4", [27], 6, false);
		animation.add("c5", [28], 6, false);
		animation.add("k", [18], 6, false);
	}

	function animate()
	{
		switch (pickup_type)
		{
			case 0:
				animation.play("c1");
			case 1:
				animation.play("c2");
			case 2:
				animation.play("c3");
			case 3:
				animation.play("c4");
			case 4:
				animation.play("c5");
			case 5:
				animation.play("k");
			case _:
		}
	}

	override function update(elapsed:Float)
	{
		animate();
		super.update(elapsed);
	}

	override function kill()
	{
		alive = false;
		FlxTween.tween(this, {alpha: 0, y: y - 16}, 0.33, {ease: FlxEase.circOut, onComplete: finishKill});
	}

	function finishKill(_)
	{
		exists = false;
	}
}

package;

import flixel.FlxSprite;

class Lever extends FlxSprite
{
	public var pushed = false;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.tiles__png, true, 16, 16);
		animation.add("off", [19], 6, false);
		animation.add("on", [20], 6, false);
	}

	function animate()
	{
		switch (pushed)
		{
			case false:
				animation.play("off");
			case true:
				animation.play("on");
			case _:
		}
	}

	override function update(elapsed:Float)
	{
		animate();
		super.update(elapsed);
	}
}

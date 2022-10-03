package;

import flixel.FlxSprite;

class Spikes extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.tiles__png, true, 16, 16);
		animation.add("s", [4], 6, false);
	}

	function animate()
	{
		animation.play("s");
	}

	override function update(elapsed:Float)
	{
		animate();
		super.update(elapsed);
	}
}

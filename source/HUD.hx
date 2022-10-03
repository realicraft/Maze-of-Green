package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class HUD extends FlxTypedGroup<FlxSprite>
{
	var playState:PlayState;

	var coinCounter:FlxText;
	var timeCounter:FlxText;

	public function new()
	{
		super();
		coinCounter = new FlxText(76, 8, 0, "0", 8);
		timeCounter = new FlxText(188, 8, 0, "0:00.00", 8);
		add(coinCounter);
		add(timeCounter);

		forEach(function(sprite) sprite.scrollFactor.set(0, 0));
	}

	public function updateHUD(coins:Int, time:Int)
	{
		coinCounter.text = Std.string(coins);
		timeCounter.text = Math.floor(time / 3600)
			+ ":"
			+ StringTools.lpad(Std.string(Math.floor((time % 3600) / 60)), "0", 2)
			+ "."
			+ StringTools.lpad(Std.string(Math.floor(time % 60)), "0", 2);
	}
}

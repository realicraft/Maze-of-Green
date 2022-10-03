package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import haxe.Timer;

class PlayState extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var runtime_timer = new Timer(17);
	var runtime:Int = 0;
	var pickups:FlxTypedGroup<Pickup>;
	var spikes:FlxTypedGroup<Spikes>;
	var levers:FlxTypedGroup<Lever>;
	var hud:HUD;

	var coins:Int = 0;
	var have_key:Bool = false;
	var have_lever:Bool = false;

	var level:Int = 1;

	public function new(lev:Int)
	{
		super();
		level = lev;
	}

	override public function create()
	{
		FlxG.watch.add(this, "coins");
		FlxG.watch.add(this, "have_key");
		FlxG.watch.add(this, "have_lever");
		FlxG.drawFramerate = 60;
		runtime_timer.run = function()
		{
			runtime++;
		}

		switch (level)
		{
			case(1):
				map = new FlxOgmo3Loader(AssetPaths.ld51__ogmo, AssetPaths.stage_1__json);
			case(2):
				map = new FlxOgmo3Loader(AssetPaths.ld51__ogmo, AssetPaths.stage_2__json);
			case(3):
				map = new FlxOgmo3Loader(AssetPaths.ld51__ogmo, AssetPaths.stage_3__json);
			case(4):
				map = new FlxOgmo3Loader(AssetPaths.ld51__ogmo, AssetPaths.stage_4__json);
			case(5):
				map = new FlxOgmo3Loader(AssetPaths.ld51__ogmo, AssetPaths.stage_5__json);
			case(6):
				map = new FlxOgmo3Loader(AssetPaths.ld51__ogmo, AssetPaths.stage_final__json);
		}
		// map = new FlxOgmo3Loader(AssetPaths.ld51__ogmo, AssetPaths.stage_1__json);
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();
		walls.setTileProperties(0, ANY);
		walls.setTileProperties(1, ANY);
		walls.setTileProperties(2, ANY);
		walls.setTileProperties(3, ANY);
		walls.setTileProperties(4, ANY);
		walls.setTileProperties(5, ANY);
		walls.setTileProperties(6, ANY);
		walls.setTileProperties(7, ANY);
		walls.setTileProperties(8, NONE);
		walls.setTileProperties(9, NONE);
		walls.setTileProperties(10, NONE);
		walls.setTileProperties(11, NONE);
		walls.setTileProperties(12, NONE);
		walls.setTileProperties(13, NONE);
		walls.setTileProperties(14, NONE);
		walls.setTileProperties(15, NONE);
		walls.setTileProperties(16, ANY);
		walls.setTileProperties(17, NONE);
		walls.setTileProperties(18, NONE);
		walls.setTileProperties(19, NONE);
		walls.setTileProperties(20, NONE);
		walls.setTileProperties(21, ANY);
		walls.setTileProperties(22, NONE);
		walls.setTileProperties(23, ANY);
		walls.setTileProperties(24, NONE);
		walls.setTileProperties(25, NONE);
		walls.setTileProperties(26, NONE);
		walls.setTileProperties(27, NONE);
		walls.setTileProperties(28, NONE);
		walls.setTileProperties(29, NONE);
		add(walls);

		pickups = new FlxTypedGroup<Pickup>();
		add(pickups);

		player = new Player();
		map.loadEntities(placeEntities, "entities");
		add(player);
		FlxG.camera.follow(player, TOPDOWN, 1);

		hud = new HUD();
		add(hud);

		super.create();

		#if FLX_MOUSE
		FlxG.mouse.visible = false;
		#end
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, walls);
		FlxG.overlap(player, pickups, playerTouchPickup);
		hud.updateHUD(coins, runtime);
	}

	function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;
		switch (entity.name)
		{
			case "player":
				player.setPosition(x, y);
			case "coin1":
				pickups.add(new Pickup(x, y, 0));
			case "coin2":
				pickups.add(new Pickup(x, y, 1));
			case "coin3":
				pickups.add(new Pickup(x, y, 2));
			case "coin4":
				pickups.add(new Pickup(x, y, 3));
			case "coin5":
				pickups.add(new Pickup(x, y, 4));
			case "key":
				pickups.add(new Pickup(x, y, 5));
			case "spikes":
			// spikes.add(new Spikes(x, y));
			case "lever":
				// levers.add(new Lever(x, y));
		}
	}

	function playerTouchPickup(player:Player, pickup:Pickup)
	{
		if (player.alive && player.exists && pickup.alive && pickup.exists)
		{
			switch (pickup.pickup_type)
			{
				case 0:
					coins++;
				case 1:
					coins += 1;
				case 2:
					coins += 2;
				case 3:
					coins += 3;
				case 4:
					coins += 4;
				case 5:
					have_key = true;
			}
			pickup.kill();
		}
	}
}

this.sb_rain_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sb_rain_skill";
		this.m.Name = "Extreme Weather";
		this.m.Description = "Causes abnormal weather, reduces the melee skills, ranged skills, melee defense, and ranged defense of all enemies on the battlefield by -5. \n[color=#8f1e1e]Requires:[/color] 399 Crowns";
		this.m.Icon = "ui/xx75.png";
		this.m.IconDisabled = "ui/xx75_sw.png";
		this.m.SoundOnUse = [
			"sounds/combat/perfect_focus_01.wav"
		];
		this.m.SoundVolume = 1.7;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 25;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		if (this.Tactical.isActive())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "Own [color=#e6b71e]" + this.World.Assets.getMoney() + "[/color] crowns"
			});
		}
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local weather = this.Tactical.getWeather();
		local rain = weather.createRainSettings();
		local clouds = weather.createCloudSettings();
		local everyone = this.Tactical.Entities.getAllInstances();
		foreach( ever in everyone )
		{
			foreach( e in ever )
			{
				e.getSkills().add(this.new("scripts/skills/effects/sb_rain2_effect"));
				if (!_user.isAlliedWith(e))
				{
					e.getSkills().add(this.new("scripts/skills/effects/sb_rain_effect"));
				}
			}
		}
		if (this.Math.rand(1, 100) <= 50)
		{
			weather.setAmbientLightingColor(this.createColor(this.Const.Tactical.AmbientLightingColor.Storm));
			weather.setAmbientLightingSaturation(this.Const.Tactical.AmbientLightingSaturation.Storm);
			rain.MinDrops = 500;
			rain.MaxDrops = 500;
			rain.NumSplats = 200;
			rain.MinVelocity = 700.0;
			rain.MaxVelocity = 900.0;
			rain.MinAlpha = 1.0;
			rain.MaxAlpha = 1.0;
			rain.SplatAlpha = 0.8;
			rain.MinScale = 2.7;
			rain.MaxScale = 3.0;
			weather.buildRain(rain);
			clouds.Type = this.getconsttable().CloudType.Custom;
			clouds.MinClouds = 0;
			clouds.MaxClouds = 0;
			clouds.MinVelocity = 0;
			clouds.MaxVelocity = 0;
			clouds.MinAlpha = 0;
			clouds.MaxAlpha = 0;
			clouds.MinScale = 0;
			clouds.MaxScale = 0;
			clouds.Sprite = "";
			weather.buildCloudCover(clouds);
			this.Sound.setAmbience(0, this.Const.SoundAmbience.Rain, this.Const.Sound.Volume.Ambience * 1.2, 0);

		}
		else
		{
			weather.setAmbientLightingColor(this.createColor(this.Const.Tactical.AmbientLightingColor.LightRain));
			weather.setAmbientLightingSaturation(this.Const.Tactical.AmbientLightingSaturation.LightRain);
			rain.MinDrops = 300;
			rain.MaxDrops = 300;
			rain.NumSplats = 0;
			rain.MinVelocity = 200.0;
			rain.MaxVelocity = 400.0;
			rain.MinAlpha = 0.5;
			rain.MaxAlpha = 0.9;
			rain.MinScale = 1.0;
			rain.MaxScale = 3.0;
			rain.clearDropBrushes();
			rain.addDropBrush("snow_particle_02");
			rain.addDropBrush("snow_particle_03");
			rain.addDropBrush("snow_particle_04");
			weather.buildRain(rain);
			clouds.Type = this.getconsttable().CloudType.Custom;
			clouds.MinClouds = 150;
			clouds.MaxClouds = 150;
			clouds.MinVelocity = 400.0;
			clouds.MaxVelocity = 500.0;
			clouds.MinAlpha = 0.6;
			clouds.MaxAlpha = 1.0;
			clouds.MinScale = 1.0;
			clouds.MaxScale = 4.0;
			clouds.Sprite = "wind_01";
			clouds.RandomizeDirection = false;
			clouds.RandomizeRotation = false;
			clouds.Direction = this.createVec(-1.0, -0.7);
			weather.buildCloudCover(clouds);
			this.Sound.setAmbience(0, this.Const.SoundAmbience.Blizzard, this.Const.Sound.Volume.Ambience * 1.2, 0);
		}
		this.World.Assets.addMoney(-399);
	}

	function isHidden()
	{
		if (this.getContainer().getActor().getSkills().hasSkill("effects.sb_rain2_effect"))
		{
			return true;
		}
		return false;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		else
		if (this.World.Assets.getMoney() < 399)
		{
			return false;
		}
		return true;
	}

});


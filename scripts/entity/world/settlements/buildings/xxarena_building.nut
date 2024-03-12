this.xxarena_building <- this.inherit("scripts/entity/world/settlements/buildings/building", {
	m = {
		UIImageClosed = null,
		CooldownUntil = 0
	},
	function refreshCooldown()
	{
		this.m.CooldownUntil = this.World.getTime().Days + 1;
	}

	function isClosed()
	{
		return this.World.getTime().Days < this.m.CooldownUntil;
	}

	function create()
	{
		this.building.create();
		this.m.ID = "building.xxarena";
		this.m.Name = "Adventurer\'s Guild";
		this.m.Description = "A place that arranges work for adventurers by day and provides entertainment by night.";
		this.m.UIImage = "ui/xbuilding_01";
		this.m.UIImageNight = "ui/xbuilding_01_night";
		this.m.Tooltip = "world-town-screen.main-dialog-module.AdventurersGuild";
		this.m.TooltipIcon = "ui/icons/special.png";
		this.m.IsClosedAtNight = false;
		this.m.Sounds = [
			{
				File = "ambience/buildings/tavern_laugh_00.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_01.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_02.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_03.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_04.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_05.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_06.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_08.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_09.wav",
				Volume = 0.75,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [
			{
				File = "ambience/buildings/tavern_laugh_00.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_01.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_02.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_03.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_04.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_05.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_06.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_08.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_laugh_09.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_drunk_00.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/tavern_drunk_01.wav",
				Volume = 0.5,
				Pitch = 1.0
			}
		];
	}

	function onClicked( _townScreen )
	{
		if (!this.World.getTime().IsDaytime)
		{
			local f = this.World.FactionManager.getFactionOfType(this.Const.Faction.Beasts);
			local contracts = f.getContracts();
			local c;
			c = this.new("scripts/contracts/contracts/xxarena_n_contract");
			c.setFaction(f.getID());
			c.setHome(this.World.State.getCurrentTown());
			c.setScreenForArena();
			this.World.Contracts.showContract(c);
		}
		else
		if ((this.World.Contracts.getActiveContract() == null || this.World.Contracts.getActiveContract().getType() == "contract.xxarena") && this.World.getTime().Days >= this.m.CooldownUntil)
		{
			local f = this.World.FactionManager.getFactionOfType(this.Const.Faction.Beasts);
			local contracts = f.getContracts();
			local c;
			if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getType() == "contract.xxarena")
			{
				c = this.World.Contracts.getActiveContract();
			}
			else if (contracts.len() == 0)
			{
				c = this.new("scripts/contracts/contracts/xxarena_contract");
				c.setFaction(f.getID());
				c.setHome(this.World.State.getCurrentTown());
				this.World.Contracts.addContract(c);
			}
			else
			{
				c = contracts[0];
			}
			c.setScreenForArena();
			this.World.Contracts.showContract(c);
		}
	}

	function onSettlementEntered()
	{
	}

	function onSerialize( _out )
	{
		this.building.onSerialize(_out);
		_out.writeU32(this.m.CooldownUntil);
	}

	function onDeserialize( _in )
	{
		this.building.onDeserialize(_in);

		if (_in.getMetaData().getVersion() >= 56)
		{
			this.m.CooldownUntil = _in.readU32();
		}
	}

});


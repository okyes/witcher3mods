//modFriendlyStash begin
class CModFriendlyStashConfig
{
	public var stashSync, stashRoach, bagsRoach, disableChests : bool;
	public var stashMenuMode, stashMerchantMode, stashAlchemyMode, stashCraftingMode : int;
	public var stashDistance, baseWeightGeralt, baseWeightRoach, weightMultRoach : float;

	public function GetSyncModeByDefault() : bool
	{
		return (bool)theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'FSStashSync');
	}
	
	public function IsCraftingAccessAllowed() : bool
	{
		switch(stashCraftingMode)
		{
			case 0: //off
				return false;
			case 1: //full access
				return true;
			case 2: //settlement
				return IsInSettlement();
			case 3: //distance
				return IsStashCloseEnough();
		}
		
		return false;
	}
	
	public function IsAlchemyAccessAllowed(bHerbalist : bool) : bool
	{
		switch(stashAlchemyMode)
		{
			case 0: //off
				return false;
			case 1: //full access
				return true;
			case 2: //settlement
				return IsInSettlement();
			case 3: //distance
				return IsStashCloseEnough();
			case 4: //alchemist
				return bHerbalist;
		}
		
		return false;
	}
	
	public function IsShopMenuAccessAllowed() : bool
	{
		switch(stashMerchantMode)
		{
			case 0: //view
				return false;
			case 1: //full
				return true;
			case 2: //settlement
				return IsInSettlement();
			case 3: //distance
				return IsStashCloseEnough();
		}
		return false;
	}
	
	public function IsStashMenuAccessAllowed() : bool
	{
		switch(stashMenuMode)
		{
			case 0: //view
				return false;
			case 1: //full
				return true;
			case 2: //settlement
				return IsInSettlement();
			case 3: //distance
				return IsStashCloseEnough();
		}
		return false;
	}
	
	public function Init()
	{
		UpdateUserSettings();
	}
	
	public function UpdateUserSettings()
	{
		//[modFriendlyStash]
		stashSync = theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'FSStashSync');
		stashRoach = theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'FSStashRoach');
		bagsRoach = theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'FSBagsRoach');
		disableChests = theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'FSDisableChests');
		stashDistance = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'FSStashDistance'));
		baseWeightGeralt = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'FSPlayerWeightBase'));
		baseWeightRoach = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'FSRoachWeightBase'));
		weightMultRoach = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'FSRoachWeightMult'));
		stashMenuMode = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'Virtual_FSStashMenuMode'));
		stashMerchantMode = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'Virtual_FSStashMerchantMode'));
		stashAlchemyMode = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'Virtual_FSStashAlchemyMode'));
		stashCraftingMode = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyStash', 'Virtual_FSStashCraftingMode'));
		GetWitcherPlayer().UpdateEncumbrance();
	}
	
	function IsInSettlement() : bool
	{
		return GetWitcherPlayer().IsInSettlement();
	}
	
	function IsStashCloseEnough() : bool
	{
		var commonMapManager		: CCommonMapManager = theGame.GetCommonMapManager();
		var playerPosition			: Vector = thePlayer.GetWorldPosition();
		var distanceFromPlayer		: float = 0;
		var worldPath				: String;
		var mapPinInstances			: array< SCommonMapPinInstance >;
		var mapPinInstancesCount	: int;
		var pin						: SCommonMapPinInstance;
		var i						: int;
		
		if(stashRoach && thePlayer.GetIsHorseMounted())
			return true;
		
		worldPath = commonMapManager.GetWorldPathFromAreaType(commonMapManager.GetCurrentArea());
		mapPinInstances = commonMapManager.GetMapPinInstances(worldPath);
		mapPinInstancesCount = mapPinInstances.Size();
		
		for(i = 0; i < mapPinInstancesCount; i += 1)
		{
			pin = mapPinInstances[i];
			if(stashRoach && pin.visibleType == 'Horse' || !stashRoach &&
			   (pin.visibleType == 'PlayerStash' || pin.visibleType == 'PlayerStashDiscoverable'))
			{
				distanceFromPlayer = VecDistance2D(playerPosition, pin.position);
				//theGame.witcherLog.AddMessage("pin: " + pin.visibleType);
				//theGame.witcherLog.AddMessage("dist: " + distanceFromPlayer);
				if(distanceFromPlayer <= stashDistance)
					return true;
			}
		}
	
		return false;
	}
}

function GetFriendlyStashConfig() : CModFriendlyStashConfig
{
	return GetWitcherPlayer().fStashConfig;
}
//modFriendlyStash end

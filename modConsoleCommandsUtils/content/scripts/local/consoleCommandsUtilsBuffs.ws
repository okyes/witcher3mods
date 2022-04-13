function utilsBuffMe( type : EEffectType, optional duration : float, optional src : string )
{
	var params : SCustomEffectParams;

	if(duration > 0)
	{
		params.effectType = type;
		params.sourceName = src;
		params.duration = duration;
		thePlayer.AddEffectCustom(params);
	}
	else
	{
		thePlayer.AddEffectDefault(type, NULL, src);
	}
}

function utilsBuffMeShrines()
{
	var buffDuration : int;

	buffDuration = 259200;

	utilsBuffMe(EET_ShrineAard, buffDuration);
	utilsBuffMe(EET_ShrineAxii, buffDuration);
	utilsBuffMe(EET_ShrineIgni, buffDuration);
	utilsBuffMe(EET_ShrineQuen, buffDuration);
	utilsBuffMe(EET_ShrineYrden, buffDuration);
}

function utilsBuffMeWeaponArmor()
{
	var buffDuration : int;

	buffDuration = 259200;

	utilsBuffMe(EET_EnhancedArmor, buffDuration, "repair_object");
	utilsBuffMe(EET_EnhancedWeapon, buffDuration, "repair_object");
}

function utilsBuffMeCorvoBianco()
{
	var buffDuration : int;

	buffDuration = 259200;

	utilsBuffMe(EET_WellRested, 129600, "Bed Buff");
	utilsBuffMe(EET_HorseStableBuff, buffDuration, "Stables");
	utilsBuffMe(EET_BookshelfBuff, buffDuration, "Bookshelf");
}

exec function ushr()
{
	utilsBuffMeShrines();
}

exec function uwpn()
{
	utilsBuffMeWeaponArmor();
}

exec function ucorvo()
{
	utilsBuffMeCorvoBianco();
}

exec function ubuff()
{
	utilsBuffMeShrines();
	utilsBuffMeWeaponArmor();
	utilsBuffMeCorvoBianco();
}

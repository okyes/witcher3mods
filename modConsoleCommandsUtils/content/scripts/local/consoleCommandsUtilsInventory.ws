function utilsAddItem(itemName : name, optional count : int, optional equip : bool)
{
	var ids : array<SItemUniqueId>;
	var i : int;

	if(IsNameValid(itemName))
	{
		ids = thePlayer.inv.AddAnItem(itemName, count);
		if(thePlayer.inv.IsItemSingletonItem(ids[0]))
		{
			for(i=0; i<ids.Size(); i+=1)
				thePlayer.inv.SingletonItemSetAmmo(ids[i], thePlayer.inv.SingletonItemGetMaxAmmo(ids[i]));
		}
		
		if(ids.Size() == 0)
		{
			LogItems("exec function additem: failed to add item <<" + itemName + ">>, most likely wrong item name");
			return;
		}
		
		if(equip)
			thePlayer.EquipItem(ids[0]);
	}
	else
	{
		LogItems("exec function additem: Invalid item name <<"+itemName+">>, cannot add");
	}
}

exec function usuccub()
{
	utilsAddItem('Succubus mutagen');
}

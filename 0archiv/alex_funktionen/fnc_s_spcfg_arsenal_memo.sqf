/*
  fnc_s_spcfg_arsenal_memo
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: unnecessary

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
params ["_action_obj","_spieler","_action_id","_uebergabe","_seite_nr"];

if (!(s_mission_params select 6)) exitwith {
  [["<t color='#ff0000' size='2'>Ausruestungen stehen in dieser Mission nicht zur Verfuegung!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};


_spieler setvariable ["pos_bei_arsenalaufruf",getposworld _spieler];

// # arsenal-inhalte aufbereiten
private _arsenal_whitelist = [];



[_spieler,s_spcfg_arsenal_whitelist_rucksaecke,false,false] remoteexec ["BIS_fnc_addVirtualBackpackCargo",_spieler];
[_spieler,s_spcfg_arsenal_whitelist_items,false,false] remoteexec ["BIS_fnc_addVirtualItemCargo",_spieler];
[_spieler,s_spcfg_arsenal_whitelist_munition,false,false] remoteexec ["BIS_fnc_addVirtualMagazineCargo",_spieler];
[_spieler,s_spcfg_arsenal_whitelist_waffen,false,false] remoteexec ["BIS_fnc_addVirtualWeaponCargo",_spieler];

[[],"alex_scripte\a_spcfg_oeffnet_arsenal.sqf"] remoteexec ["execvm",_spieler];

//["Open",[nil,_spieler,_spieler]] remoteexec ["bis_fnc_arsenal",_spieler];
//["Open",[nil,player,player]] call bis_fnc_arsenal;

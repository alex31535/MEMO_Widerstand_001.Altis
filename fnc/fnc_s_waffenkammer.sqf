/*
  fnc_s_waffenkammer
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

private _objektliste = [_spieler] call fnc_s_loadout_zu_objektliste;
private _objekte_hinzugefuegt = false;

{
  if (!(isClass (configFile >> "CFGMagazines" >> _x))) then {
    if (((gettext (configfile >> "CfgVehicles" >> _x >> "vehicleClass")) == "Backpacks") && {(s_whitelist_rucksaecke find _x) == -1}) then {
      s_whitelist_rucksaecke pushback _x; _objekte_hinzugefuegt = true;
    };
    if ((count(getArray (configFile >> "CfgWeapons" >> _x >> "magazines"))) > 0) then {
      if ((s_whitelist_waffen find _x) == -1) then {s_whitelist_waffen pushback _x; _objekte_hinzugefuegt = true;};
    } else {
      if ((s_whitelist_items find _x) == -1) then {s_whitelist_items pushback _x; _objekte_hinzugefuegt = true;};
    };
  };
} foreach _objektliste;


if (_objekte_hinzugefuegt) then {
  private _db = "";
  {
    while {s_db_aktiv} do {uisleep 0.3};
    s_db_aktiv = true;
    _db = ["new", format["%1_%2_%3",s_pref_spiel,_x,(toLowerANSI worldname)]] call OO_INIDBI;
    call compile format["[""write"",[""whitelist"",""%1"",s_whitelist_%1]] call _db;",_x];
    s_db_aktiv = false;
  } foreach ["rucksaecke","items","munition","waffen"];
  {
    [[format["<t color='#02bf1b' size='2'>%1 hat der Waffenkammer neue Objekte hinzugefuegt!",name _spieler], "PLAIN DOWN", -1, true, true]] remoteExec ["cutText",_x];
  } foreach playableunits;
};




// # arsenal-inhalte aufbereiten
private _arsenal_whitelist = [];

[_spieler,s_whitelist_rucksaecke,false,false] remoteexec ["BIS_fnc_addVirtualBackpackCargo",_spieler];
[_spieler,s_whitelist_items,false,false] remoteexec ["BIS_fnc_addVirtualItemCargo",_spieler];
[_spieler,s_whitelist_munition,false,false] remoteexec ["BIS_fnc_addVirtualMagazineCargo",_spieler];
[_spieler,s_whitelist_waffen,false,false] remoteexec ["BIS_fnc_addVirtualWeaponCargo",_spieler];

[[],"scripte\a_spieler_oeffnet_waffenkammer.sqf"] remoteexec ["execvm",_spieler];

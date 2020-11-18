/*
  fnc_s_garage_einparken
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
params ["_action_obj","_spieler","_action_id","_uebergabe","_area_str"];
private _area = []; call compile format ["_area = %1;",_area_str];
private _fzg_in_garagenbereich = [_area] call fnc_s_garage_blockiert;
_fzg_in_garagenbereich params ["_fzg", "_fzg_klasse", "_fzg_displayname"];
if (isnull _fzg) exitwith {
  [["<t color='#ff0000' size='2'>Es befindet sich kein Fahrzeug im Anleger-Bereich!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};

[[format["<t color='#00ff40' size='2'>%1: Eingeparkt!",gettext(configFile >> "CfgVehicles" >> _fzg_klasse)], "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];

private _fzg_klasse = typeof _fzg;

if ((s_garage_pflicht find _fzg_klasse) != -1) exitwith {};

private _liste_str = "";

if (_fzg_klasse isKindOf "Tank") then {_liste_str = "s_garage_kette"};
if (_fzg_klasse isKindOf "Car") then {_liste_str = "s_garage_rad"};
if (_fzg_klasse isKindOf "Helicopter") then {_liste_str = "s_garage_heli"};
if (_fzg_klasse isKindOf "Plane") then {_liste_str = "s_garage_flug"};
if (_fzg_klasse isKindOf "Ship") then {_liste_str = "s_garage_boot"};

call compile format["%1 pushback _fzg_klasse; %1 sort true;",_liste_str];

while {s_db_aktiv} do {uisleep 0.3};
s_db_aktiv = true;
private _db = ["new", format["%1_%2_%3",s_pref_spiel,_liste_str,(toLowerANSI worldname)]] call OO_INIDBI;
call compile format["[""write"",[""%1"",""klassen"",%1]] call _db;",_liste_str];
s_db_aktiv = false;

deletevehicle _fzg;

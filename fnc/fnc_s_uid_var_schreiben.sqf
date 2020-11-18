/*
  fnc_s_uid_var_schreiben
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
if (isnil "OO_INIDBI") exitwith {systemchat "fnc_s_uid_var_schreiben: Abbruch - iniDBi auf server nicht vorhanden...."};
params ["_spieler"];
private _uid_var = [];
private _uid = getplayeruid _spieler;
call compile format["_uid_var = if (isnil ""s_%1"") then [{[]},{s_%1}];",_uid];
if ((count s_uid_var_eintraege) != (count _uid_var)) exitwith {systemchat "fnc_s_uid_var_schreiben: FEHLER: Anz VAR-Eintraege nicht korrekt!"};
while {s_db_aktiv} do {uisleep 0.3};
s_db_aktiv = true;
private _db = ["new", format["%1_%2_%3",s_pref_spiel,_uid,(toLowerANSI worldname)]] call OO_INIDBI;
{["write",[name _spieler,_x select 0, _uid_var select _foreachindex]] call _db} foreach s_uid_var_eintraege;
s_db_aktiv = false;

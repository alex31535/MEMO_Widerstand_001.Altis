/*
  fnc_s_uid_var_lesen
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
if (isnil "OO_INIDBI") exitwith {systemchat "fnc_s_uid_var_lesen: Abbruch - iniDBi auf server nicht vorhanden...."};
params ["_spieler"];
while {s_db_aktiv} do {uisleep 0.3};
s_db_aktiv = true;
private _uid = getplayeruid _spieler;
private _db = ["new", format["%1_%2_%3",s_pref_spiel,_uid,(toLowerANSI worldname)]] call OO_INIDBI;
private _uid_var = [];
private _db_existiert = "exists" call _db;
if (_db_existiert) then {
  private _name = name _spieler;
  private _parameter = [];
  {
    _parameter = ["read",[_name,_x select 0]] call _db;
    _uid_var pushback _parameter;
  } foreach s_uid_var_eintraege;
};
call compile format["s_%1 = _uid_var;",_uid];
s_db_aktiv = false;

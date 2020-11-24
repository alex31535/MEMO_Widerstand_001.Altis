/*
  fnc_s_uid_var
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.13
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: unnecessary

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
params ["_spieler"];
private _uid = getplayeruid _spieler;
private _uid_var = [];
call compile format["_uid_var = if (isnil ""s_%1"") then [{[]},{s_%1}];",_uid];
if ((count _uid_var) == 0) then {[_spieler] call fnc_s_uid_var_lesen};
call compile format["_uid_var = if (isnil ""s_%1"") then [{[]},{s_%1}];",_uid];
if ((count _uid_var) == 0) then {
  _uid_var = [_spieler] call fnc_s_uid_var_neu;
  [_spieler] call fnc_s_uid_var_anwenden;
};
_uid_var

/*
  fnc_s_sys_cityring_strassen_besetzen.sqf
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
params ["_strassenliste","_auswahl_vec"];
private _vec = objnull;
private _erstellte_objekte = [];
{
  _vec = (selectrandom _auswahl_vec) createVehicle (position _x);
  _vec setdir (random 360);
  _erstellte_objekte pushback _vec;
  createVehicleCrew _vec;
  _erstellte_objekte append (crew _vec);
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {
    [_vec] call fnc_s_debugmarker_erstellen;
    {[_x] call fnc_s_debugmarker_erstellen} forEach crew _vec;
    systemchat format["fnc_s_sys_cityring_strassen_besetzen: %1(+crew)",typeof _vec];
  };
} foreach _strassenliste;
_erstellte_objekte

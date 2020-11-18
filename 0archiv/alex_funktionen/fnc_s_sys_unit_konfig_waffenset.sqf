/*
  fnc_s_sys_unit_konfig_waffenset.sqf
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
params ["_unit","_set_primaer_oder_faust","_set_sekundaer"];
systemchat format["fnc_s_sys_unit_konfig_waffenset: %1",_this];
private _loadout = getunitloadout _unit;
if ((count _set_primaer_oder_faust) > 0) then {
  _loadout set [0,_set_primaer_oder_faust select 0];
  _loadout set [2,_set_primaer_oder_faust select 2];
  _loadout set [4,_set_primaer_oder_faust select 4];
};
if ((count _set_sekundaer) > 0) then {
  _loadout set [1,_set_sekundaer select 0];
  _loadout set [5,_set_sekundaer select 1];
};
_unit setunitloadout _loadout;

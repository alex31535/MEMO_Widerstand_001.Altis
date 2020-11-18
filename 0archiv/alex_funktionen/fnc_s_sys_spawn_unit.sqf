/*
  fnc_s_sys_spawn_unit.sqf
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
params ["_pos_spawn","_klassen"];
private _unit = (creategroup [([east,west,resistance,civilian] select (getnumber(configFile >> "CfgVehicles" >> (_klassen select 0) >> "side"))),true]) createUnit [selectrandom _klassen, [0,0,0], [], 0, "NONE"];
_unit setposasl (agltoasl _pos_spawn);
_unit setdir (random 360);
if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
_unit

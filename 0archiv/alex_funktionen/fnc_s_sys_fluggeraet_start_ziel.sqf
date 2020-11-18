/*
  fnc_s_sys_fluggeraet_start_ziel
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
params ["_startpos","_zielobjekt","_auswahl_fluggeraete"];
private _pos_zielobjekt = getposatl _zielobjekt;
// # flugobjekt erstellen und bewegen
private _flugobjekt = createVehicle [selectrandom _auswahl_fluggeraete, _startpos, [], 0, "FLY"];
_flugobjekt setdir (_flugobjekt getRelDir _zielobjekt);
_flugobjekt setVelocity [60 * (sin (getDir _flugobjekt)), 60 * (cos (getDir _flugobjekt)),10];
createVehicleCrew _flugobjekt;
_flugobjekt engineOn true;
// # wegpunkt
private _wp = (group(driver _flugobjekt)) addWaypoint [_pos_zielobjekt, 0];
[(group(driver _flugobjekt)), 0] setWaypointBehaviour "COMBAT"; // COMBAT
[(group(driver _flugobjekt)), 0] setWaypointSpeed "NORMAL";
_wp setWaypointType "SAD";// Move
// # markieren?
if ((!isnil "s_debugmarker") && {s_debugmarker}) then {
  {[_x] call fnc_s_debugmarker_erstellen} foreach (units(group(driver _flugobjekt)));
};
// # admin-skills ?
if (!isnil "fnc_s_sys_unit_konfig_skills") then {
  {[_x,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills} foreach (units(group(driver _flugobjekt)));
};
// ausgabe
_flugobjekt

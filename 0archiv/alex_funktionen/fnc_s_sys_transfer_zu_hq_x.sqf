/*
  fnc_s_sys_transfer_zu_x
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
params ["_action_obj","_spieler","_action_id","_uebergabe","_zielpos_str"];
if (((driver(objectparent _spieler)) == _spieler) && {(speed(objectparent _spieler)) > 0}) exitwith {
  [["<t color='#ff0000' size='2'>Halte das Fahrzeug an um zum HQ zu reisen!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
if (((getposatl _action_obj) select 2) > 4) exitwith {
  [["<t color='#ff0000' size='2'>Das Fahrzeug muss auf dem Boden stehen um zum HQ reisen zu koennen!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
private _zielpos = []; call compile format["_zielpos = %1;",_zielpos_str];
if (isnil "_zielpos") exitwith {
  [["<t color='#ff0000' size='2'>Das Ziel existiert nicht oder eine Reise ist zZt nicht moeglich!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
_spieler setpos _zielpos;

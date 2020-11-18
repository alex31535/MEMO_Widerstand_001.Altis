/*
  fnc_s_sys_transfer_zu_fob
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
params ["_action_obj","_spieler","_action_id","_uebergabe"];
if (isnull s_garage_mob_fob) exitwith {
  [["<t color='#ff0000' size='2'>Es existiert kein FOB!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
private _sitzplaetze_frei = (count(fullCrew [s_garage_mob_fob, "cargo", true])) - (count(fullCrew [s_garage_mob_fob, "cargo"]));
if (_sitzplaetze_frei <1) exitwith {
  [["<t color='#ff0000' size='2'>Du musst warten - Alle freien Platze sind besetzt!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
[_spieler, s_garage_mob_fob] remoteexec ["moveincargo",_spieler];

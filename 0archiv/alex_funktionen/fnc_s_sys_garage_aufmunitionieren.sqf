/*
  fnc_s_garage_w_aufmunitionieren
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
private _fzg_in_garagenbereich = [_area] call fnc_s_sys_area_blockiert;
_fzg_in_garagenbereich params ["_fzg", "_fzg_klasse", "_fzg_displayname"];
if (isnull _fzg) exitwith {
  [["<t color='#ff0000' size='2'>Es befindet sich kein Fahrzeug im Anleger-Bereich!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
_fzg setVehicleAmmoDef 1;
_fzg setAmmoCargo 1;
[[format["<t color='#00ff40' size='2'>%1: Erfolgreich aufmunitioniert!",_fzg_displayname], "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];

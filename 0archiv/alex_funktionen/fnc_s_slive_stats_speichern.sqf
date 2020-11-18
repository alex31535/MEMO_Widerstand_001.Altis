/*
  fnc_s_slive_stats_speichern.sqf
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
params ["_uid","_name","_s_slive_uid"];
systemchat format["fnc_s_slive_stats_speichern: %1, %2",_uid,_name];
private _db = ["new", (format["%1_%2_%3_%4",s_slive_name_db,(toLowerANSI worldname),s_slive_version_db,_uid])] call OO_INIDBI;
{["write",[_name,_x,_s_slive_uid select _foreachindex]] call _db} foreach s_slive_keys_db;

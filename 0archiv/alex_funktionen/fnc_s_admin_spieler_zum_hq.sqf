/*
  fnc_s_admin_mission_notaus.sqf
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
/*
s_mission_params = [
  0: mission aktiv ?  false,
  1: name der Missione  "",
  2: missionspfad zb "alex_missions\memo_deathmatch\" oder "alex_missions\",
  3: aktuelle punkte aus mission  0
  4: notaus false
];
*/
params ["_action_obj","_spieler","_action_id","_uebergabe"];

if (s_mission_params select 0) exitwith {
  [["<t color='#ff0000' size='2'>Die aktuelle Mission muss zuerst beendet werden!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};


while {(count(playableunits inareaarray s_sys_area_hq)) != (count playableunits)} do {
  {if (!(_x inarea s_sys_area_hq)) then {_x setposworld s_missions_posworld_notaus}} foreach playableunits;
};

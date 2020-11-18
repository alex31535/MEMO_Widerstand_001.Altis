/*
  fnc_s_mission_mission_waehlen.sqf
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by: Client-Init: ["loop"] execVM "alex_inkognito\init_inkognito.sqf";
	Parameters: "loop" or "fnc"
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: unnecessary

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
#define _display 2010
#define _lb_ctrl 2014
#define _toptext_idc 2015
#define _button_ok_idc 2012
#define _def_nebeldichte_abstufung 0.05
params ["_action_obj","_spieler","_action_id","_uebergabe"];
if (s_mission_params select 0) exitwith {
  [[format["<t color='#ff0000' size='2'>%1 ist noch aktiv!",s_mission_params select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};


if ((count(playableunits inareaarray s_sys_area_hq)) < (count playableunits)) exitwith {
  [["<t color='#ff0000' size='2'>Zum Aufruf einer neuen Mission muessen alle Spieler im HQ-Bereich sein!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};





private _toptext = "Bitte waehle eine Mission....";
private _button_ok_action = "[lbData [2014, lbcursel 2014]] remoteexec [""fnc_s_mission_mission_aktivieren"",2];closedialog 0;";
private _lb_eintraege = [];
private _lb_eintraege_data = [];
{
  _lb_eintraege pushback (_x select 1);
  _lb_eintraege_data pushback (str _x);
} foreach s_missions_auswahl;
["class_lb_auswahl_1_2010",_display,_toptext_idc,_toptext,_lb_ctrl,_lb_eintraege,_lb_eintraege_data,_button_ok_idc,_button_ok_action] remoteexec ["fnc_a_mission_spieler_waehlt_mission",remoteExecutedOwner];

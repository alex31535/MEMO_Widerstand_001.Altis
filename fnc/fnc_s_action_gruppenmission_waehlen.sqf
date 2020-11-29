/*
  fnc_s_action_gruppenmission_waehlen.sqf
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

params ["_action_obj","_spieler","_action_id","_uebergabe"];
if (s_mission_params select 0) exitwith {
  [[format["<t color='#ff0000' size='2'>%1 ist noch aktiv!",s_mission_params select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};

if ((isdedicated) && {s_gruppenmission_min_anz_spieler > (count playableunits)}) exitwith {
  [[format["<t color='#ff0000' size='2'>Es sind mindestens %1 Spieler noetig um eine Gruppenmission zu starten!",s_gruppenmission_min_anz_spieler], "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};


if ((count(playableunits inareaarray "m_area_basis")) < (count playableunits)) exitwith {
  [["<t color='#ff0000' size='2'>Zum Aufruf einer neuen Gruppenission muessen alle Spieler im HQ-Bereich sein!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};


if ((s_spieler_oder_ki select 0) == "ki") exitwith {
  [] remoteexec ["fnc_a_gruppenmission_starten_ki",_spieler];
};


private _lvl = [_spieler] call fnc_s_spielerlevel;
[_lvl,s_loc_params] remoteexec ["fnc_a_map_gruppenmissionswahl",_spieler];

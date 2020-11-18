/*
  s_admin_wetter.sqf
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
#define _display 2010
#define _lb_ctrl 2014
#define _toptext_idc 2015
#define _button_ok_idc 2012
#define _def_overcast_abstufung 0.05
params ["_action_obj","_spieler","_action_id","_uebergabe"];

private _toptext = "Bitte waehle ein Wetter....";
private _button_ok_action = "[lbData [2014, lbcursel 2014]] remoteexec [""fnc_s_admin_wetter_setzen"",2];closedialog 0;";
private _lb_eintraege = [];
private _lb_eintraege_data = [];
private _overcast = [];
for "_i" from 0 to 1 step _def_overcast_abstufung do {_overcast pushback _i};_overcast pushback 1;
{
  _lb_eintraege pushback (format["%1 %2 Schlechtwetter",_x *100,"%"]);
  _lb_eintraege_data pushback (str _x);
} foreach _overcast;
["class_lb_auswahl_1_2010",_display,_toptext_idc,_toptext,_lb_ctrl,_lb_eintraege,_lb_eintraege_data,_button_ok_idc,_button_ok_action] remoteexec ["fnc_a_admin_spieler_waehlt_wetter",_spieler];

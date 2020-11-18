/*
  fnc_s_admin_ki_level_max.sqf
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
#define _def_nebeldichte_abstufung 0.05
params ["_action_obj","_spieler","_action_id","_uebergabe"];

private _toptext = "Maximaler KI-Level (Prozent)....";
private _button_ok_action = "[lbData [2014, lbcursel 2014]] remoteexec [""fnc_s_admin_ki_level_min_setzen"",2];closedialog 0;";
private _lb_eintraege = [];
private _lb_eintraege_data = [];
private _ki_lvl_werte = [];
for "_i" from s_admin_ki_level_min to 100 step 5 do {_ki_lvl_werte pushback _i};
{
  _lb_eintraege pushback (format["%1 %2",_x,"%"]);
  _lb_eintraege_data pushback (str _x);
} foreach _ki_lvl_werte;
["class_lb_auswahl_1_2010",_display,_toptext_idc,_toptext,_lb_ctrl,_lb_eintraege,_lb_eintraege_data,_button_ok_idc,_button_ok_action] remoteexec ["fnc_a_admin_spieler_waehlt_ki_level_min",_spieler];


[["<t color='#ff0000' size='2'>Veraenderungen im KI-Level haben keine Auswirkungen auf bereits erstellte KI!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];

/*
  fnc_s_spcfg_ausstattungen_auflisten_psycho
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
#define _def_display 2010
#define _def_lb_ctrl 2014
#define _def_toptext_idc 2015
#define _def_button_ok_idc 2012
params ["_action_obj","_spieler","_action_id","_uebergabe","_seite_nr"];

if (!(s_mission_params select 6)) exitwith {
  [["<t color='#ff0000' size='2'>Ausruestungen stehen in dieser Mission nicht zur Verfuegung!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};

private _toptext = "Waehle eine Psycho-Ausstattung";
//private _button_ok_action = "[lbData [2014, lbcursel 2014]] spawn fnc_a_spcfg_spieler_ausstatten_psycho;closedialog 0;";
private _button_ok_action = "[lbData [2014, lbcursel 2014],player] remoteexec ['fnc_s_spcfg_spieler_ausstatten_psycho',2];closedialog 0;";
private _lb_eintraege = [];
private _lb_eintraege_pic = [];
private _lb_eintraege_data = [];
{
  _lb_eintraege pushback (_x select 0);
  _lb_eintraege_pic pushback "";
  _lb_eintraege_data pushback (str(_x select 1));//(str _x);
} foreach s_spcfg_ausstattungen_psycho;

["class_lb_auswahl_1_2010",_def_display,_def_toptext_idc,_toptext,_def_lb_ctrl,_lb_eintraege,_lb_eintraege_pic,_lb_eintraege_data,_def_button_ok_idc,_button_ok_action] remoteexec ["fnc_a_spieler_waehlt_ausstattung",_spieler];

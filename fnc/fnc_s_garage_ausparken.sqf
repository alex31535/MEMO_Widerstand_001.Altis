/*
  fnc_s_garage_ausparken
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
params ["_action_obj","_spieler","_action_id","_uebergabe","_area_str","_liste_str","_klasse_block_obj"];
private _area = []; call compile format ["_area = %1;",_area_str];
private _fzg_in_garagenbereich = [_area] call fnc_s_garage_blockiert;
_fzg_in_garagenbereich params ["_fzg", "_fzg_klasse", "_fzg_displayname"];
if !(isnull _fzg) exitwith {
  [[format["<t color='#ff0000' size='2'>%1 blockiert den Garagenbereich!",_fzg_displayname], "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
private _vec_dummy = _klasse_block_obj createVehicle [0,0,0];
_vec_dummy setdir (_area select 3);
_vec_dummy allowdammage false;
_vec_dummy enableSimulation false;
_vec_dummy setpos (_area select 0);
// # LB-Konfiguration
private _liste_vec = []; call compile format ["_liste_vec = %1;",_liste_str];
private _toptext = "Waehle ein Fahrzeug....";
private _button_ok_action = format["[lbData [2014, lbcursel 2014],%1,%2,""%3"",""%4""] remoteexec ['fnc_s_garage_ausparken_ende',2];closedialog 0;",_area select 0,_area select 3,_area_str,_liste_str];
private _lb_eintraege = [];
private _lb_eintraege_pic = [];
private _lb_eintraege_data = [];
{
  _lb_eintraege pushback (getText(configfile >> "CfgVehicles" >> _x >> "DisplayName"));
  _lb_eintraege_pic pushback (gettext(configfile >> "CfgVehicles" >> _x >> "picture"));
  _lb_eintraege_data pushback _x;//(str _x);
} foreach _liste_vec;
["class_lb_auswahl_1_2010",_def_display,_def_toptext_idc,_toptext,_def_lb_ctrl,_lb_eintraege,_lb_eintraege_pic,_lb_eintraege_data,_def_button_ok_idc,_button_ok_action,netid _vec_dummy] remoteexec ["fnc_a_garage_spieler_waehlt",remoteExecutedOwner];

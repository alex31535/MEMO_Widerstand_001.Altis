/*
  fnc_s_spcfg_ausstattungen_auflisten
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
params ["_action_obj","_spieler","_action_id","_uebergabe"];

if (!(s_mission_params select 6)) exitwith {
  [["<t color='#ff0000' size='2'>Ausruestungen stehen in dieser Mission nicht zur Verfuegung!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};

private _toptext = "Waehle eine Ausstattung....";
private _button_ok_action = "[lbData [2014, lbcursel 2014],player] remoteexec ['fnc_s_spcfg_spieler_ausstatten',2];closedialog 0;";
private _lb_eintraege = [];
private _lb_eintraege_pic = [];
private _lb_eintraege_data = [];
private _liste_units = []; call compile format["_liste_units = s_spcfg_units_schnellausstattung_%1;",getnumber(configFile >> "CfgVehicles" >> typeof _spieler >> "side")];
{
  _lb_eintraege pushback (gettext(configfile >> "CfgVehicles" >> _x >> "DisplayName"));
  _lb_eintraege_pic pushback "";//(gettext(configfile >> "CfgVehicles" >> _x >> "picture"));
  _lb_eintraege_data pushback _x;//(str _x);
} foreach _liste_units;

["class_lb_auswahl_1_2010",_def_display,_def_toptext_idc,_toptext,_def_lb_ctrl,_lb_eintraege,_lb_eintraege_pic,_lb_eintraege_data,_def_button_ok_idc,_button_ok_action] remoteexec ["fnc_a_spieler_waehlt_ausstattung",_spieler];

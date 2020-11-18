/*
  fnc_a_mission_spieler_waehlt_mission.sqf
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
params ["_gui_klasse","_display","_toptext_idc","_toptext","_lb_ctrl","_lb_eintraege","_lb_eintraege_data","_button_ok_idc","_button_ok_action"];
// # dialog vorbereiten
createDialog _gui_klasse;
ctrlSetText [_toptext_idc, _toptext];
buttonSetAction [_button_ok_idc, _button_ok_action];
private _listbox = (finddisplay _display) displayctrl _lb_ctrl;
// # listboxeintraege setzen
{
  _listbox lbadd _x;
  _listbox lbSetData [_foreachindex, _lb_eintraege_data select _foreachindex]; // setzt datansatz als STRING
} foreach _lb_eintraege;

_listbox lbSetCurSel 0;

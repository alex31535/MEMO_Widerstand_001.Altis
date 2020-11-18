/*
  fnc_a_spieler_waehlt_ausstattung
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
params ["_gui_klasse","_display","_toptext_idc","_toptext","_lb_ctrl","_lb_eintraege","_lb_eintraege_pic","_lb_eintraege_data","_button_ok_idc","_button_ok_action"];
// # dialog vorbereiten
createDialog _gui_klasse;
ctrlSetText [_toptext_idc, _toptext];
buttonSetAction [_button_ok_idc, _button_ok_action];
private _listbox = (finddisplay _display) displayctrl _lb_ctrl;
// # listboxeintraege setzen
{
  _listbox lbadd _x;
  _listbox lbSetPicture [_foreachindex, _lb_eintraege_pic select _foreachindex];
  _listbox lbSetData [_foreachindex, _lb_eintraege_data select _foreachindex]; // setzt datansatz als STRING
} foreach _lb_eintraege;
_listbox lbSetCurSel 0;
while {!dialog} do {sleep 0.1};
while {dialog} do {sleep 0.1};
//if (! isnil "TFAR_fnc_activeSwRadio") then {[(call TFAR_fnc_activeSwRadio), 1, "111"] call TFAR_fnc_SetChannelFrequency};
//if (! isnil "TFAR_fnc_activeSwRadio") then {[(call TFAR_fnc_activeLrRadio), 1, "75"] call TFAR_fnc_SetChannelFrequency};

/*
  fnc_a_sys_garage_spieler_parkt_aus
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.13
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: unnecessary

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
params ["_gui_klasse","_display","_toptext_idc","_toptext","_lb_ctrl","_lb_eintraege","_lb_eintraege_pic","_lb_eintraege_data","_button_ok_idc","_button_ok_action","_obj_netid"];
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
[objectfromnetid _obj_netid] remoteexec ["deletevehicle",2];

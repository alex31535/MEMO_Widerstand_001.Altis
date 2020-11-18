/*
  fnc_a_mission_spieler_waehlt_parameter
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
#define _DEF_idd 5010
#define _DEF_idc_frame 5020
#define _DEF_idc_kopftext 5100
#define _DEF_idc_infotext 5500
#define _DEF_idc_parameter_name 5200
#define _DEF_idc_parameter_auswahl 5400
#define _DEF_idc_parameter_aktuell 5300
#define _DEF_idc_button_fertig 5030
#define _DEF_idc_button_zufall 5060
params ["_parameter","_missionsverzeichnis"];
/* _parameter-element:
_parameter pushback ["Punkte-Rate",[["Gering",7000],["Mittel",10000],["Hoch",15000]],
  "Gibt an wie schnell die Zu- und Abnahme der Punkte ist.",
  ["Mittel",10000]];
*/
// # wenn KEINE parameter uebergeben wurden, dann gleich weiter.....
if ((count _parameter) == 0) exitwith {[_parameter,format["%1s_mission_generieren.sqf",_missionsverzeichnis]] remoteexec ["execvm",2]};
// # var fuer zufallsbutton
a_alles_auf_zufall = false;
// # dialog vorbereiten
createDialog "class_lb_missionsparameter";
ctrlSetText [_DEF_idc_kopftext, "Waehle die Parameter zur Berechnung der Mission"];
buttonSetAction [_DEF_idc_button_fertig, "closedialog 0;"];
buttonSetAction [_DEF_idc_button_zufall, "a_alles_auf_zufall = true;closedialog 0;"];
ctrlSetText [_DEF_idc_infotext, "Parameter waehlen um Informationen anzeigen zu lassen..."];
// # namen-lb fuellen
private _listbox_name = (finddisplay _DEF_idd) displayctrl _DEF_idc_parameter_name;
{
  _listbox_name lbadd (format["%1: %2",_x select 0,(_x select 3) select 0]);
  _listbox_name lbSetData [_foreachindex,(str((_x select 3) select 1))]; // setzt datansatz als STRING
} foreach _parameter;
// # index vordefinieren und ctrl der auswahl finden
private _lb_index_parameter_name = -1;
private _lb_index_parameter_auswahl = -1;
private _listbox_auswahl = (finddisplay _DEF_idd) displayctrl _DEF_idc_parameter_auswahl;
// # alle aenderungen waehrend des dialogs festhalten
while {dialog} do {
  // + aktionen innerhalb der namen-lb
  if (((lbCurSel _DEF_idc_parameter_name) != _lb_index_parameter_name) && {(lbCurSel _DEF_idc_parameter_name) != -1}) then {
    _lb_index_parameter_name = lbCurSel _DEF_idc_parameter_name;
    //ctrlSetText [_DEF_idc_infotext, (_parameter select _lb_index_parameter_name) select 2];
    ((finddisplay _DEF_idd) displayctrl _DEF_idc_infotext) ctrlSetStructuredText (parseText((_parameter select _lb_index_parameter_name) select 2));
    //_ctrl ctrlSetStructuredText parseText _text;
    lbClear _listbox_auswahl;
    {
      _listbox_auswahl lbadd (_x select 0);
      _listbox_auswahl lbSetData [_foreachindex,str(_x select 1)];
    } foreach ((_parameter select _lb_index_parameter_name) select 1);
    _listbox_auswahl lbSetCurSel -1;
  };
  // + aktionen innerhalb der auswahl-lb
  if (((lbCurSel _DEF_idc_parameter_auswahl) != _lb_index_parameter_auswahl) && {(lbCurSel _DEF_idc_parameter_auswahl) != -1}) then {
    _lb_index_parameter_auswahl = lbCurSel _DEF_idc_parameter_auswahl;
    _lb_text_eintrag = format["%1: %2",
        (_parameter select _lb_index_parameter_name) select 0,
        (((_parameter select _lb_index_parameter_name) select 1) select _lb_index_parameter_auswahl) select 0];
    _listbox_name lbSetText [_lb_index_parameter_name, _lb_text_eintrag];
    _listbox_name lbSetData [_lb_index_parameter_name, str((((_parameter select _lb_index_parameter_name) select 1) select _lb_index_parameter_auswahl) select 1)];
    // aktualisierung der parameter
    _parameter_eintrag = _parameter select _lb_index_parameter_name;
    _parameter_eintrag set [3,
      [
        (((_parameter select _lb_index_parameter_name) select 1) select _lb_index_parameter_auswahl) select 0,
        (((_parameter select _lb_index_parameter_name) select 1) select _lb_index_parameter_auswahl) select 1
      ]
    ];
    _parameter set [_lb_index_parameter_name,_parameter_eintrag];
  };
};


// # zuefaellige parameter setzen
if (a_alles_auf_zufall) then {{_x set [3,selectrandom (_x select 1)]} foreach _parameter};
a_alles_auf_zufall = nil;


[_parameter,format["%1s_mission_generieren.sqf",_missionsverzeichnis]] remoteexec ["execvm",2];

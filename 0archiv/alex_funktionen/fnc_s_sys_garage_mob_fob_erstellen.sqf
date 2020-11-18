/*
  fnc_s_garage_mob_fob
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
params ["_action_obj","_spieler","_action_id","_uebergabe","_area_str"];
private _area = []; call compile format ["_area = %1;",_area_str];
private _fzg_in_garagenbereich = [_area] call fnc_s_sys_area_blockiert;
_fzg_in_garagenbereich params ["_fzg", "_fzg_klasse", "_fzg_displayname"];
if (isnull _fzg) exitwith {
  [["<t color='#ff0000' size='2'>Es befindet sich kein Fahrzeug im Garagen-Bereich!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
if (!isnull s_garage_mob_fob) exitwith {
  [["<t color='#ff0000' size='2'>Es existiert bereits ein mobiles FOB!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
private _sitzplaetze_belegt_plus_freie = fullCrew [_fzg, "cargo", true];
if ((count _sitzplaetze_belegt_plus_freie) == 0) exitwith {
  [[format["<t color='#ff0000' size='2'>%1 kannst du nicht zu einem FOB machen!",_fzg_displayname], "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
s_garage_mob_fob = _fzg;
{
  [s_garage_mob_fob,_x] call fnc_s_sys_garage_mob_fob_action;
  [[format["<t color='#00ff40' size='2'>%1 hat ein mobiles FOB erstellt: %2!",name _spieler,_fzg_displayname], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach playableunits;
private _marker = createmarker [format["respawn_%11","west"],position s_garage_mob_fob];
_marker setMarkerShape "ICON";
_marker setMarkertype "respawn_unknown";
_marker setMarkertext "Mobiles FOB";
while {true} do {
  if (isnull s_garage_mob_fob) exitwith {};
  if ((getdammage s_garage_mob_fob) > 0.95) exitwith {
    {[["<t color='#ff0000' size='2'>Das mobile FOB wurde zerstoert!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
  };
  _marker setmarkerpos (getpos s_garage_mob_fob);
  sleep 0.6;
};
s_garage_mob_fob = objnull;
deletemarker _marker;

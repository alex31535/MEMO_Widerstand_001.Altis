/*
  fnc_s_sys_garage_mob_fob_universal
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
#define _DEF_actionreichweite 30
params ["_fob_obj"];

if ((!isnil "s_garage_mob_fob") && {!isnull s_garage_mob_fob}) then {deletevehicle s_garage_mob_fob;};

s_garage_mob_fob = _fob_obj;


{
  [s_garage_mob_fob,_x] call fnc_s_sys_garage_mob_fob_action;
  [["<t color='#00ff40' size='2'>Ein neues FOB wurde erstellt!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach playableunits;


private _marker = createmarker [format["respawn_%199","west"],position s_garage_mob_fob];
_marker setMarkerShape "ICON";
_marker setMarkertype "respawn_unknown";
_marker setMarkertext "Mobiles FOB HQ";

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

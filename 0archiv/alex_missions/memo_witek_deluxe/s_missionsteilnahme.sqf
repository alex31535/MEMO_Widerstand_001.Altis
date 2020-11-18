/*
  s_missionsteilnahme.sqf
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
params ["_spieler"];
private _positionen_innerhalb_haus = [];
private _startpos = [];
while {(count _startpos) == 0} do {
  uisleep 0.3;
  _positionen_innerhalb_haus = [selectrandom s_temp_dmd_haeuser] call fnc_a_sys_positionen_innerhalb_haus;
  if ((count _positionen_innerhalb_haus) > 0) then {
    _startpos = selectrandom _positionen_innerhalb_haus;
    if ((count(allunits inareaarray [_startpos,15,15,0,false])) > 0) then {_startpos = []};
  };
};
_spieler addrating -10000;
[["<t color='#ffb300' size='4'>Triff dich mit deinen Teamkameraden am Sammelpunkt - Es muessen alle dort sein um den naechsten Punkt freizuschalten!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
[[s_dmd_loc_params,_startpos], "alex_missions\memo_witek_deluxe\a_im_spiel.sqf"] remoteexec ["execVM",_spieler];

/*
  s_fnc_js_spieler_startet_neu
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

systemchat format["s_fnc_js_spieler_startet_neu: %1",name _spieler];


[["....spieleinstieg wird erstellt....", "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];

private _pos = (position s_js_startfahrzeug) findEmptyPosition [0,20,typeof _spieler];

_spieler setpos _pos;

private _uid_var = [
  netid _spieler,
  _pos,
  getdir _spieler,
  getdammage _spieler,
  getunitloadout _spieler
];
call compile format["s_js_uid_var_%1 = _uid_var;",getplayeruid _x];

private _pos_anfuehrer = position (objectfromnetid s_js_anfuehrer_netid);

[ [objectfromnetid s_js_anfuehrer_netid, position s_js_startfahrzeug, s_js_neuspawndist],"alex_missions\jaeger_sammler\a_js_spieler_startet_neu.sqf"] remoteexec ["execvm",_spieler];

/*
  s_mission_anfordern.sqf
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
params ["_remoteexecutedowner"];
// # leichen entfernen
{deletevehicle _x} foreach allDeadMen;
// # vehicle ausserhalb hq loeschen sofern hq-area vorhanden
if (!isnil "s_sys_area_hq") then {
  {
    if ((position _x) inarea s_sys_area_hq) then {
      if ((count(fullCrew [_x, "driver", true])) > 0) then {deletevehicle _x};// fahzeuge mit fahrerposition loeschen
    } else {
      deletevehicle _x;
    };
  } foreach vehicles;
};

// # spieler ausserhalb hq zurueckholen
[] call fnc_s_mission_spieler_zu_hq;


private _loc_params_mission = [];

for "_i" from 1 to 50 do {
  _loc = selectrandom s_sys_locations;
  if ((((_loc select 1) select 0) distance (s_sys_area_hq select 0)) > (((_loc select 2) select 1) + (s_sys_area_hq select 1))) exitwith {_loc_params_mission = _loc};
};


if ((count _loc_params_mission) == 0) exitwith {
  [["<t color='#ff0000' size='2'>Die Missionsanforderung ist fehlgeschlagen - Versuche es nochmal!", "PLAIN", -1, true, true]] remoteExec ["cutText",_remoteexecutedowner];
};


{s_mission_params set [_foreachindex,_x]} foreach s_mission_params_fr;


{
  [eo_hq_missionsteilnahme,[0,format["%1teilnahmebild.jpg",s_mission_params select 2]]] remoteExec ["setObjectTexture", _x, true];
  [[format["<t color='#ff8400' size='2'>%1 angefordert - Standby fuer Missionserstellung!",s_mission_params select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach playableunits;

_loc_params_mission execvm "alex_missions\memo_fast_response\s_mission_generieren.sqf";

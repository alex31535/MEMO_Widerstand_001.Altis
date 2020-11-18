/*
  s_mission_anfordern.sqf (vert)
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
params ["_remoteexecutedowner"]; // kann zahl oder objekt sein !!
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
/* A N P A S S E N */{s_mission_params set [_foreachindex,_x]} foreach s_mission_params_js;
if (!isnil "eo_hq_missionsteilnahme") then {
  {
    [eo_hq_missionsteilnahme,[0,format["%1teilnahmebild.jpg",s_mission_params select 2]]] remoteExec ["setObjectTexture", _x, true];
    [[format["<t color='#ff8400' size='2'>%1 angefordert - Standby fuer Missionserstellung!",s_mission_params select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
  } foreach playableunits;
};
/* A N P A S S E N */s_missionsgenerierungen = s_js_missionsgenerierungen_max +0;
uisleep 8;
s_js_anfuehrer_uid = getplayeruid _remoteexecutedowner;
s_js_anfuehrer_netid = netid _remoteexecutedowner;
[] call fnc_s_sys_memobasis_an_aus;
[_remoteexecutedowner/*OBBJEKT !!*/] execvm format["%1s_mission_parameter_an_spieler.sqf",s_mission_params select 2];

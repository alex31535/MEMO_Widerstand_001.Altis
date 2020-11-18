/*
  s_mission_loeschen.sqf
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

/*
s_mission_params = [
  0: mission aktiv ?  false,
  1: name der Missione  "",
  2: missionspfad zb "alex_missions\memo_deathmatch\" oder "alex_missions\",
  3: aktuelle punkte aus mission  0
  4: notaus false
];
*/
params ["_erstellte_objekte","_erstellte_marker"];
if (s_mission_params select 4) then {
  {
    [[format["<t color='#ff0000' size='4'>%1 wurde ueber NOTAUS beendet!",s_mission_params select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    call compile format["s_%1_loadout_arsenal = [];",getplayeruid _x];
  } foreach playableunits;
};
// # erstellte objekte loeschen
{deletevehicle _x} foreach _erstellte_objekte;
// # erstellte marker loeschen
{deletemarker _x} foreach _erstellte_marker;
// # leichen entfernen
{deletevehicle _x} foreach allDead;
// # minen entfernen
{deletevehicle _x} foreach allMines;
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
// # reset auf mission-params
s_mission_params = [];
{s_mission_params pushback _x} foreach s_mission_params_reset;
if (!isnil "eo_hq_missionsteilnahme") then {
  {[eo_hq_missionsteilnahme,[0,format["%1teilnahmebild.jpg",s_mission_params select 2]]] remoteExec ["setObjectTexture", _x, true]} foreach playableunits;
} else {
  Systemchat "s_mission_loeschen: Fehler - eo_hq_missionsteilnahme nicht vorhanden!";
};

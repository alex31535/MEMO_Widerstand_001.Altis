/*
  init_dmd_server.sqf
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
// # funktionen


// # params (global, mission-bezogen)
s_dmd_loc_params = [];
s_dmd_area_auswahl = [/*[name loc,area loc]*/];
s_dmd_min_gebaeudepositionen = 3;
s_dmd_min_anz_gebaeude = 25; // entspricht auch der gesamtspielerzahl inkl. ki
s_dmd_aktiv = false;
s_dmd_treffpunkt_haus = objnull;
s_dmd_zaehler_treffpunkte = 0;
s_dmd_zufall_spielerklon = [false,false,true,false,false,false,false,false,false,true];
// # liste fuer missions-relevante locations erstellen
private _loc_pos = [];
private _loc_groesse = 0;
private _loc_area = [];
private _loc_haeuser = [];
{
  _loc_pos = locationposition _x;
  _loc_groesse = (((size _x) select 0)+((size _x) select 1))/2;
  _loc_haeuser = [_loc_pos, _loc_groesse, s_dmd_min_gebaeudepositionen] call fnc_a_sys_gebaeudeauswahl;
  if ((count _loc_haeuser) > s_dmd_min_anz_gebaeude) then {
    _loc_area = [_loc_pos, _loc_groesse, _loc_groesse, 0, false];
    s_dmd_area_auswahl pushback [text _x,_loc_area];
  };
} foreach (nearestLocations [[worldsize/2,worldsize/2,0], ["NameCity","NameCityCapital"], worldsize]);
// # eintrag fuer die missionsauswahl erstellen
s_mission_params_dmd = [
  /*0: mission aktiv ?*/  true,
  /*1: name der Missione*/  "Witeks Deathmatch Deluxe",
  /*2: missionspfad zb "alex_missions\memo_deathmatch\" */ "alex_missions\memo_witek_deluxe\",
  /*3: aktuelle punkte aus mission */ 0,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ false,
  /* 6: ausstattungen verfuegbar */ true
];
s_missions_auswahl pushback s_mission_params_dmd;

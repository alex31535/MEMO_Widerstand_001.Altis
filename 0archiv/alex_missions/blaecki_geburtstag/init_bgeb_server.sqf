/*
  init_bgeb_server.sqf
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
s_bgeb_auswahl_vec = [
  "O_MRAP_02_hmg_F",
  "O_APC_Tracked_02_AA_F",
  "O_MRAP_02_gmg_F",
  "O_MBT_02_cannon_F",
  "O_APC_Wheeled_02_rcws_v2_F",
  "O_APC_Tracked_02_cannon_F"
];
s_bgeb_helis = [
  "O_Heli_Light_02_dynamicLoadout_F",
  "O_Heli_Attack_02_dynamicLoadout_F"
];
s_bgeb_flugzeuge = [
 "O_Plane_CAS_02_dynamicLoadout_F"
];
s_bgeb_obj_max = 120;
s_bgeb_prozent_units_haus = 50;
s_bgeb_min_gebaeudepositionen = 4;
s_bgeb_feind_seite = EAST;//[EAST,WEST,RESISTANCE,CIVILIAN] select (getNumber(configFile >> "CfgVehicles" >> (s_bgeb_unitklassen_feind_allgemein select 0) >> "side"));
s_begeb_gruppenstaerken_zufuss = [1,2,3,4];
s_begeb_auswahl_zielfahrzeuge = ["B_APC_Tracked_01_rcws_F","B_APC_Tracked_01_CRV_F"];



// # liste fuer missions-relevante locations erstellen

s_mission_params_bgeb = [
  /*0: mission aktiv ?*/  true,
  /*1: name der Missione*/  "Blaeckis Geburtstagsmission",
  /*2: missionspfad zb "alex_missions\memo_deathmatch\" */ "alex_missions\blaecki_geburtstag\",
  /*3: aktuelle punkte aus mission */ 0,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ true,
  /* 6: ausstattungen verfuegbar */ true
];
s_missions_auswahl pushback s_mission_params_bgeb;

/*
  init_fr_server.sqf
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



// # params: s_fr_mission
s_fr_mission = [];

s_fr_unitklassen_zielperson_allgemein = ["O_officer_F"];
s_fr_unitklassen_feind_allgemein = ["O_Soldier_GL_F"];
// -> ggf allgemeine feindklassen durch systemvorgaben ersetzen
if (!isnil "s_units_aus_cfg_0") then {s_fr_unitklassen_feind_allgemein = s_units_aus_cfg_0};

s_fr_feind_seite = [EAST,WEST,RESISTANCE,CIVILIAN] select (getNumber(configFile >> "CfgVehicles" >> (s_fr_unitklassen_feind_allgemein select 0) >> "side"));

// # pruefen ob ggf neue zielpersonen durch manipulierte feindklassen zur verfuegung stehen
private _alternative_zielpersonen = [];
{if (((tolower _x) find "officer") != -1) then {_alternative_zielpersonen pushback _x}} foreach s_fr_unitklassen_feind_allgemein;
if ((count _alternative_zielpersonen) > 0) then {s_fr_unitklassen_zielperson_allgemein = _alternative_zielpersonen};

s_fr_unitklassen_zivilist_allgemein = ["C_man_1_1_F"];
// -> ggf allgemeine zivilklassen durch systemvorgaben ersetzen
if (!isnil "s_units_aus_cfg_3") then {s_fr_unitklassen_zivilist_allgemein = s_units_aus_cfg_3};

s_fr_missionspunkte = 100;
s_fr_missionsende = 0;

s_mission_params_fr = [
  /*0: mission aktiv ?*/  true,
  /*1: name der Missione*/  "Fast Response",
  /*2: missionspfad zb "alex_missions\memo_deathmatch\" */ "alex_missions\memo_fast_response\",
  /*3: aktuelle punkte aus mission */ 0,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ true,
  /* 6: ausstattungen verfuegbar */ true
];

s_missions_auswahl pushback s_mission_params_fr;

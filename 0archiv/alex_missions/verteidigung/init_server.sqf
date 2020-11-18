/*
  init_hlhc_server.sqf
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
fnc_s_vert_moerserziel = compile preprocessfilelinenumbers "alex_missions\verteidigung\fnc_s_vert_moerserziel.sqf";

// # params (global, mission-bezogen)
s_vert_unitklassen_feind_allgemein = s_units_aus_cfg_0;
s_vert_vecklassen_rad = s_sys_vec_rad_0;
s_vert_vecklassen_kette = s_sys_vec_kette_0;
s_vert_vecklassen_flug = s_sys_vec_flug_0;
s_vert_vecklassen_heli = s_sys_vec_heli_0;
s_vert_anz_max_objekte = -1;
s_vert_zielobjekt_klasse_spieler = "Flag_Blue_F";
s_vert_zielobjekt_klasse_feind = "Flag_Red_F";
s_vert_spcfg_obj_klasse = "Box_NATO_AmmoOrd_F";
s_vert_punkte_spieler_start = -1;
s_vert_punkte_sieg = 10000;
s_vert_str_m_fahne = "m_vert_fahne";
s_vert_str_m_fahne_area = "m_vert_fahne_area";
s_vert_pos_fob = [];// generiert sobald eine spawn-pos ermittelt wurde :: wird in missionsteilnahme abgefragt! :: wird am missionsende geloescht
s_vert_random_spawn = []; // wird beim generieren/core resetet und befuellt
s_vert_liste_spieler_spawn_pos = []; // wird beim generieren/core befuellt
s_vert_missionsgenerierungen_max = 50;
s_vert_missionskennung = "vert";
s_vert_moerser_pos = []; // nach core unbedingt reset!
s_vert_anz_moersersignal = 3;
s_vert_moersersignal_zaehler = 0; // wird in core wieder auf null gesetzt
s_vert_dist_moerser = 800;
s_vert_rucksaecke = [
  ["B_UAV_01_backpack_F",1],
  /*["I_C_HMG_02_high_weapon_F",1],*/
  ["B_GMG_01_high_weapon_F",1],
  ["B_HMG_01_high_weapon_F",1],
  ["B_HMG_01_support_high_F",3]
];
s_vert_items = [
  ["B_UavTerminal",1]
];
s_vert_mags = [
  ["SmokeShellPurple",10]
];





// # liste fuer missions-relevante locations erstellen
s_mission_params_vert = [
  /*0: mission aktiv ?*/  true,
  /*1: name der Missione*/  "Verteidigung",
  /*2: missionspfad zb "alex_missions\memo_deathmatch\" */ "alex_missions\verteidigung\",
  /*3: aktuelle punkte aus mission */ 0,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ false,
  /* 6: ausstattungen verfuegbar */ true
];
s_missions_auswahl pushback s_mission_params_vert;

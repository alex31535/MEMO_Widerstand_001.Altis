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
fnc_s_vertZ_moerserziel = compile preprocessfilelinenumbers "alex_missions\verteidigung_zombie\fnc_s_vert_moerserziel.sqf";

// # params (global, mission-bezogen)
s_vertZ_zombieklassen_feind_allgemein = s_zombies_aus_cfg_2;
for "_i" from 1 to 4 do {s_vertZ_zombieklassen_feind_allgemein pushback (selectrandom s_zombieboss_aus_cfg_2)}; s_vertZ_zombieklassen_feind_allgemein call BIS_fnc_arrayShuffle;
s_vertZ_unitklassen_feind_allgemein = s_units_aus_cfg_0;
s_vertZ_vecklassen_rad = ["C_Offroad_01_F","CUP_O_Hilux_unarmed_CHDKZ","CUP_O_UAZ_Open_RU"];//s_sys_vec_rad_0;
s_vertZ_vecklassen_kette = ["CUP_O_Ural_Open_RU","O_Truck_02_transport_F"];//s_sys_vec_kette_0;
s_vertZ_anz_max_objekte = -1;
s_vertZ_anz_max_zombies = 50;// in PROZENT!!! von gesamtzahl objekte, wird veraendert ueber spieler-parameter (s. GENERIEREN)
s_vertZ_anz_max_units = 100 - s_vertZ_anz_max_zombies;// in PROZENT!!! wird beeinflusst durch s_vertZ_anz_max_zombies (s. GENERIEREN)
s_vertZ_zielobjekt_klasse_spieler = "Flag_Blue_F";
s_vertZ_zielobjekt_klasse_feind = "Flag_Red_F";
s_vertZ_spcfg_obj_klasse = "Box_NATO_AmmoOrd_F";
s_vertZ_punkte_spieler_start = -1;
s_vertZ_punkte_sieg = 10000;
s_vertZ_str_m_fahne = "m_vert_fahne";
s_vertZ_str_m_fahne_area = "m_vert_fahne_area";
s_vertZ_pos_fob = [];// generiert sobald eine spawn-pos ermittelt wurde :: wird in missionsteilnahme abgefragt! :: wird am missionsende geloescht
s_vertZ_random_spawn = []; // wird beim generieren/core resetet und befuellt
s_vertZ_liste_spieler_spawn_pos = []; // wird beim generieren/core befuellt
s_vertZ_missionsgenerierungen_max = 50;
s_vertZ_missionskennung = "vert";
s_vertZ_moerser_pos = []; // nach core unbedingt reset!
s_vertZ_anz_moersersignal = 3;
s_vertZ_moersersignal_zaehler = 0; // wird in core wieder auf null gesetzt
s_vertZ_dist_moerser = 800;
s_vertZ_rucksaecke = [
  ["B_UAV_01_backpack_F",1],
  /*["I_C_HMG_02_high_weapon_F",1],*/
  ["B_GMG_01_high_weapon_F",1],
  ["B_HMG_01_high_weapon_F",1],
  ["B_HMG_01_support_high_F",3]
];
s_vertZ_items = [
  ["B_UavTerminal",1],
  ["RyanZombiesAntiVirusCure",5]
  /*,
  ["RyanZombiesAntiVirusTemporary",10]*/
];
s_vertZ_mags = [
  ["SmokeShellPurple",10]
];





// # liste fuer missions-relevante locations erstellen
s_mission_params_vertZ = [
  /*0: mission aktiv ?*/  true,
  /*1: name der Missione*/  "Verteidigung (Z-Edition)",
  /*2: missionspfad zb "alex_missions\memo_deathmatch\" */ "alex_missions\verteidigung_zombie\",
  /*3: aktuelle punkte aus mission */ 0,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ false,
  /* 6: ausstattungen verfuegbar */ true
];
s_missions_auswahl pushback s_mission_params_vertZ;

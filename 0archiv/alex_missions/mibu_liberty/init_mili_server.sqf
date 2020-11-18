/*
  init_mili_server.sqf
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

if (isnil "eo_liberty") exitwith {systemchat "init_mili_server.sqf: Abbruch - Objekt eo_liberty nicht vorhanden"};

[] execvm "alex_missions\mibu_liberty\s_params_liberty.sqf";



// # funktionen


// # params (global, mission-bezogen)

// # liste fuer missions-relevante locations erstellen

s_mission_params_mili = [
  /*0: mission aktiv ?*/  true,
  /*1: name der Missione*/  "MiBu: Liberty",
  /*2: missionspfad zb "alex_missions\memo_deathmatch\" */ "alex_missions\mibu_liberty\",
  /*3: aktuelle punkte aus mission */ 0,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ true,
  /* 6: ausstattungen verfuegbar */ true
];
s_missions_auswahl pushback s_mission_params_mili;
s_mili_zeitfenster_vorgabe = [25,20,15,10,5,3,2,1]; /* MINUTEN!!!*/
s_mili_seite = east;
s_mili_besetzung = [ /* in prozent */
/* 0: schiffsobjekt [klasse, pos, dir]*/ -1,
/* 1: debugpos an bord: [pos, dir] */ -1,
/* 2: waffen [[klasse,pos, dir],...] */ 80,
/* 3: kisten/deko [[pos, dir],...] */ 60,
/* 4: ki-pos flugdeck [[pos, dir],...] */ 0,
/* 5: ki-pos gang [[pos, dir],...] */ 40,
/* 6: ki-pos bruecke [[pos, dir],...] */ 20,
/* 7: ki-pos bootsdeck [[pos, dir],...] */ 25,
/* 8: ki-pos bug [[pos, dir],...] */ 30,
/* 9: ki-pos hangar [[pos, dir],...] */ 50,
/* 10: ki-pos taucher [[pos, dir],...] */ 70,
/* 11: ki-pos geisel [[pos, dir],...] */ -1, /* wird nun anhand cargo-space des heli auf dem flugdeck berechnet */
/* 12: pos fluchtpunkt [pos] */ -1
];
s_mili_deko = [
"Land_Pallet_MilBoxes_F",
"Land_PaperBox_open_full_F",
"Land_PaperBox_open_empty_F",
"Land_PaperBox_closed_F"
];
s_mili_ki_klassen = [
  "O_Soldier_F"
];
s_mili_ki_klassen_taucher = [
  "O_Diver_F"
];

s_mili_ki_klassen_geisel = [
  "C_man_1_1_F"
];

s_mili_ki_loadout_geisel = [
  "B_Survivor_F"
];

s_mili_waffensets_angreifer = [
  [
    ["SMG_01_F","","acc_flashlight_smg_01","",["30Rnd_45ACP_Mag_SMG_01",30],[],""],
    [],
    [],
    [],
    ["V_BandollierB_blk",[["MiniGrenade",1,1],["30Rnd_45ACP_Mag_SMG_01_Tracer_Red",7,30]]]
  ],
  [
    ["hgun_PDW2000_F","","","",["30Rnd_9x21_Mag",30],[],""],
    [],
    [],
    [],
    ["V_BandollierB_blk",[["30Rnd_9x21_Red_Mag",7,30]]]
  ],
  [
    [],
    [],
    ["hgun_ACPC2_F","","acc_flashlight_pistol","",["9Rnd_45ACP_Mag",9],[],""],
    [],
    ["V_BandollierB_blk",[["9Rnd_45ACP_Mag",12,9]]]
  ]
];

s_mili_uniformen_angreifer = [
  "U_BG_Guerilla1_1",
  "U_BG_Guerilla3_1",
  "U_BG_Guerrilla_6_1"
];

s_mili_brillen_angreifer = [
  "G_Bandanna_shades",
  "G_Bandanna_tan",
  "G_Bandanna_khk",
  "G_Bandanna_oli",
  "G_Bandanna_aviator",
  "G_Bandanna_blk",
  "G_Bandanna_sport"
];

s_mili_uniformen_geiseln = [
  "U_BG_Guerilla2_1",
  "U_BG_Guerilla2_2",
  "U_BG_Guerilla2_3"
];

s_mili_westen_geiseln = [
  "V_Press_F"
];



// # reset-parameter
s_mili_liste_geiseln = [];
s_mili_liste_ki = [];
s_mili_liste_dekoobjekte = [];
s_mili_debugpos = [];
s_mili_waffenliste = [];
s_mili_marker = "";
s_mili_waffenoffizier = objnull;
s_mili_liste_geiselnehmer = [];

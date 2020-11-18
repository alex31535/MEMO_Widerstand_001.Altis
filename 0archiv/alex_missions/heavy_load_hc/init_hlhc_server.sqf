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

if (isnil "eo_hl_fzg") exitwith {systemchat "init_hlhc_server: abbruch - eo_hl_fzg nicht gefunden!"};
if (isnil "eo_hl_fzg_benzin") exitwith {systemchat "init_hlhc_server: abbruch - eo_hl_fzg_benzin nicht gefunden!"};

// # funktionen


// # params (global, mission-bezogen)
s_hlhc_fzg_params = [typeof eo_hl_fzg,getposworld eo_hl_fzg,getdir eo_hl_fzg]; deletevehicle eo_hl_fzg; eo_hl_fzg = nil;
s_hlhc_fzg_benzin_params = [typeof eo_hl_fzg_benzin,getposworld eo_hl_fzg_benzin,getdir eo_hl_fzg_benzin]; deletevehicle eo_hl_fzg_benzin; eo_hl_fzg_benzin = nil;
s_hlhc_speedlimit = [12,-10,2.5,-2.5];
s_hlhc_spawn_dist = [350,50];// 500-600m
s_hlhc_dist_max = worldsize /2;
s_hlhc_gebaeude_spawn_hauspos = 2;
s_hlhc_max_vec = 5;
//s_hlhc_max_ki_zufuss = 30;
s_hlhc_max_ki_pro_spieler = 3;
s_hlhc_benzinverlust = 0.00005;
s_hlhc_unitklassen_feind_allgemein = ["O_Soldier_GL_F"];
s_hlhc_zeitabstand_verfolgung = 5;
s_hlhc_dist_zuendung_selbstmoerder = 15;
s_hlhc_chance_selbstmoerder = [false,true,false,true,false,true,false,false,true,false];
s_hlhc_chance_launcher = [false,false,false,false,false,false,false,false,true,false];
s_hlhc_waffensets_angreifer = [
  [
    ["SMG_01_F","","acc_flashlight_smg_01","",["30Rnd_45ACP_Mag_SMG_01",30],[],""],
    "sekundaer",
    [],
    "uniform",
    ["V_BandollierB_blk",[["MiniGrenade",1,1],["30Rnd_45ACP_Mag_SMG_01_Tracer_Red",7,30]]]
  ],
  [
    ["hgun_PDW2000_F","","","",["30Rnd_9x21_Mag",30],[],""],
    "sekundaer",
    [],
    "uniform",
    ["V_BandollierB_blk",[["30Rnd_9x21_Red_Mag",7,30]]]
  ],
  [
    [],
    "sekundaer",
    ["hgun_ACPC2_F","","acc_flashlight_pistol","",["9Rnd_45ACP_Mag",9],[],""],
    "uniform",
    ["V_BandollierB_blk",[["9Rnd_45ACP_Mag",12,9]]]
  ],
  [
    ["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],
    "sekundaer",
    [],
    "uniform",
  ["V_BandollierB_khk",[["30Rnd_762x39_Mag_F",6,30],["MiniGrenade",2,1]]]
  ],
  [
  ["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],
    "sekundaer",
    [],
    "uniform",
    ["V_BandollierB_blk",[["30Rnd_545x39_Mag_F",6,30],["MiniGrenade",3,1]]]
  ]
];

s_hlhc_launchersets_angreifer = [
  [
    /*loadoutpos 1*/["launch_RPG32_F","","","",["RPG32_F",1],[],""],
    /*loadoutpos 5*/["B_FieldPack_oli",[["RPG32_F",3,1]]]
  ]
];
s_hlhc_rucksacksets_selbstmoerder = [
  /*loadoutpos 5*/["B_Kitbag_sgg",[["CUP_TimeBomb_M",6,1]]]
];
s_hlhc_uniformen_angreifer = [
  "U_BG_Guerilla1_1",
  "U_BG_Guerilla3_1",
  "U_BG_Guerrilla_6_1"
];
s_hlhc_brillen_angreifer = [
  "G_Bandanna_shades",
  "G_Bandanna_tan",
  "G_Bandanna_khk",
  "G_Bandanna_oli",
  "G_Bandanna_aviator",
  "G_Bandanna_blk",
  "G_Bandanna_sport"
];

// # liste fuer missions-relevante locations erstellen
s_mission_params_hlhc = [
  /*0: mission aktiv ?*/  true,
  /*1: name der Missione*/  "Schwer beladen (HARDCORE)",
  /*2: missionspfad zb "alex_missions\memo_deathmatch\" */ "alex_missions\heavy_load_hc\",
  /*3: aktuelle punkte aus mission */ 0,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ false,
  /* 6: ausstattungen verfuegbar */ true
];
s_missions_auswahl pushback s_mission_params_hlhc;

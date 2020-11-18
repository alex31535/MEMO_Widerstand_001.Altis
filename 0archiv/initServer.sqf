s_initserver_beendet = false;
//
s_objektklassen_aus_cfg_aktiv = true;
s_slive_aktiv = true;
s_garage_aktiv = true;
s_garage_w_aktiv = true;
s_spcfg_aktiv = true;
s_missions_aktiv = true;
s_score_aktiv = false;

s_tfar_aktiv = TFAR_fnc_isTeamSpeakPluginEnabled;


private _scriptaufruf = false;

//------------------------------------------------------------------------------<SYSTEM: Funktionen
systemchat "initialisiere System-Funktionen...";
// # system
fnc_s_sys_area_blockiert = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_area_blockiert.sqf";
fnc_s_sys_cityring_strassenliste = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_cityring_strassenliste.sqf";
fnc_s_sys_wp_area_strassen = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_wp_area_strassen.sqf";
fnc_s_sys_pos_im_wald = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_pos_im_wald.sqf";
fnc_s_sys_cityring_strassen_besetzen = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_cityring_strassen_besetzen.sqf";
fnc_s_sys_spawn_unit = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_spawn_unit.sqf";
fnc_s_sys_unit_in_bestimmten_haus = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_unit_in_bestimmten_haus.sqf";
fnc_s_sys_fluggeraet_sad = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_fluggeraet_sad.sqf";
fnc_s_sys_area_haus_aus_liste = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_area_haus_aus_liste.sqf";
fnc_s_sys_spawnpos_in_umkreis_obj = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_spawnpos_in_umkreis_obj.sqf";
fnc_s_sys_unit_konfig_skills = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_unit_konfig_skills.sqf";
fnc_s_sys_unit_konfig_waffenset = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_unit_konfig_waffenset.sqf";
fnc_s_sys_unit_konfig_loadout = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_unit_konfig_loadout.sqf";
fnc_s_sys_garage_mob_fob_universal = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_garage_mob_fob_universal.sqf";
fnc_s_sys_pos_dir_strassenrand = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_pos_dir_strassenrand.sqf";
fnc_s_missionsgenerierung_wiederholen = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_missionsgenerierung_wiederholen.sqf";
fnc_s_sys_missionsparameter_inidbi = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_missionsparameter_inidbi.sqf";
fnc_s_sys_moerser = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_moerser.sqf";
fnc_s_sys_fluggeraet_start_ziel = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_fluggeraet_start_ziel.sqf";
fnc_s_sys_unit_folgt = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_unit_folgt.sqf";
fnc_s_sys_memobasis_an_aus = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_memobasis_an_aus.sqf";
// # admin
fnc_s_admin_wetter = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_wetter.sqf";
fnc_s_admin_uhrzeit = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_uhrzeit.sqf";
fnc_s_admin_nebel = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_nebel.sqf";
  //fnc_s_admin_abiemte_effekte
fnc_s_admin_ki_level_min = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_ki_level_min.sqf";
fnc_s_admin_ki_level_max = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_ki_level_max.sqf";
fnc_s_admin_mission_notaus = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_mission_notaus.sqf";
fnc_s_admin_spieler_zum_hq = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_spieler_zum_hq.sqf";
fnc_s_admin_ki_teamkamerad = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_ki_teamkamerad.sqf";
fnc_s_admin_ki_entfernen = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_ki_entfernen.sqf";
fnc_s_admin_uhrzeit_setzen = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_uhrzeit_setzen.sqf";
fnc_s_admin_nebel_setzen = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_nebel_setzen.sqf";
fnc_s_admin_wetter_setzen = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_wetter_setzen.sqf";
fnc_s_admin_ki_level_min_setzen = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_ki_level_min_setzen.sqf";
fnc_s_admin_ki_level_max_setzen = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_admin_ki_level_max_setzen.sqf";
// # debugmarker
fnc_s_debugmarker_erstellen = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_debugmarker_erstellen.sqf";
// # objektmuelleimer
fnc_s_objmuell_intervall = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_objmuell_intervall.sqf";
fnc_s_objmuell_obj = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_objmuell_obj.sqf";
fnc_s_objmuell_alles = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_objmuell_alles.sqf";
// # slive
fnc_s_slive_stats_neu = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_slive_stats_neu.sqf";
fnc_s_slive_stats_anwenden = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_slive_stats_anwenden.sqf";
fnc_s_slive_stats_speichern = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_slive_stats_speichern.sqf";
// # spcfg
fnc_s_spcfg_ausstattungen_auflisten = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_spcfg_ausstattungen_auflisten.sqf";
fnc_s_spcfg_spieler_ausstatten = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_spcfg_spieler_ausstatten.sqf";
fnc_s_spcfg_arsenal_memo = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_spcfg_arsenal_memo.sqf";
fnc_s_spcfg_loadout_spieler_speichern = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_spcfg_loadout_spieler_speichern.sqf";
fnc_s_spcfg_arsenalloadout_aktualisieren = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_spcfg_arsenalloadout_aktualisieren.sqf";
fnc_s_spcfg_arsenalloadout_auf_spieler = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_spcfg_arsenalloadout_auf_spieler.sqf";
fnc_s_spcfg_ausstattungen_auflisten_psycho = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_spcfg_ausstattungen_auflisten_psycho.sqf";
fnc_s_spcfg_spieler_ausstatten_psycho = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_spcfg_spieler_ausstatten_psycho.sqf";
fnc_s_spcfg_action_auf_obj = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_spcfg_action_auf_obj.sqf";
fnc_s_spcfg_loadout_bz = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_spcfg_loadout_bz.sqf";
// # garage
fnc_s_sys_transfer_zu_hq_x = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_transfer_zu_hq_x.sqf";
fnc_s_sys_transfer_zu_fob = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_transfer_zu_fob.sqf";
fnc_s_sys_garage_ausparken_abschluss = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_garage_ausparken_abschluss.sqf";
fnc_s_sys_garage_ausparken = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_garage_ausparken.sqf";
fnc_s_sys_garage_auftanken = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_garage_auftanken.sqf";
fnc_s_sys_garage_aufmunitionieren = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_garage_aufmunitionieren.sqf";
fnc_s_sys_garage_reparieren = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_garage_reparieren.sqf";
fnc_s_sys_garage_einparken = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_garage_einparken.sqf";
fnc_s_sys_garage_mob_fob_erstellen = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_garage_mob_fob_erstellen.sqf";
fnc_s_sys_garage_mob_fob_action = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_sys_garage_mob_fob_action.sqf";
// # missions-framework
fnc_s_mission_mission_waehlen = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_mission_mission_waehlen.sqf";
fnc_s_mission_mission_aktivieren = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_mission_mission_aktivieren.sqf";
fnc_s_mission_spieler_zu_hq = compile preprocessfilelinenumbers "alex_funktionen\fnc_s_mission_spieler_zu_hq.sqf";
// # mission: fast response
// # mission: blaeckis geburtstag
// # mission: heavy load hardcore
// # mission: heavy load
// # mission: deathmatch deluxe
// # mission: deathmatch
// # mission: liberty




//------------------------------------------------------------------------------<SYSTEM: Objektklassen
/*
+funktionen:
  keine nutzung von funktionen
+editor-objekte (eo_xyz):
  eo_hq_missionsgeber
  eo_mod_%1
+editor-marker (em_xyz):
  em_insel_%1
*/
if (s_objektklassen_aus_cfg_aktiv) then {
  systemchat "initialisiere Objektklassen...";
  /* inkludiert s_sys_lo_X_Y_Z :*/
  #include "ausstattungen_ki.hpp"
  s_sys_locations = [
    /*0 text _x, */
    /*1 loc- innen [locationposition _x, _groesse, _groesse, 0, false],  */
    /*2 loc "aktivierung" [locationposition _x, _groesse + _dist_aktivierung, _groesse + _dist_aktivierung, 0, false],*/
    /*3 loc "deaktivierung" [locationposition _x, _groesse + _dist_deaktivierung, _groesse + _dist_deaktivierung, 0, false],*/
		/*4 loc auf einer insel? true/false ---> inseln werde durch marker mit der kennung em_insel_%1 markiert. diese werden nach abfrage auf unsichtbar gesetzt */
  ];
  s_sys_dist_loc_aktivierung = 800; // ring 1
  s_sys_dist_loc_deaktivierung = 1500; // ring 2
  s_map_mods = ["vanilla"];
  /* moegliche mods:
    ["vanilla","kart","mark","CUP_Units","expansion","CBA_A3","jets","argo","orange","tacops","tank","enoch","GM"]
    die bestimmung weiterer mods erfolg ueber die platzierung von editor-objekten mit der kennung: eo_mod_%1 */
  s_units_aus_cfg_0 = [/*0:EAST*/]; s_units_aus_cfg_1 = [/*1:WEST*/]; s_units_aus_cfg_2 = [/*2:RESISTANCE*/]; s_units_aus_cfg_3 = [/*3:CIVILIAN*/];
  s_zombies_aus_cfg_0 = [/*0:EAST*/]; s_zombies_aus_cfg_1 = [/*1:WEST*/]; s_zombies_aus_cfg_2 = [/*2:RESISTANCE*/]; s_zombies_aus_cfg_3 = [/*3:CIVILIAN*/];
  s_zombieboss_aus_cfg_0 = [/*0:EAST*/]; s_zombieboss_aus_cfg_1 = [/*1:WEST*/]; s_zombieboss_aus_cfg_2 = [/*2:RESISTANCE*/]; s_zombieboss_aus_cfg_3 = [/*3:CIVILIAN*/];
  s_sys_vec_kette_0 = [];   s_sys_vec_kette_1 = []; s_sys_vec_kette_2 = []; s_sys_vec_kette_3 = [];
  s_sys_vec_rad_0 = []; s_sys_vec_rad_1 = []; s_sys_vec_rad_2 = []; s_sys_vec_rad_3 = [];
  s_sys_vec_heli_0 = []; s_sys_vec_heli_1 = []; s_sys_vec_heli_2 = []; s_sys_vec_heli_3 = [];
  s_sys_vec_flug_0 = []; s_sys_vec_flug_1 = []; s_sys_vec_flug_2 = []; s_sys_vec_flug_3 = [];
  s_sys_wasserfahrzeuge_0 = []; s_sys_wasserfahrzeuge_1 = []; s_sys_wasserfahrzeuge_2 = []; s_sys_wasserfahrzeuge_3 = [];
  /* der inhalt der objektlisten wird anhand der cfg-eintraege unter zuhilfenahme des mod-filters bestimmt */
 _scriptaufruf = [] execvm "alex_scripte\alex_system_objektklassen.sqf"; waituntil {scriptdone _scriptaufruf};
 s_sys_area_hq = [position eo_hq_missionsgeber,500, 500, 0, false];
 {_x allowdammage false} foreach ((s_sys_area_hq select 0) nearObjects ["House",s_sys_area_hq select 1]);
};
//------------------------------------------------------------------------------SYSTEM: Objektklassen>

//------------------------------------------------------------------------------<ADMIN
/*
+funktionen:
  fnc_s_admin_wetter_setzen
  fnc_s_admin_wetter
  fnc_s_admin_uhrzeit
  fnc_s_admin_nebel
  fnc_s_admin_abiemte_effekte
  fnc_s_admin_ki_level_min
  fnc_s_admin_ki_level_max
  fnc_s_admin_mission_notaus
  fnc_s_admin_spieler_zum_hq
  fnc_s_admin_ki_teamkamerad
  fnc_s_admin_ki_entfernen
  fnc_s_admin_uhrzeit_setzen
  fnc_s_admin_nebel_setzen
  fnc_s_admin_wetter_setzen
  fnc_s_admin_ki_level_min_setzen
  fnc_s_admin_ki_level_max_setzen
  fnc_s_sys_unit_konfig_skills
+editor-objekte (eo_xyz):
  eo_admin
  eo_admin_lampe_1
+editor-marker (em_xyz):
  keine
*/
systemchat "initialisiere Admin-Funktionen...";
if (!isnull eo_admin) then {eo_admin allowdammage false};
if (!isnull eo_admin_lampe_1) then {eo_admin_lampe_1 allowdammage false};
s_admin_spieler_uid = [
/*[Alex31535]*/   "76561197996449012",
/*[Mibu]*/        "76561198072927849",
/*[Alex1]*/       "76561198133185572",
/*[Psycho]*/      "76561197990980361",
/*[Bobby  Biber] "76561197981056315"*/
/*[witek]*/       "76561198018425052"
/*[Papa] "76561198051263858"*/
/*[seb] "76561198086095654"*/
/*[boss] "76561198853730385"*/
];
s_admin_uhrzeiten = []; for "_i" from 0 to 23 do {s_admin_uhrzeiten pushback [2021,5,21,_i,0];s_admin_uhrzeiten pushback [2021,5,21,_i,30]};
s_admin_ki_level_min = 5;
s_admin_ki_level_max = 20;
[((random 100)/100)] call fnc_s_admin_wetter_setzen;
if (isdedicated) then {private _datum_zeit = systemTime; _datum_zeit resize 5; setDate _datum_zeit};

//------------------------------------------------------------------------------ADMIN>

//------------------------------------------------------------------------------<OBJEKTMUELLEIMER
/*
+funktionen:
  keine
+editor-objekte (eo_xyz):
  keine
+editor-marker (em_xyz):
  keine
*/
systemchat "initialisiere Objektmuelleimer...";
[15] execVM "alex_scripte\init_objektmuelleimer.sqf";
//------------------------------------------------------------------------------OBJEKTMUELLEIMER>

//------------------------------------------------------------------------------<DEBUGMARKER
/*
+funktionen:
  ???
+editor-objekte (eo_xyz):
  ???
+editor-marker (em_xyz):
  ???
*/
s_debugmarker = true; if (isdedicated) then {s_debugmarker = false};
if (s_debugmarker) then {
  systemchat "initialisiere Debugmarkierer...";
  params ["_debugmarker_kennung"];
  s_debugmarker_kennung = "DeBuG";
  s_debugmarker_farbe = [/*0:EAST*/"ColorEAST",/*1:WEST*/"ColorWEST",/*2:RESISTANCE*/"ColorGUER",/*3:CIVILIAN*/"ColorCIV",/*4:NEUTRAL*/"ColorUNKNOWN"];
  [] execVM "alex_scripte\init_debugmarker.sqf";
};
//------------------------------------------------------------------------------DEBUGMARKER>

//------------------------------------------------------------------------------<SLIVE
if ((s_slive_aktiv) && {! isnil "eo_slive_obj_startposworld"}) then {
  systemchat "initialisiere SLive...";
  s_slive_startloadout_west = getunitloadout "B_Soldier_F"; if (!isnil "s_units_aus_cfg_1") then {s_slive_startloadout_west = s_units_aus_cfg_1 select 0};
  s_slive_startposworld = getposworld eo_slive_obj_startposworld; deletevehicle eo_slive_obj_startposworld;
  s_slive_name_db = "slive_test";
  s_slive_version_db = 0.01;
  s_slive_keys_db = [
    /*0:*/"pos",
    /*1:*/"dir",
    /*2:*/"haltung",
    /*3:*/"gesundheit",
    /*4:*/"ausstattung"
  ];
  if ((isserver) && {!isdedicated}) then {
    player addAction ["<t color='#ffbb00'>DEBUG: SLive Disconnect",
      {[getplayeruid player,name player,[getposworld player,getdir player,stance player,(getAllHitPointsDamage player) select 2,getunitloadout player]] call fnc_s_slive_stats_speichern;
      },"",1.5,true,true,"","",2];
  };
};
//------------------------------------------------------------------------------SLIVE>

//------------------------------------------------------------------------------<SPCFG
if (!isnil "eo_obj_spcfg") then {eo_obj_spcfg allowdamage false};
if ((s_spcfg_aktiv) && {! isnil "eo_spcfg_spieler"} && {! isnil "eo_obj_spcfg"}) then {
  systemchat "initialisiere Ausstattungen...";
  eo_obj_spcfg_mission = objnull;
  s_spcfg_loadout_spieler_universal = getunitloadout eo_spcfg_spieler; deletevehicle eo_spcfg_spieler;
  eo_obj_spcfg allowdammage false;
  clearWeaponCargoGlobal eo_obj_spcfg;
  clearMagazineCargoGlobal eo_obj_spcfg;
  clearBackpackCargoGlobal eo_obj_spcfg;
  clearItemCargoGlobal eo_obj_spcfg;
  if (! isnil "eo_obj_spcfg_lampe_1") then {eo_obj_spcfg_lampe_1 allowdammage false};
  #include "ausstattungen_whiteliste_vanilla.hpp"
  /* liefert:
    s_spcfg_arsenal_whitelist_rucksaecke
    s_spcfg_arsenal_whitelist_items
    s_spcfg_arsenal_whitelist_waffen
    s_spcfg_arsenal_whitelist_munition
  */
  {
    _waffe = _x;
    _magazine = (getArray(configFile >> "CfgWeapons" >> _waffe >> "magazines")) select {!(_x in s_spcfg_arsenal_whitelist_munition)};
    s_spcfg_arsenal_whitelist_munition append _magazine;
  } foreach s_spcfg_arsenal_whitelist_waffen;
  s_spcfg_units_schnellausstattung_0 = []; s_spcfg_units_schnellausstattung_1  = []; s_spcfg_units_schnellausstattung_2  = [];
  s_spcfg_units_schnellausstattung_3  = []; s_spcfg_units_schnellausstattung_4  = [];
  for "_i" from 0 to 4 do {
    call compile format["if (!isnil ""s_units_aus_cfg_%1"") then {s_spcfg_units_schnellausstattung_%1 = s_units_aus_cfg_%1};",_i];
  };
  #include "ausstattungen_psycho.hpp"
  /* liefert:
    s_spcfg_ausstattungen_psycho = [
      ["Psycho Pilot",[UNITLOADOUT]],
      ...
    ];
  */
  s_spcfg_bz_loadout_4_weste = [];
  {for "_i" from 1 to 6 do {s_spcfg_bz_loadout_4_weste pushback (format["CUP_V_OI_TKI_Jacket%1_0%2",_x,_i])}} foreach [1,3,5,6];
  s_spcfg_bz_loadout_0_4 = [
  [["CUP_arifle_AKM_Early","","","",["CUP_30Rnd_762x39_AK47_bakelite_M",30],[],""],["CUP_V_OI_TKI_Jacket1_04",[["CUP_30Rnd_762x39_AK47_bakelite_M",3,30],["HandGrenade",1,1]]]],
  [["CUP_srifle_CZ550_rail","","","",["CUP_5x_22_LR_17_HMR_M",5],[],""],["CUP_V_OI_TKI_Jacket6_01",[["HandGrenade",1,1],["CUP_5x_22_LR_17_HMR_M",10,5]]]],
  [["CUP_sgun_CZ584","","","",["CUP_1Rnd_12Gauge_Pellets_No00_Buck",1],[],""],["CUP_V_OI_TKI_Jacket6_01",[["HandGrenade",1,1],["CUP_1Rnd_12Gauge_Pellets_No00_Buck",45,1]]]],
  [["CUP_arifle_G3A3_ris","","","",["CUP_20Rnd_762x51_G3",20],[],""],["CUP_V_OI_TKI_Jacket6_01",[["HandGrenade",1,1],["CUP_20Rnd_762x51_G3",5,20]]]],
  [["CUP_arifle_M16A1E1","","","",["CUP_30Rnd_556x45_Stanag",30],[],""],["CUP_V_OI_TKI_Jacket6_01",[["HandGrenade",1,1],["CUP_30Rnd_556x45_Stanag",8,30]]]],
  [["CUP_smg_M3A1_blk","","","",["CUP_30Rnd_45ACP_M3A1_BLK_M",30],[],""],["CUP_V_OI_TKI_Jacket6_01",[["HandGrenade",1,1],["CUP_30Rnd_45ACP_M3A1_BLK_M",7,30]]]],
  [["CUP_smg_Mac10","","","",["CUP_30Rnd_45ACP_MAC10_M",30],[],""],["CUP_V_OI_TKI_Jacket6_01",[["HandGrenade",1,1],["CUP_30Rnd_45ACP_MAC10_M",7,30]]]],
  [["CUP_srifle_LeeEnfield","","","",["CUP_10x_303_M",10],[],""],["CUP_V_OI_TKI_Jacket6_01",[["HandGrenade",1,1],["CUP_10x_303_M",10,10]]]],
  [["CUP_srifle_Remington700","","","",["CUP_6Rnd_762x51_R700",6],[],""],["CUP_V_OI_TKI_Jacket6_01",[["HandGrenade",1,1],["CUP_6Rnd_762x51_R700",8,6]]]],
  [["CUP_arifle_IMI_Romat","","","",["CUP_20Rnd_762x51_FNFAL_M",20],[],""],["CUP_V_OI_TKI_Jacket6_01",[["HandGrenade",1,1],["CUP_20Rnd_762x51_FNFAL_M",5,20]]]],
  [["CUP_arifle_Sa58P","","","",["CUP_30Rnd_Sa58_M",30],[],""],["CUP_V_OI_TKI_Jacket6_01",[["HandGrenade",1,1],["CUP_30Rnd_Sa58_M",7,30]]]],
  [["CUP_smg_saiga9","","","",["CUP_10Rnd_9x19_Saiga9",10],[],""],["CUP_V_OI_TKI_Jacket6_01",[["HandGrenade",1,1],["CUP_10Rnd_9x19_Saiga9",15,10]]]],
  [["CUP_SKS","","","",["CUP_10Rnd_762x39_SKS_M",10],[],""],["CUP_V_OI_TKI_Jacket6_01",[["HandGrenade",1,1],["CUP_10Rnd_762x39_SKS_M",10,10]]]]
  ];
  s_spcfg_bz_loadout_3_uniform = [];
  {
    for "_i" from 1 to 4 do {s_spcfg_bz_loadout_3_uniform pushback (format["%1%2",_x,_i])};
  } foreach ["CUP_O_TKI_Khet_Jeans_0","CUP_U_C_Mechanic_0","CUP_U_C_Profiteer_0","CUP_U_C_racketeer_0","CUP_U_C_Rocker_0","CUP_U_C_Worker_0"];
  for "_i" from 1 to 43 do {s_spcfg_bz_loadout_3_uniform pushback (format["CUP_I_B_PMC_Unit_%1",_i])};
  s_spcfg_bz_loadout_7_brillen = ["CUP_G_Scarf_Face_Blk","CUP_G_Scarf_Face_Grn","CUP_G_Scarf_Face_Red","CUP_G_Scarf_Face_Tan","CUP_G_Scarf_Face_White"];
};
//------------------------------------------------------------------------------SPCFG>



//------------------------------------------------------------------------------<GARAGE
s_garage_mob_fob = objnull;
if ((s_garage_aktiv) && {! isnil "eo_garage_hq_steuerung"} && {! isnil "eo_garage_hq_platzierung"}) then {
  systemchat "initialisiere Garage HQ...";
  eo_garage_hq_platzierung allowdamage false;
  eo_garage_hq_steuerung allowdamage false;
  eo_garage_lampe_1 allowdammage false;
  eo_garage_lampe_2 allowdammage false;
  s_garage_hq_area = [
        position eo_garage_hq_platzierung,
        (sizeOf(typeof eo_garage_hq_platzierung))/1.5,
        (sizeOf(typeof eo_garage_hq_platzierung))/1.5,
        getdir eo_garage_hq_platzierung,
        false
  ];
  s_garage_max_mob_respawn = 1;
  s_pos_transfer_hq = position eo_garage_pos_transfer; deletevehicle eo_garage_pos_transfer;
  private _marker = createMarker ["m_garage_icon", s_pos_transfer_hq];
  _marker setMarkerType "b_unknown";
  _marker setMarkerColor "ColorYellow";
  _marker setmarkertext "[MEMO] Garage HQ";
};
//------------------------------------------------------------------------------GARAGE>

//------------------------------------------------------------------------------<GARAGE_W
if ((s_garage_w_aktiv) && {! isnil "eo_garage_w_steuerung"} && {! isnil "eo_garage_w_platzierung"}) then {
  systemchat "initialisiere Garage Hafen...";
  eo_garage_w_lampe_1 allowdammage false;
  eo_garage_w_lampe_2 allowdammage false;
  s_pos_transfer_hq_w = position eo_garage_w_pos_transfer; deletevehicle eo_garage_w_pos_transfer;
  s_garage_w_area = [getposworld eo_garage_w_platzierung, 15, 15, getdir eo_garage_w_platzierung, false]; deletevehicle eo_garage_w_platzierung;
  s_garage_w_uboot_pfilchtausstattung = [
    ["B_SDV_01_F","O_SDV_01_F","I_SDV_01_F"]
  ];
  s_garage_w_max_mob_respawn = 1;
  s_garage_w_liste_vec = [
    "B_Boat_Armed_01_minigun_F",
    "B_SDV_01_F",
    "B_Boat_Transport_01_F"
  ];
  if (!isnil "s_sys_landfahrzeuge_1") then {s_garage_w_liste_vec = s_sys_wasserfahrzeuge_1};
  private _marker = createMarker ["m_garage_w_icon", s_pos_transfer_hq_w ];
  _marker setMarkerType "b_naval";
  _marker setMarkerColor "ColorYellow";
  _marker setmarkertext "[MEMO] Hafen";
};
//------------------------------------------------------------------------------GARAGE_W>

//------------------------------------------------------------------------------<TSM
//  ...
//------------------------------------------------------------------------------TSM>

//------------------------------------------------------------------------------<alex_hq/missions
if ((s_missions_aktiv) && {! isnil "s_sys_area_hq"}) then {
  systemchat "initialisiere Missions-Framework...";
  s_missions_posworld_notaus = getposworld eo_missions_posworld_notaus; deletevehicle eo_missions_posworld_notaus;
  s_missions_auswahl = [
  /* inhalte aus s_mission_params je nach mission */
  ];
  s_mission_params_reset = [
  /* 0: mission aktiv ? */ false,
  /* 1: name der Mission */ "",
  /* 2: missionspfad zb "alex_missions\memo_deathmatch\" */ "alex_missions\",
  /* 3: aktuelle punkte aus mission */ 0,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ true,
  /* 6: ausstattungen verfuegbar */ true
  ];
  s_mission_params = []; {s_mission_params pushback _x} foreach s_mission_params_reset;
  private _marker = createMarker ["m_hq", s_sys_area_hq select 0];
  _marker setMarkerShape "ELLIPSE";
  _marker setMarkerSize [(s_sys_area_hq select 1) +100, (s_sys_area_hq select 1) +100];
  _marker setMarkerColor "ColorWEST";
  _marker setmarkeralpha 0.8;
  _marker = createMarker ["m_hq_icon", s_sys_area_hq select 0];
  _marker setMarkerType "mil_dot";
  _marker setMarkerColor "ColorYellow";
  _marker setmarkertext "[MEMO] HQ";
  // D E B U G --------------- _scriptaufruf = [] execVM "alex_missions\memo_fast_response\init_fr_server.sqf"; waituntil {scriptdone _scriptaufruf};
  //_scriptaufruf = [] execVM "alex_missions\mibu_liberty\init_mili_server.sqf"; waituntil {scriptdone _scriptaufruf};
  // D E B U G --------------- _scriptaufruf = [] execVM "alex_missions\memo_witek_deluxe\init_dmd_server.sqf"; waituntil {scriptdone _scriptaufruf};
  //_scriptaufruf = [] execVM "alex_missions\blaecki_geburtstag\init_bgeb_server.sqf"; waituntil {scriptdone _scriptaufruf};
  // D E B U G --------------- _scriptaufruf = [] execVM "alex_missions\heavy_load_hc\init_hlhc_server.sqf"; waituntil {scriptdone _scriptaufruf};
  // D E B U G --------------- _scriptaufruf = [] execVM "alex_missions\verteidigung\init_server.sqf"; waituntil {scriptdone _scriptaufruf};
  //_scriptaufruf = [] execVM "alex_missions\angst\init_server.sqf"; waituntil {scriptdone _scriptaufruf}; (nur in version 033)
  //_scriptaufruf = [] execVM "alex_missions\mutter_ruft_dich\init_server.sqf"; waituntil {scriptdone _scriptaufruf};
  // D E B U G --------------- _scriptaufruf = [] execVM "alex_missions\verteidigung_zombie\init_server.sqf"; waituntil {scriptdone _scriptaufruf};
  // D E B U G --------------- _scriptaufruf = [] execVM "alex_missions\rettung_z\init_server.sqf"; waituntil {scriptdone _scriptaufruf};
  _scriptaufruf = [] execVM "alex_missions\jaeger_sammler\init_server.sqf"; waituntil {scriptdone _scriptaufruf};

};
//------------------------------------------------------------------------------alex_hq/missions>

// ----------------------------------------------------------------------------------------------------------------------EVENTHANDLER: HandleDisconnect
systemchat "initialisiere Disconnect-Handler...";
addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];
  // <SLIVE
  private _slive_stats = [
      getposworld _unit,
      getdir _unit,
      stance _unit,
      (getAllHitPointsDamage _unit) select 2,
      getunitloadout _unit
  ];
  if (s_slive_aktiv) then {[_uid, _name, _slive_stats] spawn fnc_s_slive_stats_speichern};
  // SLIVE>
  deletevehicle _unit;
}];

// ----------------------------------------------------------------------------------------------------------------------EVENTHANDLER: EntityRespawned
systemchat "initialisiere Respawn-Handler...";
addMissionEventHandler ["EntityRespawned", {
	params ["_unit_neu", "_unit_alt"];
  [_unit_neu] joinsilent grpnull;
	_unit_neu addEventHandler ["Handlescore", {s_score_aktiv}];
  if (s_slive_aktiv) then {
    private _slive_stats = [_unit_neu] call fnc_s_slive_stats_neu;
    [_unit_neu, _slive_stats] spawn fnc_s_slive_stats_anwenden;
    [getplayeruid _unit_neu, name _unit_neu, _slive_stats] spawn fnc_s_slive_stats_speichern;
  };

}];


// ----------------------------------------------------------------------------------------------------------------------BEENDIGUNG BEKANNTGEBEN
systemchat "Initialisierungen beendet...";
s_initserver_beendet = true;

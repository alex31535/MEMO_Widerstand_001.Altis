params ["_spieler","_jip"];
private _uid = getplayeruid _spieler;
private _name = name _spieler;
private _text = "";
private _eintrag_db = [];
// # auf server warten ----------------------------------------------------------------------------------------------------------auf server warten
while {!s_initserver_beendet} do {
  [["....warte auf Server....", "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];
  uisleep 1;
};

// # admin ---------------------------------------------------------------------------------------------------------------------------------admin
if (!( isnil "eo_admin") && {((getplayeruid _spieler) in s_admin_spieler_uid)}) then {
  [["....initialisiere Admin-Funktionen....", "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];
  uisleep 1;
  [eo_admin, ["<t color='#ffbb00'>Wetter",{_this remoteexec ["fnc_s_admin_wetter",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_admin, ["<t color='#ffbb00'>Uhrzeit",{_this remoteexec ["fnc_s_admin_uhrzeit",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_admin, ["<t color='#ffbb00'>Nebel",{_this remoteexec ["fnc_s_admin_nebel",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_admin, ["<t color='#ffbb00'>Ambiete-Effekte",{_this remoteexec ["fnc_s_admin_abiemte_effekte",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_admin, ["<t color='#ffbb00'>KI-Level min",{_this remoteexec ["fnc_s_admin_ki_level_min",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_admin, ["<t color='#ffbb00'>KI-Level max",{_this remoteexec ["fnc_s_admin_ki_level_max",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_admin, ["<t color='#ffbb00'>Mission: NOT-Aus",{_this remoteexec ["fnc_s_admin_mission_notaus",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_admin, ["<t color='#ffbb00'>Alle Spieler zum HQ",{_this remoteexec ["fnc_s_admin_spieler_zum_hq",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_admin, ["<t color='#ffbb00'>KI Teamkamerad",{_this remoteexec ["fnc_s_admin_ki_teamkamerad",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_admin, ["<t color='#ffbb00'>KI aus Gruppe entfernen",{_this remoteexec ["fnc_s_admin_ki_entfernen",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
};

// # spcfg ---------------------------------------------------------------------------------------------------------------------------------spcfg
call compile format["s_%1_loadout_arsenal = [];",getplayeruid _spieler];
if (s_spcfg_aktiv) then {
  [["....initialisiere Ausstattungen....", "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];
  uisleep 1;
  if (! isnil "eo_obj_spcfg") then {/* immer vorhandenes ausstattungsobjekt im HQ */
    [eo_obj_spcfg, ["<t color='#ffbb00'>Psychos Ausstattungen",{_this remoteexec ["fnc_s_spcfg_ausstattungen_auflisten_psycho",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
    [eo_obj_spcfg, ["<t color='#ffbb00'>Schnellausstattung",{_this remoteexec ["fnc_s_spcfg_ausstattungen_auflisten",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
    [eo_obj_spcfg, ["<t color='#ffbb00'>MEMO Waffenkammer",{_this remoteexec ["fnc_s_spcfg_arsenal_memo",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
    [eo_obj_spcfg, ["<t color='#ffbb00'>MEMO Waffenkammer: Letzte Ausstattung",{_this remoteexec ["fnc_s_spcfg_arsenalloadout_auf_spieler",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  };
  if ((! isnil "eo_obj_spcfg_mission") && {! isnull eo_obj_spcfg_mission}) then {/* ausstattungsobjekt innerhalb missionsstruktur */
    [eo_obj_spcfg_mission, ["<t color='#ffbb00'>Psychos Ausstattungen",{_this remoteexec ["fnc_s_spcfg_ausstattungen_auflisten_psycho",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
    [eo_obj_spcfg_mission, ["<t color='#ffbb00'>Schnellausstattung",{_this remoteexec ["fnc_s_spcfg_ausstattungen_auflisten",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
    [eo_obj_spcfg_mission, ["<t color='#ffbb00'>MEMO Waffenkammer",{_this remoteexec ["fnc_s_spcfg_arsenal_memo",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
    [eo_obj_spcfg_mission, ["<t color='#ffbb00'>MEMO Waffenkammer: Letzte Ausstattung",{_this remoteexec ["fnc_s_spcfg_arsenalloadout_auf_spieler",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  };
};

// # slive ---------------------------------------------------------------------------------------------------------------------------------slive
if (s_slive_aktiv) then {
  [["....initialisiere SLive....", "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];
  uisleep 1;
  /*0:pos*/_spieler setPosworld s_slive_startposworld;
  /*1:dir*/_spieler setdir (random 360);
  /*2:haltung*/
  /*3:gesundheit*/
  /*4:ausstattung*/_spieler setunitloadout s_slive_startloadout_west;
};

// # garage hq ---------------------------------------------------------------------------------------------------------------------------------garage hq
if ((s_garage_aktiv) && {! isnil "eo_garage_hq_steuerung"}) then {
  [["....initialisiere HQ-Garage....", "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];
  uisleep 1;
  [eo_garage_hq_steuerung, ["<t color='#ffbb00'>Auftanken",
      {_this append ["s_garage_hq_area"];_this remoteexec ["fnc_s_sys_garage_auftanken",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_hq_steuerung, ["<t color='#ffbb00'>Aufmunitionieren",
      {_this append ["s_garage_hq_area"];_this remoteexec ["fnc_s_sys_garage_aufmunitionieren",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_hq_steuerung, ["<t color='#ffbb00'>Reparieren",
      {_this append ["s_garage_hq_area"];_this remoteexec ["fnc_s_sys_garage_reparieren",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_hq_steuerung, ["<t color='#ffbc00'>Fahrzeug einparken",
      {_this append ["s_garage_hq_area"];_this remoteexec ["fnc_s_sys_garage_einparken",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_hq_steuerung, ["<t color='#ffbd00'>Radfahrzeug ausparken",
      {_this append ["s_garage_hq_area","s_sys_vec_rad_1","RoadBarrier_small_F"];_this remoteexec ["fnc_s_sys_garage_ausparken",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_hq_steuerung, ["<t color='#ffbd00'>Kettenfahrzeug ausparken",
      {_this append ["s_garage_hq_area","s_sys_vec_kette_1","RoadBarrier_small_F"];_this remoteexec ["fnc_s_sys_garage_ausparken",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_hq_steuerung, ["<t color='#ffbd00'>Helikopter ausparken",
      {_this append ["s_garage_hq_area","s_sys_vec_heli_1","RoadBarrier_small_F"];_this remoteexec ["fnc_s_sys_garage_ausparken",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_hq_steuerung, ["<t color='#ffbd00'>Flugzeug ausparken",
      {_this append ["s_garage_hq_area","s_sys_vec_flug_1","RoadBarrier_small_F"];_this remoteexec ["fnc_s_sys_garage_ausparken",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_hq_steuerung, ["<t color='#ffbe00'>Fahrzeug zu mobilen FOB",
      {_this append ["s_garage_hq_area"];_this remoteexec ["fnc_s_sys_garage_mob_fob_erstellen",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_hq_steuerung, ["<t color='#ffbf00'>Schnellreise: FOB",
      {_this remoteexec ["fnc_s_sys_transfer_zu_fob",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_hq_steuerung, ["<t color='#ffbf00'>Schnellreise: Garage Hafen",
      {_this append ["s_pos_transfer_hq_w"];_this remoteexec ["fnc_s_sys_transfer_zu_hq_x",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  // ggf fob-action setzen
  if ((!isnil "s_garage_mob_fob") && {!isnull s_garage_mob_fob}) then {
    [s_garage_mob_fob,_spieler] call fnc_s_sys_garage_mob_fob_action;
  };
};


// # garage hafen ---------------------------------------------------------------------------------------------------------------------------------garage hafen
if ((s_garage_w_aktiv) && {! isnil "eo_garage_w_steuerung"}) then {
  [["....initialisiere Hafen-Garage....", "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];
  uisleep 1;
  [eo_garage_w_steuerung, ["<t color='#ffbb00'>Auftanken",
      {_this append ["s_garage_w_area"];_this remoteexec ["fnc_s_sys_garage_auftanken",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_w_steuerung, ["<t color='#ffbb00'>Aufmunitionieren",
      {_this append ["s_garage_w_area"];_this remoteexec ["fnc_s_sys_garage_aufmunitionieren",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_w_steuerung, ["<t color='#ffbb00'>Reparieren",
      {_this append ["s_garage_w_area"];_this remoteexec ["fnc_s_sys_garage_reparieren",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_w_steuerung, ["<t color='#ffbc00'>Fahrzeug einparken",
      {_this append ["s_garage_w_area"];_this remoteexec ["fnc_s_sys_garage_einparken",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_w_steuerung, ["<t color='#ffbd00'>Fahrzeug ausparken",
      {_this append ["s_garage_w_area","s_garage_w_liste_vec","Land_BuoyBig_F"];_this remoteexec ["fnc_s_sys_garage_ausparken",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_w_steuerung, ["<t color='#ffbe00'>Fahrzeug zu mobilen FOB",
      {_this append ["s_garage_w_area"];_this remoteexec ["fnc_s_sys_garage_mob_fob_erstellen",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_w_steuerung, ["<t color='#ffbf00'>Schnellreise: FOB",
      {_this remoteexec ["fnc_s_sys_transfer_zu_fob",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_garage_w_steuerung, ["<t color='#ffbf00'>Schnellreise: HQ",
      {_this append ["s_pos_transfer_hq"];_this remoteexec ["fnc_s_sys_transfer_zu_hq_x",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
};

// # missions allgemein ------------------------------------------------------------------------------------------------------------------------missions allgemein
if ((s_missions_aktiv) && {! isnil "eo_hq_missionsgeber"} && {! isnil "eo_hq_missionsteilnahme"} && {! isnil "s_mission_params"}) then {
  [["....initialisiere Missionen....", "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];
  uisleep 1;
  [eo_hq_missionsteilnahme,[0,format["%1teilnahmebild.jpg",s_mission_params select 2]]] remoteExec ["setObjectTexture", _spieler];
  [eo_hq_missionsgeber,["<t color='#ffbb00'>Mission waehlen",
    {_this remoteexec ["fnc_s_mission_mission_waehlen",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
  [eo_hq_missionsteilnahme, ["<t color='#ffbb00'>Teilnehmen",
    {[_this,"alex_scripte\s_action_missionsteilnahme.sqf"] remoteexec ["execvm",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];
};



// # spieler freigeben ------------------------------------------------------------------------------------------------------------------------spieler freigeben
[["....bereit....", "BLACK IN", 2, true, true]] remoteexec ["titleText",_spieler];
[] remoteexec ["fnc_a_tfar_frequenzen_setzen",_spieler];

s_initserver_beendet = false;
private _scriptaufruf = false;

//----------------------------------------------------------------------------------------------------------------------------------------------------------Funktionen
systemchat "Initialisiere Funktionen...";

fnc_s_uid_var_schreiben = compile preprocessfilelinenumbers "fnc\fnc_s_uid_var_schreiben.sqf";
fnc_s_uid_var_lesen = compile preprocessfilelinenumbers "fnc\fnc_s_uid_var_lesen.sqf";
fnc_s_uid_var_aktualisieren = compile preprocessfilelinenumbers "fnc\fnc_s_uid_var_aktualisieren.sqf";
fnc_s_uid_var_neu = compile preprocessfilelinenumbers "fnc\fnc_s_uid_var_neu.sqf";
fnc_s_uid_var_anwenden = compile preprocessfilelinenumbers "fnc\fnc_s_uid_var_anwenden.sqf";

fnc_s_waffenkammer = compile preprocessfilelinenumbers "fnc\fnc_s_waffenkammer.sqf";
fnc_s_loadout_zu_objektliste = compile preprocessfilelinenumbers "fnc\fnc_s_loadout_zu_objektliste.sqf";

fnc_s_garage_ausparken = compile preprocessfilelinenumbers "fnc\fnc_s_garage_ausparken.sqf";
fnc_s_garage_blockiert = compile preprocessfilelinenumbers "fnc\fnc_s_garage_blockiert.sqf";
fnc_s_garage_ausparken_ende = compile preprocessfilelinenumbers "fnc\fnc_s_garage_ausparken_ende.sqf";
fnc_s_garage_einparken = compile preprocessfilelinenumbers "fnc\fnc_s_garage_einparken.sqf";

fnc_s_gebaeudeauswahl = compile preprocessfilelinenumbers "fnc\fnc_s_gebaeudeauswahl.sqf";

fnc_s_action_gruppenmission_waehlen = compile preprocessfilelinenumbers "fnc\fnc_s_action_gruppenmission_waehlen.sqf";

fnc_s_uid_var = compile preprocessfilelinenumbers "fnc\fnc_s_uid_var.sqf";
fnc_s_spielerlevel = compile preprocessfilelinenumbers "fnc\fnc_s_spielerlevel.sqf";
fnc_s_gruppenmission_starten = compile preprocessfilelinenumbers "fnc\fnc_s_gruppenmission_starten.sqf";
fnc_s_gruppenmission_starten_ki = compile preprocessfilelinenumbers "fnc\fnc_s_gruppenmission_starten_ki.sqf";
fnc_s_locmarker_selectarea_an_aus = compile preprocessfilelinenumbers "fnc\fnc_s_locmarker_selectarea_an_aus.sqf";

//----------------------------------------------------------------------------------------------------------------------------------------------------------<system-globals
systemchat "Setze statische Globals...";
// # spiel-version, auch relevant bei db-zuordnung
s_pref_spiel = "mw_001"; // mw == memo widerstand
// # temp-var um zu vermeiden, dass zu viele db-zugriffe gleichzeitig stattfinden
s_db_aktiv = false;
// # grundhalte der spieler-db variable
s_uid_var_eintraege = [
  /*0*/["worldpos",[0,0,0]],
  /*1*/["dir",0],
  /*2*/["haltung",""],
  /*3*/["schaden",0],
  /*4*/["loadout",[]],
  /*5*/["punkte",0]
];
// # universal-/reset-parameter fuer missions-var
s_mission_params_reset = [
/* 0: mission (global/single) aktiv ? */ false,
/* 1: name der Mission */ "",
/* 2: missionspfad zb "alex_missions\memo_deathmatch\" */ "missions\",
/* 3: allg.Missionsparameter */ [],
/* 4: notaus */ false,
/* 5: garagen verfuegbar */ true,
/* 6: ausstattungen verfuegbar */ true
];
// # start-missionsparameter erstellen
s_mission_params = []; {s_mission_params pushback _x} foreach s_mission_params_reset;
// # min-anz an spielern zum starten einer gruppenmission
s_gruppenmission_min_anz_spieler = 4;
// # variable zur festlegung wer als nächstes eine gruppenmission startet
s_spieler_oder_ki = ["spieler","ki"];
private _db = "";
private _db_existiert = false;
_db = ["new", format["%1_s_spieler_oder_ki_%2",s_pref_spiel,(toLowerANSI worldname)]] call OO_INIDBI;
_db_existiert = "exists" call _db;
if (_db_existiert) then {
  s_spieler_oder_ki = ["read",["s_spieler_oder_ki","s_spieler_oder_ki"]] call _db;
} else {
  ["write",["s_spieler_oder_ki","s_spieler_oder_ki",s_spieler_oder_ki]] call _db;
};


//----------------------------------------------------------------------------------------------------------------------------------------------------<Parameter auf Editor-Objekte
systemchat "Editor-Objekte: Parameter...";
// # neustart-loadout holen
s_loadout_basis = getunitloadout eo_loadout_basis; deletevehicle eo_loadout_basis;
// # ausstattungs-objekt leeren
clearBackpackCargoGlobal eo_basis_ausruestung;
clearMagazineCargoGlobal eo_basis_ausruestung;
clearItemCargoGlobal eo_basis_ausruestung;
clearWeaponCargoGlobal eo_basis_ausruestung;
eo_basis_ausruestung allowdammage false;
// # gebaeude innerhalb basis-area auf unzerstoerbar setzen
{_x allowdammage false} foreach ((position eo_flagge_basis) nearObjects ["House",150]);
eo_flagge_basis allowdammage false;
// # m_area_basis: markiert den bereich der basis
"m_area_basis" setmarkeralpha 1;

//------------------------------------------------------------------------------------------------------------------------------------------------------<mod-listen erstellen
systemchat "Editor-Objekte: Mod-Listen...";
s_map_mods = [];
private _obj = objnull;
private _mod = "";
for "_i" from 1 to 20 do {
  call compile format["_obj = if (isnil ""eo_mod_%1"") then [{objnull},{eo_mod_%1}];",_i];
	if (!isnull _obj) then {
		_mod = ((((configSourceMod(configFile >> "CfgVehicles" >> (typeof _obj))) splitstring "@") select 0) splitString " ") joinString "_";
		if ((!isnil "_mod") && {_mod != ""}) then {
			s_map_mods pushback _mod;
		};
		deletevehicle _obj;
	};
};

//-------------------------------------------------------------------------------------------------------------------------------------------------<basis-parameter der waffenkammer
systemchat "Initialisiere Waffenkammer-Whitelist...";
// # erststart-parameter, werden ggf mit db-inhalten ueberschrieben
s_whitelist_rucksaecke = [];
s_whitelist_items = [
"U_BG_Guerilla2_1",
"U_BG_Guerilla2_2",
"U_BG_Guerilla2_3",
"U_BG_Guerilla1_1",
"U_BG_Guerilla3_1",
"ItemMap",
"ItemCompass",
"ItemWatch",
"ItemRadio",
"Binocular",
"TFAR_microdagr",
"FirstAidKit",
"V_BandollierB_rgr",
"H_Cap_grn",
"G_Bandanna_oli"
];
s_whitelist_munition = [];
s_whitelist_waffen = [
"hgun_Rook40_F",
"CUP_srifle_LeeEnfield",
"hgun_Pistol_heavy_02_F"
];
// # db-inhalte pruefen und ggf erststart-parameter ueberschreiben
{
  _db = ["new", format["%1_%2_%3",s_pref_spiel,_x,(toLowerANSI worldname)]] call OO_INIDBI;
  _db_existiert = "exists" call _db;
  if (_db_existiert) then {call compile format["s_whitelist_%1 = [""read"",[""whitelist"",""%1""]] call _db;",_x]};
} foreach ["rucksaecke","items","munition","waffen"];


//-----------------------------------------------------------------------------------------------------------------------------------------------------------------<garage
systemchat "Initialisiere Garagen-Whitelist...";
// # garagen-area definieren
s_garage_area = [
      position eo_garage_platzierung,
      (sizeOf(typeof eo_garage_platzierung))/1.5,
      (sizeOf(typeof eo_garage_platzierung))/1.5,
      getdir eo_garage_platzierung,
      false
];
// # pflicht-fahrzeuge fuer die garage. die fahrzeuge sind level-abhaengig (index!) und unendlich verfuegbar
s_garage_pflicht = [
/* lvl 0*/ "C_Tractor_01_F"
];
// # liste aller kettenfahrzeuge
s_garage_kette = [];
// # liste aller radfahrzeuge
s_garage_rad = [
"C_Tractor_01_F"
];
// # liste aller helikopter
s_garage_heli = [];
// # liste aller flugzeuge
s_garage_flug = [];
// # liste aller wasserfahrzeuge
s_garage_boot = [];
// # db aufrufen und ggf die obigen erststart-parameter ueberschreiben
{
  _db = ["new", format["%1_%2_%3",s_pref_spiel,_x,(toLowerANSI worldname)]] call OO_INIDBI;
  _db_existiert = "exists" call _db;
  if (_db_existiert) then {call compile format["%1 = [""read"",[""%1"",""klassen""]] call _db;",_x]};
} foreach ["s_garage_kette","s_garage_rad","s_garage_heli","s_garage_flug","s_garage_boot"];


//------------------------------------------------------------------------------------------------------------------------------------------------------------<location-parameter
systemchat "Locations: Initialisierung...";
// # level-scritte vordefinieren. in abhaengigkeit einer vorhanden location-db wird werden die werte entweder neu berechnet (in script locationberechnung) oder aus db gelesen
s_lvl_steps = [/* zb [4638.57,9027.14,13415.7,17804.3,22192.9,26581.4,30970]*/];
// # location-var definieren. anfaenglich leer - wenn db vorhanden, dann werden hier die db-inhalte uebertragen
s_loc_params = [
/*
  [
0:loc-name            "Anthrakia",
1:loc-pos             [16584.3,16104,-15.1762],
2:loc-groesse         562.5,
3:geabeudedichte      116,
4:dichte loc-objekte  [["mil",0],["spe",0],["sak",2],["ind",0]],
5:loc-pkt             116,
6:loc-lvl             2
7:loc-farbe           "ColorRed"
  ]
*/
];
_db = ["new", format["%1_s_loc_params_%2",s_pref_spiel,(toLowerANSI worldname)]] call OO_INIDBI;
_db_existiert = "exists" call _db;
if (_db_existiert) then {
  systemchat "Locations: Lese Datenbank...";
  private _sections = "getSections" call _db;
  private _eintrag = [];
  {
    _eintrag = ["read",[_x,_x]] call _db;
    s_loc_params pushback _eintrag;
  } foreach _sections;
  _db = ["new", format["%1_s_lvl_steps_%2",s_pref_spiel,(toLowerANSI worldname)]] call OO_INIDBI;
  _db_existiert = "exists" call _db;
  if (_db_existiert) then {
    s_lvl_steps = ["read",["s_lvl_steps","s_lvl_steps"]] call _db;
  } else {
    for "_i" from 1 to 7 do {s_lvl_steps pushback (_i*12345)};
  };
};
// # wenn keine location-db existiert, dann wird ein script aufgerufen, das die inhalte anhand der map generiert und auch die level-steps generiert
if (!_db_existiert) then {
  systemchat "Locations: Neuerstellung der Location-Parameter...";
   _scriptaufruf = [
    /* 0: anz von gebaeude-positionen zur filterung bei gebaeudesuche*/3, /*je hoeher der wert desto weniger gebaeude werden bei der locationberechnung beruecksichtigt*/
    /* 1: lvl-obergrenze*/7,/* sollte auf 7 festgesetzt bleiben, da dies auch auf duf die lvl-abhaengige missionsauswahl auswirkungen hat*/
    /* 2: groesse einer obj-location*/225,/* je groesser die obj-location desto weniger individuelle obj-locations werden erstellt*/
    /* 3: distanz-teiler zur berechnung der location-bewertung*/worldsize/7,/* je groesser der wert desto geringer fällt die lvl-bewertung aus*/
    /* 4 filter-schluessel zum selectieren der editor-objekte :: zb eo_locobj_FILTER_1, etc*/["mil","spe","sak","ind"],
    /* 5 pkt-aufwertung bezogen auf filter-schluessel */[0.75,0.3,0.2,0.25]
   ] execvm "scripte\s_locationberechnung.sqf"; waituntil {scriptdone _scriptaufruf};
   _db = ["new", format["%1_s_loc_params_%2",s_pref_spiel,(toLowerANSI worldname)]] call OO_INIDBI;
   {
     ["write",[_x select 0,_x select 0,_x]] call _db;
   } foreach s_loc_params;
   _db = ["new", format["%1_s_lvl_steps_%2",s_pref_spiel,(toLowerANSI worldname)]] call OO_INIDBI;
   ["write",["s_lvl_steps","s_lvl_steps",s_lvl_steps]] call _db;
};
// # eroberungspunkte (pro spieler) bezogen auf location-eroberung berechnen
s_pkt_loc_eroberung = floor((s_lvl_steps select ((count s_lvl_steps) -1)) /10);
s_pkt_loc_verloren = s_pkt_loc_eroberung *-1;
// # locations werden auf dem map global markiert. die markierung dient auch zur selektion von gruppen-missionen
systemchat "Locations: Markierung...";
private _marker = "";
{
  _marker = createMarker [format["m_loc_icon_%1",_foreachindex],[((_x select 1) select 0),((_x select 1) select 1) +50,0]];
  _marker setMarkerType "mil_dot";
  _marker setmarkertext (format["%1 LvL %2",_x select 0,_x select 6]);
  _marker setmarkercolor (_x select 7);
  _marker = createMarker [format["m_loc_area_%1",_foreachindex],_x select 1];
  _marker setMarkerShape "ELLIPSE";
  _marker setMarkerSize [50, 50];
  _marker setMarkerColor (_x select 7);
  _marker setmarkeralpha 0;
} foreach s_loc_params;


//------------------------------------------------------------------------------------------------------------------------------------------------------------------<eventhandler
systemchat "Setze Eventhandler...";

addMissionEventHandler ["HandleDisconnect", {
	params ["_spieler", "_id", "_uid", "_name"];
  [_spieler] call fnc_s_uid_var_aktualisieren;
  [_spieler] call fnc_s_uid_var_schreiben;
  deletevehicle _spieler;
}];

// -------------------------------------------------------------------------------------------------------------------------------------------------------------BEENDIGUNG BEKANNTGEBEN
systemchat "Initialisierungen beendet...";
s_initserver_beendet = true;

// # witti: enticklungsumgebung----------------------------------------------------------------------------------------------------------------------------witti: enticklungsumgebung
[] execvm "witti\initServer.sqf";

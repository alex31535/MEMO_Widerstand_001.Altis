s_initserver_beendet = false;
private _scriptaufruf = false;

//------------------------------------------------------------------------------Funktionen
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

//------------------------------------------------------------------------------<system-globals
systemchat "Setze statische Globals...";

s_pref_spiel = "mw_001"; // == memo widerstand
s_db_aktiv = false;
s_uid_var_eintraege = [
  ["worldpos",[0,0,0]],
  ["dir",0],
  ["haltung",""],
  ["schaden",0],
  ["loadout",[]]
];


//------------------------------------------------------------------------------<
systemchat "Editor-Objekte: Parameter...";
s_loadout_basis = getunitloadout eo_loadout_basis; deletevehicle eo_loadout_basis;
clearBackpackCargoGlobal eo_basis_ausruestung;
clearMagazineCargoGlobal eo_basis_ausruestung;
clearItemCargoGlobal eo_basis_ausruestung;
clearWeaponCargoGlobal eo_basis_ausruestung;
{_x allowdammage false} foreach ((position eo_flagge_basis) nearObjects ["House",150]);



//------------------------------------------------------------------------------<
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

//------------------------------------------------------------------------------<
systemchat "Initialisiere Waffenkammer-Whitelist...";

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
private _db = "";
private _db_existiert = false;
{
  _db = ["new", format["%1_%2_%3",s_pref_spiel,_x,(toLowerANSI worldname)]] call OO_INIDBI;
  _db_existiert = "exists" call _db;
  if (_db_existiert) then {call compile format["s_whitelist_%1 = [""read"",[""whitelist"",""%1""]] call _db;",_x]};
} foreach ["rucksaecke","items","munition","waffen"];


//------------------------------------------------------------------------------<
systemchat "Initialisiere Garagen-Whitelist...";

s_garage_area = [
      position eo_garage_platzierung,
      (sizeOf(typeof eo_garage_platzierung))/1.5,
      (sizeOf(typeof eo_garage_platzierung))/1.5,
      getdir eo_garage_platzierung,
      false
];
s_garage_pflicht = [
"C_Tractor_01_F"
];
s_garage_kette = [];
s_garage_rad = [
"C_Tractor_01_F"
];
s_garage_heli = [];
s_garage_flug = [];
s_garage_boot = [];

{
  _db = ["new", format["%1_%2_%3",s_pref_spiel,_x,(toLowerANSI worldname)]] call OO_INIDBI;
  _db_existiert = "exists" call _db;
  if (_db_existiert) then {call compile format["%1 = [""read"",[""%1"",""klassen""]] call _db;",_x]};
} foreach ["s_garage_kette","s_garage_rad","s_garage_heli","s_garage_flug","s_garage_boot"];


//------------------------------------------------------------------------------<
systemchat "Locations: Initialisierung...";

s_loc_params = [];
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
};

if ((count s_loc_params) == 0) then {
  systemchat "Locations: Neuerstellung der Location-Parameter...";
   _scriptaufruf = [
    /* 0: anz von gebaeude-positionen zur filterung bei gebaeudesuche*/3, /*je hoeher der wert desto weniger gebaeude werden bei der locationberechnung beruecksichtigt*/
    /* 1: lvl-obergrenze*/7,/* sollte auf 7 festgesetzt bleiben, da dies auch auf duf die lvl-abhaengige missionsauswahl auswirkungen hat*/
    /* 2: groesse einer obj-location*/225,/* je groesser die obj-location desto weniger individuelle obj-locations werden erstellt*/
    /* 3: distanz-teiler zur berechnung der location-bewertung*/worldsize/7,/* je groesser der wert desto geringer fällt die lvl-bewertung aus*/
    /* 4 filter-schluessel zum selectieren der editor-objekte :: zb eo_locobj_FILTER_1, etc*/["mil","spe","sak","ind"],
    /* 5 pkt-aufwertung bezogen auf filter-schluessel */[60,30,10,5]
   ] execvm "scripte\s_locationberechnung.sqf"; waituntil {scriptdone _scriptaufruf};
   _db = ["new", format["%1_s_loc_params_%2",s_pref_spiel,(toLowerANSI worldname)]] call OO_INIDBI;
   {
     ["write",[_x select 0,_x select 0,_x]] call _db;
   } foreach s_loc_params;
};
systemchat "Locations: Markierung...";
private _marker = "";
{
  _marker = createMarker [format["m_loc_icon_%1",_foreachindex],[((_x select 1) select 0),((_x select 1) select 1) +50,0]];
  _marker setMarkerType "mil_dot";
  _marker setmarkertext (format[" %1 - Geb:%2 Obj:%3 pkt:%4 LvL:%5",_x select 0,_x select 3,_x select 4,_x select 5,_x select 6]);
  _marker = createMarker [format["m_loc_area_%1",_foreachindex],_x select 1];
  _marker setMarkerShape "ELLIPSE";
  _marker setMarkerSize [50, 50];
  _marker setMarkerColor "ColorRed";
  _marker setmarkeralpha 0.6;
} foreach s_loc_params;

//------------------------------------------------------------------------------<

//------------------------------------------------------------------------------<eventhandler
systemchat "Setze Eventhandler...";

addMissionEventHandler ["HandleDisconnect", {
	params ["_spieler", "_id", "_uid", "_name"];
  [_spieler] call fnc_s_uid_var_aktualisieren;
  [_spieler] call fnc_s_uid_var_schreiben;
  deletevehicle _spieler;
}];

// ----------------------------------------------------------------------------------------------------------------------BEENDIGUNG BEKANNTGEBEN
systemchat "Initialisierungen beendet...";
s_initserver_beendet = true;

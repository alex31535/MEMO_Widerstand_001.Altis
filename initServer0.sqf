s_initserver_beendet = false;
private _scriptaufruf = false;

//------------------------------------------------------------------------------Funktionen
fnc_s_uid_var_schreiben = compile preprocessfilelinenumbers "fnc\fnc_s_uid_var_schreiben.sqf";
fnc_s_uid_var_lesen = compile preprocessfilelinenumbers "fnc\fnc_s_uid_var_lesen.sqf";
fnc_s_uid_var_aktualisieren = compile preprocessfilelinenumbers "fnc\fnc_s_uid_var_aktualisieren.sqf";
fnc_s_uid_var_neu = compile preprocessfilelinenumbers "fnc\fnc_s_uid_var_neu.sqf";
fnc_s_uid_var_anwenden = compile preprocessfilelinenumbers "fnc\fnc_s_uid_var_anwenden.sqf";

fnc_s_waffenkammer = compile preprocessfilelinenumbers "fnc\fnc_s_waffenkammer.sqf";
fnc_s_loadout_zu_objektliste = compile preprocessfilelinenumbers "fnc\fnc_s_loadout_zu_objektliste.sqf";
//------------------------------------------------------------------------------<system-globals
s_pref_spiel = "mw_001"; // == memo widerstand
s_db_aktiv = false;
s_uid_var_eintraege = [
  ["worldpos",[0,0,0]],
  ["dir",0],
  ["haltung",""],
  ["schaden",0],
  ["loadout",[]]
];
s_loadout_basis = getunitloadout eo_loadout_basis; deletevehicle eo_loadout_basis;
clearBackpackCargoGlobal eo_basis_ausruestung;
clearMagazineCargoGlobal eo_basis_ausruestung;
clearItemCargoGlobal eo_basis_ausruestung;
clearWeaponCargoGlobal eo_basis_ausruestung;
{_x allowdammage false} foreach ((position eo_flagge_basis) nearObjects ["House",150]);



s_whitelist_rucksaecke = [];
private _db = ["new", format["%1_%2_%3",s_pref_spiel,"rucksaecke",(toLowerANSI worldname)]] call OO_INIDBI;
private _db_existiert = "exists" call _db;
if (_db_existiert) then {s_whitelist_rucksaecke = ["read",["whitelist","rucksaecke"]] call _db};

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
while {s_db_aktiv} do {uisleep 0.3};
s_db_aktiv = true;
_db = ["new", format["%1_%2_%3",s_pref_spiel,"items",(toLowerANSI worldname)]] call OO_INIDBI;
_db_existiert = "exists" call _db;
if (_db_existiert) then {s_whitelist_items = ["read",["whitelist","items"]] call _db};

s_whitelist_munition = [];
_db = ["new", format["%1_%2_%3",s_pref_spiel,"munition",(toLowerANSI worldname)]] call OO_INIDBI;
_db_existiert = "exists" call _db;
if (_db_existiert) then {s_whitelist_munition = ["read",["whitelist","munition"]] call _db};

s_whitelist_waffen = [
"hgun_Rook40_F",
"CUP_srifle_LeeEnfield",
"hgun_Pistol_heavy_02_F"
];
_db = ["new", format["%1_%2_%3",s_pref_spiel,"waffen",(toLowerANSI worldname)]] call OO_INIDBI;
_db_existiert = "exists" call _db;
if (_db_existiert) then {s_whitelist_waffen = ["read",["whitelist","waffen"]] call _db};

private _db = "";
private _db_existiert = false;
{
  _db = ["new", format["%1_%2_%3",s_pref_spiel,_x,(toLowerANSI worldname)]] call OO_INIDBI;
  _db_existiert = "exists" call _db;
  if (_db_existiert) then {call compile format["s_whitelist_%1 = [""read"",[""whitelist"",""%1""]] call _db;",_x]};
} foreach ["rucksaecke","items","munition","waffen"];










//------------------------------------------------------------------------------<eventhandler
addMissionEventHandler ["HandleDisconnect", {
	params ["_spieler", "_id", "_uid", "_name"];
  [_spieler] call fnc_s_uid_var_aktualisieren;
  [_spieler] call fnc_s_uid_var_schreiben;
  deletevehicle _spieler;
}];

// ----------------------------------------------------------------------------------------------------------------------BEENDIGUNG BEKANNTGEBEN
systemchat "Initialisierungen beendet...";
s_initserver_beendet = true;

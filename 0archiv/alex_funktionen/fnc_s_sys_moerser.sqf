/*
  fnc_s_sys_moerser
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.13
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: unnecessary

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
#define _DEF_wartezeiten [3,4,5,3,4,5,3,4,5]
#define _DEF_abweichungen [5,10,15,20,25,20,15,10,5]
params ["_pos_moerser","_pos_zieluebergabe","_seite_angreifer","_dist_spielerfrei_loeschung","_anz_runden"];
// bereits aktive moerser beenden
if (!isnil "fnc_s_sys_moerser_aktiv") then {fnc_s_sys_moerser_aktiv = false; while {! isnil "fnc_s_sys_moerser_aktiv"} do {uisleep 0.3}};
fnc_s_sys_moerser_aktiv = true; // global um das script serverseitig abbrechen zu koennen
private _unit_klasse = "I_Soldier_F";
switch (_seite_angreifer) do {
  case "east": {_unit_klasse = "O_Soldier_F"};
  case "west": {_unit_klasse = "B_Soldier_F"};
  default {_unit_klasse = "I_Soldier_F"};
};
// # moerser + unit erstellen
private _moerser = "B_Mortar_01_F" createVehicle _pos_moerser;
private _moerser_unit = objnull;
call compile format["_moerser_unit = (creategroup [%1,true]) createUnit [_unit_klasse, _pos_moerser, [], 0, ""NONE""];",_seite_angreifer];
private _winkel = 0;
private _abweichung = 0;
private _zielpunkt_moerser = [0,0,0];
_moerser_unit moveingunner _moerser;
// # core
while {fnc_s_sys_moerser_aktiv} do {
  if (!alive _moerser_unit) exitwith {};
  _winkel = floor(random 360);
  _abweichung = selectrandom _DEF_abweichungen;
  _zielpunkt_moerser = [(_pos_zieluebergabe select 0) + ((sin _winkel) * _abweichung),(_pos_zieluebergabe select 1) + ((cos _winkel) * _abweichung),0];
  _moerser commandArtilleryFire [_zielpunkt_moerser,"8Rnd_82mm_Mo_shells",1];
  _moerser setVehicleAmmo 1;
  if ((!isnil "_anz_runden") && {!(_anz_runden < 0)}) then {
    _anz_runden = _anz_runden -1;
    if (_anz_runden <= 0) then {fnc_s_sys_moerser_aktiv = false};
  };
  sleep (selectrandom _DEF_wartezeiten);
};
// # vor dem loeschen der objekte, warten bis kein spieler in der naehe ist
while {(count(playableunits inAreaArray [_pos_moerser, _dist_spielerfrei_loeschung, _dist_spielerfrei_loeschung,0,false])) > 0} do {
  uisleep 1;
};
// # objekte und marker loeschen
deletevehicle _moerser_unit;
deletevehicle _moerser;
// # globale-var deaktivieren
fnc_s_sys_moerser_aktiv = nil;

/*
  s_mission_core.sqf
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
#define _DEF_maerker_area_groesse 80

params ["_erstellte_objekte","_erstellte_marker","_liste_hauspos","_vec_transport_fob","_verteiler_unit_zombie"];

// # zivilisten-parameter definieren
private _params_rettung = [_liste_hauspos] call s_fnc_rettz_loc_erstellen; // --> [_zivilist, _spawnpositionen_z, _loc_und_pos, _liste_hauspos(neu)]
private _zivilist = _params_rettung select 0;
private _spawnpositionen_feinde = _params_rettung select 1;
private _liste_hauspos = _params_rettung select 2;// aktualisierte liste
private _area = [position _zivilist,s_rettz_area_dist_aktivierung,s_rettz_area_dist_aktivierung,0,false];
private _marker = createMarker ["m_rettz_zivilist_area", _zivilist getRelPos [random(_DEF_maerker_area_groesse/1.5), random 360]];
_marker  setMarkerShape "ELLIPSE";
_marker setMarkerColor "ColorYellow";
_marker setmarkeralpha 0.5;
_marker setMarkerSize [_DEF_maerker_area_groesse, _DEF_maerker_area_groesse];
_erstellte_marker pushback _marker;
_marker = createMarker ["m_rettz_zivilist", getmarkerpos "m_rettz_zivilist_area"];
_marker setMarkerType "mil_dot";
_marker setMarkerColor "ColorBlue";
_marker setMarkertext "Notsignal Zivilist";
_erstellte_objekte pushback _zivilist;
_erstellte_marker pushback _marker;


uisleep 3;

// /* D E B U G */ _spawnpositionen_feinde = [];

{
  if ((count _spawnpositionen_feinde) == 0) then {
    [["<t color='#02bf1b' size='4'>Notsignal empfangen - Begeben Sie sich zum Zielort und holen Sie den Zivilisten ab.... es ist nicht mit Feindkontakt zu rechnen!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
  } else {
    [["<t color='#02bf1b' size='4'>Notsignal empfangen - Begeben Sie sich zum Zielort und retten Sie den Zivilisten!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
  };
} foreach playableunits;


//----------------------------------------------------------------------------------------------------------------------- hauptteil start
private _erstellte_feinde = [];
private _area_spawn_aktiv = false;
private _zeitstempel_spawn = time + s_rettz_zeitintervall_spawn;
private _feind_typ = ""; // "u", "z"
private _feind_klasse = "";
private _strassen_in_ziv_naehe = _zivilist nearRoads s_rettz_strassendistanz_ziv;
private _feind = objnull;
private _core_status = "";
private _spieler_in_naehe = [];
while {_core_status == ""} do {

  // # listen pruefen
  _erstellte_objekte = _erstellte_objekte select {!isnull _x};
  _erstellte_objekte = _erstellte_objekte select {alive _x};
  _erstellte_feinde = _erstellte_feinde select {!isnull _x};
  _erstellte_feinde = _erstellte_feinde select {alive _x};

  // # pruefen ob spawn aktiviert werden kann
  if (!_area_spawn_aktiv) then {if ((count(playableunits inareaarray _area)) > 0) then {_area_spawn_aktiv = true}};

  // # spawn ausloesen wenn area aktiv ist
  if ((_area_spawn_aktiv) && {time > _zeitstempel_spawn} && {(count _erstellte_feinde) < s_rettz_max_anz_zombies} && {(count _spawnpositionen_feinde) > 0}) then {
    _spawnpositionen_feinde call BIS_fnc_arrayShuffle;
    _feind_typ = selectrandom _verteiler_unit_zombie;
    _feind_klasse = if (_feind_typ == "u") then [{s_rettz_unitklassen_allgemein},{s_rettz_zombieklassen_allgemein}];
    _feind = [selectrandom _spawnpositionen_feinde,_feind_klasse] call fnc_s_sys_spawn_unit;
    _feind_klasse = if (_feind_typ == "u") then {[_feind] call fnc_s_spcfg_loadout_bz};
    if ((count _strassen_in_ziv_naehe) > 0) then {
      _feind move (position(selectrandom _strassen_in_ziv_naehe));
    } else {
      _feind move (getPosATL _zivilist);
    };
    _erstellte_objekte pushback _feind;
    _erstellte_feinde pushback _feind;
    _zeitstempel_spawn = time + s_rettz_zeitintervall_spawn;
  };

  // # gruppen-kontrolle des zivilisten
  [_zivilist] call fnc_s_sys_unit_folgt;

  // # bedingungen zur beendigung der core-schleife
  _spieler_in_naehe = (playableunits inareaarray [getposatl _zivilist,3,3,0,false,3]) select {alive _x};
  if ((count _spieler_in_naehe) > 0) then {_core_status = "zivilist im transporter"};
  // ## zivilist im transporter?
  if ((alive _zivilist) && {(objectParent _zivilist) == _vec_transport_fob}) then {_core_status = "zivilist im transporter"};
  // ## zivilist getoetet
  if (!alive _zivilist)then {_core_status = "zivilist getoetet"};
  // ## transporter zerstoert
  if (isnull _vec_transport_fob) then {_core_status = "transporter zerstoert"};
  // ## notaus aktiviert?
  if (s_mission_params select 4) then {_core_status = "notaus"};

  // # bremse
  uisleep 0.3;
};
//----------------------------------------------------------------------------------------------------------------------- hauptteil ende


// # corestatus auswerten
private _mission_beenden = false;
switch (_core_status) do {
  case "zivilist im transporter": {
    deletevehicle _zivilist;
    s_rettz_zivilisten_gerettet = s_rettz_zivilisten_gerettet +1;
    if (s_rettz_zivilisten_gerettet == s_rettz_anz_zivilisten) then {
      {[["<t color='#2cb02a' size='8'>Mission abgeschlossen - Sie haben alle Zivilisten gerettet!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
      _mission_beenden = true;
    } else {
      {[["<t color='#2cb02a' size='8'>Geschafft - Sie haben den Zivilisten gerettet...aber es geht weiter!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
    };
  };
  case "transporter zerstoert": {
    {[["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN - Das Transportfahrzeug wurde zerstoert!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
    _mission_beenden = true;
  };
  case "zivilist getoetet": {
    s_rettz_zivilisten_getoetet = s_rettz_zivilisten_getoetet +1;
    if (s_rettz_zivilisten_getoetet > s_rettz_anz_zivilisten_tot_max) then {
      {[["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN - Zu viele Ziviliste nsind bei der Rettung gestorben!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
      _mission_beenden = true;
    } else {
      {[["<t color='#d93316' size='6'>OH NEIN - Der Zivilist bei der Rettung gestorben!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
      s_rettz_zivilisten_gerettet = s_rettz_zivilisten_gerettet +1; // todesrate noch im toleranzbereich, daher anz rettungen erhoehen
    };
  };
  case "notaus": {
    _mission_beenden = true;
  };
};


deletemarker "m_rettz_zivilist_area";
deletemarker "m_rettz_zivilist";

// # nach der core-auswertung kurz pausieren
uisleep 3;

if (_mission_beenden) exitwith {[_erstellte_objekte,_erstellte_marker] execvm "alex_scripte\s_mission_loeschen.sqf"};

[_erstellte_objekte,_erstellte_marker,_liste_hauspos,_vec_transport_fob,_verteiler_unit_zombie] execvm (format["%1s_mission_core.sqf",s_mission_params select 2]);

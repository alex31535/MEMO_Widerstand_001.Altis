/*
  fnc_s_gruppenmission_starten_ki
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

// Dorida="["Dorida",[19336.9,13252.3,-37.8615],525,114,[["mil",0],["spe",0],["sak",1],["ind",0]],114,1,"ColorRed"]"
#define _DEF_startverzoegerung_min_pro_1000m 5


// # alle gebiete nach farben selektieren
private _gebiete_red = [];
private _gebiete_green = [];
private _gebiete_blue = [];
{
  if ((_x select 7) == "ColorRed") then {_gebiete_red pushback _foreachindex};
  if ((_x select 7) == "ColorGreen") then {_gebiete_green pushback _foreachindex};
  if ((_x select 7) == "ColorBlue") then {_gebiete_blue pushback _foreachindex};
} foreach s_loc_params;


// # wenn keine roten gebiete mehr vorhanden sind, dann abbruch
if ((count _gebiete_red) == 0) exitwith {
  [[]/*_loc_params*/,[]/*_erstellte_objekte*/,[]/*_erstellte_marker*/] call fnc_s_gruppenmission_missionsende;
  [["<t color='#ff0000' size='4'>Der Feind verfuegt nur noch ueber verstreute Einheiten - Er hat zZt keine Moeglichkeit zu einem Gegenschlag!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};


private _dist = 0;
private _loc_params_ziel = [];
private _loc_params_start = [];
private _pos_ziel = [];
private _dist_start_ziel = 0;
private _loc_index_ziel = -1;
private _loc_index_start = -1;
private _start_in_min = 0;

// # feind greift destabiles gebiet an?
if ((count _gebiete_green) > 0) exitwith {
  _dist = worldsize;
  _loc_index_ziel = selectrandom _gebiete_green;
  _loc_params_ziel = s_loc_params select _loc_index_ziel;
  _pos_ziel = _loc_params_ziel select 1;
  {
    _dist_start_ziel = _pos_ziel distance ((s_loc_params select _x) select 1);
    if (_dist_start_ziel < _dist) then {_loc_index_start = _x; _dist = _dist_start_ziel};
  } foreach _gebiete_red;
  _loc_params_start = s_loc_params select _loc_index_start;
  _start_in_min = (ceil((_pos_ziel distance (position eo_flagge_basis))/ 1000)) * _DEF_startverzoegerung_min_pro_1000m;
  if (_start_in_min > 20) then {_start_in_min = 20};
  s_mission_params = [
  /* 0: mission (global/single) aktiv ? */ true,
  /* 1: name der Mission */ format["Der Feind schickt Einheiten (Level %1) aus %2 um die destabilisierte Region %3 zurueckzuerobern - Der Angriff startet in %4 Minuten!",_loc_params_start select 6,_loc_params_start select 0,_loc_params_ziel select 0,_start_in_min],
  /* 2: missionspfad zb "alex_missions\memo_deathmatch\" */ "missionen\stabilisieren\",
  /* 3: allg.Missionsparameter, hier index auf s_loc_params */ _loc_index_ziel,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ true,
  /* 6: ausstattungen verfuegbar */ true
  ];
  {[[format["<t color='#ffa600' size='4'>%1",s_mission_params select 1], "PLAIN", -1, true, true]] remoteexec ["cuttext",_x]} foreach playableunits;
  uisleep (_start_in_min *60);
  [((s_loc_params select _loc_index_ziel) select 6)] execvm "missionen\stabilisieren\s_mission_generieren.sqf";
};


if ((count _gebiete_blue) > 0) exitwith {
  _dist = worldsize;
  _loc_index_ziel = selectrandom _gebiete_blue;
  _loc_params_ziel = s_loc_params select _loc_index_ziel;
  _pos_ziel = _loc_params_ziel select 1;
  {
    _dist_start_ziel = _pos_ziel distance ((s_loc_params select _x) select 1);
    if (_dist_start_ziel < _dist) then {_loc_index_start = _x; _dist = _dist_start_ziel};
  } foreach _gebiete_red;
  _loc_params_start = s_loc_params select _loc_index_start;
  _start_in_min = (ceil((_pos_ziel distance (position eo_flagge_basis))/ 1000)) * _DEF_startverzoegerung_min_pro_1000m;
  if (_start_in_min > 20) then {_start_in_min = 20};
  s_mission_params = [
  /* 0: mission (global/single) aktiv ? */ true,
  /* 1: name der Mission */ format["Der Feind schickt Einheiten (Level %1) aus %2 um die Region %3 zurueckzuerobern - Der Angriff startet in %4 Minuten!",_loc_params_start select 6,_loc_params_start select 0,_loc_params_ziel select 0,_start_in_min],
  /* 2: missionspfad zb "alex_missions\memo_deathmatch\" */ "missionen\stabilisieren\",
  /* 3: allg.Missionsparameter, hier index auf s_loc_params */ _loc_index_ziel,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ true,
  /* 6: ausstattungen verfuegbar */ true
  ];
  {[[format["<t color='#ffa600' size='4'>%1",s_mission_params select 1], "PLAIN", -1, true, true]] remoteexec ["cuttext",_x]} foreach playableunits;
  uisleep (_start_in_min *60);
  [((s_loc_params select _loc_index_ziel) select 6)] execvm "missionen\verteidigen\s_mission_generieren.sqf";
};


[[]/*_loc_params*/,[]/*_erstellte_objekte*/,[]/*_erstellte_marker*/] call fnc_s_gruppenmission_missionsende;
[["<t color='#ff0000' size='4'>Der Feind hat das Land fest im Griff - Kein Grund fuer ihn aktiv zu werden!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];

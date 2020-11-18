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
#define _DEF_dist_grp_erkennung 3
#define _DEF_zeitintervall_clear 15

params ["_erstellte_objekte","_erstellte_marker","_liste_hauspos","_vec_transport_fob","_verteiler_unit_zombie"];

{
  [[format["<t color='#02bf1b' size='6'>Neuer Auftrag: Retten Sie nacheinander %1 Zivilisten!",s_rettz_anz_zivilisten], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach playableunits;

uisleep 5;
systemchat format ["%1: Core wird gestartet...",s_mission_params_rettz select 1];

// # core ----------------------------------------------------------------------------------------------------------------------------- core
s_rettz_zivilist_getoetet = 0;
private _missionsende_resultat = "";
private _params_rettung = [];
private _marker = "";
private _zivilist = objnull;
private _spawnpositionen_z = [];
private _area_spawn_aktiv = false;
private _area = [];
private _zeitstempel_spawn = time + s_rettz_zeitintervall_spawn;
private _zeitstempel_clear = time + _DEF_zeitintervall_clear;
private _feind = objnull;
private _erstellte_feinde = [];
private _units_in_area = [];
private _strassen_in_ziv_naehe = [];
private _feind_klasse = "";
private _feind_typ = "";
while {s_mission_params select 0} do {

  // # listen pruefen
  _erstellte_objekte = _erstellte_objekte select {!isnull _x};
  _erstellte_objekte = _erstellte_objekte select {alive _x};
  _erstellte_feinde = _erstellte_feinde select {!isnull _x};
  _erstellte_feinde = _erstellte_feinde select {alive _x};



  // # neuen zivilisten initialisieren
  if ((count _params_rettung) == 0) then {
    _params_rettung = [_liste_hauspos] call s_fnc_rettz_loc_erstellen; // --> [_zivilist, _spawnpositionen_z, _loc_und_pos, _liste_hauspos(neu)]
    _zivilist = _params_rettung select 0;
    _spawnpositionen_z = _params_rettung select 1;
    _liste_hauspos = _params_rettung select 2;// aktualisierte liste
    _area = [
        position _zivilist,
        s_rettz_area_dist_aktivierung,
        s_rettz_area_dist_aktivierung,
        0,
        false
    ];
    _zivilist addMPEventHandler ["MPKilled",{s_rettz_zivilist_getoetet = true}];
    _zivilist setcaptive true;
    _area_spawn_aktiv = false;
    _marker = createMarker ["m_rettz_zivilist_area", _zivilist getRelPos [random(_DEF_maerker_area_groesse/1.5), random 360]];
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
    _strassen_in_ziv_naehe = _zivilist nearRoads s_rettz_strassendistanz_ziv;
    {
      [["<t color='#02bf1b' size='4'>Notsignal empfangen - Begeben Sie sich zum Zielort und retten den Zivilisten!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };



  // # pruefen ob spawn aktiviert werden kann
  if (!_area_spawn_aktiv) then {
    if ((count(playableunits inareaarray _area)) > 0) then {
      _area_spawn_aktiv = true;
    };
  };


  // # spawn ausloesen wenn area aktiv ist
  if ((_area_spawn_aktiv) && {time > _zeitstempel_spawn} && {(count _erstellte_feinde) < s_rettz_max_anz_zombies}) then {
    _spawnpositionen_z call BIS_fnc_arrayShuffle;
    _feind_typ = selectrandom _verteiler_unit_zombie;
    _feind_klasse = if (_feind_typ == "u") then [{s_rettz_unitklassen_allgemein},{s_rettz_zombieklassen_allgemein}];
    _feind = [selectrandom _spawnpositionen_z,_feind_klasse] call fnc_s_sys_spawn_unit;
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


 // # zivilist getoetet, aber 50%-regel
 if (((count _params_rettung) != 0) && {!alive _zivilist}) then {
   _params_rettung = [];
   _area_spawn_aktiv = false;
   _zivilist = objnull;
   deletemarker "m_rettz_zivilist";
   deletemarker "m_rettz_zivilist_area";
   {s_objektmuelleimer pushback [_x,s_rettz_spawn_dist]} foreach _erstellte_feinde;
   {
     [["<t color='#02bf1b' size='3'>Der Zivilist wurde getoetet!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
   } foreach playableunits
 };




  // # zivilist kontrollieren
  if ((!isnull _zivilist) && {alive _zivilist}) then {
    if ((leader _zivilist) != _zivilist) then {
      if ((lifeState(leader _zivilist)) == "INCAPACITATED") then {
        if (_zivilist checkAIFeature "MOVE") then {
          [_zivilist] joinsilent grpnull;
          _zivilist move (position _zivilist);
          _zivilist disableAI "MOVE";
        };
      };
    } else {
      _units_in_area = (playableunits inareaarray [getposatl _zivilist,_DEF_dist_grp_erkennung,_DEF_dist_grp_erkennung,0,false,_DEF_dist_grp_erkennung]) select {alive _x};
      if ((count _units_in_area) > 0) then {
        [_zivilist] joinsilent (_units_in_area select 0);
        _zivilist enableAI "Move";
        if (captive _zivilist) then {_zivilist setcaptive false};
      } else {
        if (_zivilist checkAIFeature "MOVE") then {
          [_zivilist] joinsilent grpnull;
          _zivilist move (position _zivilist);
          _zivilist disableAI "MOVE";
        };
      };
    };
    if ((objectParent _zivilist) == _vec_transport_fob) then {
      [_zivilist] joinsilent grpnull;
      if ((_vec_transport_fob getCargoIndex _zivilist) == -1) then {
        unassignVehicle _zivilist;
        _zivilist assignascargo _vec_transport_fob;
        _zivilist moveincargo _vec_transport_fob;
      };
      _params_rettung = [];
      _area_spawn_aktiv = false;
      _zivilist = objnull;
      deletemarker "m_rettz_zivilist";
      deletemarker "m_rettz_zivilist_area";
      {s_objektmuelleimer pushback [_x,s_rettz_spawn_dist]} foreach _erstellte_feinde;
      {
        [[format["<t color='#02bf1b' size='3'>Sie haben einen %1 von %2 Zivilisten gerettet, aber warten sie bis er autom. im Laderaum platzgenommen hat!",s_rettz_anz_zivilisten - (count _params_rettung),s_rettz_anz_zivilisten], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
      } foreach playableunits;
    };
  };







  // # abbruchbedingungen
  // + zivilist auf dem transportweg verstorben ohne 50%-regel
  if ((!s_rettz_mibus_50_prozent) && {s_rettz_zivilist_getoetet > 0}) then {_missionsende_resultat = "zivilist getoetet"; s_mission_params set [0,false]};
  // + zivilist auf dem transportweg verstorben ohne 50%-regel
  if ((s_rettz_mibus_50_prozent) && {s_rettz_zivilist_getoetet > (s_rettz_anz_zivilisten/2)}) then {_missionsende_resultat = "50% zivilisten getoetet"; s_mission_params set [0,false]};
  // + alle ziviisten gerettet
  if (((count _liste_hauspos) == 0) && {(count _params_rettung) == 0}) then {_missionsende_resultat = "zivilisten gerettet"; s_mission_params set [0,false]};
  // + transporter zerstoert
  if (isnull _vec_transport_fob) then {_missionsende_resultat = "transporter zerstoert"; s_mission_params set [0,false]};
  // + transporter zerstoert
  if ((getdammage _vec_transport_fob) > 0.96) then {_missionsende_resultat = "transporter zerstoert"; s_mission_params set [0,false]};
  // + notaus aktiviert?
  if (s_mission_params select 4) then {s_mission_params set [0,false]};
  // # bremse
  uisleep 0.3;
};

// # manipulation missionsbezogener variablen



// # eventhandler entfernen






// # auswertung
switch (_missionsende_resultat) do {
  case "zivilisten gerettet": {
    {
      [["<t color='#2cb02a' size='8'>Geschafft - Sie haben alle Zivilisten gerettet!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
  case "transporter zerstoert": {
    {
      [["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN - Das Transportfahrzeug wurde zerstoert!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
  case "zivilist getoetet": {
    {
      [["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN - Ein Zivilist wurde getoetet!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
  case "50% zivilisten getoetet": {
    {
      [["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN - 50% der zu rettenden Zivilisten sind getoetet worden!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
};

// # alles loeschen
[_erstellte_objekte,_erstellte_marker] execvm "alex_scripte\s_mission_loeschen.sqf";

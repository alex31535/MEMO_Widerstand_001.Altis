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
params ["_loc_params","_erstellte_objekte","_erstellte_marker","_liste_spawnpos_inf","_liste_spawnstrassen_vec","_fahne","_spawn_zyklus"];

{
  [["<t color='#02bf1b' size='2'>Begeben Sie sich zum Zielort und verteidigen Sie die Fahne!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach playableunits;

systemchat format ["%1: Core wird gestartet...",s_mission_params_vert select 1];
// # core ----------------------------------------------------------------------------------------------------------------------------- core
s_vert_pos_fob = position eo_obj_spcfg_mission;
private _missionsende_resultat = "";
private _zeitstempel_spawn = time + _spawn_zyklus;
private _spawn_typ = "";
private _pos_spawn = [];
private _dir_spawn = 0;
private _unit = objnull;
private _gruppe = grpnull;
private _vec_klasse = "";
private _anz = 0;
private _anz_spieler = 0;
private _units_in_flaggenarea = [];
private _anz_units_in_flaggenarea_spieler = 0;
private _anz_units_in_flaggenarea_feind = 0;
private _punkte_spieler = s_vert_punkte_spieler_start + 0;
private _vec = objnull;
while {s_mission_params select 0} do {

  // # anz aktueller spieler im missionsbereich
  _anz_spieler = count((playableunits inareaarray (_loc_params select 1)) select {alive _x});

  // # reset auf variablen
  _spawn_typ = "";

  // # listen pruefen
  _erstellte_objekte = _erstellte_objekte select {!isnull _x};
  _erstellte_objekte = _erstellte_objekte select {alive _x};


  // # spawn-zeit erreicht?
  if (time > _zeitstempel_spawn) then {
    s_vert_random_spawn call BIS_fnc_arrayShuffle;
    _spawn_typ = selectrandom s_vert_random_spawn;
    _zeitstempel_spawn = time + _spawn_zyklus;
  };

  // # ggf spawn ausloesen
  if ((_spawn_typ != "") && {(count _erstellte_objekte) < s_vert_anz_max_objekte}) then {
    if (_spawn_typ == "inf") then {
      _liste_spawnpos_inf call BIS_fnc_arrayShuffle;
      _pos_spawn = selectrandom _liste_spawnpos_inf;
      _unit = [_pos_spawn,s_vert_unitklassen_feind_allgemein] call fnc_s_sys_spawn_unit;
      [_unit,s_admin_ki_level_min/100,s_admin_ki_level_max/100] call fnc_s_sys_unit_konfig_skills;
      _gruppe = group _unit;
      while {(count(waypoints _gruppe))>1} do {deleteWaypoint((waypoints _x)select 0)};
      _gruppe addWaypoint [position _fahne, 5, 0];
      [_gruppe, 0] setWaypointBehaviour "AWARE";
      [_gruppe, 0] setWaypointspeed "FULL";
      [_gruppe, 0] setWaypointType "MOVE";
      _gruppe addWaypoint [position _fahne,2,1];
      [_gruppe, 1] setWaypointCompletionRadius 2;
      [_gruppe, 1] setWaypointBehaviour "COMBAT";
      [_gruppe, 1] setWaypointspeed "FULL";
      [_gruppe, 1] setWaypointType "SAD";
      _erstellte_objekte pushback _unit;
    };//(_spawn_typ == "inf")
    if (_spawn_typ in ["rad","kette"]) then {
      call compile format["_vec_klasse = selectrandom s_vert_vecklassen_%1;",_spawn_typ];//"O_MRAP_02_hmg_F";
      _anz = getnumber(configFile >> "CfgVehicles" >> _vec_klasse >> "transportSoldier");
      if (_anz > 0) then {
        _liste_spawnstrassen_vec call BIS_fnc_arrayShuffle;
        _strasse = selectrandom _liste_spawnstrassen_vec;
        _vec = _vec_klasse createVehicle (position _strasse);
        _vec setdir (getdir _strasse);
        _gruppe = creategroup [east,true];
        {_unit = _gruppe createUnit [selectrandom s_vert_unitklassen_feind_allgemein, [0,0,0], [], 0, "NONE"];_unit moveInTurret [_vec, _x]} foreach (allTurrets _vec);
        if ((count(fullCrew [_vec, "gunner", true])) > 0) then {_unit = _gruppe createUnit [selectrandom s_vert_unitklassen_feind_allgemein, [0,0,0], [], 0, "NONE"];_unit moveingunner _vec};
        if ((count(fullCrew [_vec, "commander", true])) > 0) then {_unit = _gruppe createUnit [selectrandom s_vert_unitklassen_feind_allgemein, [0,0,0], [], 0, "NONE"];_unit moveingunner _vec};
        _unit = _gruppe createUnit [selectrandom s_vert_unitklassen_feind_allgemein, [0,0,0], [], 0, "NONE"];
        _unit moveindriver _vec;
        if ((!isnil "s_debugmarker") && {s_debugmarker}) then {{[_x] call fnc_s_debugmarker_erstellen} foreach (units _gruppe)};
        if (!isnil "fnc_s_sys_unit_konfig_skills") then {{[_x,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills} foreach (units _gruppe)};
        _gruppe addWaypoint [position _strasse, 5, 0];
        [_gruppe, 0] setWaypointBehaviour "COMBAT";
        [_gruppe, 0] setWaypointspeed "LIMITED";
        [_gruppe, 0] setWaypointType "MOVE";
        [_gruppe, 0] setWaypointCompletionRadius 30;
        _gruppe addWaypoint [position(selectrandom((position _fahne) nearroads ((_loc_params select 1) select 1))),10,1];
        [_gruppe, 1] setWaypointCompletionRadius 2;
        [_gruppe, 1] setWaypointBehaviour "COMBAT";
        [_gruppe, 1] setWaypointspeed "LIMITED";
        [_gruppe, 1] setWaypointType "TR UNLOAD";
        [_gruppe, 1] setWaypointCompletionRadius 50;
        _erstellte_objekte append (units _gruppe);
        _erstellte_objekte pushback _vec;
        // # cargo
        if ((count(fullCrew [_vec, "cargo", true])) > 0) then {
          _gruppe = creategroup [east,true];
          {_unit = _gruppe createUnit [selectrandom s_vert_unitklassen_feind_allgemein, [0,0,0], [], 0, "NONE"];_unit moveincargo _vec} foreach (fullCrew [_vec, "cargo", true]);
          _gruppe addWaypoint [position _fahne, 5, 0];
          [_gruppe, 0] setWaypointBehaviour "AWARE";
          [_gruppe, 0] setWaypointspeed "FULL";
          [_gruppe, 0] setWaypointType "MOVE";
          _gruppe addWaypoint [position _fahne,2,1];
          [_gruppe, 1] setWaypointCompletionRadius 2;
          [_gruppe, 1] setWaypointBehaviour "COMBAT";
          [_gruppe, 1] setWaypointspeed "FULL";
          [_gruppe, 1] setWaypointType "SAD";
          if ((!isnil "s_debugmarker") && {s_debugmarker}) then {{[_x] call fnc_s_debugmarker_erstellen} foreach (units _gruppe)};
          if (!isnil "fnc_s_sys_unit_konfig_skills") then {{[_x,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills} foreach (units _gruppe)};
          _erstellte_objekte append (units _gruppe);
        };//((count(fullCrew [_vec, "cargo", true])) > 0)
      };//(_anz[cargo!)] > 0)
    };//(_spawn_typ == "rad")
    if (_spawn_typ in ["flug","heli"]) then {
      call compile format["_vec = [_fahne,s_vert_vecklassen_%1] call fnc_s_sys_fluggeraet_sad;",_spawn_typ];
      _erstellte_objekte pushback _vec;
      _erstellte_objekte append (units(group(driver _vec)));
      if ((!isnil "s_debugmarker") && {s_debugmarker}) then {
        {[_x] call fnc_s_debugmarker_erstellen} foreach (units(group(driver _vec)));
        [_vec] call fnc_s_debugmarker_erstellen;
      };
      if (!isnil "fnc_s_sys_unit_konfig_skills") then {
        {[_x,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills} foreach (units(group(driver _vec)));
      };
    };
    _spawn_typ = "";
  };//((_spawn_typ != "") && {(count _erstellte_objekte) < s_vert_anz_max_objekte})



  // # flaggenstatus
  _units_in_flaggenarea = (allunits select {alive _x}) inareaarray s_vert_str_m_fahne_area;
  _anz_units_in_flaggenarea_spieler = count((_units_in_flaggenarea select {isplayer _x}) select {(lifeState _x) == "HEALTHY"});
  _anz_units_in_flaggenarea_feind = count(_units_in_flaggenarea select {!isplayer _x});
  _units_in_flaggenarea_verhaeltnis = _anz_units_in_flaggenarea_spieler - _anz_units_in_flaggenarea_feind;
  //systemchat format["vert gen: verhaeltnis: %1",_units_in_flaggenarea_verhaeltnis];
  if (_units_in_flaggenarea_verhaeltnis != 0) then {
    if (((typeof _fahne) == s_vert_zielobjekt_klasse_spieler) && {_units_in_flaggenarea_verhaeltnis < 0}) then {
      _pos = position _fahne; deletevehicle _fahne; _fahne = nil;
      _fahne = s_vert_zielobjekt_klasse_feind createVehicle _pos;
      _erstellte_objekte pushback _fahne;
      s_vert_str_m_fahne setMarkerColor "ColorRed";
    };//((typeof _zielobjekt) == s_vert_zielobjekt_klasse_spieler)
    if (((typeof _fahne) == s_vert_zielobjekt_klasse_feind) && {_units_in_flaggenarea_verhaeltnis > 0}) then {
      _pos = position _fahne; deletevehicle _fahne; _fahne = nil;
      _fahne = s_vert_zielobjekt_klasse_spieler createVehicle _pos;
      _erstellte_objekte pushback _fahne;
      s_vert_str_m_fahne setMarkerColor "ColorBlue";
    };//((typeof _zielobjekt) == s_vert_zielobjekt_klasse_spieler)
  };//((count _units_in_flaggenarea) > 0)



  // # punkte aktualisieren
  _punkte_spieler = _punkte_spieler + _units_in_flaggenarea_verhaeltnis;
  s_vert_str_m_fahne setmarkertext (format["Punkte: %1%2",100/(s_vert_punkte_sieg/(_punkte_spieler +0.000001)),"%"]);

  // # sieg-punktezahl erreicht
  if (_punkte_spieler > s_vert_punkte_sieg) then {s_mission_params set [0,false]; _missionsende_resultat = "punkte erreicht"};

  // # punkte auf null
  if (_punkte_spieler < 0) then {s_mission_params set [0,false]; _missionsende_resultat = "punkte 0"};

  // # notaus aktiviert?
  if (s_mission_params select 4) then {s_mission_params set [0,false]};

  uisleep 0.3;

};

// # manipulation missionsbezogener variablen
s_vert_pos_fob = [];// # wichtig um missionsteilnahme zu unterbinden
s_vert_moerser_pos = [];
s_vert_moersersignal_zaehler = 0;
deletemarker "m_vert_moerserposition";



// # eventhandler entfernen
{
  [_x,"Killed"] remoteexec ["removeAllEventHandlers",_x];
} foreach playableunits;





// # auswertung
switch (_missionsende_resultat) do {
  case "punkte erreicht": {
    {
      [["<t color='#2cb02a' size='4'>Geschafft - Die erforderlichen Siegpunkte wurden erreicht!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
  case "punkte 0": {
    {
      [["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN - Das Punktekonto ist auf Null gesunken!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
};

// # alles loeschen
[_erstellte_objekte,_erstellte_marker] execvm "alex_scripte\s_mission_loeschen.sqf";

/*
  s_mission_generieren.sqf
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
#define _DEF_min_anz_geb_positionen_fob 3
#define _DEF_dist_toleranz 100
#define _DEF_dist_toleranz_vec 100
#define _DEF_min_anz_geb_positionen_inf_spawn 3


private _erstellte_objekte = [];
private _erstellte_marker = [];

private _infanterie_fallschirm = false;

private _loc_params = s_loc_params select (s_mission_params select 3);
private _loc_name = _loc_params select 0;
private _loc_pos = _loc_params select 1;
private _loc_groesse = _loc_params select 2;
private _loc_geb_dichte = _loc_params select 3;
private _loc_dichte_obj = _loc_params select 4;
private _loc_pkt = _loc_params select 5;
private _loc_lvl = _loc_params select 6;
private _loc_farbe = _loc_params select 7;

private _gen_params = [
/*0 ["Spawnabstaende",[["Schnell",2],["Mittel",4],["Langsam",8]],*/ (9 - _loc_lvl),
/*1 ["Haeuserdichte",[["Gering",4],["Mittel",10],["Hoch",18]],*/ 1,
/*2 "Objektdichte",[["Gering",50],["Mittel",90],["Hoch",128]],*/ (45 + (_loc_lvl * 10)),
/*3 ["Groesse Flaggenzone",[["Gering",30],["Mittel",50],["Hoch",80]],*/ (30 + (_loc_lvl * 7.5)),
/*4 ["Punkte-Rate",[["Gering",7000],["Mittel",10000],["Hoch",15000]],*/ (5000 + (_loc_lvl * 1500)),
/*5 ["Dichte Landfahrzeug-Spawn",[["Gering",2],["Mittel",5],["Hoch",8]],*/ (9 - _loc_lvl),
/*6 ["Dichte Infanterie-Spawn",[["Gering",2],["Mittel",5],["Hoch",8]],*/ (9 - _loc_lvl),
/*7 ["Wahrscheinlichkeit Infanterie",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],*/ ([5,10,15,20,25,30,35,40] select _loc_lvl),
/*8 ["Wahrscheinlichkeit Radfahrzeuge",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],*/ ([5,10,15,20,25,30,35,40] select _loc_lvl),
/*9 ["Wahrscheinlichkeit Kettenfahrzeuge",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],*/ ([5,10,15,20,25,30,35,40] select _loc_lvl),
/*10 ["Wahrscheinlichkeit Flugzeuge",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],*/ ([5,10,15,20,25,30,35,40] select _loc_lvl),
/*11 ["Wahrscheinlichkeit Helikopter",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],*/ ([5,10,15,20,25,30,35,40] select _loc_lvl),
/*12 ["Entfernung Infanterie",[["Sehr weit",650],["Weit",550],["Mittel",450],["Nah",350],["Sehr nah",250]],*/ (550 - (45 * _loc_lvl))
];

private _punkte_spieler = (_gen_params select 4)/100;

private _pos_dir_fahne = [];


// # wenn keine strassen in der zielzone ermittelt werden koennen, dann wwerden die rad- und kettenfahrzeuge auf null gesetzt
//    ausserdem muss die position der fahne angeglichen werden
private _strassen_area1 = (_loc_params select 1) nearRoads ((_loc_params select 2)/2);
if ((count _strassen_area1) == 0) then {
  _gen_params set [8,0];
  _gen_params set [9,0];
  _pos_dir_fahne = ((_loc_params select 1) select 0) findEmptyPosition [5,((_loc_params select 1) select 1),"Flag_Green_F"];
} else {
  _pos_dir_fahne = [selectrandom _strassen_area1] call fnc_s_pos_dir_strassenrand;
};


// # flagge erstellen und area markieren
private _fahne = "Flag_Green_F" createVehicle (_pos_dir_fahne select 0);
_erstellte_objekte pushback _fahne;
private _marker = createMarker ["m_fahne_icon", (_pos_dir_fahne select 0)];
_marker setMarkerType "mil_dot";
_marker setMarkerColor "ColorGreen";
_erstellte_marker pushback _marker;
_marker = createMarker ["m_fahne_area", (_pos_dir_fahne select 0)];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerColor "ColorPink";
_marker setMarkerBrush "Border";
_marker setMarkerSize [_gen_params select 3, _gen_params select 3];
_erstellte_marker pushback _marker;



// # spawn-punkte fuer inf bestimmen: separiert von vec-spawnpos-suche, da unterschiedliche distanzen
private _liste_spawnpos_inf = []; // <--- uebergabe-var
private _dist = (_gen_params select 3) + (_gen_params select 12) - (_DEF_dist_toleranz/2);
private _pos_rel = [];
private _wasser_gefunden = false;
private _pos_im_wald = false;
private _gebaeude = [];
private _positionen_innerhalb_haus = [];
private _pos = [];
for "_i" from 0 to 360 step 2 do {
  _pos_rel = _fahne getRelPos [_dist + (random _DEF_dist_toleranz), _i];
  if ((!(surfaceiswater _pos_rel)) && {(_pos_rel distance _fahne) > (_gen_params select 12)}) then {
    _wasser_gefunden = [_pos_rel,position _fahne] call fnc_s_wasser_zwischen_a_und_b;
    if (!_wasser_gefunden) then {
      _pos_im_wald = [_pos_rel] call fnc_s_pos_im_wald;
      if (_pos_im_wald) then {
        _liste_spawnpos_inf pushback _pos_rel;
      } else {
        _gebaeude = [_pos_rel,50,_DEF_min_anz_geb_positionen_inf_spawn] call fnc_s_gebaeudeauswahl;
        if ((count _gebaeude) > 0) then {
          _positionen_innerhalb_haus = [selectrandom _gebaeude] call fnc_s_positionen_innerhalb_haus;
          if ((count _positionen_innerhalb_haus) > 0) then {
            _pos = selectrandom _positionen_innerhalb_haus;
            {if (((count _pos) > 0) && {(_pos distance _x) < 50}) then {_pos = []}} foreach _liste_spawnpos_inf;
            if ((count _pos) > 0) then {_liste_spawnpos_inf pushback _pos};
          };//((count _positionen_innerhalb_haus) > 0)
        };//((count _gebaeude) > 0)
      };//(_pos_im_wald)
    };//(!_wasser_gefunden)
  };//!(surfaceiswater
};//for "_i"






private _liste_spawnstrassen_vec = [];
private _strasse = objnull;
private _strassen_brauchbar = [];
// # spawn-punkte fuer vec bestimmen
if (((_gen_params select 8) + (_gen_params select 9)) > 0) then {
  _dist = (_loc_params select 2) - (_DEF_dist_toleranz_vec/2);
  for "_i" from 0 to 360 step 2 do {
    _pos_rel = _fahne getRelPos [_dist + (random _DEF_dist_toleranz_vec), _i];
    _wasser_gefunden = [_pos_rel,position _fahne] call fnc_s_wasser_zwischen_a_und_b;
    if (!_wasser_gefunden) then {
      _strassen = _pos_rel nearRoads 80;
      _strassen_brauchbar = [];
      if ((count _strassen) > 0) then {
        {if ((((getRoadInfo _x) select 0) in ["ROAD","MAIN ROAD","TRACK"]) && {!((getRoadInfo _x) select 8)}) then {_strassen_brauchbar pushback _x}} foreach _strassen;
      };
      if ((count _strassen_brauchbar) > 0) then {
        _strasse = selectrandom _strassen_brauchbar;
        {if ((!isnull _strasse) && {((position _strasse) distance (position _x)) < 100}) then {_strasse = objnull}} foreach _liste_spawnstrassen_vec;
        if (!isnull _strasse) then {_liste_spawnstrassen_vec pushback _strasse};
      };
    };
  };
};


if ((count _liste_spawnpos_inf) == 0) then {
  {_liste_spawnpos_inf pushback (position _x)} foreach _liste_spawnstrassen_vec;
};


if (!isdedicated) then {
  private _m = "";
  {
    private _m = createMarker [format["m_vert_spawnpos_inf_%1",_foreachindex], _x];
    _m setMarkerType "mil_dot";
    _m setMarkerColor "ColorYellow";
    _m setmarkertext (format["inf_%1",_foreachindex]);
    _erstellte_marker pushback _m;
  } foreach _liste_spawnpos_inf;
  {
    private _m = createMarker [format["m_vert_spawnpos_vec_%1",_foreachindex], position _x];
    _m setMarkerType "mil_dot";
    _m setMarkerColor "ColorYellow";
    _m setmarkertext (format["vec_%1",_foreachindex]);
    _erstellte_marker pushback _m;
  } foreach _liste_spawnstrassen_vec;
};


private _vert_random_spawn = [];
for "_i" from 1 to (_gen_params select 7) do {_vert_random_spawn pushback "inf"};
for "_i" from 1 to (_gen_params select 8) do {_vert_random_spawn pushback "rad"};
for "_i" from 1 to (_gen_params select 9) do {_vert_random_spawn pushback "kette"};
//for "_i" from 1 to (_gen_params select 10) do {_vert_random_spawn pushback "flug"};
//for "_i" from 1 to (_gen_params select 11) do {_vert_random_spawn pushback "heli"};
private call BIS_fnc_arrayShuffle;



private _missionsende_resultat = "";
private _zeitstempel_spawn = time + (_gen_params select 0);
private _spawn_typ = "";
private _unit = objnull;
private _gruppe = grpnull;
private _vec_klasse = "";
private _anz = 0;
private _units_in_flaggenarea = [];
private _anz_units_in_flaggenarea_spieler = 0;
private _anz_units_in_flaggenarea_feind = 0;
private _vec = objnull;

private _flaggenzone = [(position _fahne), _gen_params select 3, _gen_params select 3, 0, false];

while {s_mission_params select 0} do {
  // # anz aktueller spieler im missionsbereich
  //_anz_spieler = count((playableunits inareaarray "m_fahne_area") select {alive _x});
  // # reset auf variablen
  _spawn_typ = "";
  // # listen pruefen
  _erstellte_objekte = _erstellte_objekte select {!isnull _x};
  _erstellte_objekte = _erstellte_objekte select {alive _x};
  // # spawn-zeit erreicht?
  if (time > _zeitstempel_spawn) then {
    _vert_random_spawn call BIS_fnc_arrayShuffle;
    _spawn_typ = selectrandom _vert_random_spawn;
    _zeitstempel_spawn = time + (_gen_params select 0);
  };

  // # ggf spawn ausloesen
  if ((_spawn_typ != "") && {(count _erstellte_objekte) < ((_gen_params select 2))}) then {
    if (_spawn_typ == "inf") then {
      _liste_spawnpos_inf call BIS_fnc_arrayShuffle;
      _unit = (creategroup [s_feind_seite,true]) createUnit [s_feind_klasse, [0,0,0], [], 0, "NONE"];
      _unit setposasl (agltoasl (selectrandom _liste_spawnpos_inf));
      _unit setdir (random 360);
      [_unit,_loc_lvl] call fnc_s_feindkonfig;
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
      if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
    };//(_spawn_typ == "inf")
    if (_spawn_typ in ["rad","kette"]) then {
      _vec_klasse = selectrandom (s_feind_fzg_land_bewaffnet select _loc_lvl);
      _anz = getnumber(configFile >> "CfgVehicles" >> _vec_klasse >> "transportSoldier");
      //if (_anz > 0) then {
        _liste_spawnstrassen_vec call BIS_fnc_arrayShuffle;
        _strasse = selectrandom _liste_spawnstrassen_vec;
        _vec = _vec_klasse createVehicle (position _strasse);
        _vec setdir (getdir _strasse);
        _gruppe = creategroup [east,true];
        {_unit = _gruppe createUnit [s_feind_klasse, (position _vec), [], 0, "NONE"];_unit moveInTurret [_vec, _x]} foreach (allTurrets _vec);
        if ((count(fullCrew [_vec, "gunner", true])) > 0) then {_unit = _gruppe createUnit [s_feind_klasse, (position _vec), [], 0, "NONE"];_unit moveingunner _vec};
        if ((count(fullCrew [_vec, "commander", true])) > 0) then {_unit = _gruppe createUnit [s_feind_klasse, (position _vec), [], 0, "NONE"];_unit moveingunner _vec};
        _unit = _gruppe createUnit [s_feind_klasse, (position _vec), [], 0, "NONE"];
        _unit moveindriver _vec;
        if ((!isnil "s_debugmarker") && {s_debugmarker}) then {{[_x] call fnc_s_debugmarker_erstellen} foreach (units _gruppe)};
        {[_x,_loc_lvl] call fnc_s_feindkonfig} foreach (units _gruppe);
        _gruppe addWaypoint [position _strasse, 5, 0];
        [_gruppe, 0] setWaypointBehaviour "COMBAT";
        [_gruppe, 0] setWaypointspeed "LIMITED";
        [_gruppe, 0] setWaypointType "MOVE";
        [_gruppe, 0] setWaypointCompletionRadius 30;
        _gruppe addWaypoint [(position _fahne) findEmptyPosition [10,100,(typeof _vec)],10,1];
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
          {_unit = _gruppe createUnit [s_feind_klasse, (position _vec), [], 0, "NONE"];_unit moveincargo _vec} foreach (fullCrew [_vec, "cargo", true]);
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
          {[_x,_loc_lvl] call fnc_s_feindkonfig} foreach (units _gruppe);
          _erstellte_objekte append (units _gruppe);
        };//((count(fullCrew [_vec, "cargo", true])) > 0)
      //};//(_anz[cargo!)] > 0)
    };//(_spawn_typ == "rad")
    if (_spawn_typ in ["flug","heli"]) then {
      //call compile format["_vec = [_fahne,s_vert_vecklassen_%1] call fnc_s_sys_fluggeraet_sad;",_spawn_typ];
      //_erstellte_objekte pushback _vec;
      //_erstellte_objekte append (units(group(driver _vec)));
      //if ((!isnil "s_debugmarker") && {s_debugmarker}) then {
      //  {[_x] call fnc_s_debugmarker_erstellen} foreach (units(group(driver _vec)));
      //  [_vec] call fnc_s_debugmarker_erstellen;
      //};
      //if (!isnil "fnc_s_sys_unit_konfig_skills") then {
      //  {[_x,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills} foreach (units(group(driver _vec)));
      //};
    };
    _spawn_typ = "";
  };//((_spawn_typ != "") && {(count _erstellte_objekte) < s_vert_anz_max_objekte})



  // # flaggenstatus
  _units_in_flaggenarea = (allunits select {alive _x}) inareaarray "m_fahne_area";
  _anz_units_in_flaggenarea_spieler = count((_units_in_flaggenarea select {isplayer _x}) select {(lifeState _x) == "HEALTHY"});
  _anz_units_in_flaggenarea_feind = count(_units_in_flaggenarea select {!isplayer _x});
  _units_in_flaggenarea_verhaeltnis = _anz_units_in_flaggenarea_spieler - _anz_units_in_flaggenarea_feind;
  if (_units_in_flaggenarea_verhaeltnis != 0) then {
    if (((typeof _fahne) == "Flag_Blue_F") && {_units_in_flaggenarea_verhaeltnis < 0}) then {
      _pos = position _fahne; deletevehicle _fahne; _fahne = nil;
      _fahne = "Flag_Red_F" createVehicle _pos;
      _erstellte_objekte pushback _fahne;
      "m_fahne_icon" setMarkerColor "ColorRed";
    };//((typeof _zielobjekt) == s_vert_zielobjekt_klasse_spieler)
    if (((typeof _fahne) == "Flag_Red_F") && {_units_in_flaggenarea_verhaeltnis > 0}) then {
      _pos = position _fahne; deletevehicle _fahne; _fahne = nil;
      _fahne = "Flag_Blue_F" createVehicle _pos;
      _erstellte_objekte pushback _fahne;
      "m_fahne_icon" setMarkerColor "ColorBlue";
    };//((typeof _zielobjekt) == s_vert_zielobjekt_klasse_spieler)
  };//((count _units_in_flaggenarea) > 0)



  // # punkte aktualisieren
  _punkte_spieler = _punkte_spieler + _units_in_flaggenarea_verhaeltnis;
  "m_fahne_icon" setmarkertext (format["Punkte: %1%2",100/((_gen_params select 4)/(_punkte_spieler +0.000001)),"%"]);
  // # sieg-punktezahl erreicht
  if (_punkte_spieler > (_gen_params select 4)) then {s_mission_params set [0,false]; _missionsende_resultat = "punkte erreicht"};
  // # punkte auf null
  if (_punkte_spieler < 0) then {s_mission_params set [0,false]; _missionsende_resultat = "punkte 0"};
  // # notaus aktiviert?
  if (s_mission_params select 4) then {s_mission_params set [0,false]};
  uisleep 0.3;
};



// # auswertung
switch (_missionsende_resultat) do {
  case "punkte erreicht": {
    {
      [["<t color='#2cb02a' size='4'>Geschafft - Sie haben die Region stabilisiert!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
    _loc_params set [7,"ColorBlue"];
  };
  case "punkte 0": {
    {
      [["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN - Die Region ist verloren!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
    _loc_params set [7,"ColorRed"];
  };
};

s_loc_params set [s_mission_params select 3,_loc_params];
(format["m_loc_icon_%1",s_mission_params select 3]) setmarkercolor (_loc_params select 7);

while {s_db_aktiv} do {uisleep 0.3}; s_db_aktiv = true;
private _db = ["new", format["%1_s_loc_params_%2",s_pref_spiel,(toLowerANSI worldname)]] call OO_INIDBI;
{["write",[_x select 0,_x select 0,_x]] call _db;} foreach s_loc_params;
s_db_aktiv = false;

reverse s_spieler_oder_ki;
while {s_db_aktiv} do {uisleep 0.3};
s_db_aktiv = true;
private _db = ["new", format["%1_s_spieler_oder_ki_%2",s_pref_spiel,(toLowerANSI worldname)]] call OO_INIDBI;
["write",["s_spieler_oder_ki","s_spieler_oder_ki",s_spieler_oder_ki]] call _db;
s_db_aktiv = false;

// bereinigungen -> objektmuelleimer
{deletemarker _x} foreach _erstellte_marker;
{s_objektmuelleimer pushback [_x,750]; _x allowfleeing 1} foreach _erstellte_objekte;

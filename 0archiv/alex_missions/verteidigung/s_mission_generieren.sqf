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
#define _DEF_dist_toleranz 100
#define _DEF_dist_toleranz_vec 100
#define _DEF_min_anz_geb_positionen_inf_spawn 3
#define _DEF_min_anz_geb_positionen_fob 5

private _parameter_uebergabe = _this;

// # bei erstaufruf die parameter in reduzierter form speichern
if (s_missionsgenerierungen == s_vert_missionsgenerierungen_max) then {
  private _parameter_inidbi = [];
    {_parameter_inidbi pushback [_x select 0,_x select 3]} foreach _parameter_uebergabe;
  [s_vert_missionskennung,_parameter_inidbi] call fnc_s_sys_missionsparameter_inidbi;
};


// # durchlaufzaehler verringern und vorgang ggf beenden
s_missionsgenerierungen = s_missionsgenerierungen -1;
if (s_missionsgenerierungen == 0) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Missionsparameter haben in meheren Durchlaeufen zu keinem Ergebnis gefuehrt. Missionsanforderung bitte wiederholen und ggf Parameter anpassen!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [[],[]] execvm "alex_scripte\s_mission_loeschen.sqf";
};
[[format["<t color='#ff0000' size='2'>Generiere: %1 (%2)...",s_mission_params_vert select 1,s_missionsgenerierungen], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];



// hier gilt : remoteExecutedOwner !
private _spieler_param = [];
/* Parameterliste: (aus s_mission_parameter_an_spieler.sqf)
0 ["Spawnabstaende",[["Schnell",2],["Mittel",4],["Langsam",8]],
1 ["Haeuserdichte",[["Gering",4],["Mittel",10],["Hoch",18]],
2 "Objektdichte",[["Gering",50],["Mittel",90],["Hoch",128]],
3 ["Groesse Flaggenzone",[["Gering",30],["Mittel",50],["Hoch",80]],
4 ["Punkte-Rate",[["Gering",7000],["Mittel",10000],["Hoch",15000]],
5 ["Dichte Landfahrzeug-Spawn",[["Gering",2],["Mittel",5],["Hoch",8]],
6 ["Dichte Infanterie-Spawn",[["Gering",2],["Mittel",5],["Hoch",8]],
7 ["Wahrscheinlichkeit Infanterie",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],
8 ["Wahrscheinlichkeit Radfahrzeuge",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],
9 ["Wahrscheinlichkeit Kettenfahrzeuge",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],
10 ["Wahrscheinlichkeit Flugzeuge",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],
11 ["Wahrscheinlichkeit Helikopter",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],
12 ["Entfernung Infanterie",[["Sehr weit",650],["Weit",550],["Mittel",450],["Nah",350],["Sehr nah",250]],
*/
{_spieler_param pushback ((_x select 3) select 1)} foreach _parameter_uebergabe;


// # parameter fuer weitergabe an core:
private _vert_p_spawnabstaende = _spieler_param select 0;


// # missionuebergreifende parameter
s_vert_pos_fob = [];// generiert sobald eine spawn-pos ermittelt wurde :: wird in missionsteilnahme abgefragt! :: wird am missionsende geloescht

// # parameter zu globals
s_vert_punkte_sieg = _spieler_param select 4;
s_vert_punkte_spieler_start = (_spieler_param select 4)/100;
s_vert_anz_max_objekte = (_spieler_param select 2);
s_vert_random_spawn = [];
for "_i" from 1 to (_spieler_param select 7) do {s_vert_random_spawn pushback "inf"};
for "_i" from 1 to (_spieler_param select 8) do {s_vert_random_spawn pushback "rad"};
for "_i" from 1 to (_spieler_param select 9) do {s_vert_random_spawn pushback "kette"};
for "_i" from 1 to (_spieler_param select 10) do {s_vert_random_spawn pushback "flug"};
for "_i" from 1 to (_spieler_param select 11) do {s_vert_random_spawn pushback "heli"};
s_vert_random_spawn call BIS_fnc_arrayShuffle;


private _erstellte_objekte = [];
private _erstellte_marker = [];



// # geeignete location finden
private _loc = locationnull;
private _loc_params = [];
for "_i" from 1 to 50 do {
  _loc = selectrandom s_sys_locations;
  if ((((_loc select 1) select 0) distance (s_sys_area_hq select 0)) > (((_loc select 2) select 1) + (s_sys_area_hq select 1))) exitwith {_loc_params = _loc};
};
if ((count _loc_params) == 0) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Locationberechnung fehlgeschlagen. Neugenerierung wird ausgeloest!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [_this,_erstellte_objekte,_erstellte_marker] call fnc_s_missionsgenerierung_wiederholen;
};



// # strassen in area 1 feststellen
private _strassen_area1 = ((_loc_params select 1) select 0) nearRoads ((_loc_params select 1) select 1);
if ((count _strassen_area1) < 10) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Anzahl ermittelter Strassensegmente zu gering. Neugenerierung wird ausgeloest!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [_this,_erstellte_objekte,_erstellte_marker] call fnc_s_missionsgenerierung_wiederholen;;
};

// # strasse fuer flagge waehlen und area markieren
private _pos_dir_fahne = [selectrandom _strassen_area1] call fnc_s_sys_pos_dir_strassenrand;
if ((count _pos_dir_fahne) == 0) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Platzeirung der Fahne auf Strassensegment nicht moeglich. Neugenerierung wird ausgeloest!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [_this,_erstellte_objekte,_erstellte_marker] call fnc_s_missionsgenerierung_wiederholen;
};
private _fahne = s_vert_zielobjekt_klasse_spieler createVehicle (_pos_dir_fahne select 0);
_erstellte_objekte pushback _fahne;
private _marker = createMarker [s_vert_str_m_fahne, (_pos_dir_fahne select 0)];
_marker setMarkerType "mil_dot";
_marker setMarkerColor "ColorBlue";
_erstellte_marker pushback _marker;
_marker = createMarker [s_vert_str_m_fahne_area, (_pos_dir_fahne select 0)];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerColor "ColorPink";
_marker setMarkerBrush "Border";
_marker setMarkerSize [_spieler_param select 3, _spieler_param select 3];
_erstellte_marker pushback _marker;
//systemchat format ["%1: Flagge gesetzt und markiert...",s_mission_params_vert select 1];


// # haeuser in area1 ermitteln und position fuer fob suchen
private _haeuser_area1 = [(_loc_params select 1) select 0, (_loc_params select 1) select 1, _DEF_min_anz_geb_positionen_fob] call fnc_a_sys_gebaeudeauswahl;
if ((count _haeuser_area1) < (_spieler_param select 1)) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Berechnete Gebaeude unter Midestanzahl. Neugenerierung wird ausgeloest!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [_this,_erstellte_objekte,_erstellte_marker] call fnc_s_missionsgenerierung_wiederholen;
};
//systemchat format ["%1: Alle Gebaeude innerhalb Area1 errechnet...",s_mission_params_vert select 1];
private _haeuser_fob_area1 = [];
{
  if ((((position _x) distance _fahne) < ((_spieler_param select 3) + 50)) && {!((position _x) inarea s_vert_str_m_fahne_area)}) then {
    _haeuser_fob_area1 pushback _x;
  };
} foreach _haeuser_area1;
if ((count _haeuser_fob_area1) == 0) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Keine Auswahl fuer FOB. Neugenerierung wird ausgeloest!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [_this,_erstellte_objekte,_erstellte_marker] call fnc_s_missionsgenerierung_wiederholen;
};
//systemchat format ["%1: Gebaeudeauswahl fuer FOB erstellt...",s_mission_params_vert select 1];
private _haeuser_fob_area1_mit_innenbereich = [];
private _positionen_innerhalb_haus = [];
{
  _positionen_innerhalb_haus = [_x] call fnc_a_sys_positionen_innerhalb_haus;
  if ((count _positionen_innerhalb_haus) > 0) then {_haeuser_fob_area1_mit_innenbereich pushback _x};
} foreach _haeuser_fob_area1;
if ((count _haeuser_fob_area1_mit_innenbereich) == 0) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Positionierung des FOB innerhalb Location nicht moeglich. Neugenerierung wird ausgeloest!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [_this,_erstellte_objekte,_erstellte_marker] call fnc_s_missionsgenerierung_wiederholen;
};
//systemchat format ["%1: Positionierungsmoeglichkeiten fuer FOB berechnet...",s_mission_params_vert select 1];
s_vert_liste_spieler_spawn_pos = [selectrandom _haeuser_fob_area1_mit_innenbereich] call fnc_a_sys_positionen_innerhalb_haus;
eo_obj_spcfg_mission = s_vert_spcfg_obj_klasse createVehicle [0,0,0];
eo_obj_spcfg_mission setposatl (selectrandom s_vert_liste_spieler_spawn_pos);
eo_obj_spcfg_mission setdir (random 360);
[eo_obj_spcfg_mission] call fnc_s_spcfg_action_auf_obj;
_erstellte_objekte pushback eo_obj_spcfg_mission;
_marker = createMarker ["m_vert_versorgung", position eo_obj_spcfg_mission];
_marker setMarkerType "mil_dot";
_marker setMarkerColor "ColorYellow";
_marker setmarkertext "Versorgung";
_erstellte_marker pushback _marker;
eo_obj_spcfg_mission allowdammage false;
(nearestBuilding eo_obj_spcfg_mission) allowdammage false;

// # zusaetzliche ausruestung in die kiste
{eo_obj_spcfg_mission addBackpackCargoGlobal _x} foreach s_vert_rucksaecke;
{eo_obj_spcfg_mission additemCargoGlobal _x} foreach s_vert_items;
{eo_obj_spcfg_mission addMagazineCargoGlobal _x} foreach s_vert_mags;


//systemchat format ["%1: FOB/Versorgung gesetzt und markiert...",s_mission_params_vert select 1];

//--------------------------------------------------------------------------------------------
// # spawn-punkte fuer inf bestimmen: separiert von vec-spawnpos-suche, da unterschiedliche distanzen
private _liste_spawnpos_inf = []; // <--- uebergabe-var
private _dist = (_spieler_param select 3) + (_spieler_param select 12) - (_DEF_dist_toleranz/2);
private _pos_rel = [];
private _wasser_gefunden = false;
private _pos_im_wald = false;
private _gebaeude = [];
private _positionen_innerhalb_haus = [];
private _pos = [];
for "_i" from 0 to 360 step 2 do {
  _pos_rel = _fahne getRelPos [_dist + (random _DEF_dist_toleranz), _i];
  if ((!(surfaceiswater _pos_rel)) && {(_pos_rel distance eo_obj_spcfg_mission) > (_spieler_param select 12)}) then {
    _wasser_gefunden = [_pos_rel,position _fahne] call fnc_a_sys_wasser_zwischen_a_und_b;
    if (!_wasser_gefunden) then {
      _pos_im_wald = [_pos_rel] call fnc_s_sys_pos_im_wald;
      if (_pos_im_wald) then {
        _liste_spawnpos_inf pushback _pos_rel;
      } else {
        _gebaeude = [_pos_rel,50,_DEF_min_anz_geb_positionen_inf_spawn] call fnc_a_sys_gebaeudeauswahl;
        if ((count _gebaeude) > 0) then {
          _positionen_innerhalb_haus = [selectrandom _gebaeude] call fnc_a_sys_positionen_innerhalb_haus;
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
if ((count _liste_spawnpos_inf) < (_spieler_param select 6)) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Zu wenig Infanterie-Spawnpunkte. Neugenerierung wird ausgeloest!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [_this,_erstellte_objekte,_erstellte_marker] call fnc_s_missionsgenerierung_wiederholen;
};

//--------------------------------------------------------------------------------------------
// # spawn-punkte fuer vec bestimmen
private _liste_spawnstrassen_vec = [];
private _strasse = objnull;
private _strassen_brauchbar = [];
_dist = ((_loc_params select 2) select 1) - (_DEF_dist_toleranz_vec/2);
for "_i" from 0 to 360 step 2 do {
  _pos_rel = _fahne getRelPos [_dist + (random _DEF_dist_toleranz_vec), _i];
  _wasser_gefunden = [_pos_rel,position _fahne] call fnc_a_sys_wasser_zwischen_a_und_b;
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
  };//(!_wasser_gefunden)
};
if ((count _liste_spawnstrassen_vec) < (_spieler_param select 5)) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Zu wenig Fahrzeug-Spawnpunkte. Neugenerierung wird ausgeloest!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [_this,_erstellte_objekte,_erstellte_marker] call fnc_s_missionsgenerierung_wiederholen;
};
//systemchat format ["%1: Spawnpunkt ermittelt...",s_mission_params_vert select 1];



// # moerserposition finden
for "_i" from 0 to 360 step 1 do {
  //_pos_rel = _fahne getRelPos [s_vert_dist_moerser, _i];
  _strassen = (_fahne getRelPos [s_vert_dist_moerser, _i]) nearRoads 50;
  if ((count _strassen) > 0) exitwith {s_vert_moerser_pos = position(selectrandom _strassen)};
};
if ((count s_vert_moerser_pos) == 0) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Keine Moerser-Position gefunden. Neugenerierung wird ausgeloest!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [_this,_erstellte_objekte,_erstellte_marker] call fnc_s_missionsgenerierung_wiederholen;
};

// # dedicated: markieren
if (!isdedicated) then {
  createMarker ["m_vert_moerserposition", s_vert_moerser_pos];
  "m_vert_moerserposition" setMarkerType "mil_dot";
  "m_vert_moerserposition" setmarkertext "moerser";
  _erstellte_marker pushback "m_vert_moerserposition";
};





//--------------------------------------------------------------------------------------------

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


//--------------------------------------------------------------------------------------------





_core_params = [
  _loc_params,
  _erstellte_objekte,
  _erstellte_marker,
  _liste_spawnpos_inf,
  _liste_spawnstrassen_vec,
  _fahne,
  _vert_p_spawnabstaende
];


_core_params execvm (format["%1s_mission_core.sqf",s_mission_params select 2]);

/*
  a_js_spieler_startet_neu
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
#define _DEF_min_anz_geb_positionen 5
#define _DEF_dist_spielerfrei 50
#define _DEF_maerker_area_groesse 40

params ["_anfuehrer","_bsp_startpos","_neuspawndist"];

titleText ["....spieleinstieg wird erstellt....", "BLACK FADED", -1, true, true];

private _spawnpos = _bsp_startpos;
private _pos_anfuehrer = position _anfuehrer;
if ((_pos_anfuehrer distance _bsp_startpos) > _neuspawndist) then {_spawnpos = []};

private _moegleiche_spawnpositionen = [];
private _positionen_innerhalb_haus = [];
private _gebaeude = objnull;
private _wasser_gefunden = false;
private _dist = _neuspawndist;
private _pos_rel = [];
private _zeitstempel = time;
private _spieler_muss_gerettet_werden = false;

while {(count _spawnpos) == 0} do {
  titleText [format["....spawnposition wird gesucht (%1)....",floor(time - _zeitstempel)], "BLACK FADED", -1, true, true];
  for "_i" from 0 to 360 step 2 do {
    _pos_rel = _anfuehrer getRelPos [_dist, _i];
    if ((!(surfaceiswater _pos_rel)) && {(count(playableunits inareaarray [_pos_rel,_DEF_dist_spielerfrei,_DEF_dist_spielerfrei,0,false])) == 0})then {
      _wasser_gefunden = [_pos_rel,_pos_anfuehrer] call fnc_a_sys_wasser_zwischen_a_und_b;
      if (!_wasser_gefunden) then {
        _gebaeude = [_pos_rel,_DEF_dist_spielerfrei,_DEF_min_anz_geb_positionen] call fnc_a_sys_gebaeudeauswahl;
        if ((count _gebaeude) > 0) then {
          _positionen_innerhalb_haus = [selectrandom _gebaeude] call fnc_a_sys_positionen_innerhalb_haus;
          if ((count _positionen_innerhalb_haus) > 0) then {
            _moegleiche_spawnpositionen pushback (selectrandom _positionen_innerhalb_haus);
          };//((count _positionen_innerhalb_haus) > 0)
        };//((count _gebaeude) > 0)
      };//(!_wasser_gefunden)
    };//!(surfaceiswater
  };//for "_i"
  if ((count _moegleiche_spawnpositionen) > 0) then {
    _spawnpos = selectrandom _moegleiche_spawnpositionen;
    _spieler_muss_gerettet_werden = true;
  } else {
    _dist = _dist + _DEF_dist_spielerfrei;
  };
  uisleep 0.3;
};

private _letzte_position = position player;
[player, agltoasl _spawnpos] remoteexec ["setposasl",2];


if (!_spieler_muss_gerettet_werden) exitwith {titleText ["....bereit....", "BLACK IN", -1, true, true]};

_zeitstempel = time;
titleText [format["....auf rettung warten (%1)....",floor(time - _zeitstempel)], "BLACK FADED", -1, true, true];

while {(player distance _letzte_position) <10} do {uisleep 1; titleText [format["....auf rettung warten (%1)....",floor(time - _zeitstempel)], "BLACK FADED", -1, true, true]};

private _marker_area = createMarker [format["m_js_%1_area",netid player], player getRelPos [random(_DEF_maerker_area_groesse/1.5), random 360]];
_marker_area  setMarkerShape "ELLIPSE";
_marker_area setMarkerColor "ColorYellow";
_marker_area setmarkeralpha 0.5;
_marker_area setMarkerSize [_DEF_maerker_area_groesse, _DEF_maerker_area_groesse];

private _marker_icon = createMarker [format["m_js_%1_icon",netid player], getmarkerpos _marker_area];
_marker_icon setMarkerType "mil_dot";
_marker_icon setMarkerColor "ColorBlue";
_marker_icon setMarkertext (name player);


private _spieler_in_naehe = [];
while {(count _spieler_in_naehe) < 2} do {
  titleText [format["....auf rettung warten (%1)....",floor(time - _zeitstempel)], "BLACK FADED", -1, true, true];
  _spieler_in_naehe = (playableunits inareaarray [getposatl player,3,3,0,false,3]) select {alive _x};
  uisleep 0.3;
};


titleText ["....gerettet....", "BLACK IN", -1, true, true];


deletemarker _marker_area;
deletemarker _marker_icon;

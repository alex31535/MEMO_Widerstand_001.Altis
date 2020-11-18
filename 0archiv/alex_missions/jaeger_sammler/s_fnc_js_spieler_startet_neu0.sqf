/*
  s_fnc_js_spieler_startet_neu
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
params ["_spieler"];
[["....spieleinstieg wird erstellt....", "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];
_spieler setposworld (selectrandom s_js_erststartpositionen);
private _pos_anfuehrer = position (objectfromnetid s_js_anfuehrer_netid);
[
  [
    objectfromnetid s_js_anfuehrer_netid,
    s_js_erststartpositionen select 0,
    s_js_neuspawndist
  ],
  "alex_missions\jaeger_sammler\a_js_spieler_startet_neu.sqf"] remoteexec ["execvm",_spieler];




if (true) exitwith {};






//##########################################################################################################################################################

//_x setvariable ["im_spiel_js",true];
//s_js_dist_ausserhalb_gruppe
//s_js_erststartpositionen
//s_js_anfuehrer_uid
//s_js_anfuehrer_netid
#define _DEF_min_anz_geb_positionen 5
#define _DEF_dist_spielerfrei 50
#define _DEF_maerker_area_groesse 80
params ["_spieler"];
[["....spieleinstieg wird erstellt....", "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];
//-------------------------------------------------------------
private _spawnpos = selectrandom s_js_erststartpositionen;
if ((_pos_anfuehrer distance (s_js_erststartpositionen select 0)) > s_js_neuspawndist)) then {_spawnpos = []};
//_spieler setposworld (selectrandom s_js_erststartpositionen);
//if (s_js_anfuehrer_uid == (getplayeruid _spieler)) exitwith {_spieler setposworld (selectrandom s_js_erststartpositionen)};
//if ((_pos_anfuehrer distance (s_js_erststartpositionen select 0)) < s_js_dist_ausserhalb_gruppe)) exitwith {_spieler setposworld (selectrandom s_js_erststartpositionen)};
private _anfuehrer = objectfromnetid s_js_anfuehrer_netid;
private _pos_anfuehrer = position (objectfromnetid s_js_anfuehrer_netid);
private _moegleiche_spawnpositionen = [];
private _positionen_innerhalb_haus = [];
private _gebaeude = objnull;
private _wasser_gefunden = false;
private _dist = [];
private _pos_rel = [];
private _zeitstempel = time;
private _spiele_muss_gerettet_werden = false;
while {(count _spawnpos) == 0} do {
  [[format["....spawnposition wird gesucht (%1)....",floor(time - _zeitstempel)], "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];
  for "_i" from 0 to 360 step 2 do {
    _pos_rel = _anfuehrer getRelPos [_dist, _i];
    if (!(surfaceiswater _pos_rel)) then {
      _wasser_gefunden = [_pos_rel,position _anfuehrer] call fnc_a_sys_wasser_zwischen_a_und_b;
      if ((!_wasser_gefunden) && {(count(playableunits inareaarray [_pos_rel,_DEF_dist_spielerfrei,_DEF_dist_spielerfrei,0,false])) == 0}) then {
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
    _spiele_muss_gerettet_werden = true;
  } else {
    _dist = _dist + _DEF_dist_spielerfrei;
  };
  uisleep 0.3;
};

_spieler setposasl (agltoasl _spawnpos);

if (!_spiele_muss_gerettet_werden) exitwith {[["....bereit....", "BLACK IN", 2, true, true]] remoteexec ["titleText",_spieler]}

_zeitstempel = time;
[[format["....auf rettung warten (%1)....",floor(time - _zeitstempel)], "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];




private _marker_area = createMarker [format["m_js_%1_area",netid _spieler], _spieler getRelPos [random(_DEF_maerker_area_groesse/1.5), random 360]];
_marker_area  setMarkerShape "ELLIPSE";
_marker_area setMarkerColor "ColorYellow";
_marker_area setmarkeralpha 0.5;
_marker_area setMarkerSize [_DEF_maerker_area_groesse, _DEF_maerker_area_groesse];

private _marker_icon = createMarker [format["m_js_%1_icon",netid _spieler], getmarkerpos _marker_area];
_marker_icon setMarkerType "mil_dot";
_marker_icon setMarkerColor "ColorBlue";
_marker_icon setMarkertext (name _spieler);


private _spieler_in_naehe = [];
while {(count _spieler_in_naehe) == 0} do {
  [[format["....auf rettung warten (%1)....",floor(time - _zeitstempel)], "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];
  _spieler_in_naehe = (playableunits inareaarray [getposatl _spieler,3,3,0,false,3]) select {alive _x};
  uisleep 0.3;
};


[["....gerettet!....", "BLACK IN", 2, true, true]] remoteexec ["titleText",_spieler]

deletemarker _marker_area;
deletemarker _marker_icon;





//-------------------------------------------------------------

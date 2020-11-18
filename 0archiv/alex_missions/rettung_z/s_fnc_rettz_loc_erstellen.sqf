/*
  s_fnc_rettz_loc_erstellen
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

#define _DEF_min_anz_geb_positionen_zombie_spawn 2

params ["_liste_hauspos"];
private _pos_im_haus = _liste_hauspos select 0;
_liste_hauspos deleteat 0;

private _zivilist = [_pos_im_haus,[s_units_aus_cfg_1 select 0]] call fnc_s_sys_spawn_unit;
_zivilist setunitloadout "CUP_C_C_Assistant_01";
_zivilist disableAI "MOVE";
_zivilist disableAI "TARGET";
_zivilist disableAI "AUTOTARGET";
_zivilist disableAI "COVER";
_zivilist disableAI "AUTOCOMBAT";
_zivilist disableAI "AIMINGERROR";
_zivilist setSpeaker "NoVoice";
_zivilist setdir (random 360);
_zivilist allowfleeing 0;
_zivilist setcaptive true;

private _pos_rel = [];
private _wasser_gefunden = false;
private _pos_im_wald = false;
private _spawnpositionen_z = [];
private _gebaeudeliste = [];
private _positionen_innerhalb_haus = [];
private _pos = [];
for "_i" from 0 to 360 step 2 do {
  _pos_rel = _zivilist getRelPos [s_rettz_spawn_dist, _i];
  if ((!(surfaceiswater _pos_rel)) && {(_pos_rel distance (s_sys_area_hq select 0)) > (s_sys_area_hq select 1)}) then {
    _wasser_gefunden = [_pos_rel,position _zivilist] call fnc_a_sys_wasser_zwischen_a_und_b;
    if (!_wasser_gefunden) then {
      _pos_im_wald = [_pos_rel] call fnc_s_sys_pos_im_wald;
      if (_pos_im_wald) then {
        _spawnpositionen_z pushback _pos_rel;
      } else {
        _gebaeudeliste = [_pos_rel,50,_DEF_min_anz_geb_positionen_zombie_spawn] call fnc_a_sys_gebaeudeauswahl;
        if ((count _gebaeudeliste) > 0) then {
          _positionen_innerhalb_haus = [selectrandom _gebaeudeliste] call fnc_a_sys_positionen_innerhalb_haus;
          if ((count _positionen_innerhalb_haus) > 0) then {
            _pos = selectrandom _positionen_innerhalb_haus;
            {if (((count _pos) > 0) && {(_pos distance _x) < 50}) then {_pos = []}} foreach _spawnpositionen_z;
            if ((count _pos) > 0) then {_spawnpositionen_z pushback _pos};
          };//((count _positionen_innerhalb_haus) > 0)
        };//((count _gebaeude) > 0)
      };//(_pos_im_wald)
    };//(!_wasser_gefunden)
  };//!(surfaceiswater
};//for "_i"


[_zivilist,_spawnpositionen_z,_liste_hauspos]

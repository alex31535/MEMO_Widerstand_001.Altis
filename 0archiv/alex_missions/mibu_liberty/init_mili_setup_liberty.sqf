/*
  init_mili_setup_liberty_altis.sqf
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

/* 0: schiffsobjekt [klasse, pos, dir]*/
eo_liberty = (s_mili_p_liberty select 0) createVehicle [0,0,0];
eo_liberty setposworld (s_mili_p_liberty select 1);
eo_liberty setdir (s_mili_p_liberty select 2);

//[[eo_liberty,"Land_Destroyer_01_hull_04_F"] call BIS_fnc_Destroyer01GetShipPart,1,true] call BIS_fnc_Destroyer01AnimateHangarDoors;



/* 0.1: heli, flugdeck [klasse, pos, dir]*/
s_mili_liberty_heli = (s_mili_p_heli select 0) createVehicle [0,0,0];
s_mili_liberty_heli allowdammage false;
s_mili_liberty_heli setdir (s_mili_p_heli select 2);
s_mili_liberty_heli setposworld (s_mili_p_heli select 1);
s_mili_liberty_heli lock 3;
//lockcargo findet weiter unten bei der geisel-erstellung statt !


/* 1: debugpos an bord: [pos, dir] */
//player setposworld s_mili_p_debugpos;
//player allowdammage false;
//player setcaptive true;

/* 2: waffen [[klasse,pos, dir],...] WAFFENOBJEKTE */
private _params = []; {_params pushback _x} foreach s_mili_p_waffen;
private _waffe = objnull;
{
  _waffe = (_x select 0) createVehicle [0,0,0];
  _waffe setposworld (_x select 1);
  _waffe setdir (_x select 2);
  s_mili_waffenliste pushback _waffe;
} foreach _params;


/* 2: waffen [[klasse,pos, dir],...] WAFFENBESATZUNG */
private _waffeliste_temp = []; {_waffeliste_temp pushback _x} foreach s_mili_waffenliste;
private _anz = ceil(((count _waffeliste_temp)/100) * (s_mili_besetzung select 2));
private _index = -1;
private _unit = objnull;
s_mili_liste_ki = [];
for "_i" from 1 to _anz do {
  _index = floor(random(count _waffeliste_temp));
  _waffe = _waffeliste_temp select _index;
  _unit = (creategroup [s_mili_seite,true]) createUnit [selectrandom s_mili_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _unit assignAsGunner _waffe;
  _unit moveingunner _waffe;
  s_mili_liste_ki pushback _unit;
  if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
  _waffeliste_temp deleteat _index;
  _waffeliste_temp call BIS_fnc_arrayShuffle;
};




/* 3: kisten/deko [[pos, dir],...] */
private _params = []; {_params pushback _x} foreach s_mili_p_deko;
private _obj_deko = objnull;
_anz = ceil(((count _params) /100) * (s_mili_besetzung select 3));
for "_i" from 1 to _anz do {
  _obj_deko = createSimpleObject [(selectrandom s_mili_deko), [0,0,0]];
  _index = floor(random(count _params));
  _obj_deko setdir (random 360);
  _obj_deko setposworld (_params select _index);
  _params deleteat _index;
  s_mili_liste_dekoobjekte pushback _obj_deko;
  _params call BIS_fnc_arrayShuffle;
};

/* 4: ki-pos flugdeck [[pos, dir],...] */
private _params = []; {_params pushback _x} foreach s_mili_p_ki_flugdeck;
_anz = ceil(((count _params) /100) * (s_mili_besetzung select 4));
for "_i" from 0 to _anz do {
  _unit = (creategroup [s_mili_seite,true]) createUnit [selectrandom s_mili_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _params));
  _unit allowFleeing 0;
  _unit setposworld ((_params select _index) select 0);
  _unit setFormDir ((_params select _index) select 1);
  [_unit,"bandit"] call fnc_s_sys_unit_konfig_loadout;
  [_unit,selectrandom s_mili_waffensets_angreifer,[]] call fnc_s_sys_unit_konfig_waffenset;
  _params deleteat _index;
  s_mili_liste_ki pushback _unit;
  if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
  _params call BIS_fnc_arrayShuffle;
};

/* 5: ki-pos gang [[pos, dir],...] */
private _params = []; {_params pushback _x} foreach s_mili_p_ki_gang;
_anz = ceil(((count _params) /100) * (s_mili_besetzung select 5));
for "_i" from 0 to _anz do {
  _unit = (creategroup [s_mili_seite,true]) createUnit [selectrandom s_mili_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _params));
  _unit allowFleeing 0;
  _unit setposworld ((_params select _index) select 0);
  _unit setFormDir ((_params select _index) select 1);
  [_unit,"bandit"] call fnc_s_sys_unit_konfig_loadout;
  [_unit,selectrandom s_mili_waffensets_angreifer,[]] call fnc_s_sys_unit_konfig_waffenset;
  _params deleteat _index;
  s_mili_liste_ki pushback _unit;
  if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
  _params call BIS_fnc_arrayShuffle;
};

/* 6: ki-pos bruecke [[pos, dir],...] */
private _params = []; {_params pushback _x} foreach s_mili_p_ki_bruecke;
_anz = ceil(((count _params) /100) * (s_mili_besetzung select 6));
for "_i" from 0 to _anz do {
  _unit = (creategroup [s_mili_seite,true]) createUnit [selectrandom s_mili_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _params));
  _unit allowFleeing 0;
  _unit setposworld ((_params select _index) select 0);
  _unit setFormDir ((_params select _index) select 1);
  [_unit,"bandit"] call fnc_s_sys_unit_konfig_loadout;
  [_unit,selectrandom s_mili_waffensets_angreifer,[]] call fnc_s_sys_unit_konfig_waffenset;
  _params deleteat _index;
  s_mili_liste_ki pushback _unit;
  if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
  _params call BIS_fnc_arrayShuffle;
  if (isnull s_mili_waffenoffizier) then {
    s_mili_waffenoffizier = _unit;
    s_mili_waffenoffizier addMPEventHandler ["MPKilled",{
      {deletevehicle (assignedGunner _x)} foreach s_mili_waffenliste;
      {[["<t color='#119c28' size='2'>Der Waffenoffizier wurde getoetet - Die Waffensysteme der Liberty sind nun deaktiviert!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
    }];
  };
};




/* 7: ki-pos bootsdeck [[pos, dir],...] */
private _params = []; {_params pushback _x} foreach s_mili_p_ki_bootsdeck;
_anz = ceil(((count _params) /100) * (s_mili_besetzung select 7));
for "_i" from 0 to _anz do {
  _unit = (creategroup [s_mili_seite,true]) createUnit [selectrandom s_mili_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _params));
  _unit allowFleeing 0;
  _unit setposworld ((_params select _index) select 0);
  _unit setFormDir ((_params select _index) select 1);
  [_unit,"bandit"] call fnc_s_sys_unit_konfig_loadout;
  [_unit,selectrandom s_mili_waffensets_angreifer,[]] call fnc_s_sys_unit_konfig_waffenset;
  _params deleteat _index;
  s_mili_liste_ki pushback _unit;
  if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
  _params call BIS_fnc_arrayShuffle;
};

/* 8: ki-pos bug [[pos, dir],...] */
private _params = []; {_params pushback _x} foreach s_mili_p_ki_bug;
_anz = ceil(((count _params) /100) * (s_mili_besetzung select 8));
for "_i" from 0 to _anz do {
  _unit = (creategroup [s_mili_seite,true]) createUnit [selectrandom s_mili_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _params));
  _unit allowFleeing 0;
  _unit setposworld ((_params select _index) select 0);
  _unit setFormDir ((_params select _index) select 1);
  [_unit,"bandit"] call fnc_s_sys_unit_konfig_loadout;
  [_unit,selectrandom s_mili_waffensets_angreifer,[]] call fnc_s_sys_unit_konfig_waffenset;
  _params deleteat _index;
  s_mili_liste_ki pushback _unit;
  if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
  _params call BIS_fnc_arrayShuffle;
};

/* 9: ki-pos hangar [[pos, dir],...] */
private _params = []; {_params pushback _x} foreach s_mili_p_ki_hangar;
_anz = ceil(((count _params) /100) * (s_mili_besetzung select 9));
for "_i" from 0 to _anz do {
  _unit = (creategroup [s_mili_seite,true]) createUnit [selectrandom s_mili_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _params));
  _unit allowFleeing 0;
  _unit setposworld ((_params select _index) select 0);
  _unit setFormDir ((_params select _index) select 1);
  [_unit,"bandit"] call fnc_s_sys_unit_konfig_loadout;
  [_unit,selectrandom s_mili_waffensets_angreifer,[]] call fnc_s_sys_unit_konfig_waffenset;
  _params deleteat _index;
  s_mili_liste_ki pushback _unit;
  if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
  _params call BIS_fnc_arrayShuffle;
};

{s_mili_liste_geiselnehmer pushback _x} foreach s_mili_liste_ki;

/* 10: ki-pos taucher [[pos, dir],...] */
private _params = []; {_params pushback _x} foreach s_mili_p_ki_taucher;
_anz = ceil(((count _params) /100) * (s_mili_besetzung select 10));
for "_i" from 0 to _anz do {
  _unit = (creategroup [s_mili_seite,true]) createUnit [selectrandom s_mili_ki_klassen_taucher, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _params));
  _unit allowFleeing 0;
  _unit setposworld (_params select _index);
  _unit setFormDir (random 360);
  _params deleteat _index;
  s_mili_liste_ki pushback _unit;
  if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
  _params call BIS_fnc_arrayShuffle;
};

/* 11: ki-pos geisel [[pos, dir],...] */
private _params = []; {_params pushback _x} foreach s_mili_p_ki_geiseln;
for "_i" from 1 to (count(fullCrew [s_mili_liberty_heli, "cargo", true])) do {
  _index = floor(random(count _params));
  _unit = (creategroup [civilian,true]) createUnit [selectrandom s_mili_ki_klassen_geisel, [0,0,0], [], 0, "CAN_COLLIDE"];
  _unit allowFleeing 0;
  _unit setposworld ((_params select _index) select 0);
  _unit disableAI "MOVE";
  //_unit setFormDir ((_params select _index) select 1);
  _unit setdir (random 360);
  [_unit,"geisel"] call fnc_s_sys_unit_konfig_loadout;
  s_mili_liste_geiseln pushback _unit;
  _params call BIS_fnc_arrayShuffle;
};
s_mili_liste_ki append s_mili_liste_geiseln;



s_mili_marker = createMarker ["m_mili", position eo_liberty];
s_mili_marker setMarkerShape "ICON";
s_mili_marker setmarkertype "b_naval";
s_mili_marker setMarkerText "USS Liberty";

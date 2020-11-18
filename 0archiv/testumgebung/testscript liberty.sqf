s_liberty_params = [
/* 0: schiffsobjekt [klasse, pos, dir]*/
/* 1: debugpos an bord: [pos, dir] */
/* 2: waffen [[klasse,pos, dir],...] */
/* 3: kisten/deko [[pos, dir],...] */
/* 4: ki-pos flugdeck [[pos, dir],...] */
/* 5: ki-pos gang [[pos, dir],...] */
/* 6: ki-pos bruecke [[pos, dir],...] */
/* 7: ki-pos bootsdeck [[pos, dir],...] */
/* 8: ki-pos bug [[pos, dir],...] */
/* 9: ki-pos hangar [[pos, dir],...] */
/* 10: ki-pos taucher [[pos, dir],...] */
/* 11: ki-pos geisel [[pos, dir],...] */
/* 12: pos fluchtpunkt [pos] */
];
s_liberty_besetzung = [ /* in prozent */
/* 0: schiffsobjekt [klasse, pos, dir]*/ -1,
/* 1: debugpos an bord: [pos, dir] */ -1,
/* 2: waffen [[klasse,pos, dir],...] */ 100,
/* 3: kisten/deko [[pos, dir],...] */ 40,
/* 4: ki-pos flugdeck [[pos, dir],...] */ 100,
/* 5: ki-pos gang [[pos, dir],...] */ 40,
/* 6: ki-pos bruecke [[pos, dir],...] */ 25,
/* 7: ki-pos bootsdeck [[pos, dir],...] */ 30,
/* 8: ki-pos bug [[pos, dir],...] */ 50,
/* 9: ki-pos hangar [[pos, dir],...] */ 25,
/* 10: ki-pos taucher [[pos, dir],...] */ 50,
/* 11: ki-pos geisel [[pos, dir],...] */ 75,
/* 12: pos fluchtpunkt [pos] */ -1
];
s_liberty_deko = [
"Land_Pallet_MilBoxes_F",
"Land_PaperBox_open_full_F",
"Land_PaperBox_open_empty_F",
"Land_PaperBox_closed_F"
];
s_liberty_ki_klassen = [
  "B_Soldier_F"
];
s_liberty_ki_klassen_taucher = [
  "O_Diver_F"
];

s_liberty_ki_klassen_geisel = ["B_Survivor_F"];

s_liberty_waffenliste = [];


private _seite = WEST;


/* 0: schiffsobjekt [klasse, pos, dir]*/
s_liberty_params pushback [typeof eo_liberty,getposworld eo_liberty, getdir eo_liberty]; deletevehicle eo_liberty;

/* 1: debugpos an bord: [pos, dir] */
s_liberty_params pushback [getposworld eo_liberty_debug_pos, getdir eo_liberty_debug_pos]; deletevehicle eo_liberty_debug_pos;

/* 2: waffen [[klasse,pos, dir],...] */
private _sammlung = [];
private _obj = objnull;
for "_i" from 1 to 10 do {
  call compile format["_obj = if (isnil ""eo_liberty_waffe_%1"") then [{objnull},{eo_liberty_waffe_%1}];",_i];
  if (!isnull _obj) then {
    _sammlung pushback [typeof _obj, getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};
s_liberty_params pushback _sammlung;
copytoclipboard (str ["kisten/deko",_sammlung]);



/* 3: kisten/deko [[pos, dir],...] */
_sammlung = [];
_obj = objnull;
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_kiste_%1"") then [{objnull},{eo_liberty_kiste_%1}];",_i];
  if (!isnull _obj) then {
    _sammlung pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};
s_liberty_params pushback _sammlung;


/* 4: ki-pos flugdeck [[pos, dir],...] */
_sammlung = [];
_obj = objnull;
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_flugdeck_%1"") then [{objnull},{eo_liberty_ki_flugdeck_%1}];",_i];
  if (!isnull _obj) then {
    _sammlung pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};
s_liberty_params pushback _sammlung;


/* 5: ki-pos gang [[pos, dir],...] */
_sammlung = [];
_obj = objnull;
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_gang_%1"") then [{objnull},{eo_liberty_ki_gang_%1}];",_i];
  if (!isnull _obj) then {
    _sammlung pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};
s_liberty_params pushback _sammlung;


/* 6: ki-pos bruecke [[pos, dir],...] */
_sammlung = [];
_obj = objnull;
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_bruecke_%1"") then [{objnull},{eo_liberty_ki_bruecke_%1}];",_i];
  if (!isnull _obj) then {
    _sammlung pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};
s_liberty_params pushback _sammlung;


/* 7: ki-pos bootsdeck [[pos, dir],...] */
_sammlung = [];
_obj = objnull;
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_bootsdeck_%1"") then [{objnull},{eo_liberty_ki_bootsdeck_%1}];",_i];
  if (!isnull _obj) then {
    _sammlung pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};
s_liberty_params pushback _sammlung;



/* 8: ki-pos bug [[pos, dir],...] */
_sammlung = [];
_obj = objnull;
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_bug_%1"") then [{objnull},{eo_liberty_ki_bug_%1}];",_i];
  if (!isnull _obj) then {
    _sammlung pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};
s_liberty_params pushback _sammlung;


/* 9: ki-pos hangar [[pos, dir],...] */
_sammlung = [];
_obj = objnull;
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_hangar_%1"") then [{objnull},{eo_liberty_ki_hangar_%1}];",_i];
  if (!isnull _obj) then {
    _sammlung pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};
s_liberty_params pushback _sammlung;



/* 10: ki-pos taucher [[pos, dir],...] */
_sammlung = [];
_obj = objnull;
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_taucher_%1"") then [{objnull},{eo_liberty_ki_taucher_%1}];",_i];
  if (!isnull _obj) then {
    _sammlung pushback [getposworld _obj, random 360]; deletevehicle _obj;
  };
};
s_liberty_params pushback _sammlung;




/* 11: ki-pos geisel [[pos, dir],...] */
_sammlung = [];
_obj = objnull;
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_geisel_%1"") then [{objnull},{eo_liberty_ki_geisel_%1}];",_i];
  if (!isnull _obj) then {
    _sammlung pushback [getposworld _obj, random 360]; deletevehicle _obj;
  };
};
s_liberty_params pushback _sammlung;



/* 12: pos fluchtpunkt [pos] */
s_liberty_params pushback (getposworld eo_liberty_pos_flucht); deletevehicle eo_liberty_pos_flucht;



if (true) exitwith {};
// -------------------
uisleep 5;





private _liberty = ((s_liberty_params select 0) select 0) createVehicle [0,0,0];
_liberty setdir ((s_liberty_params select 0) select 2);
_liberty setposworld ((s_liberty_params select 0) select 1);


player setposworld ((s_liberty_params select 1) select 0);





/* 2: waffen [[klasse,pos, dir],...]*/
private _waffe = objnull;

private _liste_ki_in_waffen = [];
{
  _waffe = (_x select 0) createVehicle [0,0,0];
  _waffe setposworld (_x select 1);
  _waffe setdir (_x select 2);
  s_liberty_waffenliste pushback _waffe;
} foreach (s_liberty_params select 2);
private _waffeliste_temp = [];
{_waffeliste_temp pushback _x} foreach s_liberty_waffenliste;
private _anz = ceil(((count _waffeliste_temp)/100) * (s_liberty_besetzung select 2));
systemchat format["waffen: %1, anz: %2",count _waffeliste_temp, _anz];
private _index = -1;
for "_i" from 1 to _anz do {
  _index = floor(random(count _waffeliste_temp));
  _waffe = _waffeliste_temp select _index;
  systemchat format["waffe: %1",typeof _waffe]; sleep 1;
  _unit = (creategroup [_seite,true]) createUnit [selectrandom s_liberty_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _unit assignAsGunner _waffe;
  _unit moveingunner _waffe;
  _liste_ki_in_waffen pushback _unit;
  _waffeliste_temp deleteat _index;
  _waffeliste_temp call BIS_fnc_arrayShuffle;
};



/* 3: kisten/deko [[pos, dir],...] */
private _liste_aus_params = s_liberty_params select 3;
private _liste_dekoobjekte = [];
_anz = ceil(((count _liste_aus_params) /100) * (s_liberty_besetzung select 3));
private _obj_deko = objnull;
for "_i" from 1 to _anz do {
  _obj_deko = (selectrandom s_liberty_deko) createVehicle [0,0,0];
  _index = floor(random(count _liste_aus_params));
  _obj_deko setdir (90);
  _obj_deko setposworld ((_liste_aus_params select _index) select 0);
  _liste_aus_params deleteat _index;
  _liste_dekoobjekte pushback _obj_deko;
  _liste_aus_params call BIS_fnc_arrayShuffle;
};



/* 4: ki-pos flugdeck [[pos, dir],...] */
_liste_aus_params = s_liberty_params select 4;
private _liste_ki = [];
private _unit = objnull;
_anz = ceil(((count _liste_aus_params) /100) * (s_liberty_besetzung select 4));
for "_i" from 0 to _anz do {
  _unit = (creategroup [_seite,true]) createUnit [selectrandom s_liberty_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _liste_aus_params));
  _unit allowFleeing 0;
  _unit setposworld ((_liste_aus_params select _index) select 0);
  _unit setFormDir ((_liste_aus_params select _index) select 1);
  _liste_aus_params deleteat _index;
  _liste_ki pushback _unit;
  _liste_aus_params call BIS_fnc_arrayShuffle;
};


/* 5: ki-pos gang [[pos, dir],...] */
_liste_aus_params = s_liberty_params select 5;
_anz = ceil(((count _liste_aus_params) /100) * (s_liberty_besetzung select 5));
for "_i" from 0 to _anz do {
  _unit = (creategroup [_seite,true]) createUnit [selectrandom s_liberty_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _liste_aus_params));
  _unit allowFleeing 0;
  _unit setposworld ((_liste_aus_params select _index) select 0);
  _unit setFormDir ((_liste_aus_params select _index) select 1);
  _liste_aus_params deleteat _index;
  _liste_ki pushback _unit;
  _liste_aus_params call BIS_fnc_arrayShuffle;
};


/* 6: ki-pos bruecke [[pos, dir],...] */
private _liste_ki_bruecke = [];
_liste_aus_params = s_liberty_params select 6;
_anz = ceil(((count _liste_aus_params) /100) * (s_liberty_besetzung select 6));
for "_i" from 0 to _anz do {
  _unit = (creategroup [_seite,true]) createUnit [selectrandom s_liberty_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _liste_aus_params));
  _unit allowFleeing 0;
  _unit setposworld ((_liste_aus_params select _index) select 0);
  _unit setFormDir ((_liste_aus_params select _index) select 1);
  _liste_aus_params deleteat _index;
  _liste_ki_bruecke pushback _unit;
  _liste_aus_params call BIS_fnc_arrayShuffle;
};
_liste_ki append _liste_ki_bruecke;


private _mpindex_waffenoffizier = (selectrandom _liste_ki_bruecke) addMPEventHandler ["MPKilled",{
  {deletevehicle (assignedGunner _x)} foreach s_liberty_waffenliste;
  {[["<t color='#119c28' size='2'>Der Waffenoffizier der Liberty wurde getoetet!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
}];




/* 7: ki-pos bootsdeck [[pos, dir],...] */
_liste_aus_params = s_liberty_params select 7;
_anz = ceil(((count _liste_aus_params) /100) * (s_liberty_besetzung select 7));
for "_i" from 0 to _anz do {
  _unit = (creategroup [_seite,true]) createUnit [selectrandom s_liberty_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _liste_aus_params));
  _unit allowFleeing 0;
  _unit setposworld ((_liste_aus_params select _index) select 0);
  _unit setFormDir ((_liste_aus_params select _index) select 1);
  _liste_aus_params deleteat _index;
  _liste_ki pushback _unit;
  _liste_aus_params call BIS_fnc_arrayShuffle;
};


/* 8: ki-pos bug [[pos, dir],...] */
_liste_aus_params = s_liberty_params select 8;
_anz = ceil(((count _liste_aus_params) /100) * (s_liberty_besetzung select 8));
for "_i" from 0 to _anz do {
  _unit = (creategroup [_seite,true]) createUnit [selectrandom s_liberty_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _liste_aus_params));
  _unit allowFleeing 0;
  _unit setposworld ((_liste_aus_params select _index) select 0);
  _unit setFormDir ((_liste_aus_params select _index) select 1);
  _liste_aus_params deleteat _index;
  _liste_ki pushback _unit;
  _liste_aus_params call BIS_fnc_arrayShuffle;
};



/* 9: ki-pos hangar [[pos, dir],...] */
_liste_aus_params = s_liberty_params select 9;
_anz = ceil(((count _liste_aus_params) /100) * (s_liberty_besetzung select 9));
for "_i" from 0 to _anz do {
  _unit = (creategroup [_seite,true]) createUnit [selectrandom s_liberty_ki_klassen, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _liste_aus_params));
  _unit allowFleeing 0;
  _unit setposworld ((_liste_aus_params select _index) select 0);
  _unit setFormDir ((_liste_aus_params select _index) select 1);
  _liste_aus_params deleteat _index;
  _liste_ki pushback _unit;
  _liste_aus_params call BIS_fnc_arrayShuffle;
};

/* 10: ki-pos taucher [[pos, dir],...] */
_liste_aus_params = s_liberty_params select 10;
_anz = ceil(((count _liste_aus_params) /100) * (s_liberty_besetzung select 10));
for "_i" from 0 to _anz do {
  _unit = (creategroup [_seite,true]) createUnit [selectrandom s_liberty_ki_klassen_taucher, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _liste_aus_params));
  _unit allowFleeing 0;
  _unit setposworld ((_liste_aus_params select _index) select 0);
  _unit setFormDir ((_liste_aus_params select _index) select 1);
  _liste_aus_params deleteat _index;
  _liste_ki pushback _unit;
  _liste_aus_params call BIS_fnc_arrayShuffle;
};


/* 11: ki-pos geisel [[pos, dir],...] */
private _liste_geiseln = [];
_liste_aus_params = s_liberty_params select 11;
_anz = ceil(((count _liste_aus_params) /100) * (s_liberty_besetzung select 11));
for "_i" from 0 to _anz do {
  _unit = (creategroup [civilian,true]) createUnit [selectrandom s_liberty_ki_klassen_geisel, [0,0,0], [], 0, "CAN_COLLIDE"];
  _index = floor(random(count _liste_aus_params));
  _unit allowFleeing 0;
  _unit setposworld ((_liste_aus_params select _index) select 0);
  _unit setFormDir ((_liste_aus_params select _index) select 1);
  _liste_aus_params deleteat _index;
  _liste_geiseln pushback _unit;
  _liste_aus_params call BIS_fnc_arrayShuffle;
};
_liste_ki append _liste_geiseln;




systemchat format["testscript liberty: units : %1",count _liste_ki];

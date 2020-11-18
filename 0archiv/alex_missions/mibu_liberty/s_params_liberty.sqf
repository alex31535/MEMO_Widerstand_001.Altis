
/*
  s_params_liberty.sqf
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by:
	Parameters:
	Returns:
    s_mili_p_waffen = [];
    s_mili_p_deko = [];
    s_mili_p_ki_flugdeck = [];
    s_mili_p_ki_gang = [];
    s_mili_p_ki_bruecke = [];
    s_mili_p_ki_bootsdeck = [];
    s_mili_p_ki_bug = [];
    s_mili_p_ki_hangar = [];
    s_mili_p_ki_taucher = [];
    s_mili_p_ki_geiseln = [];
    s_mili_p_liberty = [];
  Necessary Globals:
	Necessary functions:
	Example: unnecessary

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
private _obj = objnull;

/* waffen [[klasse,pos, dir],...] */
s_mili_p_waffen = [];
for "_i" from 1 to 10 do {
  call compile format["_obj = if (isnil ""eo_liberty_waffe_%1"") then [{objnull},{eo_liberty_waffe_%1}];",_i];
  if (!isnull _obj) then {
    s_mili_p_waffen pushback [typeof _obj, getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};

/*  kisten/deko [[pos, dir],...] */
s_mili_p_deko = [];
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_kiste_%1"") then [{objnull},{eo_liberty_kiste_%1}];",_i];
  if (!isnull _obj) then {
    s_mili_p_deko pushback (getposworld _obj); /*[getposworld _obj, getdir _obj];*/ deletevehicle _obj;
  };
};

/* ki-pos flugdeck [[pos, dir],...] */
s_mili_p_ki_flugdeck = [];
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_flugdeck_%1"") then [{objnull},{eo_liberty_ki_flugdeck_%1}];",_i];
  if (!isnull _obj) then {
    s_mili_p_ki_flugdeck pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};

/* ki-pos gang [[pos, dir],...] */
s_mili_p_ki_gang = [];
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_gang_%1"") then [{objnull},{eo_liberty_ki_gang_%1}];",_i];
  if (!isnull _obj) then {
    s_mili_p_ki_gang pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};

/* 6: ki-pos bruecke [[pos, dir],...] */
s_mili_p_ki_bruecke = [];
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_bruecke_%1"") then [{objnull},{eo_liberty_ki_bruecke_%1}];",_i];
  if (!isnull _obj) then {
    s_mili_p_ki_bruecke pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};

/* 7: ki-pos bootsdeck [[pos, dir],...] */
s_mili_p_ki_bootsdeck = [];
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_bootsdeck_%1"") then [{objnull},{eo_liberty_ki_bootsdeck_%1}];",_i];
  if (!isnull _obj) then {
    s_mili_p_ki_bootsdeck pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};

/* 8: ki-pos bug [[pos, dir],...] */
s_mili_p_ki_bug = [];
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_bug_%1"") then [{objnull},{eo_liberty_ki_bug_%1}];",_i];
  if (!isnull _obj) then {
    s_mili_p_ki_bug pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};

/* 9: ki-pos hangar [[pos, dir],...] */
s_mili_p_ki_hangar = [];
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_hangar_%1"") then [{objnull},{eo_liberty_ki_hangar_%1}];",_i];
  if (!isnull _obj) then {
    s_mili_p_ki_hangar pushback [getposworld _obj, getdir _obj]; deletevehicle _obj;
  };
};

/* 10: ki-pos taucher [[pos, dir],...] */
s_mili_p_ki_taucher = [];
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_taucher_%1"") then [{objnull},{eo_liberty_ki_taucher_%1}];",_i];
  if (!isnull _obj) then {
    s_mili_p_ki_taucher pushback (getposworld _obj); deletevehicle _obj;
  };
};

/* 11: ki-pos geisel [[pos, dir],...] */
s_mili_p_ki_geiseln = [];
for "_i" from 1 to 100 do {
  call compile format["_obj = if (isnil ""eo_liberty_ki_geisel_%1"") then [{objnull},{eo_liberty_ki_geisel_%1}];",_i];
  if (!isnull _obj) then {
    s_mili_p_ki_geiseln pushback [getposworld _obj, random 360]; deletevehicle _obj;
  };
};

s_mili_p_debugpos = getposworld eo_liberty_debugpos; deletevehicle eo_liberty_debugpos;

s_mili_p_heli = [typeof eo_liberty_heli,getposworld eo_liberty_heli, getdir eo_liberty_heli]; deletevehicle eo_liberty_heli;

s_mili_p_liberty = [typeof eo_liberty,getposworld eo_liberty, getdir eo_liberty]; deletevehicle eo_liberty;

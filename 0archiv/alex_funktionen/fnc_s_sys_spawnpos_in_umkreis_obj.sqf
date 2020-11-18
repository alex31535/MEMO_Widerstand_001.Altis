/*
  fnc_s_sys_spawnpos_in_umkreis_obj.sqf
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
#define _DEF_pos_im_haus_min 3
params ["_obj","_dist_min","_dist_max","_area_pos_nogo","_dist_unitpruefung"];
if ((position _obj) inarea _area_pos_nogo) exitwith {[]};
private _pos_rel = _obj getRelPos [_dist_min + (random _dist_max), random 360];
if (surfaceiswater _pos_rel) exitwith {[]};
if (_pos_rel inarea _area_pos_nogo) exitwith {[]};
if ((count((allunits select {alive _x}) inareaarray [_pos_rel,_dist_unitpruefung,_dist_unitpruefung,0,false])) > 0) exitwith {[]};
private _pos_im_wald = [_pos_rel] call fnc_s_sys_pos_im_wald;
if (_pos_im_wald) exitwith {[_pos_rel,"wald"]};
private _strassen = _pos_rel nearRoads (_dist_min/10);
if ((count _strassen) > 0) exitwith {[position (selectrandom _strassen),"strasse"]};
private _haeuser = [_pos_rel,_dist_min/10,_DEF_pos_im_haus_min] call fnc_a_sys_gebaeudeauswahl;
if ((count _haeuser) == 0) exitwith {[]};
private _positionen_im_haus = [selectrandom _haeuser] call fnc_a_sys_positionen_innerhalb_haus;
if ((count _positionen_im_haus) == 0) exitwith {[]};
[selectrandom _positionen_im_haus,"haus"]

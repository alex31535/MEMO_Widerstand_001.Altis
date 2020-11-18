/*
  fnc_s_sys_garage_ausparken_abschluss
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.13
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: unnecessary

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
params ["_datensatz","_pos","_dir","_area_str"];
sleep 0.5;
private _area = []; call compile format["_area = %1;",_area_str];
private _fzg_in_garagenbereich = [_area] call fnc_s_sys_area_blockiert;
_fzg_in_garagenbereich params ["_fzg", "_fzg_klasse", "_fzg_displayname"];
if !(isnull _fzg) exitwith {};
private _vec = _datensatz createVehicle [0,0,0];
clearWeaponCargoGlobal _vec;
clearMagazineCargoGlobal _vec;
clearBackpackCargoGlobal _vec;
clearItemCargoGlobal _vec;
_vec setdir _dir;
_vec setpos _pos;
_vec setVariable ["tf_hasRadio", true, true];

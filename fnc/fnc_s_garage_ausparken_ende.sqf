/*
  fnc_s_garage_ausparken_abschluss_ende
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
params ["_datensatz","_pos","_dir","_area_str","_liste_str"];
sleep 0.5;
private _area = []; call compile format["_area = %1;",_area_str];
private _fzg_in_garagenbereich = [_area] call fnc_s_garage_blockiert;
_fzg_in_garagenbereich params ["_fzg", "_fzg_klasse", "_fzg_displayname"];
if !(isnull _fzg) exitwith {};
private _vec = _datensatz createVehicle _pos;//[0,0,1000];
clearWeaponCargoGlobal _vec;
clearMagazineCargoGlobal _vec;
clearBackpackCargoGlobal _vec;
clearItemCargoGlobal _vec;
_vec setdir _dir;
//_vec setpos _pos;
_vec setVariable ["tf_hasRadio", true, true];



private _liste_vec = []; call compile format ["_liste_vec = %1;",_liste_str];
_liste_vec deleteat (_liste_vec find _datensatz);
if (((s_garage_pflicht find _datensatz) != -1) && {(_liste_vec find _datensatz) == -1}) then {
  _liste_vec pushback _datensatz;
};
_liste_vec sort true;
call compile format ["%1 = _liste_vec;",_liste_str];


while {s_db_aktiv} do {uisleep 0.3};
s_db_aktiv = true;
private _db = ["new", format["%1_%2_%3",s_pref_spiel,_liste_str,(toLowerANSI worldname)]] call OO_INIDBI;
call compile format["[""write"",[""%1"",""klassen"",%1]] call _db;",_liste_str];
s_db_aktiv = false;

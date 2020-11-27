/*
  fnc_s_area_boni_fzg_land
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.12
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: [OBJ, KLASSE, DISPLAYNAME] = [fzg_pos_obj_area, "LandVehicle"] call fnc_s_LandVehicle_im_garagenbereich;

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
#define _DEF_min_anz (_lvl +1)
#define _DEF_max_lvl_auswahl (_lvl +1)

params ["_area","_lvl"];

private _erstellte_objekte = [];

private _vorhandene_fzg_klassen = [];
{if ((_vorhandene_fzg_klassen find _x) != -1) then {_vorhandene_fzg_klassen pushback _x}} foreach s_garage_kette;
{if ((_vorhandene_fzg_klassen find _x) != -1) then {_vorhandene_fzg_klassen pushback _x}} foreach s_garage_rad;


private _liste_boni_fzg_klassen = [];
private _fzg_klasse = "";
while {(count _liste_boni_fzg_klassen) < _DEF_min_anz} do {
  _fzg_klasse = selectrandom (s_feind_fzg_land_bewaffnet_west select (random(floor(_DEF_max_lvl_auswahl +1))));
  if ((_vorhandene_fzg_klassen find _fzg_klasse) == -1) then {_liste_boni_fzg_klassen pushback _fzg_klasse};
};


private _strassen_und_kreuzungen = [_area select 0, _area select 1,true] call fnc_s_strassenauswahl;
private _strassenliste = _strassen_und_kreuzungen select 0;

_strassenliste call BIS_fnc_arrayShuffle;
systemchat format["_strassenliste: %1",_strassenliste];

while {(count _liste_boni_fzg_klassen) > (count _strassen_und_kreuzungen)} do {_liste_boni_fzg_klassen deleteat 0};

private _strasse = objnull;
private _fzg_klasse = "";
private _pos_dir = [];
private _fzg = objnull;
while {(count _liste_boni_fzg_klassen) > 0} do {
  _strasse = _strassenliste select 0;
  _strassenliste deleteat 0;
  _fzg_klasse = _liste_boni_fzg_klassen select 0;
  _liste_boni_fzg_klassen deleteat 0;
  _pos_dir = [_strasse] call fnc_s_pos_dir_strassenrand;
  _fzg = _fzg_klasse createVehicle (_pos_dir select 0);
  _fzg setdir (_pos_dir select 1);
  _erstellte_objekte pushback _fzg;
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_fzg] call fnc_s_debugmarker_erstellen};
};

_erstellte_objekte

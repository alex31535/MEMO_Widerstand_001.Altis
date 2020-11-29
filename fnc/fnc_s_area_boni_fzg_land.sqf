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
#define _DEF_fzg_anz_lvl_add 1
params ["_area","_lvl"];
private _lvl_auswahl_max = _lvl + _DEF_fzg_anz_lvl_add; if (_lvl_auswahl_max > 7) then {_lvl_auswahl_max = 7};
// # alle erstellten objekte am ende an parent uebergeben
private _erstellte_objekte = [];
// # global verfuegbare fzg-klassen reduzieren auf klassen die NICHT IN DER GARAGE verfuegbar sind (ausgeparkte fahrzeuge werden nciht beruecksichtigt)
private _vorhandene_fzg_klassen = [];
{if ((_vorhandene_fzg_klassen find _x) != -1) then {_vorhandene_fzg_klassen pushback _x}} foreach s_garage_kette;
{if ((_vorhandene_fzg_klassen find _x) != -1) then {_vorhandene_fzg_klassen pushback _x}} foreach s_garage_rad;
// # fahrzeuge aus der obigen liste via zufall auswaehlen - die anzahl wurd ueber den levl bestimmt
private _liste_boni_fzg_klassen = [];
private _fzg_klasse = "";
while {(count _liste_boni_fzg_klassen) < _DEF_min_anz} do {
  _fzg_klasse = selectrandom (s_feind_fzg_land_bewaffnet_west select (random(floor(_lvl_auswahl_max)))));
  if ((_vorhandene_fzg_klassen find _fzg_klasse) == -1) then {_liste_boni_fzg_klassen pushback _fzg_klasse};
};
// # strassen (ohne kreuzungen) innerhalb der mittleren kernzone bestimmen und "besetzte" strassen ausschliessen
private _strassen_und_kreuzungen = [_area select 0, _area select 1,true] call fnc_s_strassenauswahl;
private _strassenliste = _strassen_und_kreuzungen select 0;
_strassenliste call BIS_fnc_arrayShuffle;
// # ggf die anzahl der zu setzenden fahrzeuge an die anzahl verfuegbarer strassen anpassen
while {(count _liste_boni_fzg_klassen) > (count _strassen_und_kreuzungen)} do {_liste_boni_fzg_klassen deleteat 0};
// # fahrzeuge erstellen
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
  clearBackpackCargoGlobal _fzg;
  clearItemCargoGlobal _fzg;
  clearMagazineCargoGlobal _fzg;
  clearWeaponCargoGlobal _fzg;
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_fzg] call fnc_s_debugmarker_erstellen};
};
// # erstellte fahrzeuge an parent uebergeben
_erstellte_objekte

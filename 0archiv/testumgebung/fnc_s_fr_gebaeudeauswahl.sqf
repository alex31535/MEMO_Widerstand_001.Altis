/*
  fnc_s_gebaeudeauswahl
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.14
	Description: building search function
  Called by: multiple server functions
	Parameters: [0: position, 1: search radius, 2: minimum number of building positions]
	Returns: array of objects / empty array if failed
  Necessary Globals: s_gebaeude_ki_nogo
	Example: _gebaeudeliste = [pos, radius, 4] call fnc_s_gebaeudeauswahl;

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
#define _def_geb_ki_nogo ["pier","pierconcrete","pierwooden","cargo10","cargo20","cargo40","controltower","i_addon"]
//	"controltower" : aus : airport_02_controltower_f
//	"i_addon" : aus: "Land_i_Addon_03_V1_F" bzw "Land_i_Addon_03mid_V1_F"
#define _def_geb_pfilcht ["Cargo_Patrol","Cargo_Tower","Cargo_House","Medvac_House","Chapel_Small"]
params ["_pos","_radius","_anz_hauspos_min"];
private _gebaeudeliste_ausgabe = [];
private _gebaeude = objnull;
private _string = "";
private _gebaeudeliste_grob = [];
// # gebaeude feststellen und nogo-gebaeude ausschliessen
{
	_gebaeude = _x;
	{
		_string = _x;
		{if (_string == _x) exitwith {_gebaeude = objnull}} foreach ((tolower(typeof _gebaeude)) splitString "_");
		if (isnull _gebaeude) exitwith {};
	} foreach _def_geb_ki_nogo;
	if (! isnull _gebaeude) then {_gebaeudeliste_grob pushback _gebaeude};
} foreach (_pos nearObjects ["House",_radius]);
// # grobe gebaeudeliste nach hauspositionen filtern und ggf pflichtgebaeude ohne pruefung hinzufuegen
{
  _gebaeude = _x;
  if ((count(_gebaeude buildingPos -1)) >= _anz_hauspos_min) then {
    _gebaeudeliste_ausgabe pushback _gebaeude;
  } else {
    {if (((toLowerANSI(typeof _gebaeude)) find (toLowerANSI _x)) != -1) then {_gebaeudeliste_ausgabe pushback _gebaeude}} foreach _def_geb_pfilcht;
  };
} foreach _gebaeudeliste_grob;
_gebaeudeliste_ausgabe

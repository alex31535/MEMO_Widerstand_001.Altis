/*
  fnc_s_sys_cityring_strassenliste.sqf
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
params ["_area_city","_strassenliste"];
private _pos_city = _area_city select 0;
private _ausdehnung_city = if ((_area_city select 1) > (_area_city select 2)) then [{_area_city select 1},{_area_city select 2}];
private _suchradius_strasse = floor(_ausdehnung_city / 10);
private _dist_strassen_zueinander = floor(_ausdehnung_city / 2);
private _area_verbot = [_pos_city, _dist_strassen_zueinander, _dist_strassen_zueinander, 0, false];
private _strassen_gefunden = [];
private _strasse = objNull;
for "_i" from 0 to 360 step 5 do {
  _strasse = objnull;
  _strassen_gefunden = [(_pos_city select 0) + ((sin _i) * _ausdehnung_city), (_pos_city select 1) + ((cos _i) * _ausdehnung_city), 0] nearRoads _suchradius_strasse;
  if ((count _strassen_gefunden) > 0) then {
    _strasse = selectrandom _strassen_gefunden;
    if (!(_strasse inarea _area_verbot)) then {
      {if ((_strasse distance _x) < _dist_strassen_zueinander) exitwith {_strasse = objnull}} foreach _strassenliste;
      if (!isnull _strasse) then {_strassenliste pushback _strasse};
    };
  };
};
_strassenliste

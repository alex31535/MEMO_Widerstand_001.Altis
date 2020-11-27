/*
  fnc_s_strassenauswahl
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.10
	Description: creates lists with existing streets and intersections within a zone
  Called by: multiple server functions
	Parameters: 0:position of zone 1:zone radius 1:ignore already placed objects on streets and spec. buildings
	Returns: [	0:[list of existing streets] 1:[list of exiting intersections]	]
  Necessary Globals: nothing
	Necessary functions: nothing
	Example: unnecessary

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
#define _l_nogo_gebaeude [["land_dome_big_f",30]]
params ["_pos","_radius","_ignoriere_besetzte_strassen"];
private _liste_strassen = [];
private _liste_kreuzungen = [];
private _strassensegment = objnull;
private _strasse_verwenden = true;
private _pos_strassensegment = [];
{
  _strassensegment = _x;
  _strasse_verwenden = true;
  if (_ignoriere_besetzte_strassen) then {
    _pos_strassensegment = ASLToAGL (getPosASL _strassensegment);
    if ((count(_pos_strassensegment nearEntities [["Man", "Air", "Car", "Tank"], 8])) > 0) then {
      _strasse_verwenden = false;
    } else {
      {if ((count (nearestObjects [_pos_strassensegment, [_x select 0], _x select 1])) > 0) exitwith {_strasse_verwenden = false}} foreach _l_nogo_gebaeude;
    };
  };
  if (_strasse_verwenden) then {
    if ((count (roadsConnectedTo _strassensegment)) > 2) then {
      _liste_kreuzungen pushback _strassensegment;
    } else {
      _liste_strassen pushback _strassensegment;
    };
  };
} foreach (_pos nearRoads _radius);
[_liste_strassen,_liste_kreuzungen]

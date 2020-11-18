/*
  fnc_s_loadout_zu_objektliste
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.12
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example:

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
params ["_loadout"];
private _loadout_segment = [];
private _loadout_segment_sub1 = [];
private _alle_obj_der_unit = [];
{
  _loadout_segment = _x;
  if ((typeName _loadout_segment) == "ARRAY") then {
    _loadout_segment_sub1 = _x;
    if ((typeName _loadout_segment_sub1) == "ARRAY") then {
      {
        if ((typeName _x) == "STRING") then {_alle_obj_der_unit pushback _x};
      } foreach _loadout_segment_sub1;
    };
    if ((typeName _loadout_segment_sub1) == "STRING") then {_alle_obj_der_unit pushback _loadout_segment_sub1};
  };
  if ((typeName _loadout_segment) == "STRING") then {_alle_obj_der_unit pushback _loadout_segment};
} foreach _loadout;
_alle_obj_der_unit

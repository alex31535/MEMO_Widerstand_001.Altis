/*
  fnc_a_sys_wasser_zwischen_a_und_b
  Author: Alex31535 (alex31535@miegelke.de)
  Version:
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: unnecessary

  Please give the author the necessary credits if you use or change this script. The script was created in the context
  of other functions of the author and does not guarantee functionalities with other scripts and functions that were not
  developed for this by the author.
*/
#define _def_schritt 10
params ["_pos_a","_pos_b"];
private _dir = [_pos_a, _pos_b] call fnc_a_sys_winkel_pos1_zu_pos2;
private _pos_wassertest = [];
private _wasser_gefunden = false;
while {(_pos_a distance _pos_b) > _def_schritt} do {
  _pos_wassertest = [(_pos_a select 0) + ((sin _dir) * _def_schritt), (_pos_a select 1) + ((cos _dir) * _def_schritt), (_pos_a select 2)];
  if (surfaceiswater _pos_wassertest) exitwith {_wasser_gefunden = true};//_wasser_vorhanden = true};
  _pos_a = _pos_wassertest;
};
_wasser_gefunden

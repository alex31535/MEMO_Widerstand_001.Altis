/*
  fnc_s_area_haus_aus_liste
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
params ["_pos_aktuell","_dist_min","_liste_haeuser"];
private _positionen_im_haus = [];
private _haus = objnull;
private _timeout = time + 2;
while {true} do {
  _haus = selectrandom _liste_haeuser;
  _positionen_im_haus = [_haus] call fnc_a_sys_positionen_innerhalb_haus;
  if ((count _positionen_im_haus) > 0) && {(_pos_aktuell distance _haus) < _dist_min} exitwith {};
  _haus = objnull;
  if (time > _timeout) exitwith {};
};
_haus

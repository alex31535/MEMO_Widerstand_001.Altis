/*
  fnc_a_sys_winkel_pos1_zu_pos2
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.11
	Description:
  Called by:
	Parameters: [0:[pos1#zentrum],1:[pos2#abstand]]
	Returns: winkel pos1 auf pos2 (numerisch)
  Necessary Globals:
	Example: unnecessary

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
private _winkel = (((_this select 1) select 0)-((_this select 0) select 0)) atan2 (((_this select 1) select 1)-((_this select 0) select 1));
_winkel = _winkel mod 360;
if (_winkel < 0) then {_winkel = _winkel + 360};
_winkel

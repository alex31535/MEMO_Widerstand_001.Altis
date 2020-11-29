/*
  fnc_s_spielerlevel
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
params ["_spieler"];
private _pkt = 0;
private _lvl = 0;
call compile format["_pkt = s_%1 select 5;",getplayeruid _spieler];
{if (_pkt < _x) exitwith {_lvl = _foreachindex};_lvl = 7} foreach s_lvl_steps;
_lvl

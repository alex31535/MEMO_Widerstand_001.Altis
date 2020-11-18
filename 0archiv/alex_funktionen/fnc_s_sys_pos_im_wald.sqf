/*
  fnc_s_sys_pos_im_wald.sqf
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
#define _def_radius 20
#define _def_praezision 1
#define _def_anzahl 10
params ["_pos"];
private _pos_im_wald = true;
{
	if ((_x select 1) != 1) exitwith {_pos_im_wald = false}
} foreach (selectBestPlaces [_pos,_def_radius,"trees",_def_praezision,_def_anzahl]);
if (_pos_im_wald) then {
  {
	   if ((_x select 1) != 1) exitwith {_pos_im_wald = false}
  } foreach (selectBestPlaces [_pos,_def_radius,"forest",_def_praezision,_def_anzahl]);
};
_pos_im_wald

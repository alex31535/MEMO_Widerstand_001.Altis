/*
  fnc_s_sys_unit_in_bestimmten_haus
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
params ["_unit"/*obj*/,"_haus"/*obj*/];
private _intersect = lineIntersectsSurfaces [AGLToASL(position _unit),(AGLToASL(position _unit)) vectorAdd [0, 0, 20],_unit,_unit,true,1,"GEOM","NONE"];
if (((count _intersect) > 0) && {((_intersect select 0) select 2) == _haus}) exitwith {true};
false

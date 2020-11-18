/*
  fnc_a_sys_positionen_innerhalb_haus
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
params ["_haus"];
private _positionen_innerhalb_agl = [];
{
  if ((count(lineIntersectsSurfaces [AGLToASL  _x,(AGLToASL  _x) vectorAdd [0, 0, 50],objnull,objNull,true,1,"GEOM","NONE"])) > 0) then {_positionen_innerhalb_agl pushback _x}
} foreach (_haus buildingpos -1);
_positionen_innerhalb_agl

/*
  init_debugmarker.sqf
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[OBJECT] call fnc_s_debugmarker_erstellen};

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
#define _def_farbe_not_alive "ColorGrey"
// # core-loop
private _marker = "";
private _obj = objnull;
while {true} do {
  {
    if ((_x find s_debugmarker_kennung) > -1) then {
      _obj = objectfromnetid ((_x splitstring s_debugmarker_kennung) select 0);
      if (isnil "_obj") then {
        deletemarker _x;
      } else {
        if (isnull _obj) then {
          deletemarker _x;
        } else {
          _x setmarkerpos (position _obj);
          if (!alive _obj) then {
            _x setmarkercolor "ColorGrey";
          };
        };
      };
    };
  } foreach allmapmarkers;
  uisleep 0.3;
};

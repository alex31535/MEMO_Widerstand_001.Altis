/*
  fnc_s_debugmarker_erstellen
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 0.2 (Beta)
	Description: creates an object-dependent debug marker for recognition and editing via various debug scripts
  Called by: crash_site_init.sqf
	Parameters:
  Necessary Globals:
	Example: if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[OBJECT] call fnc_s_debugmarker_erstellen};

  Please give the author the necessary credits if you use or change this script. The script was created in the context
  of other functions of the author and does not guarantee functionalities with other scripts and functions that were not
  developed for this by the author.
*/
params ["_obj"];
private _debugmarker = createMarker [format["%1%2",s_debugmarker_kennung,netid _obj],position _obj];
_debugmarker setMarkerType "mil_dot";
_debugmarker setmarkertext (getText(configFile >> "CfgVehicles" >> (typeof _obj) >> "displayName"));
if (!(_obj iskindof "Man")) then {
  _debugmarker setmarkertext (format["%1[%2]",getText(configFile >> "CfgVehicles" >> (typeof _obj) >> "displayName"),count(fullCrew _obj)]);
};
_debugmarker setmarkercolor (s_debugmarker_farbe select (getNumber(configFile >> "CfgVehicles" >> (typeof _obj) >> "side")));
_debugmarker

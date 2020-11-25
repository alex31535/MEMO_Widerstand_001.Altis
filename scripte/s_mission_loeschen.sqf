/*
  s_mission_loeschen.sqf
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
params ["_erstellte_objekte","_erstellte_marker"];
// # erstellte objekte loeschen
{deletevehicle _x} foreach _erstellte_objekte;
// # erstellte marker loeschen
{deletemarker _x} foreach _erstellte_marker;
// # leichen entfernen
{deletevehicle _x} foreach allDead;
// # minen entfernen
{deletevehicle _x} foreach allMines;

// # reset auf mission-params
s_mission_params = [];
{s_mission_params pushback _x} foreach s_mission_params_reset;

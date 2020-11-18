/*
  fnc_s_missionsgenerierung_wiederholen
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
params ["_parameter","_erstellte_objekte","_erstellte_marker"];
{deletevehicle _x} foreach _erstellte_objekte;
{deletemarker _x} foreach _erstellte_marker;
_parameter execvm (format["%1s_mission_generieren.sqf",s_mission_params select 2]);

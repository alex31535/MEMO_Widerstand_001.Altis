/*
  s_missionsteilnahme.sqf
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
[["<t color='#ff0000' size='2'>Die Mission ist schon gestartet und du bist mittendrin!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];

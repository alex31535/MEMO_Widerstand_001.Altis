/*
  s_missionsende.sqf
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
params ["_spieler","_wertung_missionsende"];

switch (_wertung_missionsende) do {
  case "BEISPIEL": {
    if (!(s_mission_params select 4)) then {
      _spieler setposworld s_missions_posworld_notaus;
      _spieler addrating ((rating player) *-1);
      [["<t color='#ff0000' size='4'>DU HAST DIE DEATHMATCH-ZONE VERLASSEN!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
    };
  };
  case "B": {

  };
  default {};
};

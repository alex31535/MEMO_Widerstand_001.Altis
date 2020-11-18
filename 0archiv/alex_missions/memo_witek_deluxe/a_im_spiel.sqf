/*
  a_im_spiel.sqf
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
params ["_dm_loc_params","_startpos"];
private _loc_name = _dm_loc_params select 0;
private _dm_area = _dm_loc_params select 1;


player setposasl (agltoasl _startpos);
player setdir (random 360);



private _im_spiel = true;
private _wertung_missionsende = ""; // wird in "s_missionsende.sqf" innerhalb eines switch bewertet
while {_im_spiel} do {
  if (!(player inarea _dm_area)) exitwith {_im_spiel = false; _wertung_missionsende = "zone verlassen"};
  if (!alive player) exitwith {_im_spiel = false; _wertung_missionsende = "getoetet"};
  uisleep 0.3;
};


[[player,_wertung_missionsende],"alex_missions\memo_witek_deluxe\s_missionsende.sqf"] remoteexec ["execvm",2];

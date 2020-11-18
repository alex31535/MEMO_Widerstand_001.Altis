/*
  fnc_s_mission_spieler_zu_hq.sqf
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by: Client-Init: ["loop"] execVM "alex_inkognito\init_inkognito.sqf";
	Parameters: "loop" or "fnc"
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: unnecessary

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
if (isnil "s_missions_posworld_notaus") exitwith {Systemchat "fnc_s_mission_spieler_zu_hq: Fehler - s_missions_posworld_notaus nicht vorhanden!"};
private _area_notaus = [s_missions_posworld_notaus,50,50,0,false];
while {true} do {
  if ((count(playableunits inareaarray _area_notaus)) == (count playableunits)) exitwith {};
  {
    if (!(_x inarea _area_notaus)) then {
      _x setUnconscious false;
      _x setdammage 0;
      _x setposworld s_missions_posworld_notaus;
    };
  } foreach playableunits;
};

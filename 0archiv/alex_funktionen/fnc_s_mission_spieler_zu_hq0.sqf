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

{
  _x setUnconscious false;
  _x setdammage 0;
  _x setposworld s_missions_posworld_notaus;
  if (! isnil "s_spcfg_loadout_spieler_universal") then {_x setunitloadout s_spcfg_loadout_spieler_universal};
} foreach (playableunits + allplayers);

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
if (isnil "s_vertZ_pos_fob") exitwith {
  [["<t color='#ff0000' size='2'>Die Missionsteilnahme ist fehlgeschlagen - Bitte den Missionsersteller kontaktieren!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
if ((count s_vertZ_pos_fob) == 0) exitwith {
  [["<t color='#ff0000' size='2'>Die Mission ist noch nicht vollstaendig generiert - Bitte warten!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};

_spieler setposatl (selectrandom s_vertZ_liste_spieler_spawn_pos);

[_spieler,"Killed"] remoteexec ["removeAllEventHandlers",_spieler];

[_spieler,["Fired",{if ((_this select 5) == "SmokeShellPurple") then {[player,(_this select 6)] remoteexec ["fnc_s_vertZ_moerserziel",2]}}]] remoteexec ["addEventHandler",_spieler];

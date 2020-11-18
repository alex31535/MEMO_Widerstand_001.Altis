/*
  fnc_s_uid_var_anwenden
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
private _uid_var = [];
call compile format["_uid_var = if (isnil ""s_%1"") then [{[]},{s_%1}];",getplayeruid _spieler];
if ((count s_uid_var_eintraege) != (count _uid_var)) exitwith {systemchat "fnc_s_uid_var_anwenden: FEHLER: Anz VAR-Eintraege nicht korrekt!"};
/*["worldpos",[0,0,0]],*/ _spieler setposworld (_uid_var select 0);
/*["dir",0],*/ [_spieler, (_uid_var select 1)] remoteexec ["setdir",_spieler];//_spieler setdir (_uid_var select 1);
/*["haltung",""],*/ [_spieler, (_uid_var select 2)] remoteexec ["playMoveNow",_spieler];
/*["schaden",0],*/ {_spieler setHitPointDamage [_x, (_uid_var select 3) select _foreachindex]} foreach ((getAllHitPointsDamage _spieler) select 0),
/*["loadout",[]]*/ _spieler setunitloadout (_uid_var select 4);
systemchat format["fnc_s_uid_var_anwenden: datensatz auf %1 angewendet...",name _spieler];

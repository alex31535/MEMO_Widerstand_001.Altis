/*
  fnc_s_uid_var_neu
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
private _uid_var = [
  /*["worldpos",[0,0,0]],*/ eo_flagge_basis getrelpos [5,random 360],
  /*["dir",0],*/ random 360,
  /*["haltung",""],*/ configName (configFile >> getText (configFile >> "CfgVehicles" >> typeOf _spieler >> "moves") >> "States" >> (animationState _spieler)),
  /*["schaden",0],*/ (getAllHitPointsDamage _spieler) select 2,
  /*["loadout",[]]*/ s_loadout_basis
];
call compile format["s_%1 = _uid_var;",getplayeruid _spieler];
systemchat format["fnc_s_uid_var_neu: neuer datensatz fuer %1 erstellt...",name _spieler];

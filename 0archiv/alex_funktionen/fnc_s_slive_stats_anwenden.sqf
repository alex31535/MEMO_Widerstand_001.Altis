/*
  fnc_s_slive_stats_anwenden.sqf
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: [spieler] call s_db_spielerdaten_anwenden;

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
params ["_spieler","_s_slive_uid"];
/*0:pos*/_spieler setPosworld (_s_slive_uid select 0);
/*1:dir*/_spieler setdir (_s_slive_uid select 1);
/*2:haltung*/
/*3:gesundheit*/
/*4:ausstattung*/_spieler setUnitLoadout (_s_slive_uid select 4);

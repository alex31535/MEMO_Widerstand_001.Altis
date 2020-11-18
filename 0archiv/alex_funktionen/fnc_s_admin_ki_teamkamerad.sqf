/*
  fnc_s_admin_ki_teamkamerad.sqf
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
params ["_action_obj","_spieler","_action_id","_uebergabe"];
private _unit = (group _spieler) createUnit ["B_Soldier_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_unit setSkill 0.1;
_unit setposworld s_slive_startposworld;

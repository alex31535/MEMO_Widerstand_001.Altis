/*
  fnc_s_create_unit_startpos_move_zielpos
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.12
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: [OBJ, KLASSE, DISPLAYNAME] = [fzg_pos_obj_area, "LandVehicle"] call fnc_s_LandVehicle_im_garagenbereich;

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
params ["_seite","_unitklasse","_lvl","_pos_start_asl","_zielpos","_verhalten"];
private _unit = (creategroup [_seite,true]) createUnit [_unitklasse, [0,0,0], [], 0, "NONE"];
_unit setposasl _pos_start_asl;
_unit setdir (random 360);
[_unit,_lvl] call fnc_s_feindkonfig;
private _gruppe = group _unit;
while {(count(waypoints _gruppe))>1} do {deleteWaypoint((waypoints _x)select 0)};
_gruppe addWaypoint [_zielpos, 5, 0];
[_gruppe, 0] setWaypointBehaviour "AWARE";
[_gruppe, 0] setWaypointspeed "FULL";
[_gruppe, 0] setWaypointType "MOVE";
_gruppe addWaypoint [_zielpos,2,1];
[_gruppe, 1] setWaypointCompletionRadius 2;
[_gruppe, 1] setWaypointBehaviour _verhalten;
[_gruppe, 1] setWaypointspeed "FULL";
[_gruppe, 1] setWaypointType "SAD";
if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
[_unit]

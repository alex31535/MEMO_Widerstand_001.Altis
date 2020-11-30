/*
  fnc_s_create_vec_trans_startpos_move_zielpos
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.12
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example:

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
params ["_seite","_vec_klasse","_unitklasse","_lvl","_pos_start","_zielpos","_verhalten"];
private _erstellte_objekte = [];

private _vec = _vec_klasse createVehicle _pos_start;
_vec setdir (random 360); // pos_dir_strassenrand !!!!!!!!!!
private _gruppe = creategroup [_seite,true];
{
  _unit = _gruppe createUnit [_unitklasse, (position _vec), [], 0, "NONE"];
  _unit moveInTurret [_vec, _x];
} foreach (allTurrets _vec);
if ((count(fullCrew [_vec, "gunner", true])) > 0) then {
  _unit = _gruppe createUnit [_unitklasse, (position _vec), [], 0, "NONE"];
  _unit moveingunner _vec;
};
if ((count(fullCrew [_vec, "commander", true])) > 0) then {
  _unit = _gruppe createUnit [_unitklasse, (position _vec), [], 0, "NONE"];
  _unit moveingunner _vec;
};
_unit = _gruppe createUnit [_unitklasse, (position _vec), [], 0, "NONE"];
_unit moveindriver _vec;

if ((!isnil "s_debugmarker") && {s_debugmarker}) then {{[_x] call fnc_s_debugmarker_erstellen} foreach (units _gruppe)};

{[_x,_lvl] call fnc_s_feindkonfig} foreach (units _gruppe);

_gruppe addWaypoint [_pos_start, 5, 0];
[_gruppe, 0] setWaypointBehaviour _verhalten;
[_gruppe, 0] setWaypointspeed "LIMITED";
[_gruppe, 0] setWaypointType "MOVE";
[_gruppe, 0] setWaypointCompletionRadius 30;
_gruppe addWaypoint [_zielpos findEmptyPosition [10,100,(typeof _vec)],10,1];
[_gruppe, 1] setWaypointCompletionRadius 2;
[_gruppe, 1] setWaypointBehaviour _verhalten;
[_gruppe, 1] setWaypointspeed "LIMITED";
[_gruppe, 1] setWaypointType "TR UNLOAD";
[_gruppe, 1] setWaypointCompletionRadius 50;
_erstellte_objekte append (units _gruppe);
_erstellte_objekte pushback _vec;
// # cargo
if ((count(fullCrew [_vec, "cargo", true])) > 0) then {
  _gruppe = creategroup [east,true];
  {
    _unit = _gruppe createUnit [_unitklasse, (position _vec), [], 0, "NONE"];
    _unit moveincargo _vec;
  } foreach (fullCrew [_vec, "cargo", true]);
  _gruppe addWaypoint [_zielpos, 5, 0];
  [_gruppe, 0] setWaypointBehaviour "AWARE";
  [_gruppe, 0] setWaypointspeed "FULL";
  [_gruppe, 0] setWaypointType "MOVE";
  _gruppe addWaypoint [_zielpos,2,1];
  [_gruppe, 1] setWaypointCompletionRadius 2;
  [_gruppe, 1] setWaypointBehaviour _verhalten;
  [_gruppe, 1] setWaypointspeed "FULL";
  [_gruppe, 1] setWaypointType "SAD";
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {{[_x] call fnc_s_debugmarker_erstellen} foreach (units _gruppe)};
  {[_x,_lvl] call fnc_s_feindkonfig} foreach (units _gruppe);
  _erstellte_objekte append (units _gruppe);
};//((count(fullCrew [_vec, "cargo", true])) > 0)

_erstellte_objekte

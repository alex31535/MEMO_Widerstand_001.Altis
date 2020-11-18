/*
  fnc_a_sys_speedlimit.sqf
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
params ["_speed_max_vor","_speed_max_zurueck","_velo_vor","_velo_zurueck"];
private _vec = objectparent player;
private _fahrer = driver _vec;
while {true} do {
  if ((speed _vec) > _speed_max_vor) then {_vec setVelocity [(sin getdir _vec * _velo_vor), (cos getdir _vec * _velo_vor), velocity _vec select 2]};
  if ((speed _vec) < _speed_max_zurueck) then {_vec setVelocity [(sin getdir _vec * _velo_zurueck), (cos getdir _vec * _velo_zurueck), velocity _vec select 2]};
  if ((leader _fahrer) != player) exitwith {};
    systemchat format["fnc_a_sys_speedlimit....aktiv(%1)",floor(time)];
};

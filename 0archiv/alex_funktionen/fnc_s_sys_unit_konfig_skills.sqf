/*
  fnc_s_sys_unit_konfig_skills.sqf
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
params ["_unit","_skill_min","_skill_max"];
_unit allowFleeing 0;
_unit setskill ["aimingAccuracy",		_skill_min + (random(_skill_max - _skill_min))];
_unit setskill ["aimingShake",			_skill_min + (random(_skill_max - _skill_min))];
_unit setskill ["aimingSpeed",			_skill_min + (random(_skill_max - _skill_min))];
_unit setskill ["endurance",				_skill_min + (random(_skill_max - _skill_min))];
_unit setskill ["spotDistance",			_skill_min + (random(_skill_max - _skill_min))];
_unit setskill ["spotTime",					_skill_min + (random(_skill_max - _skill_min))];
_unit setskill ["courage",					_skill_min + (random(_skill_max - _skill_min))];
_unit setskill ["reloadSpeed",			_skill_min + (random(_skill_max - _skill_min))];
_unit setskill ["commanding",				_skill_min + (random(_skill_max - _skill_min))];

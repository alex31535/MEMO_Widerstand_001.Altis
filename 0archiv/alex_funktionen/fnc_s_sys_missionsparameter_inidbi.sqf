/*
  fnc_s_sys_missionsparameter_inidbi
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
if (isnil "OO_INIDBI") exitwith {systemchat "fnc_s_sys_missionsparameter_inidbi: Abbruch - iniDBi nicht geladen...."};
params ["_missionskennung","_parameter"];
private _db = ["new", (format["missionsparameter_%1_%2",_missionskennung,(toLowerANSI worldname)])] call OO_INIDBI;
if ((count _parameter) != 0) exitwith {/* speichern */
  ["write",["missionsparameter",_missionskennung,_parameter]] call _db;
  systemchat format["fnc_s_sys_missionsparameter_inidbi: missionparameter fuer %1 gespeichert...",_missionskennung];
};
private _db_existiert = "exists" call _db;
if (_db_existiert) then {
  _parameter = ["read",["missionsparameter",_missionskennung]] call _db;
  systemchat format["fnc_s_sys_missionsparameter_inidbi: missionparameter fuer %1 geladen...",_missionskennung];
} else {
  systemchat format["fnc_s_sys_missionsparameter_inidbi: keine missionsparameter auf server gefunden...",_missionskennung];
};
_parameter

/*
  fnc_s_mission_mission_aktivieren.sqf
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by: Client-Init: ["loop"] execVM "alex_inkognito\init_inkognito.sqf";
	Parameters: "loop" or "fnc"
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: unnecessary

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
if (s_mission_params select 0) exitwith {
  [[format["<t color='#ff0000' size='2'>%1 ist noch aktiv!",s_mission_params select 1], "PLAIN", -1, true, true]] remoteExec ["cutText", remoteExecutedOwner];
};
[] call fnc_s_mission_spieler_zu_hq;
// # vehicle die nicht zur hq-ausstattung gehoeren werden geloescht
{
  if (_x iskindof "Tank") then {deletevehicle _x};
  if (_x iskindof "Car") then {deletevehicle _x};
  if (_x iskindof "Air") then {deletevehicle _x};
  if (_x iskindof "Helicopter") then {deletevehicle _x};
  if (_x iskindof "Plane") then {deletevehicle _x};
  if (_x iskindof "Ship") then {deletevehicle _x};
  //if ((["Tank","Car","Air","Helicopter","Plane","Ship"] find (inheritsFrom (configFile >> "CfgVehicles" >> typeof _x))) != -1) then {
  //  deletevehicle _x;
  //};
} foreach vehicles;
private _mission_params_aus_uebergabe = [];
call compile format["_mission_params_aus_uebergabe = %1;",_this select 0];
[objectfromnetid (_this select 1)] execvm (format["%1s_mission_anfordern.sqf",_mission_params_aus_uebergabe select 2]);

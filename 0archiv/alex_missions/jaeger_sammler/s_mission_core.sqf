/*
  s_mission_core.sqf
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


params ["_erstellte_objekte","_erstellte_marker"];



{
  [["<t color='#02bf1b' size='4'>HIER FEHLT DER CORE-TEXT!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach playableunits;


//----------------------------------------------------------------------------------------------------------------------- hauptteil start
private _core_status = "";
private _uid_var = [];

while {_core_status == ""} do {

  // # spieler pruefen
  {
    call compile format["_uid_var = if (isnil ""s_js_uid_var_%1"") then [{nil},{s_js_uid_var_%1}];",getplayeruid _x];
    //if (alive _x) then {
    if (isnil "_uid_var") then {[_x] call s_fnc_js_spieler_startet_neu};
    //} else {
    if ((! isnil "_uid_var") && {(_uid_var select 0) != (netid _x)}) then {call compile format["s_js_uid_var_%1 = nil;",getplayeruid _x]};
    //};
  } foreach playableunits;


  // ## notaus aktiviert?
  if (s_mission_params select 4) then {_core_status = "notaus"};
  // ## notaus aktiviert?
  if (!alive (objectfromnetid s_js_anfuehrer_netid)) then {_core_status = "anfuehrer verstorben"};

  // # bremse
  uisleep 0.3;
};
//----------------------------------------------------------------------------------------------------------------------- hauptteil ende

// # glabale variablen aus generierung loeschen
deletevehicle s_js_zielfahrzeug; s_js_zielfahrzeug = nil;
deletevehicle s_js_startfahrzeug; s_js_startfahrzeug = nil;


// # memo-basis wiederherstellen
[] call fnc_s_sys_memobasis_an_aus;

// # corestatus auswerten
private _mission_beenden = false;
switch (_core_status) do {
  case "anfuehrer verstorben": {

  };

  case "notaus": {
    _mission_beenden = true;
  };
};

// # nach der core-auswertung kurz pausieren
uisleep 3;

//if (_mission_beenden) exitwith {[_erstellte_objekte,_erstellte_marker] execvm "alex_scripte\s_mission_loeschen.sqf"};

//[_erstellte_objekte,_erstellte_marker,_liste_hauspos,_vec_transport_fob,_verteiler_unit_zombie] execvm (format["%1s_mission_core.sqf",s_mission_params select 2]);

/*
  fnc_s_wp_zone_strassen
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.12
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: _erfolgreich_erstellt = [_grp, _zone, true, "SAFE", "LIMITED",[]] call fnc_s_wp_area_strassen;

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
#define _def_gebaeudesuche_anz_hauspos 4
#define _def_min_anz_strassen 10
params ["_gruppe","_zone","_gruppe_teleport_start","_verhalten","_geschwindigkeit","_strassen_uebergabe"];
// # strassen pruefen
private _alle_strassen = if ((count(_this select 5)) == 0) then [{(_zone select 0) nearRoads (_zone select 1)},{_this select 5}];
if ((count _alle_strassen) < _def_min_anz_strassen) exitwith {systemchat "fnc_s_wp_area_strassen: zu wenig strassen gefunden"; false};
// # vorhandene wp loeschen
while {(count(waypoints _gruppe))>1} do {deleteWaypoint((waypoints _gruppe)select 0)};
// # gruppe zu startpos
if (_gruppe_teleport_start) then {{_x setPosATL (getposatl(selectrandom _alle_strassen))} foreach (units _gruppe)};
// # wp 0, start:
_gruppe addWaypoint [position (leader _gruppe), 5, 0];
[_gruppe, 0] setWaypointBehaviour _verhalten;
[_gruppe, 0] setWaypointspeed _geschwindigkeit;
[_gruppe, 0] setWaypointType "MOVE";
// # wp 1, fortsetzung und schleife:
_gruppe addWaypoint [position (leader _gruppe),2,1];//getposatl (selectrandom _alle_strassen)
[_gruppe, 1] setWaypointCompletionRadius 2;
[_gruppe, 1] setWaypointBehaviour _verhalten;
[_gruppe, 1] setWaypointspeed _geschwindigkeit;
// # statement modifizieren
private _wp_statement = "";
call compile format["_wp_statement = ""[(group this),1] setWaypointPosition [(getposatl(selectrandom(%1 nearRoads %2))),2];"";",_zone select 0,_zone select 1];
[_gruppe, 1] setWaypointStatements ["true",_wp_statement];
// # durchfuehrbarkeit publizieren
true

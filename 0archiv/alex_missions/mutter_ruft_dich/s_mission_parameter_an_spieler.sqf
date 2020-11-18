/*
  s_mission_parameter_an_spieler.sqf
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
/* Parameterliste: (weitergabe an s_mission_generieren.sqf)
0 ["Spawnabstaende",[["Schnell",2],["Mittel",4],["Langsam",8]],
1 ["Haeuserdichte",[["Gering",4],["Mittel",10],["Hoch",18]],
2 "Objektdichte",[["Gering",50],["Mittel",90],["Hoch",128]],
3 ["Groesse Flaggenzone",[["Gering",30],["Mittel",50],["Hoch",80]],
4 ["Punkte-Rate",[["Gering",7000],["Mittel",10000],["Hoch",15000]],
5 ["Dichte Landfahrzeug-Spawn",[["Gering",2],["Mittel",5],["Hoch",8]],
6 ["Dichte Infanterie-Spawn",[["Gering",2],["Mittel",5],["Hoch",8]],
7 ["Wahrscheinlichkeit Infanterie",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],
8 ["Wahrscheinlichkeit Radfahrzeuge",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],
9 ["Wahrscheinlichkeit Kettenfahrzeuge",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],
10 ["Wahrscheinlichkeit Flugzeuge",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],
11 ["Wahrscheinlichkeit Helikopter",[["Sehr gering",5],["Gering",25],["Mittel",50],["Hoch",75],["Sehr Hoch",99]],
12 ["Entfernung Infanterie",[["Sehr weit",650],["Weit",550],["Mittel",450],["Nah",350],["Sehr nah",250]],
*/
params ["_remoteexecutedowner"];
private _parameter = [];


// # auslesen gespeicherter werte -> achtung: diese werte enthalten nur DIE GEWAEHLTEN paranmeter, nicht die vollstaendige auswahl
/* A N P A S S E N */private _parameter_inidbi = [s_mrd_missionskennung,[]] call fnc_s_sys_missionsparameter_inidbi;
if (((count _parameter_inidbi) > 0) && {(count _parameter_inidbi) == (count _parameter)}) then {
  {_x set [3,(_parameter_inidbi select _foreachindex) select 1]} foreach _parameter;
};


[_parameter,s_mission_params select 2] remoteexec ["fnc_a_mission_spieler_waehlt_parameter",remoteExecutedOwner];

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
0 ["Spawnabstaende",[["Sehr schnell",2],["Schnell",3],["Mittel",4],["Langsam",5],["Sehr Langsam",6]],
1 ["Maximale Anzahl Zombies im Gebiet",[["Sehr wenig",5],["Wenig",15],["Normal",25],["Viele",40],["Sehr viele",60]],
2 ["Verdichtung Zombies um Zivilisten",[["Sehr gering",120],["Gering",100],["Normal",80],["Hoch",60],["Sehr hoch",40]]
3 ["Distanzaktivierung Zombie-Spawn",[["Sehr Langsam",250],["Langsam",400],["Normal",550],["Schnell",700],["Sehr schnell",850]]
4 ["Spawndistanz Zombies",[["Sehr weit",500],["Weit",400],["Normal",300],["Nah",200],["Sehr nah",100]]
5 ["MIBUs 50-Prozent-Regel",[["Aktiv",true],["Inaktiv",false]]
6 ["GUSTLs Mischung (Zombie-Anteil)",_100er,
7 ["Freundschaft unter Feinden und Zombies",[["Befreundet",true],["Verfeindet",false]]
8 ["Ziv/Fzg:",_auswahl,
*/
params ["_remoteexecutedowner"]; // kann zahl oder objekt sein !!
private _parameter = [];


// # auslesen gespeicherter werte -> achtung: diese werte enthalten nur DIE GEWAEHLTEN paranmeter, nicht die vollstaendige auswahl
/* A N P A S S E N */private _parameter_inidbi = [s_js_missionskennung,[]] call fnc_s_sys_missionsparameter_inidbi;
if (((count _parameter_inidbi) > 0) && {(count _parameter_inidbi) == (count _parameter)}) then {
  {_x set [3,(_parameter_inidbi select _foreachindex) select 1]} foreach _parameter;
};


[_parameter,s_mission_params select 2] remoteexec ["fnc_a_mission_spieler_waehlt_parameter",remoteExecutedOwner];

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
params ["_remoteexecutedowner"];
private _parameter = [];
private _100er_prozent = []; for "_i" from 0 to 100 do {_100er_prozent pushback [format["%1 %2",_i,"%"],_i]};


/*0*/_parameter pushback ["Spawnabstaende",[["Sehr schnell",1],["Schnell",2],["Mittel",3],["Langsam",4],["Sehr Langsam",5]],
  "Bestimmt die Zeitabstaende an in der Feinde spawnen.",
  ["Mittel",3]];
/*1*/_parameter pushback ["Maximale Anzahl Feinde im Gebiet",[["Sehr wenig",20],["Wenig",35],["Normal",50],["Viele",65],["Sehr viele",80]],
  "Bestimmt die maximale Anzahl von Feinden.",
  ["Normal",25]];
/*2*/_parameter pushback ["Verdichtung Feinde um Zivilisten",[["Sehr gering",90],["Gering",70],["Normal",50],["Hoch",30],["Sehr hoch",20]],
  "Je hoeher der Wert ist, desto mehr Feinde werden sich im direkten Umfeld des Zivilisten bewegen.",
  ["Normal",80]];
/*3*/_parameter pushback ["Distanzaktivierung Feind-Spawn",[["Sehr Langsam",500],["Langsam",600],["Normal",700],["Schnell",800],["Sehr schnell",900]],
  "Bestimmt wie schnell der Feind-Spawn bei betreten der Zielzone ausgeloest wird.",
  ["Normal",700]];
/*4*/_parameter pushback ["Spawndistanz Feinde",[["Sehr weit",500],["Weit",400],["Normal",300],["Nah",200],["Sehr nah",100]],
  "Bestimmt die Spawn-Distanz zwischen Zivilisten und Feinden.",
  ["Normal",300]];
/*5*/_parameter pushback ["MIBUs 50-Prozent-Regel",[["Aktiv",true],["Inaktiv",false]],
  "50-Prozent-Regel: Mission scheitert ERST wenn 50% der zu rettenden Zivilisten getoetet wurden - Ansonsten schon bei dem ersten toten Zivilisten.",
  ["Aktiv",true]];
/*6*/_parameter pushback ["GUSTLs Mischung (Zombie-Anteil)",_100er_prozent,
  "Bestimmt wie hoch ist der Anteil an Zombies unter den Feinden ist.",
  ["50 %",50]];
/*7*/_parameter pushback ["Freundschaft unter Feinden und Zombies",[["Befreundet",true],["Verfeindet",false]],
  "Legt fest ob die Feinde mit den Zombies befreundet sind oder nicht.",
  ["Befreundet",true]];
private _auswahl = []; {_auswahl pushback [format["%1",_x select 1],_foreachindex]} foreach s_rettz_heli_auswahl;
/*8*/_parameter pushback ["Fzg",_auswahl,
  "Bestimmt das Transportfahrzeug.",
  (_auswahl select 0)];
private _100er_anzahl = []; for "_i" from 1 to (count s_sys_locations) do {_100er_anzahl pushback [format["Anz: %1",_i],_i]};
/*9*/_parameter pushback ["Zu rettende Zivilisten",_100er_anzahl,
  "Bestimmt die Anzahl zu rettender Zivilisten.",
  ["Anz",5]];


// # auslesen gespeicherter werte -> achtung: diese werte enthalten nur DIE GEWAEHLTEN paranmeter, nicht die vollstaendige auswahl
private _parameter_inidbi = [s_rettz_missionskennung,[]] call fnc_s_sys_missionsparameter_inidbi;
if (((count _parameter_inidbi) > 0) && {(count _parameter_inidbi) == (count _parameter)}) then {
  {_x set [3,(_parameter_inidbi select _foreachindex) select 1]} foreach _parameter;
};


[_parameter,s_mission_params select 2] remoteexec ["fnc_a_mission_spieler_waehlt_parameter",remoteExecutedOwner];

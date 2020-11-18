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

private _100er = []; for "_i" from 0 to 100 do {_100er pushback [format["%1 %2",_i,"%"],_i]};

/*0*/_parameter pushback ["Spawnabstaende",[["Sehr schnell",2],["Schnell",4],["Mittel",7],["Langsam",12],["Sehr Langsam",20]],
  "Gibt die Zeitabstaende an in der Feinde spawnen.",
  ["Mittel",7]];
/*1*/_parameter pushback ["Haeuserdichte",[["Sehr gering",1],["Gering",5],["Mittel",12],["Hoch",20],["Sehr hoch",40]],
  "Je geringer die Haeuserdichte ist desto eher kommen auch gering besiedelte Gebiete in Frage.",
  ["Mittel",12]];
/*2*/_parameter pushback ["Objektdichte",[["Sehr gering",20],["Gering",50],["Mittel",90],["Hoch",105],["Sehr hoch",128]],
  "Je hoeher die Objektdichte ist, desto mehr AKTIVE Feinde koennen spawnen.",
  ["Mittel",90]];
/*3*/_parameter pushback ["Groesse Flaggenzone",[["Sehr klein",15],["Klein",30],["Mittel",50],["Gross",75],["Sehr gross",100]],
  "Gibt an wie gross die zu verteidigende Zone ist. Je groesser die Zone ist, desto schwieriger ist es sie zu verteidigen!",
  ["Mittel",50]];
/*4*/_parameter pushback ["Punkte-Rate",[["Sehr gering",5000],["Gering",7000],["Mittel",10000],["Hoch",15000],["Sehr hoch",20000]],
  "Gibt an wie schnell die Zu- und Abnahme der Punkte ist.",
  ["Mittel",10000]];
/*5*/_parameter pushback ["Dichte Landfahrzeug-Spawn",[["Sehr gering",1],["Gering",2],["Mittel",4],["Hoch",8],["Sehr hoch",12]],
  "Je geringer der Wert, desto hoeher die WAHRSCHEINLICHKEIT, dass feindliche Landfahrzeuge NUR AUS EINER RICHTUNG anfahren.",
  ["Mittel",5]];
/*6*/_parameter pushback ["Dichte Infanterie-Spawn",[["Sehr gering",1],["Gering",2],["Mittel",4],["Hoch",8],["Sehr hoch",12]],
  "Je geringer der Wert, desto hoeher die WAHRSCHEINLICHKEIT, dass feindliche Infanterie nur aus einer wenigen Richtungen anrueckt.",
  ["Mittel",5]];
/*7*/_parameter pushback ["Wahrscheinlichkeit Infanterie",_100er,
  "Wahrscheinlichkeit auf Infanterie-Spawn. ACHTUNG: Kann relativiert werden durch andere Wahrscheinlichkeiten!",
  ["50 %",50]];
/*8*/_parameter pushback ["Wahrscheinlichkeit Radfahrzeuge",_100er,
  "Wahrscheinlichkeit auf Radfahrzeuge-Spawn. ACHTUNG: Kann relativiert werden durch andere Wahrscheinlichkeiten!",
  ["50 %",50]];
/*9*/_parameter pushback ["Wahrscheinlichkeit Kettenfahrzeuge",_100er,
  "Wahrscheinlichkeit auf Kettenfahrzeuge-Spawn. ACHTUNG: Kann relativiert werden durch andere Wahrscheinlichkeiten!",
  ["50 %",50]];
/*10*/_parameter pushback ["Wahrscheinlichkeit Flugzeuge",_100er,
  "Wahrscheinlichkeit auf Flugzeug-Spawn. ACHTUNG: Kann relativiert werden durch andere Wahrscheinlichkeiten!",
  ["50 %",50]];
/*11*/_parameter pushback ["Wahrscheinlichkeit Helikopter",_100er,
  "Wahrscheinlichkeit auf Helikopter-Spawn. ACHTUNG: Kann relativiert werden durch andere Wahrscheinlichkeiten!",
  ["50 %",50]];
/*12*/_parameter pushback ["Entfernung Infanterie",[["Sehr weit",70],["Weit",600],["Mittel",500],["Nah",400],["Sehr nah",300]],
  "Gibt an wie schnell der Erstkontakt mit feindlicher Infanterie stattfindet. ACHTUNG: Je schneller der Erstkontakt, desto weniger Zeit bleibt um Vorbereitungen zu treffen (Minen, etc.)!",
  ["Mittel",500]];


// # auslesen gespeicherter werte -> achtung: diese werte enthalten nur DIE GEWAEHLTEN paranmeter, nicht die vollstaendige auswahl
private _parameter_inidbi = [s_vert_missionskennung,[]] call fnc_s_sys_missionsparameter_inidbi;
if (((count _parameter_inidbi) > 0) && {(count _parameter_inidbi) == (count _parameter)}) then {
  {_x set [3,(_parameter_inidbi select _foreachindex) select 1]} foreach _parameter;
};


[_parameter,s_mission_params select 2] remoteexec ["fnc_a_mission_spieler_waehlt_parameter",remoteExecutedOwner];

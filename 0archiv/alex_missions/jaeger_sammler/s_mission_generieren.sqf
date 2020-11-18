/*
  s_mission_generieren.sqf
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

// ########################################################################################################################################## pflicht start
private _parameter_uebergabe = _this;
private _erstellte_objekte = [];
private _erstellte_marker = [];

// # bei erstaufruf die parameter in reduzierter form speichern
/* A N P A S S E N */if (s_missionsgenerierungen == s_js_missionsgenerierungen_max) then {
  private _parameter_inidbi = [];
    {_parameter_inidbi pushback [_x select 0,_x select 3]} foreach _parameter_uebergabe;
  /* A N P A S S E N */[s_js_missionskennung,_parameter_inidbi] call fnc_s_sys_missionsparameter_inidbi;
};

// # durchlaufzaehler verringern und vorgang ggf beenden
s_missionsgenerierungen = s_missionsgenerierungen -1;
if (s_missionsgenerierungen == 0) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Missionsparameter haben in meheren Durchlaeufen zu keinem Ergebnis gefuehrt. Missionsanforderung bitte wiederholen und ggf Parameter anpassen!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [[],[]] execvm "alex_scripte\s_mission_loeschen.sqf";
};
/* A N P A S S E N */[[format["<t color='#ff0000' size='2'>Generiere: %1 (%2)...",s_mission_params_js select 1,s_missionsgenerierungen], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];


// hier gilt : remoteExecutedOwner !
private _spieler_param = [];
/* Parameterliste: (aus s_mission_parameter_an_spieler.sqf)
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
{_spieler_param pushback ((_x select 3) select 1)} foreach _parameter_uebergabe;

// # durch parameter neu gesetzte globals

// # anpassung globaler veriablen

// ########################################################################################################################################## pflicht ende
// # zielfahrzeug erstellen
s_js_zielfahrzeug = (s_js_zielfahrzeug_parms select 0) createvehicle [0,0,0];
s_js_zielfahrzeug setdir (s_js_zielfahrzeug_parms select 2);
s_js_zielfahrzeug setposworld (s_js_zielfahrzeug_parms select 1);
s_js_zielfahrzeug setfuel 0;
s_js_zielfahrzeug allowdammage false;
// # startfahrzeug erstellen
s_js_startfahrzeug = (eo_js_obj_startpos_parms select 0) createvehicle [0,0,0];
s_js_startfahrzeug setdir (eo_js_obj_startpos_parms select 2);
s_js_startfahrzeug setposworld (eo_js_obj_startpos_parms select 1);
s_js_startfahrzeug setfuel 0;
s_js_startfahrzeug allowdammage false;

// ########################################################################################################################################## pflicht start

_core_params = [
  _erstellte_objekte,
  _erstellte_marker
];

_core_params execvm (format["%1s_mission_core.sqf",s_mission_params select 2]);

// ########################################################################################################################################## pflicht ende

/*
  init_server.sqf
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


// # funktionen
s_fnc_js_spieler_startet_neu = compile preprocessfilelinenumbers "alex_missions\jaeger_sammler\s_fnc_js_spieler_startet_neu.sqf";


// # params aus editor
eo_js_obj_startpos_parms = [typeof eo_js_obj_startpos,getposworld eo_js_obj_startpos,getdir eo_js_obj_startpos]; deletevehicle eo_js_obj_startpos;
s_js_zielfahrzeug_parms = [typeof eo_js_zielfahrzeug,getposworld eo_js_zielfahrzeug,getdir eo_js_zielfahrzeug]; deletevehicle eo_js_zielfahrzeug;


// # params aus config







// # params (global, mission-bezogen)
s_js_missionsgenerierungen_max = 20;
s_js_missionskennung = "js";
s_js_dist_ausserhalb_gruppe = 100;
s_js_anfuehrer_uid = ""; // wird in "anfordern" gesetzt
s_js_anfuehrer_netid = ""; // wird in "anfordern" gesetzt
s_js_neuspawndist = s_js_dist_ausserhalb_gruppe/2;
s_js_zielfahrzeug = objnull;
s_js_startfahrzeug = objnull;
/*_uid_var = [
  _netid,
  _pos,
  getdir _spieler,
  getdammage _spieler,
  getunitloadout _spieler
]*/



// # params durch spielerparameter beeinflusst
/* Parameterliste: (aus s_mission_parameter_an_spieler.sqf)
0 ["Spawnabstaende",[["Sehr schnell",2],["Schnell",3],["Mittel",4],["Langsam",5],["Sehr Langsam",6]],
1 ["Maximale Anzahl Zombies im Gebiet",[["Sehr wenig",5],["Wenig",15],["Normal",25],["Viele",40],["Sehr viele",60]],
2 ["Verdichtung Zombies um Zivilisten",[["Sehr gering",120],["Gering",100],["Normal",80],["Hoch",60],["Sehr hoch",40]]
3 ["Distanzaktivierung Zombie-Spawn",[["Sehr Langsam",250],["Langsam",400],["Normal",550],["Schnell",700],["Sehr schnell",850]]
4 ["Spawndistanz Zombies",[["Sehr weit",500],["Weit",400],["Normal",300],["Nah",200],["Sehr nah",100]]
5 ["MIBUs 50-Prozent-Regel",[["Aktiv",true],["Inaktiv",false]]
6 ["GUSTLs Mischung (Zombie-Anteil)",_100er,
7 ["Freundschaft unter Feinden und Zombies",[["Befreundet",true],["Verfeindet",false]]
*/


// # liste fuer missions-relevante locations erstellen
s_mission_params_js = [
  /*0: mission aktiv ?*/  true,
  /*1: name der Missione*/  "Jaeger und Sammler",
  /*2: missionspfad zb "alex_missions\memo_deathmatch\" */ "alex_missions\jaeger_sammler\",
  /*3: aktuelle punkte aus mission */ 0,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ true,
  /* 6: ausstattungen verfuegbar */ true
];
s_missions_auswahl pushback s_mission_params_js;

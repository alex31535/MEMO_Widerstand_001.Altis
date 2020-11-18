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
#define _DEF_spieler_max 16

// # funktionen
s_fnc_rettz_loc_erstellen = compile preprocessfilelinenumbers "alex_missions\rettung_z\s_fnc_rettz_loc_erstellen.sqf";

// # params aus editor
private _platzbedarf_cargo_spieler = _DEF_spieler_max
      -(count(fullCrew [eo_rettz_heli_transport, "driver", true]))
      -(count(fullCrew [eo_rettz_heli_transport, "commander", true]))
      -(count(fullCrew [eo_rettz_heli_transport, "gunner", true]))
      -(count(fullCrew [eo_rettz_heli_transport, "turret", true]));

s_rettz_params_heli_transport = [
  typeof eo_rettz_heli_transport,
  position eo_rettz_heli_transport,
  getdir eo_rettz_heli_transport,
  /* anz zivilisten*/(getNumber (configFile >> "CfgVehicles" >> typeof eo_rettz_heli_transport >> "transportSoldier")) - _platzbedarf_cargo_spieler
];
deletevehicle eo_rettz_heli_transport;


// # params aus config
private _helis_aus_config = s_sys_vec_heli_0; _helis_aus_config append s_sys_vec_heli_1; _helis_aus_config append s_sys_vec_heli_2; _helis_aus_config append s_sys_vec_heli_3;
private _anz_sitzplaetze = 0;
s_rettz_heli_auswahl = [/*[0:anz ziv, 1:displayname, 2:klasse]*/];
private _vec = objnull;
{
  _vec = _x createvehicle (s_rettz_params_heli_transport select 1);
  waituntil {!isnull _vec};
  _anz_sitzplaetze = (getNumber (configFile >> "CfgVehicles" >> typeof _vec >> "transportSoldier"));
  //  (count(fullCrew [_vec, "driver", true]))
  //  +(count(fullCrew [_vec, "commander", true]))
  //  +(count(fullCrew [_vec, "turret", true]))
    //  +(count(fullCrew [_vec, "gunner", true]))
  //  +(count(fullCrew [_vec, "cargo", true]))
  //  -_DEF_spieler_max;
  if (_anz_sitzplaetze > 3) then {
    s_rettz_heli_auswahl pushback [_anz_sitzplaetze,gettext (configFile >> "CfgVehicles" >> _x >> "displayname"),_x];
  };
  deletevehicle _vec; uisleep 0.1;
} foreach _helis_aus_config;
s_rettz_heli_auswahl sort true;


// # abbruch: transport-fahrzeug hat keinen platz fuer zivilisten
if ((count s_rettz_heli_auswahl) == 0) exitwith {systemchat "init Rettung (Z-Edition): Fehler - Keine geeigneten Transportmittel In Config gefunden...."};




// # params (global, mission-bezogen)
s_rettz_anz_zivilisten = s_rettz_params_heli_transport select 3;// wird in generieren neu abgefragt/gesetzt anhand der vom spieler gewaehlet hil-parameter
s_rettz_missionsgenerierungen_max = 20;
s_rettz_missionskennung = "rettz";
s_rettz_anz_max_objekte = 128;
s_rettz_zombieklassen_allgemein = []; // wird in "generieren" immer wieder mit neuen inhalten anhand gesetzter parameter angepasst......
s_rettz_unitklassen_allgemein = [s_units_aus_cfg_0 select 0];// nur eine bsp-unit benoetigt, da loudout dyn. geaendert wird
s_rettz_zivilist_getoetet = 0; // wir ueber killed-event erhoeht und im core abgefragt. zaehler dient zur abstimmung mit "s_rettz_mibus_50_prozent"



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
s_rettz_zeitintervall_spawn = 10;
s_rettz_max_anz_zombies = 25;
s_rettz_strassendistanz_ziv = 80;
s_rettz_area_dist_aktivierung = 500;
s_rettz_spawn_dist = 300;
s_rettz_mibus_50_prozent = true;
s_rettz_gustls_mischung = 50;
s_rettz_freundschaft = true;

// # liste fuer missions-relevante locations erstellen
s_mission_params_rettz = [
  /*0: mission aktiv ?*/  true,
  /*1: name der Missione*/  "Rettung (MiGu-Edition)",
  /*2: missionspfad zb "alex_missions\memo_deathmatch\" */ "alex_missions\rettung_z\",
  /*3: aktuelle punkte aus mission */ 0,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ true,
  /* 6: ausstattungen verfuegbar */ true
];
s_missions_auswahl pushback s_mission_params_rettz;

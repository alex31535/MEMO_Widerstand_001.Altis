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
#define _DEF_anz_demons 4
#define _DEF_min_anz_geb_positionen_in_loc_zivilist 4
// ########################################################################################################################################## pflicht start
private _parameter_uebergabe = _this;
private _erstellte_objekte = [];
private _erstellte_marker = [];

// # bei erstaufruf die parameter in reduzierter form speichern
if (s_missionsgenerierungen == s_rettz_missionsgenerierungen_max) then {
  private _parameter_inidbi = [];
    {_parameter_inidbi pushback [_x select 0,_x select 3]} foreach _parameter_uebergabe;
  [s_rettz_missionskennung,_parameter_inidbi] call fnc_s_sys_missionsparameter_inidbi;
};

// # durchlaufzaehler verringern und vorgang ggf beenden
s_missionsgenerierungen = s_missionsgenerierungen -1;
if (s_missionsgenerierungen == 0) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Missionsparameter haben in meheren Durchlaeufen zu keinem Ergebnis gefuehrt. Missionsanforderung bitte wiederholen und ggf Parameter anpassen!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [[],[]] execvm "alex_scripte\s_mission_loeschen.sqf";
};
[[format["<t color='#ff0000' size='2'>Generiere: %1 (%2)...",s_mission_params_rettz select 1,s_missionsgenerierungen], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];


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
9 ["Zu rettende Zivilisten",_100er,
*/
{_spieler_param pushback ((_x select 3) select 1)} foreach _parameter_uebergabe;





// # durch parameter neu gesetzte globals
s_rettz_zeitintervall_spawn = _spieler_param select 0;
s_rettz_max_anz_zombies = _spieler_param select 1;
s_rettz_strassendistanz_ziv = _spieler_param select 2;
s_rettz_area_dist_aktivierung = _spieler_param select 3;
s_rettz_spawn_dist = _spieler_param select 4;
private _rettz_mibus_50_prozent = _spieler_param select 5;
s_rettz_gustls_mischung = _spieler_param select 6;
s_rettz_freundschaft = _spieler_param select 7;
private _s_rettz_heli_auswahl_index = _spieler_param select 8;
s_rettz_anz_zivilisten = _spieler_param select 9;

// # anpassung globaler veriablen
s_rettz_anz_zivilisten_tot_max = 0;
if ((s_rettz_anz_zivilisten > 2) && {_rettz_mibus_50_prozent}) then {s_rettz_anz_zivilisten_tot_max = ceil(s_rettz_anz_zivilisten/2)};
s_rettz_params_heli_transport set [0,(s_rettz_heli_auswahl select _s_rettz_heli_auswahl_index) select 2];
s_rettz_zombieklassen_allgemein = [];
if (s_rettz_gustls_mischung > 0) then {
  private _zombieliste = if (s_rettz_freundschaft) then [{s_zombies_aus_cfg_0},{s_zombies_aus_cfg_2}];
  {
    if (
        ((_x find "Crawler") == -1)
        && {(_x find "medium") == -1}
        && {(_x find "Player") == -1}
        && {(_x find "slow") == -1}
        && {(_x find "Spider") == -1}
        && {(_x find "walker") == -1}
      ) then {s_rettz_zombieklassen_allgemein pushback _x};
  } foreach _zombieliste;
  private _zombieliste = if (s_rettz_freundschaft) then [{s_zombieboss_aus_cfg_0},{s_zombieboss_aus_cfg_2}];
  for "_i" from 1 to _DEF_anz_demons do {s_rettz_zombieklassen_allgemein pushback (selectrandom _zombieliste)};
  s_rettz_zombieklassen_allgemein call BIS_fnc_arrayShuffle;
};



// ########################################################################################################################################## pflicht ende
private _verteiler_unit_zombie = [];
for "_i" from 1 to (100 - s_rettz_gustls_mischung) do {_verteiler_unit_zombie pushback "u"};
if (s_rettz_gustls_mischung > 0) then {
  while {(count _verteiler_unit_zombie) < 100} do {_verteiler_unit_zombie pushback "z"};
  _verteiler_unit_zombie call BIS_fnc_arrayShuffle;
};



private _positionen_innerhalb_haus = [];
private _auswahl_innenpositionen_grob = [];
private _liste_hauspos = [/*0:hauspos_innen*/];
{
  _auswahl_innenpositionen_grob = [];
  {
    _positionen_innerhalb_haus = [_x] call fnc_a_sys_positionen_innerhalb_haus;
    if ((count _positionen_innerhalb_haus) > 0) then {_auswahl_innenpositionen_grob pushback (selectrandom _positionen_innerhalb_haus)};
  } foreach ([((_x select 1) select 0), 80, _DEF_min_anz_geb_positionen_in_loc_zivilist] call fnc_a_sys_gebaeudeauswahl);
  if ((count _auswahl_innenpositionen_grob) > 0) then {_liste_hauspos pushback (selectrandom _auswahl_innenpositionen_grob)};
} foreach s_sys_locations;


if ((count _liste_hauspos) < s_rettz_anz_zivilisten) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Nicht genug Positionen fuer Zivilisten in Location-Auswahl gefunden. Neugenerierung wird ausgeloest!",s_mission_params_rettz select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [_this,_erstellte_objekte,_erstellte_marker] call fnc_s_missionsgenerierung_wiederholen;
};
while {(count _liste_hauspos) > s_rettz_anz_zivilisten} do {_liste_hauspos deleteat (floor(random(count _liste_hauspos)))};





// # fahrzeuge erstellen
private _vec_transport_fob = (s_rettz_params_heli_transport select 0) createvehicle [0,0,0];
_vec_transport_fob allowdammage false;
_vec_transport_fob setdir (s_rettz_params_heli_transport select 2);
//_vec_transport_fob setposworld (s_rettz_params_heli_transport select 1);
_vec_transport_fob setpos (s_rettz_params_heli_transport select 1);
_erstellte_objekte pushback _vec_transport_fob;
_vec_transport_fob allowCrewInImmobile true;
_vec_transport_fob setUnloadInCombat [false, false];
[_vec_transport_fob] spawn fnc_s_sys_garage_mob_fob_universal;




// ########################################################################################################################################## pflicht start
s_rettz_zivilisten_getoetet = 0;
s_rettz_zivilisten_gerettet = 0;

_core_params = [
  _erstellte_objekte,
  _erstellte_marker,
  _liste_hauspos, /* 0:hauspos_innen*/
  _vec_transport_fob,
  _verteiler_unit_zombie
];


_core_params execvm (format["%1s_mission_core.sqf",s_mission_params select 2]);

{
  [[format["<t color='#02bf1b' size='6'>Neuer Auftrag: Retten Sie nacheinander %1 Zivilisten bei maximal %2 Verlusten!",s_rettz_anz_zivilisten,s_rettz_anz_zivilisten_tot_max], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach playableunits;
// ########################################################################################################################################## pflicht ende

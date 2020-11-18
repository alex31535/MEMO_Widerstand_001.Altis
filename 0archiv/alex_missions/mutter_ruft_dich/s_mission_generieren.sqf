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


private _parameter_uebergabe = _this;

// # bei erstaufruf die parameter in reduzierter form speichern
if (s_missionsgenerierungen == s_mrd_missionsgenerierungen_max) then {
  private _parameter_inidbi = [];
    {_parameter_inidbi pushback [_x select 0,_x select 3]} foreach _parameter_uebergabe;
/* A N P A S S E N */  [s_mrd_missionskennung,_parameter_inidbi] call fnc_s_sys_missionsparameter_inidbi; /* A N P A S S E N */
};


// # durchlaufzaehler verringern und vorgang ggf beenden
s_missionsgenerierungen = s_missionsgenerierungen -1;
if (s_missionsgenerierungen == 0) exitwith {
  [[format["<t color='#ff0000' size='2'>Abbruch: %1 - Missionsparameter haben in meheren Durchlaeufen zu keinem Ergebnis gefuehrt. Missionsanforderung bitte wiederholen und ggf Parameter anpassen!",s_mission_params_vert select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];
  [[],[]] execvm "alex_scripte\s_mission_loeschen.sqf";
};
/* A N P A S S E N */[[format["<t color='#ff0000' size='2'>Generiere: %1 (%2)...",s_mission_params_mrd select 1,s_missionsgenerierungen], "PLAIN", -1, true, true]] remoteExec ["cutText",remoteExecutedOwner];



// hier gilt : remoteExecutedOwner !
private _spieler_param = [];
/* Parameterliste: (aus s_mission_parameter_an_spieler.sqf)
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
{_spieler_param pushback ((_x select 3) select 1)} foreach _parameter_uebergabe;


// # parameter fuer weitergabe an core:
private _vert_p_spawnabstaende = _spieler_param select 0;


private _erstellte_objekte = [];
private _erstellte_marker = [];
// # INDIVIDUELL ------------------------------------------------------------------------------------------------------------------------------------------
//s_mrd_params_gepard pushback [typeof _eo,getposworld _eo,getdir _eo];
//s_mrd_params_inst pushback [typeof _eo,getposworld _eo,getdir _eo];
//s_mrd_params_ammo pushback [typeof _eo,getposworld _eo,getdir _eo];
//s_mrd_params_benzin pushback [typeof _eo,getposworld _eo,getdir _eo];
//s_mrd_params_fob = [typeof eo_mrd_fob,getposworld eo_mrd_fob,getdir eo_mrd_fob]; deletevehicle eo_mrd_fob;
//s_mrd_params_ari = [typeof s_mrd_params_ari,getposworld s_mrd_params_ari,getdir s_mrd_params_ari]; deletevehicle s_mrd_params_ari;
//s_mrd_area_moerserziel = [getmarkerpos "em_mrd_moerserziel",(getmarkersize "em_mrd_moerserziel") select 0,(getmarkersize "em_mrd_moerserziel") select 1,markerDir "em_mrd_moerserziel",false];
//s_mrd_area_spawn_inf = [getmarkerpos "em_mrd_spawn_inf",(getmarkersize "em_mrd_spawn_inf") select 0,(getmarkersize "em_mrd_spawn_inf") select 1,markerDir "em_mrd_spawn_inf",false];
//s_mrd_area_todeszone= [getmarkerpos "em_mrd_todeszone",(getmarkersize "em_mrd_todeszone") select 0,(getmarkersize "em_mrd_todeszone") select 1,markerDir "em_mrd_todeszone",true];
//s_mrd_params_sani = [typeof eo_mrd_sani,getposworld eo_mrd_sani,getdir eo_mrd_sani]; deletevehicle eo_mrd_sani;

// # gepards erstellen
private _obj = objnull;
private _marker_beweglich = [];
private _marker = "";
private _gepards = [];
{
  _obj = (_x select 0) createVehicle [0,0,0];
  _obj setdir (_x select 2);
  _obj setposworld (_x select 1);
  _gepards pushback _obj;
  _erstellte_objekte pushback _obj;
  _marker = createMarker [format["%1",netid _obj], position _obj];
  _marker setMarkerType "b_antiair";
  _marker_beweglich pushback _marker;
  _erstellte_marker pushback _marker;
} foreach s_mrd_params_gepard;

// # inst-fahrzeuge erstellen
private _fahrzeuge_inst = [];
{
  _obj = (_x select 0) createVehicle [0,0,0];
  _obj setdir (_x select 2);
  _obj setposworld (_x select 1);
  _fahrzeuge_inst pushback _obj;
  _erstellte_objekte pushback _obj;
  _marker = createMarker [format["%1",netid _obj], position _obj];
  _marker setMarkerType "b_maint";
  _marker_beweglich pushback _marker;
  _erstellte_marker pushback _marker;
} foreach s_mrd_params_inst;

// # ammo-fahrzeuge erstellen
private _fahrzeuge_ammo = [];
{
  _obj = (_x select 0) createVehicle [0,0,0];
  _obj setdir (_x select 2);
  _obj setposworld (_x select 1);
  _fahrzeuge_ammo pushback _obj;
  _erstellte_objekte pushback _obj;
  _marker = createMarker [format["%1",netid _obj], position _obj];
  _marker setMarkerType "b_support";
  _marker_beweglich pushback _marker;
  _erstellte_marker pushback _marker;
} foreach s_mrd_params_ammo;

// # tank-fahrzeuge erstellen
private _fahrzeuge_benzin = [];
{
  _obj = (_x select 0) createVehicle [0,0,0];
  _obj setdir (_x select 2);
  _obj setposworld (_x select 1);
  _fahrzeuge_benzin pushback _obj;
  _erstellte_objekte pushback _obj;
  _marker = createMarker [format["%1",netid _obj], position _obj];
  _marker setMarkerType "b_service";
  _marker_beweglich pushback _marker;
  _erstellte_marker pushback _marker;
} foreach s_mrd_params_benzin;

// # ari erstellen
private _ari = (s_mrd_params_ari select 0) createVehicle [0,0,0];
_ari setdir (s_mrd_params_ari select 2);
_ari setposworld (s_mrd_params_ari select 1);
_erstellte_objekte pushback _ari;
_marker = createMarker [format["%1",netid _ari], position _ari];
_marker setMarkerType "b_art";
_marker_beweglich pushback _marker;
_erstellte_marker pushback _marker;
_ari lock 3;
private _schuetze_ari = (creategroup [west,true]) createUnit ["B_Survivor_F", [0,0,0], [], 0, "NONE"];
_schuetze_ari assignasgunner _ari;
_schuetze_ari moveingunner _ari;
_schuetze_ari disableAI "FSM";
_ari allowCrewInImmobile true;
_ari setUnloadInCombat [false, false];
_erstellte_objekte pushback _schuetze_ari;

// # fob erstellen
private _fob = (s_mrd_params_fob select 0) createVehicle [0,0,0];
_fob setdir (s_mrd_params_fob select 2);
_fob setposworld (s_mrd_params_fob select 1);
_erstellte_objekte pushback _fob;
_marker = createMarker [format["%1",netid _fob], position _fob];
_marker setMarkerType "b_hq";
_marker_beweglich pushback _marker;
_erstellte_marker pushback _marker;
[_fob] spawn fnc_s_sys_garage_mob_fob_universal;

// # sani erstellen
private _sani = (s_mrd_params_sani select 0) createVehicle [0,0,0];
_sani setdir (s_mrd_params_sani select 2);
_sani setposworld (s_mrd_params_sani select 1);
_erstellte_objekte pushback _sani;
_marker = createMarker [format["%1",netid _sani], position _sani];
_marker setMarkerType "b_med";
_marker_beweglich pushback _marker;
_erstellte_marker pushback _marker;

// # moerser erstellen
private _moerser = [];
{
  _obj = (_x select 0) createVehicle [0,0,0];
  _obj setdir (_x select 2);
  _obj setposworld (_x select 1);
  _obj allowdammage false;
  _moerser pushback _obj;
  _erstellte_objekte pushback _obj;
  _marker = createMarker [format["%1",netid _obj], position _obj];
  _marker setMarkerType "b_art";
  _erstellte_marker pushback _marker;
} foreach s_mrd_params_moerser;


private _spawngebaeude = [s_mrd_area_spawn_inf select 0, s_mrd_area_spawn_inf select 1,2] call fnc_a_sys_gebaeudeauswahl;




// # MARKIERUNGEN --------------------------------------------------------------------------------------------



// # UEBERGABE A CORE --------------------------------------------------------------------------------------------
_core_params = [
  _erstellte_objekte,
  _erstellte_marker,
  _marker_beweglich,
  _gepards,
  _fahrzeuge_benzin,
  _fahrzeuge_ammo,
  _fahrzeuge_inst,
  _ari,
  _fob,
  _sani,
  _moerser,
  _schuetze_ari,
  _spawngebaeude
];
_core_params execvm (format["%1s_mission_core.sqf",s_mission_params select 2]);

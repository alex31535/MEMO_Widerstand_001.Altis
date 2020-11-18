/*
  init_hlhc_server.sqf
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


// # gebaeudeschutz fuer mission
{_x allowdammage false} foreach ((getmarkerpos "em_mrd_gebaeudeschutz") nearObjects ["House",(getmarkersize "em_mrd_gebaeudeschutz") select 0]);
deletemarker "em_mrd_gebaeudeschutz";



// # parameter aus editor
private _eo = objnull;
s_mrd_params_gepard = [];
for "_i" from 0 to 100 do {
  call compile format["_eo = if (isnil ""eo_mrd_gepard_%1"") then [{objnull},{eo_mrd_gepard_%1}];",_i];
  if (!isnull _eo) then {
    s_mrd_params_gepard pushback [typeof _eo,getposworld _eo,getdir _eo];
    deletevehicle _eo;
  };
};
s_mrd_params_inst = [];
for "_i" from 0 to 100 do {
  call compile format["_eo = if (isnil ""eo_mrd_inst_%1"") then [{objnull},{eo_mrd_inst_%1}];",_i];
  if (!isnull _eo) then {
    s_mrd_params_inst pushback [typeof _eo,getposworld _eo,getdir _eo];
    deletevehicle _eo;
  };
};
s_mrd_params_ammo = [];
for "_i" from 0 to 100 do {
  call compile format["_eo = if (isnil ""eo_mrd_ammo_%1"") then [{objnull},{eo_mrd_ammo_%1}];",_i];
  if (!isnull _eo) then {
    s_mrd_params_ammo pushback [typeof _eo,getposworld _eo,getdir _eo];
    deletevehicle _eo;
  };
};
s_mrd_params_benzin = [];
for "_i" from 0 to 100 do {
  call compile format["_eo = if (isnil ""eo_mrd_benzin_%1"") then [{objnull},{eo_mrd_benzin_%1}];",_i];
  if (!isnull _eo) then {
    s_mrd_params_benzin pushback [typeof _eo,getposworld _eo,getdir _eo];
    deletevehicle _eo;
  };
};
s_mrd_params_moerser = [];
for "_i" from 0 to 100 do {
  call compile format["_eo = if (isnil ""eo_mrd_moerser_%1"") then [{objnull},{eo_mrd_moerser_%1}];",_i];
  if (!isnull _eo) then {
    s_mrd_params_moerser pushback [typeof _eo,getposworld _eo,getdir _eo];
    deletevehicle _eo;
  };
};
s_mrd_params_flug_startpositionen = [];
for "_i" from 0 to 100 do {
  _eo = format["em_mrd_flug_startposition_%1",_i];
  if ((getMarkerType _eo) != "") then {
    s_mrd_params_flug_startpositionen pushback (getmarkerpos _eo);
    deletemarker _eo;
  };
};


for "_i" from 0 to 100 do {
  _eo = format["em_explo_%1",_i];
  if ((getMarkerType _eo) != "") then {
    "Bo_GBU12_LGB" createVehicle (getmarkerpos _eo);
    deletemarker _eo;
  };
};

s_mrd_params_fob = [typeof eo_mrd_fob,getposworld eo_mrd_fob,getdir eo_mrd_fob]; deletevehicle eo_mrd_fob;
s_mrd_params_ari = [typeof eo_mrd_ari,getposworld eo_mrd_ari,getdir eo_mrd_ari]; deletevehicle eo_mrd_ari;
s_mrd_params_sani = [typeof eo_mrd_sani,getposworld eo_mrd_sani,getdir eo_mrd_sani]; deletevehicle eo_mrd_sani;
s_mrd_area_moerserziel = [getmarkerpos "em_mrd_moerserziel",(getmarkersize "em_mrd_moerserziel") select 0,(getmarkersize "em_mrd_moerserziel") select 1,markerDir "em_mrd_moerserziel",false];
deletemarker "em_mrd_moerserziel";
s_mrd_area_spawn_inf = [getmarkerpos "em_mrd_spawn_inf",(getmarkersize "em_mrd_spawn_inf") select 0,(getmarkersize "em_mrd_spawn_inf") select 1,markerDir "em_mrd_spawn_inf",false];
deletemarker "em_mrd_spawn_inf";
s_mrd_area_todeszone= [getmarkerpos "em_mrd_todeszone",(getmarkersize "em_mrd_todeszone") select 0,(getmarkersize "em_mrd_todeszone") select 1,markerDir "em_mrd_todeszone",true];
deletemarker "em_mrd_todeszone";

s_mrd_params_flug_klassen = [];
for "_i" from 0 to 100 do {
  call compile format["_eo = if (isnil ""eo_mrd_flug_%1"") then [{objnull},{eo_mrd_flug_%1}];",_i];
  if (!isnull _eo) then {
    s_mrd_params_flug_klassen pushback (typeof _eo);
    deletevehicle _eo;
  };
};
s_mrd_params_klassen_allgemein = [];
for "_i" from 0 to 100 do {
  call compile format["_eo = if (isnil ""eo_mrd_ki_%1"") then [{objnull},{eo_mrd_ki_%1}];",_i];
  if (!isnull _eo) then {
    s_mrd_params_klassen_allgemein pushback (typeof _eo);
    deletevehicle _eo;
  };
};
s_mrd_params_klassen_at = [];
for "_i" from 0 to 100 do {
  call compile format["_eo = if (isnil ""eo_mrd_ki_at_%1"") then [{objnull},{eo_mrd_ki_at_%1}];",_i];
  if (!isnull _eo) then {
    s_mrd_params_klassen_at pushback (typeof _eo);
    deletevehicle _eo;
  };
};

// # params (global, mission-bezogen)
s_mrd_missionsgenerierungen_max = 10;
s_mrd_missionskennung = "mrd";
s_mrd_ari_salven_max = 100;
s_mrd_ari_zeiten = [20,30,40,50,40,30,25,35,45,55,45,35,20,30,40,50,40,30];
s_mrd_flug_zeiten = [5,10,15,20,15,10,5];
s_mrd_ki_zeiten = [2,2,2,3,4,2,3,4,2,3,4,2,2,2];
s_mrd_moerser_zeiten = [5,10,15,5,10,15,5,10,15,5,10,15];
s_mrd_anz_flug_max = 3;
s_mrd_startverzoegerung = 4; // in minuten!!
s_mrd_objektlimit = 128;
s_mrd_moerser_besetzen_zufall = [false,true,false,false,false,false,true,false,false,false,true];
s_mrd_moerser_zufall_auf_spieler = [false,true,false,false,false,false,true,false,false,false,true];



// # liste fuer missions-relevante locations erstellen
s_mission_params_mrd = [
  /*0: mission aktiv ?*/  true,
  /*1: name der Missione*/  "Mutter ruft dich!",
  /*2: missionspfad zb "alex_missions\memo_deathmatch\" */ "alex_missions\mutter_ruft_dich\",
  /*3: aktuelle punkte aus mission */ 0,
  /* 4: notaus */ false,
  /* 5: garagen verfuegbar */ false,
  /* 6: ausstattungen verfuegbar */ true
];
s_missions_auswahl pushback s_mission_params_mrd;

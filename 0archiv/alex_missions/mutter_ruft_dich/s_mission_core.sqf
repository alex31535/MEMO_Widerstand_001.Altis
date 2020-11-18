/*
  s_mission_core.sqf
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
//s_mrd_area_moerserziel = [getmarkerpos "em_mrd_moerserziel",(getmarkersize "em_mrd_moerserziel") select 0,(getmarkersize "em_mrd_moerserziel") select 1,markerDir "em_mrd_moerserziel",false];
//s_mrd_area_spawn_inf = [getmarkerpos "em_mrd_spawn_inf",(getmarkersize "em_mrd_spawn_inf") select 0,(getmarkersize "em_mrd_spawn_inf") select 1,markerDir "em_mrd_spawn_inf",false];
//s_mrd_area_todeszone= [getmarkerpos "em_mrd_todeszone",(getmarkersize "em_mrd_todeszone") select 0,(getmarkersize "em_mrd_todeszone") select 1,markerDir "em_mrd_todeszone",true];

params ["_erstellte_objekte","_erstellte_marker","_marker_beweglich",
          "_gepards","_fahrzeuge_benzin","_fahrzeuge_ammo","_fahrzeuge_inst",
          "_ari","_fob","_sani","_moerser","_schuetze_ari","_spawngebaeude"];


{
  [[format["<t color='#02bf1b' size='4'>In %1 Minuten startet der Angriff auf die Artilleriestellung bei Modesta!",s_mrd_startverzoegerung], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach playableunits;

systemchat format ["%1: Core wird gestartet...",s_mission_params_vert select 1];
// # core ----------------------------------------------------------------------------------------------------------------------------- core
private _missionsende_resultat = "";
private _obj = objnull;
private _pos = [];
private _winkel = -1;
private _dist = -1;
private _anz_salven = 0;
private _aktive_flugobjekte = [];
private _moerser_besetzt = [];
private _moerser_frei = [];
private _wp = "";
private _moerser_gewaehlt = objnull;
private _zeitstempel_ari = time + (s_mrd_startverzoegerung *60) +5;
private _zeitstempel_flug = time + (s_mrd_startverzoegerung *60) +10;
private _zeitstempel_spawn_ki = time + (s_mrd_startverzoegerung *60) +15;
private _zeitstempel_moerser= time + (s_mrd_startverzoegerung *60) +20;

while {s_mission_params select 0} do {

  // # reset auf variablen


  // # listen pruefen
  _erstellte_objekte = _erstellte_objekte select {!isnull _x};
  _erstellte_objekte = _erstellte_objekte select {alive _x};
  _aktive_flugobjekte = _aktive_flugobjekte select {alive _x};
  _moerser_besetzt = [];
  _moerser_frei = [];
  {
    if (alive(gunner _x)) then {
      _moerser_besetzt pushback _x;
    } else {
      if (isnull(assignedGunner _x)) then {
        _moerser_frei pushback _x;
      } else {
        if (alive(assignedGunner _x)) then {
          _moerser_besetzt pushback _x;
        } else {
          _moerser_frei pushback _x;
        };
      };
    };
  } foreach _moerser;

systemchat format["m frei:%1 /besetzt:%2 (%3)",count _moerser_frei, count _moerser_besetzt,floor(time)];


  // # marker aktualisieren
  {
    //[format["%1",netid _obj], position _obj];
    //_obj = objectfromnetid _x
    _x setmarkerpos (position(objectfromnetid _x));
  } foreach _marker_beweglich;



//-----------------------
  // # moerser-ki und at-ki spawnen?
  if ((time > _zeitstempel_spawn_ki) && {(count _erstellte_objekte) < s_mrd_objektlimit}) then {
    _pos = selectrandom ((selectrandom _spawngebaeude) buildingpos -1);
    _obj = [_pos,s_mrd_params_klassen_allgemein] call fnc_s_sys_spawn_unit;
    if ((selectrandom s_mrd_moerser_besetzen_zufall) && {(count _moerser_frei) > 0}) then {
      _obj assignasgunner (selectrandom _moerser_frei);
      [_obj] orderGetIn true;
    } else {
      _obj setunitloadout s_mrd_params_klassen_at;
      _wp = (group _obj) addWaypoint [position _ari, 0];
      [(group _obj), 0] setWaypointBehaviour "COMBAT"; // COMBAT
      [(group _obj), 0] setWaypointSpeed "NORMAL";
      _wp setWaypointType "SAD";// Move
    };
    _erstellte_objekte pushback _obj;
    _zeitstempel_spawn_ki = time + (selectrandom s_mrd_ki_zeiten);
  };
//-----------------------

  // # moerser feuert?
  if ((time > _zeitstempel_moerser) && {(count _moerser_besetzt) > 0}) then {
    if ((selectrandom s_mrd_moerser_zufall_auf_spieler) && {(count (playableunits inareaarray s_mrd_area_moerserziel)) > 0}) then {
      _pos = position(selectrandom(playableunits inareaarray s_mrd_area_moerserziel));
    } else {
      _winkel = floor(random 360);
      _dist = random (s_mrd_area_moerserziel select 1);
      _pos = [
        ((s_mrd_area_moerserziel select 0) select 0) + ((sin _winkel) * _dist),
        ((s_mrd_area_moerserziel select 0) select 1) + ((cos _winkel) * _dist),
        0
      ];
    };
    _obj = selectrandom _moerser_besetzt;
    if (!(isnull(gunner _obj))) then {
      _obj commandArtilleryFire [_pos,"8Rnd_82mm_Mo_shells",1];
      _obj setVehicleAmmo 1;
    };
    _zeitstempel_moerser = time + (selectrandom s_mrd_moerser_zeiten);
  };

//-----------------------

  // # fluggeraete aufmunitionieren
  {_x setVehicleAmmo 1} foreach _aktive_flugobjekte;


  // # todeszone
  {
    _obj = createMine ["APERSMine", position _x, [], 0];
    _obj setdammage 1;
    (objectparent _x) setdammage 1;
  } foreach ((playableunits inareaarray s_mrd_area_todeszone) select {(lifeState _x) == "HEALTHY"});


  // # ari schiesst?
  if (time > _zeitstempel_ari) then {
    _winkel = floor(random 360);
    _dist = random (s_mrd_area_spawn_inf select 1);
    _pos = [
      ((s_mrd_area_spawn_inf select 0) select 0) + ((sin _winkel) * _dist),
      ((s_mrd_area_spawn_inf select 0) select 1) + ((cos _winkel) * _dist),
      0
    ];
    _ari commandArtilleryFire [_pos,"32Rnd_155mm_Mo_shells",1];
    _ari setVehicleAmmo 1;
    _zeitstempel_ari = time + (selectrandom s_mrd_ari_zeiten);
    {[[format["<t color='#c5d916' size='6'>Noch %1 Salven!",s_mrd_ari_salven_max - _anz_salven],"PLAIN DOWN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
    _anz_salven = _anz_salven +1;
  };


  // # flugobjekt spawnen ?
  if ((time > _zeitstempel_flug) && {(count _aktive_flugobjekte) < s_mrd_anz_flug_max} && {(count _erstellte_objekte) < s_mrd_objektlimit}) then {
    _obj = [selectrandom s_mrd_params_flug_startpositionen,_ari,s_mrd_params_flug_klassen] call fnc_s_sys_fluggeraet_start_ziel;
    {
      _x setSkill 0.95;
      _x doTarget _ari;
      _erstellte_objekte pushback _x;
    } foreach (crew _obj);
    _erstellte_objekte pushback _obj;
    _aktive_flugobjekte pushback _obj;
    _zeitstempel_flug = time + (selectrandom s_mrd_flug_zeiten);
  };



  // # missionsbeendigungen
  // +fob zerstoert
  if (!alive _fob) then {_missionsende_resultat = "fob zerstoert"; s_mission_params set [0,false]};
  // +ari zerstoert
  if (!alive _ari) then {_missionsende_resultat = "ari zerstoert"; s_mission_params set [0,false]};
  // +ari kann nicht mehr schiessen
  if (! canFire _ari) then {_missionsende_resultat = "ari kann nicht schiessen"; s_mission_params set [0,false]};
  // +ari-crew getoetet
  if ((count  ((crew _ari) select {alive _x})) == 0) then {_missionsende_resultat = "aricrew getoetet"; s_mission_params set [0,false]};
  // +max salven erreicht
  if (_anz_salven == s_mrd_ari_salven_max) then {_missionsende_resultat = "anz salven erreicht"; s_mission_params set [0,false]};
  // + notaus aktiviert?
  if (s_mission_params select 4) then {s_mission_params set [0,false]};



  uisleep 0.3;
};



// # manipulation missionsbezogener variablen




// # eventhandler entfernen






// # auswertung
switch (_missionsende_resultat) do {
  case "anz salven erreicht": {
    {
      [[format["<t color='#2cb02a' size='6'>Geschafft - Die Artillerie hat %1 Salven auf das Zielgebiet abgefeuert!",s_mrd_ari_salven_max], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
  case "fob zerstoert": {
    {
      [["<t color='#d93316' size='6'>Mission gescheitert - Sie haben das FOB verloren!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
  case "ari zerstoert": {
    {
      [["<t color='#d93316' size='6'>Mission gescheitert - Die Artillerie wurde zerstoert!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
  case "aricrew getoetet": {
    {
      [["<t color='#d93316' size='6'>Mission gescheitert - Die Artillerie-Mannschaft wurde getoetet!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
  case "ari kann nicht schiessen": {
    {
      [["<t color='#d93316' size='6'>Mission gescheitert - Das Waffensystem der Artillerie wurde zerstoert!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
};

copytoclipboard _missionsende_resultat;


// # alles loeschen
[_erstellte_objekte,_erstellte_marker] execvm "alex_scripte\s_mission_loeschen.sqf";

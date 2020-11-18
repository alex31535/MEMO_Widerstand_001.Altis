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
#define _def_suchradius_strasse 50
#define _def_dist_strassen_zueinander_ring_0 80
#define _def_dist_strassen_zueinander_ring_1 250
#define _def_dist_strassen_zueinander_ring_1 500
#define _def_auswahl_vec_ring_0 ["O_MRAP_02_hmg_F","O_APC_Tracked_02_AA_F","O_MRAP_02_gmg_F"]
#define _def_auswahl_vec_ring_1 ["O_MBT_02_cannon_F","O_APC_Wheeled_02_rcws_v2_F","O_APC_Tracked_02_cannon_F"]
#define _def_auswahl_vec_ring_2 ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_APC_Wheeled_02_rcws_v2_F","O_APC_Tracked_02_cannon_F"]
#define _DEF_obj_max 120
#define _DEF_prozent_zivilisten 30
#define _DEF_prozent_units_haus 50
#define _DEF_min_gebaeudepositionen 4
// ######################################################################


params ["_loc_name","_loc_area0","_loc_area1","_loc_area2"];


// # ring-strassen feststellen
private _strassen_gesperrt_ring_0 = [_loc_area0,[]] call fnc_s_sys_cityring_strassenliste;
private _strassen_gesperrt_ring_1 = [_loc_area1,[]] call fnc_s_sys_cityring_strassenliste;
private _strassen_gesperrt_ring_2 = [_loc_area2,[]] call fnc_s_sys_cityring_strassenliste;

// # ring-strassen besetzen um eine anz fuer verbleibende objekte zu bekommen
private _objektliste_ringbesetzung = [_strassen_gesperrt_ring_0, _def_auswahl_vec_ring_0] call fnc_s_sys_cityring_strassen_besetzen;
private _erstellte_objekte = _objektliste_ringbesetzung;
_objektliste_ringbesetzung = [_strassen_gesperrt_ring_1, _def_auswahl_vec_ring_1] call fnc_s_sys_cityring_strassen_besetzen;
_erstellte_objekte append _objektliste_ringbesetzung;
_objektliste_ringbesetzung = [_strassen_gesperrt_ring_2, _def_auswahl_vec_ring_2] call fnc_s_sys_cityring_strassen_besetzen;
_erstellte_objekte append _objektliste_ringbesetzung;

// # benoetigte units berechnen
private _anz_verbleibend = _DEF_obj_max - (count _erstellte_objekte);
private _anz_crew_plus_vec = count _erstellte_objekte;
private _anz_zivilisten = floor((_anz_verbleibend /100) * _DEF_prozent_zivilisten);
private _anz_feinde_zufuss = _anz_verbleibend - _anz_zivilisten;
private _anz_feinde_haus = floor((_anz_feinde_zufuss /100) * _DEF_prozent_units_haus);
private _anz_feinde_strasse = _anz_feinde_zufuss - _anz_feinde_haus;
private _anz_zivilisten_haus = floor((_anz_zivilisten /100) * _DEF_prozent_units_haus);
private _anz_zivilisten_strasse = _anz_zivilisten - _anz_zivilisten_haus;

// # gebaeude im ring-bereich 1 feststellen
private _alle_haeuser = [_loc_area1 select 0, _loc_area1 select 1,_DEF_min_gebaeudepositionen] call fnc_a_sys_gebaeudeauswahl;

if ((count _alle_haeuser) < 4) exitwith {
  {
    [["<t color='#ff0000' size='2'>Die Missionsanforderung ist fehlgeschlagen ... bitte erneut versuchen!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
  } foreach playableunits;
};

// # ggf berechnete units anpassen
while {(_anz_feinde_haus + _anz_zivilisten_haus) > ((count _alle_haeuser) - 2)} do {
  if (_anz_feinde_haus > 0) then {_anz_feinde_haus = _anz_feinde_haus -1};
  if (_anz_zivilisten_haus > 0) then {_anz_zivilisten_haus = _anz_zivilisten_haus -1};
};

// # strassen innerhalöb area0 auflisten
private _strassen_area0 = (_loc_area0 select 0) nearRoads (_loc_area0 select 1);


// # strassen-patrouillen fuer area0 setzen (feind)
private _gruppenstaerke = 0;
private _unit = objnull;
private _gruppe = grpnull;
while {_anz_feinde_strasse > 0} do {
  _gruppenstaerke = selectrandom [1,2,3,4];
  if (_gruppenstaerke > _anz_feinde_strasse) then {_gruppenstaerke = _anz_feinde_strasse};
  if (_gruppenstaerke > 0) then {
    _gruppe = creategroup [s_fr_feind_seite,true];
    for "_i" from 0 to _gruppenstaerke do {
      _unit = _gruppe createUnit [selectrandom s_fr_unitklassen_feind_allgemein, [0,0,0], [], 0, "NONE"];
      _erstellte_objekte pushback _unit;
      if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
    };
    if (!isnil "fnc_s_sys_unit_konfig_skills") then {{[_x,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills} foreach (units _gruppe)};
    [_gruppe, _loc_area0, true, "SAFE", "LIMITED",_strassen_area0] call fnc_s_sys_wp_area_strassen;
    _anz_feinde_strasse = _anz_feinde_strasse - (count(units _gruppe));

  };
};

// # strassen-patrouillen fuer area0 setzen (zivil)
private _zivilisten = [];
while {_anz_zivilisten_strasse > 0} do {
  _unit = (creategroup [civilian,true]) createUnit [selectrandom s_fr_unitklassen_zivilist_allgemein, [0,0,0], [], 0, "NONE"];
  _erstellte_objekte pushback _unit;
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
  _zivilisten pushback _unit;
  [group _unit, _loc_area0, true, "SAFE", "LIMITED",_strassen_area0] call fnc_s_sys_wp_area_strassen;
  _anz_zivilisten_strasse = _anz_zivilisten_strasse - (count(units(group _unit)));
  if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
};




// # feinde in haeusern erstellen
private _haus = objnull;
private _positionen_im_haus = [];
while {_anz_feinde_haus > 0} do {
  _haus = selectrandom _alle_haeuser;
  _alle_haeuser deleteat (_alle_haeuser find _haus);
  _positionen_im_haus = [_haus] call fnc_a_sys_positionen_innerhalb_haus;
  if ((count _positionen_im_haus) > 0) then {
    _unit = (creategroup [s_fr_feind_seite,true]) createUnit [selectrandom s_fr_unitklassen_feind_allgemein, [0,0,0], [], 0, "NONE"];
    _unit setposasl (agltoasl(selectrandom _positionen_im_haus));
    _unit setdir (random 360);
    _erstellte_objekte pushback _unit;
    if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
    if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
  };
  _anz_feinde_haus = _anz_feinde_haus - (count(units(group _unit)));
};


// # zivilisten in haeusern erstellen
while {_anz_zivilisten_haus > 0} do {
  _haus = selectrandom _alle_haeuser;
  _alle_haeuser deleteat (_alle_haeuser find _haus);
  _positionen_im_haus = [_haus] call fnc_a_sys_positionen_innerhalb_haus;
  if ((count _positionen_im_haus) > 0) then {
    _unit = (creategroup [civilian,true]) createUnit [selectrandom s_fr_unitklassen_zivilist_allgemein, [0,0,0], [], 0, "NONE"];
    _unit setposasl (agltoasl(selectrandom _positionen_im_haus));
    _unit setdir (random 360);
    _erstellte_objekte pushback _unit;
    _zivilisten pushback _unit;
    if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
    if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
  };
  _anz_zivilisten_haus = _anz_zivilisten_haus - (count(units(group _unit)));
};


// # zielperson in einem haus erstellen
_haus = selectrandom _alle_haeuser;
_alle_haeuser deleteat (_alle_haeuser find _haus);
_positionen_im_haus = [_haus] call fnc_a_sys_positionen_innerhalb_haus;
if ((count _positionen_im_haus) == 0) then {_positionen_im_haus = _haus buildingpos -1};
private _zielperson = (creategroup [civilian,true]) createUnit [selectrandom s_fr_unitklassen_zielperson_allgemein, [0,0,0], [], 0, "NONE"];
_zielperson setposasl (agltoasl(selectrandom _positionen_im_haus));
_zielperson disableAI "MOVE";
_zielperson setdir (random 360);
_erstellte_objekte pushback _zielperson;
private _text_haus_zielperson = getText(configfile >> "CfgVehicles" >> typeof _haus >> "DisplayName");
if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_zielperson] call fnc_s_debugmarker_erstellen};
if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_zielperson,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};



// # marker erstellen
private _erstellte_marker = [];
private _marker = createMarker ["m_fr_shape", _loc_area0 select 0];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [(_loc_area2 select 1) +100, (_loc_area2 select 1) +100];
_marker setMarkerColor (["ColorEAST","ColorWEST","ColorGUER","ColorCIV"] select (getNumber(configFile >> "CfgVehicles" >> (typeof _zielperson) >> "side")));
_marker setmarkeralpha 0.5;
_erstellte_marker pushback _marker;
_marker = createMarker ["m_fr_icon", [(_loc_area0 select 0) select 0,((_loc_area0 select 0) select 1) + (_loc_area0 select 1), 0]];
_marker setMarkerType "mil_dot";
_marker setMarkerColor "ColorYellow";
private _winkel = (((position _zielperson) select 0)-((_loc_area0 select 0) select 0)) atan2 (((position _zielperson) select 1)-((_loc_area0 select 0) select 1));
_winkel = _winkel mod 360; if (_winkel < 0) then {_winkel = _winkel + 360};
private _intel_text = format["ZP: %1, ca. %2 Grad, ca. %3m, vom Ortszentrum %4",
/*private _intel_text = format["ZP: %1, ca. %2m, vom Ortszentrum %3",*/
  _text_haus_zielperson,
  (floor(_winkel/10)) *10,
  /*(floor(((_loc_area0 select 0) distance _zielperson)/20)) *10,*/
  /*(floor((((_loc_area0 select 0) distance _zielperson)/2)/10)) *10,*/
  (floor(((_loc_area0 select 0) distance _zielperson)/10)) *10,
  _loc_name];
_marker setmarkertext _intel_text;
_erstellte_marker pushback _marker;


{
  [[format["<t color='#02bf1b' size='2'>Fuer die Region %1 steht eine neue Mission zur Verfuegung!",_loc_name], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach allplayers;


// # missionsbedingungen festlegen
private _mpindex_zielperson = _zielperson addMPEventHandler ["MPKilled",{s_fr_missionsende = 1}];
private _min_zivilisten_am_leben = floor((count _zivilisten)/2);


// # missions-core------------------------------------------------------------------------------------------------------------------
s_fr_missionsende = 0;
while {s_fr_missionsende == 0} do {
  if ((count allplayers) == 0) then {s_fr_missionsende = -1};
  _zivilisten = _zivilisten select {alive _x};
  if ((count _zivilisten) < _min_zivilisten_am_leben) then {s_fr_missionsende = -2};
  if (s_mission_params select 4) then {s_fr_missionsende = -3};/* notaus */
  systemchat format["core fr: notaus: %1",s_mission_params select 4];
  uisleep 0.3;
};


// # eventhandler auf zielperson entfernen
if (!isnull _zielperson) then {_zielperson removeMPEventHandler ["MPKilled", _mpindex_zielperson]};

// # reset auf missions-array
s_fr_mission = [];


[_erstellte_objekte,_erstellte_marker] execvm "alex_scripte\s_mission_loeschen.sqf";


// # sofortiger ausstieg wenn ueber admin notaus aktiviert wurde
if (s_fr_missionsende == -3) exitwith {};


// # missionsende auswerten
private _punkte = 0;
if (s_fr_missionsende == -1) then {
  // keine spieler mehr auf server
  _punkte = 0;
};
if (s_fr_missionsende == -2) then {
  _punkte = (floor(s_fr_missionspunkte /2)) *-1;
  {
    [[format["<t color='#ff0000' size='2'>Mission gescheitert - Zu viele zivile Opfer! Missionspunkte: %1",_punkte], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
  } foreach allplayers;
};
if (s_fr_missionsende == 1) then {
  _punkte = s_fr_missionspunkte;
  {
    [[format["<t color='#02bf1b' size='2'>Mission erfolgreich - Sie haben die Zielperson eliminiert! Missionspunkte: %1",_punkte], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
  } foreach allplayers;
};

if (!isnil "s_missionspunkte") then {s_missionspunkte = s_missionspunkte + _punkte};

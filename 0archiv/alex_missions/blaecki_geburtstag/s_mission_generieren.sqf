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

private _erstellte_objekte = [];
private _erstellte_marker = [];


// # ziellocation ermitteln
private _loc_params_mission = [
/*0 loc name */
/*1 loc-area innen */
/*2 loc-area "aktivierung" */
/*3 loc-area "deaktivierung" */
];
private _loc = [];
for "_i" from 1 to 50 do {
  _loc = selectrandom s_sys_locations;
  if ((!(_loc select 4)) && {(((_loc select 1) select 0) distance (s_sys_area_hq select 0)) > (((_loc select 2) select 1) + (s_sys_area_hq select 1))}) exitwith {_loc_params_mission = _loc};
};
if ((count _loc_params_mission) == 0) exitwith {
  [["<t color='#ff0000' size='2'>Die Missionsanforderung ist fehlgeschlagen - Versuche es nochmal!", "PLAIN", -1, true, true]] remoteExec ["cutText",_remoteexecutedowner];
  [_erstellte_objekte,_erstellte_marker] execvm "alex_scripte\s_mission_loeschen.sqf";
};



// # zonen definieren
private _loc_area1 = _loc_params_mission select 1;
private _loc_area2 = _loc_params_mission select 2;
private _loc_area3 = _loc_params_mission select 3;



// # ring-strassen feststellen
private _strassen_auf_ring_1 = [_loc_area1,[]] call fnc_s_sys_cityring_strassenliste;
private _strassen_auf_ring_2 = [_loc_area2,[]] call fnc_s_sys_cityring_strassenliste;
private _strassen_auf_ring_3 = [_loc_area3,[]] call fnc_s_sys_cityring_strassenliste;


// # zielfahrzeug erstellen
private _zielfahrzeug = objnull;
private _strasse_zielfahrzeug = selectrandom((_loc_area1 select 0) nearRoads ((_loc_area1 select 1) - 20));
_zielfahrzeug = (selectrandom s_begeb_auswahl_zielfahrzeuge) createVehicle (position _strasse_zielfahrzeug);
_zielfahrzeug setdir (getdir _strasse_zielfahrzeug);
_erstellte_objekte pushback _zielfahrzeug;
if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_zielfahrzeug] call fnc_s_debugmarker_erstellen};
private _kontrollposition_zielfahrzeug = position _zielfahrzeug;



// # ring-strassen besetzen um eine anz fuer verbleibende objekte zu bekommen
private _objektliste_fnc = [_strassen_auf_ring_1, s_bgeb_auswahl_vec] call fnc_s_sys_cityring_strassen_besetzen;
_erstellte_objekte = _objektliste_fnc;
_objektliste_fnc = [_strassen_auf_ring_2, s_bgeb_auswahl_vec] call fnc_s_sys_cityring_strassen_besetzen;
_erstellte_objekte append _objektliste_fnc;
_objektliste_fnc = [_strassen_auf_ring_3, s_bgeb_auswahl_vec] call fnc_s_sys_cityring_strassen_besetzen;
_erstellte_objekte append _objektliste_fnc;





// # helikopter erstellen
private _heli = [_zielfahrzeug,s_bgeb_helis] call fnc_s_sys_fluggeraet_sad;
_erstellte_objekte pushback _heli;
if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_heli] call fnc_s_debugmarker_erstellen};
_heli = [_zielfahrzeug,s_bgeb_helis] call fnc_s_sys_fluggeraet_sad;
_erstellte_objekte pushback _heli;
if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_heli] call fnc_s_debugmarker_erstellen};




// # flugzeug erstellen
private _flugzeug = [_zielfahrzeug,s_bgeb_flugzeuge] call fnc_s_sys_fluggeraet_sad;
_erstellte_objekte pushback _flugzeug;
if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_flugzeug] call fnc_s_debugmarker_erstellen};
_flugzeug = [_zielfahrzeug,s_bgeb_flugzeuge] call fnc_s_sys_fluggeraet_sad;
_erstellte_objekte pushback _flugzeug;
if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_flugzeug] call fnc_s_debugmarker_erstellen};



// # feindgruppen selektieren
private _feindgruppen = [];
{
  if ((_x iskindof "Man") && {(_feindgruppen find (group _x)) == -1}) then {_feindgruppen pushback (group _x)};
} foreach _erstellte_objekte;


// # benoetigte units berechnen
private _anz_verbleibend = s_bgeb_obj_max - (count _erstellte_objekte);
private _anz_feinde_haus = floor((_anz_verbleibend /100) * s_bgeb_prozent_units_haus);
private _anz_feinde_strasse = _anz_verbleibend - _anz_feinde_haus;



// # gebaeude im ring-bereich 1 feststellen
private _alle_haeuser = [_loc_area1 select 0, _loc_area1 select 1,s_bgeb_min_gebaeudepositionen] call fnc_a_sys_gebaeudeauswahl;
if ((count _alle_haeuser) < 4) exitwith {
  {
    [["<t color='#ff0000' size='2'>Die Missionsanforderung ist fehlgeschlagen ... bitte erneut versuchen!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
  } foreach playableunits;
  [_erstellte_objekte,_erstellte_marker] execvm "alex_scripte\s_mission_loeschen.sqf";
};

// # ggf berechnete units anpassen
while {_anz_feinde_haus > ((count _alle_haeuser) - 2)} do {
  if (_anz_feinde_haus > 0) then {_anz_feinde_haus = _anz_feinde_haus -1};
};



// # strassen innerhalb area1 auflisten
private _strassen_area1 = (_loc_area1 select 0) nearRoads (_loc_area1 select 1);

// # strassen-patrouillen fuer area1 setzen (feind)
private _gruppenstaerke = 0;
private _unit = objnull;
private _gruppe = grpnull;
while {_anz_feinde_strasse > 0} do {
  _gruppenstaerke = selectrandom s_begeb_gruppenstaerken_zufuss;
  if (_gruppenstaerke > _anz_feinde_strasse) then {_gruppenstaerke = _anz_feinde_strasse};
  if (_gruppenstaerke > 0) then {
    _gruppe = creategroup [s_bgeb_feind_seite,true];
    for "_i" from 0 to _gruppenstaerke do {
      _unit = _gruppe createUnit [selectrandom s_units_aus_cfg_0, [0,0,0], [], 0, "NONE"];
      _erstellte_objekte pushback _unit;
      if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
    };
    if (!isnil "fnc_s_sys_unit_konfig_skills") then {{[_x,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills} foreach (units _gruppe)};
    [_gruppe, _loc_area1, true, "SAFE", "LIMITED",_strassen_area1] call fnc_s_sys_wp_area_strassen;
    _feindgruppen pushback _gruppe;
    _anz_feinde_strasse = _anz_feinde_strasse - (count(units _gruppe));
  };
};



// # feinde in haeusern erstellen
private _haus = objnull;
private _positionen_im_haus = [];
while {_anz_feinde_haus > 0} do {
  _haus = selectrandom _alle_haeuser;
  _alle_haeuser deleteat (_alle_haeuser find _haus);
  _positionen_im_haus = [_haus] call fnc_a_sys_positionen_innerhalb_haus;
  if ((count _positionen_im_haus) > 0) then {
    _unit = (creategroup [s_bgeb_feind_seite,true]) createUnit [selectrandom s_units_aus_cfg_0, [0,0,0], [], 0, "NONE"];
    _unit setposasl (agltoasl(selectrandom _positionen_im_haus));
    _unit setdir (random 360);
    _erstellte_objekte pushback _unit;
    _feindgruppen pushback (group _unit);
    if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
    if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
  };
  _anz_feinde_haus = _anz_feinde_haus - (count(units(group _unit)));
};





// # marker erstellen
private _erstellte_marker = [];
private _marker = createMarker ["m_bgeb_shape", _loc_area1 select 0];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [(_loc_area3 select 1) +100, (_loc_area3 select 1) +100];
_marker setMarkerColor (["ColorEAST","ColorWEST","ColorGUER","ColorCIV"] select (getNumber(configFile >> "CfgVehicles" >> (s_units_aus_cfg_0 select 0) >> "side")));
_marker setmarkeralpha 0.5;
_erstellte_marker pushback _marker;
_marker = createMarker ["m_bgeb_icon", [(_loc_area1 select 0) select 0,((_loc_area1 select 0) select 1) + (_loc_area1 select 1), 0]];
_marker setMarkerType "mil_dot";
_marker setMarkerColor "ColorYellow";
_marker setmarkertext (format["Blaeckis Geburtstagswunsch: %1",getText(configfile >> "CfgVehicles" >> typeof _zielfahrzeug >> "DisplayName")]);
_erstellte_marker pushback _marker;




// # begkanntgabe ----------------------------------------------------------------------------------------------------------------------------------------------------- bekanntgabe
{
  [[format["<t color='#02bf1b' size='2'>Du bist herzlich eingeladen zu Blaeckis Geburtstagsfeier der Region %1!",_loc_params_mission select 0], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach allplayers;

player setCaptive true;
player allowdammage false;
player moveindriver _zielfahrzeug;






// # core -------------------------------------------------------------------------------------------------------------------------------------------------------------- core
private _zeitstempel_ki_folgt_zielfahrzeug = -1;
private _missionsende_resultat = "";
while {s_mission_params select 0} do {

  _feindgruppen = _feindgruppen select {!isnull _x};

  if (_zielfahrzeug inarea s_sys_area_hq) then {
    s_mission_params set [0,false];
    _missionsende_resultat = "zielfahrzeug in hq";
  };

  if (isnull _zielfahrzeug) then {
    s_mission_params set [0,false];
    _missionsende_resultat = "zielfahrzeug zerstoert";
  };

  if ((getdammage _zielfahrzeug) > 0.95) then {
    s_mission_params set [0,false];
    _missionsende_resultat = "zielfahrzeug zerstoert";
  };

  // # reaktion auf zielfahrzeug starten?
  if ((_zeitstempel_ki_folgt_zielfahrzeug == -1) && {((position _zielfahrzeug) distance _kontrollposition_zielfahrzeug) > 10}) then {
    _heli = [_zielfahrzeug,s_bgeb_helis] call fnc_s_sys_fluggeraet_sad;
    _erstellte_objekte pushback _heli;
    _feindgruppen pushback (group(driver _heli));
    _heli = [_zielfahrzeug,s_bgeb_helis] call fnc_s_sys_fluggeraet_sad;
    _erstellte_objekte pushback _heli;
    _feindgruppen pushback (group(driver _heli));
    _heli = [_zielfahrzeug,s_bgeb_helis] call fnc_s_sys_fluggeraet_sad;
    _erstellte_objekte pushback _heli;
    _feindgruppen pushback (group(driver _heli));
    // # flugzeug erstellen
    _flugzeug = [_zielfahrzeug,s_bgeb_flugzeuge] call fnc_s_sys_fluggeraet_sad;
    _erstellte_objekte pushback _flugzeug;
    _feindgruppen pushback (group(driver _flugzeug));
    _flugzeug = [_zielfahrzeug,s_bgeb_flugzeuge] call fnc_s_sys_fluggeraet_sad;
    _erstellte_objekte pushback _flugzeug;
    _feindgruppen pushback (group(driver _flugzeug));
    {
      while {(count(waypoints _x))>1} do {deleteWaypoint((waypoints _x)select 0)};
      _x addWaypoint [position _zielfahrzeug, 5, 0];
      [_x, 0] setWaypointBehaviour "AWARE";
      [_x, 0] setWaypointspeed "FULL";
      [_x, 0] setWaypointType "MOVE";
      _x addWaypoint [position _zielfahrzeug,2,1];
      [_x, 1] setWaypointCompletionRadius 2;
      [_x, 1] setWaypointBehaviour "AWARE";
      [_x, 1] setWaypointspeed "FULL";
    } foreach _feindgruppen;
    _zeitstempel_ki_folgt_zielfahrzeug = time +5;
  };

  // # verfolgung zielfahrzeug aktualisieren?
  if ((_zeitstempel_ki_folgt_zielfahrzeug != -1) && {time > _zeitstempel_ki_folgt_zielfahrzeug}) then {
    {
      [_x,1] setWaypointPosition [position _zielfahrzeug,2];
    } foreach _feindgruppen;
    _zeitstempel_ki_folgt_zielfahrzeug = time +7;
  };


  if (s_mission_params select 4) then {s_mission_params set [0,false]};
  uisleep 0.3;

};


// # auswertung
switch (_missionsende_resultat) do {

  case "zielfahrzeug in hq": {
    {
      [["<t color='#2cb02a' size='4'>Geschafft - Blaeckis Geburtstagsgeschenk ist im HQ eingetroffen!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };

  case "zielfahrzeug zerstoert": {
    {
      [["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN - Blaecki bekommt nichts zum Geburtstag!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x]
    } foreach playableunits;
  };

};


// # alles loeschen
[_erstellte_objekte,_erstellte_marker] execvm "alex_scripte\s_mission_loeschen.sqf";

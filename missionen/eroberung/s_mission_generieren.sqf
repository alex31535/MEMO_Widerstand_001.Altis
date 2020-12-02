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
#define _def_auswahl_vec_ring_0 ["O_MRAP_02_hmg_F","O_APC_Tracked_02_AA_F","O_MRAP_02_gmg_F"]
#define _def_auswahl_vec_ring_1 ["O_MBT_02_cannon_F","O_APC_Wheeled_02_rcws_v2_F","O_APC_Tracked_02_cannon_F"]
#define _def_auswahl_vec_ring_2 ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_APC_Wheeled_02_rcws_v2_F","O_APC_Tracked_02_cannon_F"]
#define _DEF_obj_max 120
#define _DEF_prozent_zivilisten 30
#define _DEF_prozent_units_haus 50
#define _DEF_min_gebaeudepositionen 4
#define _DEF_gruppenstaerken_feind [1,2,3,4]
#define _DEF_ki_level_min 10
#define _DEF_ki_level_max 40



private _loc_params = s_loc_params select (s_mission_params select 3);
private _loc_name = _loc_params select 0;
private _loc_pos = _loc_params select 1;
private _loc_groesse = _loc_params select 2;
private _loc_geb_dichte = _loc_params select 3;
private _loc_dichte_obj = _loc_params select 4;
private _loc_pkt = _loc_params select 5;
private _loc_lvl = _loc_params select 6;
private _loc_farbe = _loc_params select 7;



private _erstellte_objekte = [];
private _erstellte_marker = [];

// # areas definieren
private _loc_area0 = [_loc_pos,_loc_groesse/2,_loc_groesse/2,0,false];
private _loc_area1 = [_loc_pos,_loc_groesse,_loc_groesse,0,false];
private _loc_area2 = [_loc_pos,_loc_groesse+(_loc_groesse/2),_loc_groesse+(_loc_groesse/2),0,false];


// # ring-strassen feststellen
private _strassen_gesperrt_ring_0 = [_loc_area0,[]] call fnc_s_cityring_strassenliste;
private _strassen_gesperrt_ring_1 = [_loc_area1,[]] call fnc_s_cityring_strassenliste;
private _strassen_gesperrt_ring_2 = [_loc_area2,[]] call fnc_s_cityring_strassenliste;


// # ring-strassen besetzen um eine anz fuer verbleibende objekte zu bekommen
private _objektliste_ringbesetzung = [_strassen_gesperrt_ring_0, s_fzg_land_bewaffnet_east select _loc_lvl] call fnc_s_cityring_strassen_besetzen;
private _erstellte_objekte = _objektliste_ringbesetzung;
_objektliste_ringbesetzung = [_strassen_gesperrt_ring_1, s_fzg_land_bewaffnet_east select _loc_lvl] call fnc_s_cityring_strassen_besetzen;
_erstellte_objekte append _objektliste_ringbesetzung;
_objektliste_ringbesetzung = [_strassen_gesperrt_ring_2, s_fzg_land_bewaffnet_east select _loc_lvl] call fnc_s_cityring_strassen_besetzen;
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
private _alle_haeuser = [_loc_area1 select 0, _loc_area1 select 1,_DEF_min_gebaeudepositionen] call fnc_s_gebaeudeauswahl;


// # ggf berechnete units anpassen
while {(_anz_feinde_haus + _anz_zivilisten_haus) > ((count _alle_haeuser) - 2)} do {
  if (_anz_feinde_haus > 0) then {_anz_feinde_haus = _anz_feinde_haus -1};
  if (_anz_zivilisten_haus > 0) then {_anz_zivilisten_haus = _anz_zivilisten_haus -1};
};


// # strassen innerhalb area0 auflisten
private _strassen_area0 = (_loc_area0 select 0) nearRoads (_loc_area0 select 1);


// # strassen-patrouillen fuer area0 setzen (feind)
private _gruppenstaerke = 0;
private _unit = objnull;
private _gruppe = grpnull;
while {_anz_feinde_strasse > 0} do {
  _gruppenstaerke = selectrandom _DEF_gruppenstaerken_feind;
  if (_gruppenstaerke > _anz_feinde_strasse) then {_gruppenstaerke = _anz_feinde_strasse};
  if (_gruppenstaerke > 0) then {
    _gruppe = creategroup [s_feind_seite,true];
    for "_i" from 0 to _gruppenstaerke do {
      _unit = _gruppe createUnit [s_feind_klasse_east, [0,0,0], [], 0, "NONE"];
      _erstellte_objekte pushback _unit;
      if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
    };
    [_gruppe, _loc_area0, true, "SAFE", "LIMITED",_strassen_area0] call fnc_s_wp_area_strassen;
    _anz_feinde_strasse = _anz_feinde_strasse - (count(units _gruppe));
  };
};


// # strassen-patrouillen fuer area0 setzen (zivil)
private _zivilisten = [];
while {_anz_zivilisten_strasse > 0} do {
  _unit = (creategroup [civilian,true]) createUnit [s_zivil_klasse, [0,0,0], [], 0, "NONE"];
  _erstellte_objekte pushback _unit;
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
  _zivilisten pushback _unit;
  [group _unit, _loc_area0, true, "SAFE", "LIMITED",_strassen_area0] call fnc_s_wp_area_strassen;
  _anz_zivilisten_strasse = _anz_zivilisten_strasse - (count(units(group _unit)));
};


// # feinde in haeusern erstellen
private _haus = objnull;
private _positionen_im_haus = [];
while {_anz_feinde_haus > 0} do {
  _haus = selectrandom _alle_haeuser;
  _alle_haeuser deleteat (_alle_haeuser find _haus);
  _positionen_im_haus = [_haus] call fnc_s_positionen_innerhalb_haus;
  if ((count _positionen_im_haus) > 0) then {
    _unit = (creategroup [s_feind_seite,true]) createUnit [s_feind_klasse_east, [0,0,0], [], 0, "NONE"];
    _unit setposasl (agltoasl(selectrandom _positionen_im_haus));
    _unit setdir (random 360);
    _erstellte_objekte pushback _unit;
    if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
  };
  _anz_feinde_haus = _anz_feinde_haus - (count(units(group _unit)));
};


// # zivilisten in haeusern erstellen
while {_anz_zivilisten_haus > 0} do {
  _haus = selectrandom _alle_haeuser;
  _alle_haeuser deleteat (_alle_haeuser find _haus);
  _positionen_im_haus = [_haus] call fnc_s_positionen_innerhalb_haus;
  if ((count _positionen_im_haus) > 0) then {
    _unit = (creategroup [civilian,true]) createUnit [s_zivil_klasse, [0,0,0], [], 0, "NONE"];
    _unit setposasl (agltoasl(selectrandom _positionen_im_haus));
    _unit setdir (random 360);
    _erstellte_objekte pushback _unit;
    _zivilisten pushback _unit;
    if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
  };
  _anz_zivilisten_haus = _anz_zivilisten_haus - (count(units(group _unit)));
};



// alle bisherigen feind- und zivil-units konfigurieren
{
  if (_x iskindof "MAN") then {
    _unit = _x;
    if ((side _x) == s_feind_seite) then {
      [_unit,_loc_lvl] call fnc_s_feindkonfig;
    } else {
      {_unit disableAI _x} foreach ["AUTOTARGET","FSM","AIMINGERROR","COVER","AUTOCOMBAT"];
    };
  };
} foreach _erstellte_objekte;






// # zielperson in einem haus erstellen
_haus = selectrandom _alle_haeuser;
_alle_haeuser deleteat (_alle_haeuser find _haus);
_positionen_im_haus = [_haus] call fnc_s_positionen_innerhalb_haus;
if ((count _positionen_im_haus) == 0) then {_positionen_im_haus = _haus buildingpos -1};
private _zielperson = (creategroup [s_feind_seite,true]) createUnit [s_feind_klasse_east, [0,0,0], [], 0, "NONE"];
_zielperson setposasl (agltoasl(selectrandom _positionen_im_haus));
_zielperson disableAI "MOVE";
_zielperson setdir (random 360);
[_zielperson,_loc_lvl] call fnc_s_feindkonfig;
_erstellte_objekte pushback _zielperson;
private _text_haus_zielperson = getText(configfile >> "CfgVehicles" >> typeof _haus >> "DisplayName");
if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_zielperson] call fnc_s_debugmarker_erstellen};
[_zielperson,_DEF_ki_level_min,_DEF_ki_level_max] call fnc_s_unit_konfig_skills;


// # marker erstellen
private _marker = createMarker ["m_mission_icon", [(_loc_area0 select 0) select 0,((_loc_area0 select 0) select 1) + (_loc_area0 select 1), 0]];
_marker setMarkerType "mil_dot";
_marker setMarkerColor "ColorYellow";
private _winkel = (((position _zielperson) select 0)-((_loc_area0 select 0) select 0)) atan2 (((position _zielperson) select 1)-((_loc_area0 select 0) select 1));
_winkel = _winkel mod 360; if (_winkel < 0) then {_winkel = _winkel + 360};
private _intel_text = format["ZP: %1, ca. %2 Grad, ca. %3m, vom Ortszentrum %4",
  _text_haus_zielperson,
  (floor(_winkel/10)) *10,
  (floor(((_loc_area0 select 0) distance _zielperson)/10)) *10,
  _loc_name];
_marker setmarkertext _intel_text;
_erstellte_marker pushback _marker;



// # boni fzg setzen
private _liste_boni_fzg = [_loc_area0,_loc_lvl] call fnc_s_area_boni_fzg_land;
{_erstellte_objekte pushback _x} foreach _liste_boni_fzg;



{
  [["<t color='#02bf1b' size='4'>Eliminieren Sie die Zielperson im Zielgebiet um die Region zu destabilisieren!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach playableunits;


// # missionsbedingungen festlegen
private _mpindex_zielperson = _zielperson addMPEventHandler ["MPKilled",{s_missionsziel_erreicht = true}];
private _min_zivilisten_am_leben = floor((count _zivilisten)/2);


// # missions-core
private _missionsende_resultat = "";
s_missionsziel_erreicht = false;
while {s_mission_params select 0} do {

  // # zivilisten aktualisieren
  _zivilisten = _zivilisten select {alive _x};


  // # keine spieler mehr auf server
  if ((count allplayers) == 0) exitwith {s_mission_params set [0,false]; _missionsende_resultat = "keine spieler"};
  // # zu hohe zivile verluste
  if ((count _zivilisten) < _min_zivilisten_am_leben) then {s_mission_params set [0,false]; _missionsende_resultat = "zu viele zivile opfer"};
  // # missionsziel erreicht
  if (s_missionsziel_erreicht) then {s_mission_params set [0,false]; _missionsende_resultat = "zielperson eliminiert"};
  // # notaus aktiviert?
  if (s_mission_params select 4) then {s_mission_params set [0,false]; _missionsende_resultat = "notaus"};
  // # bremse
  uisleep 0.3;
};


// # auswertung
switch (_missionsende_resultat) do {
  case "keine spieler": {
    [_erstellte_objekte,_erstellte_marker] execvm "scripte\s_mission_loeschen.sqf";
  };
  case "zielperson eliminiert": {
    {
      [["<t color='#54d916' size='6'>MISSION ERFOLGREICH - Sie haben die Zielperson eliminiert und damit die Region erfolgreich destabilisiert!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
    _loc_params set [7,"ColorGreen"];

  };
  case "zu viele zivile opfer": {
    {
      [["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN - Es gab zu viele Zivile Opfer, ziehen Sie sich zurueck!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
  case "notaus": {
    {
      [["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN - Die Mission wurde ueber NOTAUS beendet!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
    [_erstellte_objekte,_erstellte_marker] execvm "scripte\s_mission_loeschen.sqf";
  };
};

// # gruppenmission schliessen
[_loc_params,_erstellte_objekte,_erstellte_marker] call fnc_s_gruppenmission_missionsende;

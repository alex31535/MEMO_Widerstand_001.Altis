/*
  s_dmd_generieren.sqf
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
params ["_loc_name","_dm_area"];

private _erstellte_marker = [];

s_temp_dmd_haeuser = [_dm_area select 0, _dm_area select 1, s_dmd_min_gebaeudepositionen] call fnc_a_sys_gebaeudeauswahl; /* global, da auch in missionsteilnahme verwendet */

s_dmd_zaehler_treffpunkte = 0;

s_dmd_treffpunkt_haus = selectrandom s_temp_dmd_haeuser;
private _marker_treffpunkt = createMarker ["m_dmd_treffpunkt", position s_dmd_treffpunkt_haus];
_marker_treffpunkt setMarkerType "mil_dot";
_marker_treffpunkt setMarkerColor "ColorOrange";
_marker_treffpunkt setmarkertext (format["Treffpunkt: %1",getText (configFile >> "CfgVehicles" >> typeof s_dmd_treffpunkt_haus >> "displayname")]);
_erstellte_marker pushback _marker_treffpunkt;


private _marker = createMarker ["m_dmd", _dm_area select 0];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [_dm_area select 1, _dm_area select 1];
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 0.4;
_erstellte_marker pushback _marker;


private _anz_ki_erstellbar = s_dmd_min_anz_gebaeude - (count playableunits);
private _erstellte_objekte = [];
private _positionen_innerhalb_haus = [];
private _unit = objnull;
private _spieler_am_treffpunkt = [];
private _teilnehmende_spieler = [];
private _ist_am_treffpunkt = false;
private _auswahl_ki = if (isnil "s_units_aus_cfg_0") then [{[typeof(selectrandom playableunits)]},{s_units_aus_cfg_0}];


{[[format["<t color='#ff6f00' size='2'>%1 steht zur Verfuegung....",s_mission_params select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;



while {s_mission_params select 0} do {
  _erstellte_objekte = _erstellte_objekte select {alive _x};
  _anz_ki_erstellbar = s_dmd_min_anz_gebaeude - (count playableunits) - (count _erstellte_objekte);
  if (_anz_ki_erstellbar > 0) then {
    _starthaus = selectrandom s_temp_dmd_haeuser;
    _positionen_innerhalb_haus = [_starthaus] call fnc_a_sys_positionen_innerhalb_haus;
    if ((count _positionen_innerhalb_haus) > 0) then {
      _startpos = selectrandom _positionen_innerhalb_haus;
      if ((count(allunits inareaarray [_startpos,30,30,0,false])) == 0) then {
        _unit = (creategroup [EAST,true]) createUnit [selectrandom _auswahl_ki, [0,0,0], [], 0, "NONE"];
        _unit setposasl (agltoasl(selectrandom _positionen_innerhalb_haus));
        _unit setdir (random 360);
        if (selectrandom s_dmd_zufall_spielerklon) then {[_unit,"spielerklon"] call fnc_s_sys_unit_konfig_loadout};
        if (!isnil "fnc_s_sys_unit_konfig_skills") then {[_unit,s_admin_ki_level_min/10,s_admin_ki_level_max/10] call fnc_s_sys_unit_konfig_skills};
        _unit addHeadgear (selectrandom [/*"H_Beret_red",*/"H_Cap_red"]);
        _unit addrating -10000;
        if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
        [group _unit, _dm_area, false,selectrandom["AWARE","COMBAT","STEALTH"], "LIMITED",[]] call fnc_s_sys_wp_area_strassen;
        _erstellte_objekte pushback _unit;
      };
    };
  };

  // # spieler am treffpunkt feststellen
  _teilnehmende_spieler = (playableunits inareaarray _dm_area) select {alive _x};
  if ((count _teilnehmende_spieler) > 0) then {
    _spieler_am_treffpunkt = [];
    {
      _ist_am_treffpunkt = [_x,s_dmd_treffpunkt_haus] call fnc_s_sys_unit_in_bestimmten_haus;
      if (_ist_am_treffpunkt) then {_spieler_am_treffpunkt pushback _x};
    } foreach _teilnehmende_spieler;
    if ((count _spieler_am_treffpunkt) == (count _teilnehmende_spieler)) then {
      _dmd_treffpunkt_haus = [(_dm_area select 1) *0.4,_teilnehmende_spieler] call fnc_s_sys_area_haus_aus_liste;
      if (!isnull _dmd_treffpunkt_haus) then {
        s_dmd_treffpunkt_haus = _dmd_treffpunkt_haus;
        "m_dmd_treffpunkt" setmarkerpos (position s_dmd_treffpunkt_haus);
        "m_dmd_treffpunkt" setmarkertext (format["Treffpunkt: %1",getText (configFile >> "CfgVehicles" >> typeof s_dmd_treffpunkt_haus >> "displayname")]);
        s_dmd_zaehler_treffpunkte = s_dmd_zaehler_treffpunkte +1;
        {
          [[format["<t color='#ffb300' size='4'>Treffpunkt Nr %1 erreicht! Der naechste Treffpunkt steht zur Verfuegung!",s_dmd_zaehler_treffpunkte], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
        } foreach _liste_spieler;
      };
    };
  };

  // # notaus ?
  if (s_mission_params select 4) then {s_mission_params set [0,false]};


  uisleep 0.3;
};

s_temp_dmd_haeuser = nil;


[_erstellte_objekte,_erstellte_marker] execvm "alex_scripte\s_mission_loeschen.sqf";

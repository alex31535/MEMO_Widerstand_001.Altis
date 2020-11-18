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
private _loc = [];// temporaer....
for "_i" from 1 to 50 do {
  _loc = selectrandom s_sys_locations;
  if ((!(_loc select 4)) && {(((_loc select 1) select 0) distance (s_sys_area_hq select 0)) > (((_loc select 2) select 1) + (s_sys_area_hq select 1))} && {(((_loc select 1) select 0) distance (s_sys_area_hq select 0)) < s_hlhc_dist_max}) exitwith {_loc_params_mission = _loc};
};
if ((count _loc_params_mission) == 0) exitwith {
  [["<t color='#ff0000' size='2'>Die Missionsanforderung ist fehlgeschlagen - Versuche es nochmal!", "PLAIN", -1, true, true]] remoteExec ["cutText",_remoteexecutedowner];
};

// # fahrzeug und fahrer erstellen
_hl_fzg = (s_hlhc_fzg_params select 0) createvehicle [0,0,0];
_hl_fzg setdir (s_hlhc_fzg_params select 2);
_hl_fzg setposworld (s_hlhc_fzg_params select 1);
[_hl_fzg] spawn fnc_s_sys_garage_mob_fob_universal;
_erstellte_objekte pushback _hl_fzg;

// # fahrzeug und fahrer erstellen
_hl_fzg_benzin = (s_hlhc_fzg_benzin_params select 0) createvehicle [0,0,0];
_hl_fzg_benzin setdir (s_hlhc_fzg_benzin_params select 2);
_hl_fzg_benzin setposworld (s_hlhc_fzg_benzin_params select 1);
_erstellte_objekte pushback _hl_fzg_benzin;


private _hl_fzg_fahrer = (creategroup [west,true]) createUnit ["B_Survivor_F", [0,0,0], [], 0, "NONE"];
_hl_fzg_fahrer assignasdriver _hl_fzg;
_hl_fzg_fahrer moveindriver _hl_fzg;
_hl_fzg lockDriver true;
_hl_fzg_fahrer allowdammage false;
_hl_fzg_fahrer addEventHandler ["GetOutMan", {params ["_unit", "_role", "_vehicle", "_turret"];_hl_fzg lockDriver false;_unit moveindriver _vehicle;_hl_fzg lockDriver true;}];
_hl_fzg allowCrewInImmobile true;
_hl_fzg setUnloadInCombat [false, false];
_erstellte_objekte pushback _hl_fzg_fahrer;

private _marker = createMarker ["m_hl_zielgebiet_area", (_loc_params_mission select 1) select 0];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [((_loc_params_mission select 1) select 1), ((_loc_params_mission select 1) select 1)];
_marker setMarkerColor "ColorWEST";
_marker setmarkeralpha 0.5;
_erstellte_marker pushback _marker;

_marker = createMarker ["m_hl_zielgebiet_icon", [((_loc_params_mission select 1) select 0) select 0,(((_loc_params_mission select 1) select 0) select 1) + ((_loc_params_mission select 1) select 1), 0]];
_marker setMarkerType "mil_dot";
_marker setMarkerColor "ColorYellow";
_marker setmarkertext (format["Ziel: %1",_loc_params_mission select 0]);
_erstellte_marker pushback _marker;

private _marker_fzg = createMarker ["m_hl_icon_fzg", position _hl_fzg];
_marker_fzg setMarkerType "mil_dot";
_marker_fzg setMarkerColor "ColorYellow";
_marker_fzg setmarkertext "Exp. Fzg";
_erstellte_marker pushback _marker_fzg;

{
  [[format["<t color='#02bf1b' size='2'>Ein voellig ueberladenes Fahrzeug braucht Infanterie-Begleitung auf dem Weg nach %1!",_loc_params_mission select 0], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach allplayers;


// # core -------------------------------------------------------------------------------------------------------------------------------------------------------------- core
private _missionsende_resultat = "";
private _spieler_im_hl_fzg = [];
private _liste_ki_zufuss = [];
private _liste_ki_selbstmoerder = [];
private _pos_spawn = [];
private _unit = objnull;
private _gruppe = grpnull;
private _zeitstempel_ki_folgt_zielfahrzeug = time + s_hlhc_zeitabstand_verfolgung;
private _dist_ki_loeschen = (s_hlhc_spawn_dist select 0) + (s_hlhc_spawn_dist select 1) +50;
private _pos_spawn_typ = [];
private _benzinhinweis = false;
while {s_mission_params select 0} do {

  // # listen pruefen
  _liste_ki_zufuss = _liste_ki_zufuss select {alive _x};
  {if ((count(playableunits inareaarray [position _x,_dist_ki_loeschen,_dist_ki_loeschen,0,false])) == 0) exitwith {deletevehicle _x}} foreach _liste_ki_zufuss;
  _liste_ki_selbstmoerder = _liste_ki_selbstmoerder select {alive _x};
  {if ((count(playableunits inareaarray [position _x,_dist_ki_loeschen,_dist_ki_loeschen,0,false])) == 0) exitwith {deletevehicle _x}} foreach _liste_ki_selbstmoerder;

  // # wurde das fahrzeug zerstoert?
  if (isnull _hl_fzg) then {s_mission_params set [0,false]; _missionsende_resultat = "fahrzeug zerstoert"};

  // # sofern das fahrzeug noch existiert.....
  if (!isnull _hl_fzg) then {

    // # zielzone erreicht?
    if (_hl_fzg inarea (_loc_params_mission select 1)) then {s_mission_params set [0,false]; _missionsende_resultat = "fahrzeug im zielgebiet"};

    // # zu hoher schaden resultiert in misserfolg
    if ((getdammage _hl_fzg) > 0.96) then {s_mission_params set [0,false]; _missionsende_resultat = "fahrzeugschaden zu hoch"};

    // # benzin reduzieren
    if (isengineon _hl_fzg) then {_hl_fzg setfuel ((fuel _hl_fzg) - s_hlhc_benzinverlust)};


    // # fzg-marker aktualisieren
    _marker_fzg setmarkerpos (position _hl_fzg);


    // # gruppenfuehrer fzg-fahrer pruefen, ggf aktualisieren
    if ((!isnull (commander _hl_fzg)) && {(leader _hl_fzg_fahrer) != (commander _hl_fzg)}) then {
      if ((isplayer(leader _hl_fzg_fahrer)) && {(leader _hl_fzg_fahrer) in (crew _hl_fzg)}) then {
        [[format["<t color='#ff0000' size='2'>Du musst aussteigen damit %1 die Fahrzeugontrolle uebernehmen kann - Danach kannst du wieder einsteigen!",name (commander _hl_fzg)], "PLAIN", -1, true, true]] remoteExec ["cutText",(leader _hl_fzg_fahrer)];
      };
      [_hl_fzg_fahrer] joinsilent (commander _hl_fzg);
      {
        [[format["<t color='#ff0000' size='2'>%1 hat die Fahrzeugontrolle uebernommen!",name (commander _hl_fzg)], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
      } foreach (playableunits);
      s_hlhc_speedlimit remoteexec ["fnc_a_sys_speedlimit",commander _hl_fzg];
    };


    // # obj-spawn pruefen
    if (((count _liste_ki_zufuss) + (count _liste_ki_selbstmoerder)) < ((count playableunits) * s_hlhc_max_ki_pro_spieler)) then {
      _pos_spawn_typ = [_hl_fzg,s_hlhc_spawn_dist select 0,s_hlhc_spawn_dist select 1,s_sys_area_hq,(s_hlhc_spawn_dist select 0)/4] call fnc_s_sys_spawnpos_in_umkreis_obj;
      if ((count _pos_spawn_typ) > 0) then {
        _pos_spawn = _pos_spawn_typ select 0;
        if ((_pos_spawn_typ select 1) == "strasse") then {
          // vec-spawner
        } else {
          if (selectrandom s_hlhc_chance_selbstmoerder) then {
            _unit = [_pos_spawn,s_hlhc_unitklassen_feind_allgemein] call fnc_s_sys_spawn_unit;
            [_unit,"selbstmoerder"] call fnc_s_sys_unit_konfig_loadout;
            _liste_ki_selbstmoerder pushback _unit;
          } else {
            _unit = [_pos_spawn,s_hlhc_unitklassen_feind_allgemein] call fnc_s_sys_spawn_unit;
            [_unit,s_admin_ki_level_min/100,s_admin_ki_level_max/100] call fnc_s_sys_unit_konfig_skills;
            [_unit,"bandit"] call fnc_s_sys_unit_konfig_loadout;
            [_unit,selectrandom s_hlhc_waffensets_angreifer,[]] call fnc_s_sys_unit_konfig_waffenset;
            if (selectrandom s_hlhc_chance_launcher) then {[_unit,[],selectrandom s_hlhc_launchersets_angreifer] call fnc_s_sys_unit_konfig_waffenset};
            _liste_ki_zufuss pushback _unit;
          };
        };
      };//if ((count _pos_spawn_typ) > 0) then {
    };


    // # verfolgung aktualisieren?
    if (time > _zeitstempel_ki_folgt_zielfahrzeug) then {
      {
        _gruppe = group _x;
        while {(count(waypoints _gruppe))>1} do {deleteWaypoint((waypoints _x)select 0)};
        _gruppe addWaypoint [position _hl_fzg, 5, 0];
        [_gruppe, 0] setWaypointBehaviour "AWARE";
        [_gruppe, 0] setWaypointspeed "FULL";
        [_gruppe, 0] setWaypointType "MOVE";
        _gruppe addWaypoint [position _hl_fzg,2,1];
        [_gruppe, 1] setWaypointCompletionRadius 2;
        [_gruppe, 1] setWaypointBehaviour "AWARE";
        [_gruppe, 1] setWaypointspeed "FULL";
      } foreach _liste_ki_zufuss;
      {
        if ((_x distance _hl_fzg) > s_hlhc_dist_zuendung_selbstmoerder) then {
          _x doMove getpos _hl_fzg;
        } else {
          "Bo_GBU12_LGB" createVehicle (position _x);
        };
      } foreach _liste_ki_selbstmoerder;
      _zeitstempel_ki_folgt_zielfahrzeug = time + s_hlhc_zeitabstand_verfolgung;
    };


  };//(!isnull _hl_fzg)


  // # benzin-hinweis
  if (((fuel _hl_fzg) == 0) && {!_benzinhinweis}) then {
    _benzinhinweis = true;
    if (!isnull _hl_fzg) then {
      {
        [["<t color='#ff0000' size='2'>Das Fahrzeug hat keinen Treibstoff mehr - Evtl. ist der Tank beschaedigt! Ihr koennt aufgeben oder das Fahrzeug reparieren und neu betanken...", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
      } foreach (playableunits);
    } else {
      s_mission_params set [0,false];
      _missionsende_resultat = "fahrzeugschaden zu hoch";
    };
  };




  // # notaus aktiviert?
  if (s_mission_params select 4) then {s_mission_params set [0,false]};

  uisleep 0.3;

};



// # auswertung
switch (_missionsende_resultat) do {
  case "fahrzeug im zielgebiet": {
    {
      [["<t color='#2cb02a' size='4'>Geschafft - Das Fahrzeug wurde erfolgreich ueberfuehrt!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
  case "fahrzeug zerstoert": {
    {
      [["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN - Das Fahrzeug wurde zerstoert!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
  case "fahrzeugschaden zu hoch": {
    {
      [["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN - Das Fahrzeug ist nicht mehr reparabel!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
    } foreach playableunits;
  };
};

// # alles loeschen
_erstellte_objekte append _liste_ki_zufuss;
_erstellte_objekte append _liste_ki_selbstmoerder;
[_erstellte_objekte,_erstellte_marker] execvm "alex_scripte\s_mission_loeschen.sqf";

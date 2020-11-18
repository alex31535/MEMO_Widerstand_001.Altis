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
s_mili_liste_geiseln = [];
s_mili_liste_ki = [];
s_mili_liste_dekoobjekte = [];
s_mili_debugpos = [];
s_mili_waffenliste = [];
s_mili_marker = "";
s_mili_waffenoffizier = objnull;
s_mili_liste_geiselnehmer = []; // ...ohne taucher

private _scriptaufruf = "";
_scriptaufruf = [] execvm "alex_missions\mibu_liberty\init_mili_setup_liberty.sqf"; waituntil {scriptdone _scriptaufruf};


//player allowdammage false;
//player setposworld [15237.6,14245.3,8.81885];
//player setunitloadout "O_Soldier_F";

{[[format[" <t color='#9c1128' size='6'>Die USS Liberty wurde geentert! Sie haben %1 Minuten um %2 Geiseln zu befreien!",s_mili_zeitfenster_vorgabe select 0, count s_mili_liste_geiseln], "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;





private _zeit_ende = time + ((s_mili_zeitfenster_vorgabe select 0) *60);
private _alle_zeitstempel = [];
{_alle_zeitstempel pushback [_x,_zeit_ende - (_x *60)]} foreach s_mili_zeitfenster_vorgabe;
_alle_zeitstempel deleteat 0;



private _missionsende_resultat = "";
private _geiseln_max = count s_mili_liste_geiseln;
private _geiseln_gerettet = [];
private _unit = objnull;
private _mili_area_liberty = [position eo_liberty,500,500,0,false];



while {s_mission_params select 0} do {


  s_mili_liste_geiseln = s_mili_liste_geiseln select {alive _x};

  {
    if ((count(playableunits inAreaArray [getposworld _x,1.5,1.5,0,false,1.5])) > 0) exitwith {
      s_mili_liste_geiseln deleteat _foreachindex;
      _unit = _x;
      _unit assignascargo s_mili_liberty_heli;
      _unit moveincargo s_mili_liberty_heli;
      s_mili_liste_ki pushback _unit;
      _geiseln_gerettet pushback _unit;
      {[[format["<t color='#9c1128' size='2'>Geisel %1 gerettet...%2 Geiseln verbleibend!",name _unit, count s_mili_liste_geiseln], "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
    };
  } foreach s_mili_liste_geiseln;



  // # geisel gestorben?
  if (((count s_mili_liste_geiseln) + (count _geiseln_gerettet)) < _geiseln_max) then {
    s_mission_params set [0,false];
    _missionsende_resultat = "geisel gestorben";
  };



  if (((locked s_mili_liberty_heli) == 3) && {(count s_mili_liste_geiseln) == 0}) then {
    {[["<t color='#d1c51d' size='4'>Alle lebenden Geiseln gerettet - Der Helikopter auf dem Flugdeck ist betriebsbereit!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
    s_mili_liberty_heli lock 0;
    s_mili_liberty_heli lockCargo true;
  };


  if (!((position s_mili_liberty_heli) inarea _mili_area_liberty)) then {
    s_mission_params set [0,false];
    _missionsende_resultat = "mit heli geflohen";
  };



  // # zeit-schalter
  if (time > _zeit_ende) then {
    s_mission_params set [0,false];
    _missionsende_resultat = "zeit abgelaufen";
  } else {
    if (((count _alle_zeitstempel) > 0) && {time > ((_alle_zeitstempel select 0) select 1)}) then {
      {
        [[format["<t color='#9c1128' size='2'>Achtung - Ca. %1 Minute(n) bis zur Zuendung der Bomben!",(_alle_zeitstempel select 0) select 0], "PLAIN", -1, true, true]] remoteExec ["cutText",_x]
      } foreach playableunits;
      _alle_zeitstempel deleteat 0;
    };
  };


  // # waffen aufmunitionieren
  {_x setVehicleAmmo 1} foreach s_mili_waffenliste;


  // # notaus-bedingung
  if (s_mission_params select 4) then {
    s_mission_params set [0,false];
    _missionsende_resultat = "notaus";
  };


  uisleep 0.3;
};



// # auswertung
s_mili_liberty_heli allowdammage true;
switch (_missionsende_resultat) do {

  case "mit heli geflohen": {
    {
      [[format["<t color='#2cb02a' size='2'>Geschafft - %1 von %2 Geiseln konnten gerettet werden !",_geiseln_max, count _geiseln_gerettet], "PLAIN", -1, true, true]] remoteExec ["cutText",_x]
    } foreach playableunits;
    {deletevehicle _x} foreach _geiseln_gerettet;
  };

  case "zeit abgelaufen": {
    {
      [[format["<t color='#d93316' size='6'>Die Zeit ist abgelaufen - Die Bomben detonieren in wenigen Augenblicken!",count s_mili_liste_geiseln], "PLAIN", -1, true, true]] remoteExec ["cutText",_x]
    } foreach playableunits;
    s_mili_liste_geiseln append _geiseln_gerettet;
    uisleep 5;
    {"Bo_GBU12_LGB" createVehicle (getposworld _x); uisleep (selectrandom [5,4,3,2,1])} foreach s_mili_liste_geiseln;
    {
      [[format["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN!",count s_mili_liste_geiseln], "PLAIN", -1, true, true]] remoteExec ["cutText",_x]
    } foreach playableunits;
  };

  case "geisel gestorben": {
    {
      [[format["<t color='#d93316' size='4'>Die Sprengstoffwesten der Geiseln wurden aktiviert!",count s_mili_liste_geiseln], "PLAIN", -1, true, true]] remoteExec ["cutText",_x]
    } foreach playableunits;
    s_mili_liste_geiseln append _geiseln_gerettet;
    uisleep 3;
    {"Bo_GBU12_LGB" createVehicle (getposworld _x); uisleep (selectrandom [5,4,3,2,1])} foreach s_mili_liste_geiseln;
    {
      [[format["<t color='#d93316' size='6'>MISSION FEHLGESCHLAGEN!",count s_mili_liste_geiseln], "PLAIN", -1, true, true]] remoteExec ["cutText",_x]
    } foreach playableunits;
  };


};






// # alles loeschen
private _erstellte_objekte = s_mili_liste_geiseln;
_erstellte_objekte append _geiseln_gerettet;
_erstellte_objekte append s_mili_liste_ki;
_erstellte_objekte append s_mili_liste_dekoobjekte;
_erstellte_objekte append s_mili_waffenliste;
_erstellte_objekte append [s_mili_liberty_heli,eo_liberty];
[_erstellte_objekte,[s_mili_marker]] execvm "alex_scripte\s_mission_loeschen.sqf";

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


params ["_erstellte_objekte","_erstellte_marker"];





{
  [["<t color='#02bf1b' size='4'>Notsignal empfangen - Begeben Sie sich zum Zielort und retten Sie den Zivilisten!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
} foreach playableunits;


//----------------------------------------------------------------------------------------------------------------------- hauptteil start
private _core_status = "";
while {_core_status == ""} do {




  // ## notaus aktiviert?
  if (s_mission_params select 4) then {_core_status = "notaus"};

  // # bremse
  uisleep 0.3;
};
//----------------------------------------------------------------------------------------------------------------------- hauptteil ende


// # corestatus auswerten
private _mission_beenden = false;
switch (_core_status) do {
  case "zivilist im transporter": {
    s_rettz_zivilisten_gerettet = s_rettz_zivilisten_gerettet +1;
    if (s_rettz_zivilisten_gerettet == s_rettz_anz_zivilisten) then {
      {[["<t color='#2cb02a' size='8'>Mission abgeschlossen - Sie haben alle Zivilisten gerettet!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
      _mission_beenden = true;
    } else {
      {[["<t color='#2cb02a' size='8'>Geschafft - Sie haben alle Zivilisten gerettet!", "PLAIN", -1, true, true]] remoteExec ["cutText",_x]} foreach playableunits;
    };
  };

  case "notaus": {
    _mission_beenden = true;
  };
};

// # nach der core-auswertung kurz pausieren
uisleep 3;

//if (_mission_beenden) exitwith {[_erstellte_objekte,_erstellte_marker] execvm "alex_scripte\s_mission_loeschen.sqf"};

//[_erstellte_objekte,_erstellte_marker,_liste_hauspos,_vec_transport_fob,_verteiler_unit_zombie] execvm (format["%1s_mission_core.sqf",s_mission_params select 2]);

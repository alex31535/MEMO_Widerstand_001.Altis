/*
  fnc_s_gruppenmission_starten
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
// # die uebergebenen parameter orientieren sich 1:1 an den loc-parametern
//params ["_loc_name","_loc_pos","_loc_groesse","_loc_geb_dichte","_loc_dichte_obj","_loc_pkt","_loc_lvl","_loc_farbe"];
params ["_params_index"];
private _params = s_loc_params select _params_index;
private _loc_name = _params select 0;
private _loc_pos = _params select 1;
private _loc_groesse = _params select 2;
private _loc_geb_dichte = _params select 3;
private _loc_dichte_obj = _params select 4;
private _loc_pkt = _params select 5;
private _loc_lvl = _params select 6;
private _loc_farbe = _params select 7;



reverse s_spieler_oder_ki;
while {s_db_aktiv} do {uisleep 0.3};
s_db_aktiv = true;
private _db = ["new", format["%1_s_spieler_oder_ki_%2",s_pref_spiel,(toLowerANSI worldname)]] call OO_INIDBI;
["write",["s_spieler_oder_ki","s_spieler_oder_ki",s_spieler_oder_ki]] call _db;
s_db_aktiv = false;


private _missionstyp = "nicht erkannt";
private _missionsname = format["Test(nicht erkannt): %1 Level ",_loc_name,_loc_lvl];
private _garagennutzung = true;
private _waffenkammernutzung = true;

switch (_loc_farbe) do {
  case "ColorRed": {
    _missionstyp = "eroberung";
    _missionsname = format["Eroberung: %1 Level %2",_loc_name,_loc_lvl];
    _garagennutzung = true;
    _waffenkammernutzung = true;
  };
  case "ColorGreen": {
    _missionstyp = "stabilisieren";
    _missionsname = format["Stabilisieren: %1 Level %2",_loc_name,_loc_lvl];
    _garagennutzung = true;
    _waffenkammernutzung = true;
  };
  case "ColorBlue": {
    _missionstyp = "verteidigen";
    _missionsname = format["Verteidigen: %1 Level %2",_loc_name,_loc_lvl];
    _garagennutzung = false;
    _waffenkammernutzung = false;
  };
  default {
    _missionstyp = "test";
    _missionsname = format["Test(Default): %1 Level %2",_loc_name,_loc_lvl];
    _garagennutzung = false;
    _waffenkammernutzung = false;
  };
};




private _missionsparameter = [
/* 0: mission (global/single) aktiv ? */ true,
/* 1: name der Mission */ _missionsname,
/* 2: missionspfad zb "alex_missions\memo_deathmatch\" */ format["missionen\%1\",_missionstyp],
/* 3: allg.Missionsparameter, hier index auf s_loc_params */ _params_index,
/* 4: notaus */ false,
/* 5: garagen verfuegbar */ _garagennutzung,
/* 6: ausstattungen verfuegbar */ _waffenkammernutzung
];

// # start-missionsparameter erstellen
s_mission_params = _missionsparameter;


// # bekanntgabe des ziels
{[[format["<t color='#ffa600' size='6'>Neue Gruppenmission: %1",_missionsname], "PLAIN", -1, true, true]] remoteexec ["cuttext",_x]} foreach playableunits;

[] execvm (format["missionen\%1\s_mission_generieren.sqf",_missionstyp]);

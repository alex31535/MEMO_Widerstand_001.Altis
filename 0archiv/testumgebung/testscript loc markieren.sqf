#define _DEF_min_gebaeudepositionen 3

fnc_s_fr_gebaeudeauswahl_test = compile preprocessfilelinenumbers "testumgebung\fnc_s_fr_gebaeudeauswahl.sqf";
fnc_s_fr_positionen_innerhalb_haus_test = compile preprocessfilelinenumbers "testumgebung\fnc_s_fr_positionen_innerhalb_haus.sqf";


private _location_auswahl = nearestLocations [[worldsize/2,worldsize/2,0], ["NameCity","NameCityCapital"], worldsize];


private _loc_gewaehlt = selectrandom _location_auswahl;

private _loc_pos = locationposition _loc_gewaehlt;

private _loc_groesse = (((size _loc_gewaehlt) select 0)+((size _loc_gewaehlt) select 1))/2;

private _loc_area = [_loc_pos, _loc_groesse, _loc_groesse, 0, false];

private _loc_haeuser = [_loc_pos, _loc_groesse, _DEF_min_gebaeudepositionen] call fnc_s_fr_gebaeudeauswahl_test;


private _marker = createMarker ["testmission", _loc_pos];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [_loc_groesse, _loc_groesse];
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 0.5;


systemchat format["testmission: %1, groesse: %2, haeuser: %3",text _loc_gewaehlt, _loc_groesse, count _loc_haeuser];

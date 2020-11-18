

#define _DEF_min_anz_geb_positionen_in_loc_zivilist 4

for "_i" from 0 to 500 do {
  _marker = format["m_test_%1",_i];
  if ((getMarkerType _marker) == "") exitwith {};
  deletemarker _marker;
};




//private _haeuser_area1 = [];
private _positionen_innerhalb_haus = [];
private _auswahl_innenpositionen_grob = [];
private _liste_hauspos = [/*0:hauspos_innen*/];






systemchat "Suche Haeuser....";
{
  _auswahl_innenpositionen_grob = [];
  //_haeuser_area1 = [((_x select 1) select 0), 80, _DEF_min_anz_geb_positionen_in_loc_zivilist] call fnc_a_sys_gebaeudeauswahl;
  {
    _positionen_innerhalb_haus = [_x] call fnc_a_sys_positionen_innerhalb_haus;
    if ((count _positionen_innerhalb_haus) > 0) then {_auswahl_innenpositionen_grob pushback (selectrandom _positionen_innerhalb_haus)};
  //} foreach _haeuser_area1;
  } foreach ([((_x select 1) select 0), 80, _DEF_min_anz_geb_positionen_in_loc_zivilist] call fnc_a_sys_gebaeudeauswahl);
  if ((count _auswahl_innenpositionen_grob) > 0) then {_liste_hauspos pushback (selectrandom _auswahl_innenpositionen_grob)};
} foreach s_sys_locations;






systemchat "Passe Anzahl gefunderner Haeuser an....";
while {(count _liste_hauspos) > s_rettz_anz_zivilisten} do {_liste_hauspos deleteat (floor(random(count _liste_hauspos)))};

systemchat "Markiere Haeuser....";

{
  _marker = createMarker [format["m_test_%1",_foreachindex], _x];
  _marker setMarkerType "mil_dot";
  _marker setMarkertext (format["Zivilist #%1",_foreachindex]);
} foreach _liste_hauspos;

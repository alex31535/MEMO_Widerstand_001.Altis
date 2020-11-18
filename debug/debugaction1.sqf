#define _DEF_geb_positionen 3
#define _DEF_lvl_max 7


_liste_klassen = [];
for "_i" from 1 to 100 do {
  call compile format["if (!isnil ""eo_mapobj_%1"") then {_liste_klassen pushback (typeof eo_mapobj_%1); deletevehicle eo_mapobj_%1};",_i];
};


private _pos_basis = position eo_flagge_basis;

private _loc_params = [


];

private _alle_obj_gefiltert_temp = [];
private _alle_map_obj_verwertet = [];
private _pkt_max = 0;
private _location = "";
private _loc_pos = [];
private _groesse = 0;
private _gebaeudeauswahl = [];
private _pkt = 0;
private _map_obj_in_loc_verwertbar = [];
private _loc_count = 0;
{
  _location = _x;
  _loc_pos = locationposition _location;
  _groesse = ((((size _x) select 0)+((size _x) select 1))/2) *2;
  _gebaeudeauswahl = [_loc_pos,_groesse,_DEF_geb_positionen] call fnc_s_gebaeudeauswahl;
  _map_obj_in_loc_verwertbar = [];
  {
    _klasse = _x;
    {
      _map_obj = _x;
      {if (_x == _map_obj) exitwith {_map_obj = objnull}} foreach _alle_map_obj_verwertet;
      //{if (_x == _map_obj) exitwith {_map_obj = objnull}} foreach _map_obj_in_loc_verwertbar;
      if (!isnull _map_obj) then {_map_obj_in_loc_verwertbar pushback _map_obj};
    } foreach nearestObjects [_loc_pos, [_klasse], _groesse];
    _alle_map_obj_verwertet append _map_obj_in_loc_verwertbar;
  } foreach _liste_klassen;
  _pkt = (count _gebaeudeauswahl) + ((count _map_obj_in_loc_verwertbar) *10);
  _loc_params pushback [_loc_pos, count _gebaeudeauswahl,count _map_obj_in_loc_verwertbar,_pkt];
  systemchat format["%1: +obj:%2 pkt:%3",text _location,count _map_obj_in_loc_verwertbar,_pkt];
  {
    _marker = createMarker [format["m_%1_%2",_loc_count,_foreachindex], position _x];
    _marker setMarkerType "mil_dot";
    _marker setMarkerColor "ColorGreen";
  } foreach _map_obj_in_loc_verwertbar;
  if (_pkt > _pkt_max) then {_pkt_max = _pkt};
  _loc_count = _loc_count +1;
} forEach (nearestLocations [[worldsize/2,worldsize/2,0], ["NameVillage","NameCity","NameCityCapital"], worldsize]);



private _marker = "";
private _pkt_step = _pkt_max/(_DEF_lvl_max +1);
private _pkt_lvl_steps = [];
for "_i" from 0 to (_DEF_lvl_max +1) do {
  _pkt_lvl_steps pushback (_pkt_step * _i);
};
systemchat format["_pkt_lvl_steps: %1",count _pkt_lvl_steps];
{
  _marker = createMarker [format["m_loc_%1",_foreachindex], _x select 0];
  _marker setMarkerType "mil_dot";
  _marker setMarkerColor "ColorRed";
  _pkt = _x select 3;
  _lvl = -1;
  {
    if (_x > _pkt) exitwith {_lvl = _foreachindex -1};
  } foreach _pkt_lvl_steps;
  if (_lvl == -1) then {_lvl = _DEF_lvl_max};
  _marker setmarkertext (format["LVL %1 +obj:%2 pkt:%3",_lvl,_x select 2,_x select 3]);
} foreach _loc_params;









//{
//  _alle_obj = nearestObjects [[worldsize/2,worldsize/2,0], [_x], worldsize];
//  {
//    _marker = createMarker [format["m_obj_%1",floor((position _x) select 0)],(position _x)];
//    _marker setMarkerType "mil_dot";
//    _marker setMarkerColor "ColorBlue";
//    _marker setmarkertext (typeof _x);
//  } foreach _alle_obj;

//} foreach _liste_klassen;

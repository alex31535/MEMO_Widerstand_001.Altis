#define _DEF_geb_positionen 3
#define _DEF_lvl_max 7


systemchat "starte...";

// # filter-schluessel zum selectieren der editor-objekte :: zb eo_locobj_FILTER_1, etc
private _liste_eo_obj_filter_str = [
"mil",
"spe",
"sak",
"ind"
];

systemchat "1...";

// # array zur feststellung von auf der map vorhandener objekte mit deren haeufigkeit
private _eo_obj_klassen_prio = [
/*
[filter ("mil"),[[klasse 1,anz],[klasse 2,anz],...]]
*/
];

systemchat "2...";


// # gesamte map nach allen objekttypen durchsuchen und priorisieren
private _filter_str = "";
private _liste_klassen_zu_filter_str = [];
private _liste_klasse_anz = [];
private _obj_klasse = "";
private _anz_obj_auf_map = 0;
private _alle_obj_auf_map = [];
systemchat "3...";
{
  _filter_str = _x;
  _liste_klassen_zu_filter_str = [];
  systemchat format["filter: %1",_filter_str];
  for "_i" from 1 to 100 do {
    systemchat format["filter: %1...%2",_filter_str,_i];
    call compile format["if (!isnil ""eo_locobj_%1_%2"") then {_liste_klassen_zu_filter_str pushback (typeof eo_locobj_%1_%2); deletevehicle eo_locobj_%1_%2};",_filter_str,_i];
  };
  _liste_klasse_anz = [];
  {
    _obj_klasse = _x;

    _alle_obj_auf_map = nearestObjects [[worldsize/2,worldsize/2,0], [_obj_klasse], worldsize];
    _anz_obj_auf_map = count _alle_obj_auf_map;
    if (_anz_obj_auf_map > 0) then {_liste_klasse_anz pushback [_anz_obj_auf_map,_obj_klasse,_alle_obj_auf_map]};
    systemchat format["%1...suche %2 = %3",_filter_str,_obj_klasse,_anz_obj_auf_map];
  } foreach _liste_klassen_zu_filter_str;
  _liste_klasse_anz sort false;
  _eo_obj_klassen_prio pushback [_filter_str,_liste_klasse_anz];
} foreach _liste_eo_obj_filter_str;


copytoclipboard (str _eo_obj_klassen_prio);
systemchat "fertig...";
/*
[
  ["mil",[
    [34,"Land_i_Barracks_V1_F"],
    [27,"Land_i_Barracks_V2_F"],
    [14,"Land_Cargo_Tower_V1_F"],
    [12,"Land_Research_house_V1_F"],
    [11,"Land_Cargo_HQ_V1_F"],
    [10,"Land_MilOffices_V1_F"],
    [7,"Land_TentHangar_V1_F"],
    [7,"Land_Research_HQ_F"],
    [7,"Land_Dome_Big_F"],
    [6,"Land_u_Barracks_V2_F"],
    [6,"Land_Cargo_Tower_V3_F"],
    [4,"Land_Hangar_F"],
    [4,"Land_Cargo_HQ_V3_F"],
    [3,"Land_Radar_Small_F"],
    [3,"Land_Airport_Tower_F"],
    [1,"Land_Radar_F"]
  ]],
  ["spe",[
    [16,"Land_GH_House_1_F"],
    [13,"Land_GH_House_2_F"],
    [8,"Land_Offices_01_V1_F"],
    [5,"Land_Lighthouse_small_F"],
    [3,"Land_Castle_01_tower_F"],
    [1,"Land_MolonLabe_F"]
  ]],
  ["sak",[
    [42,"Land_Chapel_V1_F"],
    [8,"Land_Chapel_V2_F"],
    [5,"Land_Church_01_V1_F"]
  ]],
  ["ind",[
    [47,"Land_dp_smallFactory_F"],
    [6,"Land_Factory_Main_F"],
    [4,"Land_dp_mainFactory_F"]
  ]]
]
*/

if (true) exitwith {};

//####################################################################################################################################################
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















//######################################################################################




//#define _DEF_geb_positionen 3
//#define _DEF_lvl_max 7
//#define _DEF_groesse_obj_area 250
//#define _DEF_dist_teiler (worldsize/1000)

params ["_DEF_geb_positionen","_DEF_lvl_max","_DEF_groesse_obj_area","_DEF_dist_teiler","_liste_eo_obj_filter_str","_loc_obj_aufwertungen"];

systemchat "locationberechnung wird gestartet...";

private _pos_basis = position eo_flagge_basis;

// # array zur feststellung von auf der map vorhandener objekte mit deren haeufigkeit
private _eo_obj_klassen_prio = [ /*[filter ("mil"),[[klasse 1,anz],[klasse 2,anz],...]] */];


systemchat "locationberechnung: objektfilter werden erstellt...";
// # gesamte map nach allen objekttypen durchsuchen und priorisieren
private _filter_str = "";
private _liste_klassen_zu_filter_str = [];
private _liste_klasse_anz = [];
private _obj_klasse = "";
private _anz_obj_auf_map = 0;
private _alle_obj_auf_map = [];
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
    if (_anz_obj_auf_map > 0) then {_liste_klasse_anz pushback [_anz_obj_auf_map,_obj_klasse]};
    systemchat format["%1...suche %2 = %3",_filter_str,_obj_klasse,_anz_obj_auf_map];
  } foreach _liste_klassen_zu_filter_str;
  _liste_klasse_anz sort false;
  _eo_obj_klassen_prio pushback [_filter_str,_liste_klasse_anz];
} foreach _liste_eo_obj_filter_str;




private _alle_loc_params = [/*[loc-pos,groesse,anz gebaeude,zusatzpunkte],[...]*/];
// hier nur lokal, da am ende noch zusätzliche parameter in abhängigkeit objektbasierter locations berechnet und angehängt werden !!!!!!!!!!!!!



systemchat "locationberechnung: map-location werden errechnet...";
private _loc_param = [];
private _location = locationnull;
private _loc_pos = [];
private _groesse = 0;
private _gebaeudeauswahl = [];
private _anz_aller_gebaeude = 0;
private _liste_klasse_anz = [];
private _obj_klasse = "";
private _alle_klassenobjekte_innerhalb_loc = [];
private _anz_alle_klassenobjekte_innerhalb_loc = 0;

private _loc_pkt = 0;
private _pkt_max = 0;


private _liste_locobjekte = [];
private _lobobjekt_kennung = "";
{
  _loc_param = [];
  _location = _x;
  _loc_pos = locationposition _location;
  /*0->*/_loc_param pushback (text _location);
  /*1->*/_loc_param pushback _loc_pos;
  _groesse = ((((size _x) select 0)+((size _x) select 1))/2) *1.5;
  /*2->*/_loc_param pushback _groesse;
  _gebaeudeauswahl = [_loc_pos,_groesse,_DEF_geb_positionen] call fnc_s_gebaeudeauswahl;
  _anz_aller_gebaeude = count _gebaeudeauswahl;
  /*3->*/_loc_param pushback _anz_aller_gebaeude;
  _liste_locobjekte = [];
  //----loc-objekt innerhalb der location
  {
    _lobobjekt_kennung = _x select 0;
    _liste_klasse_anz = _x select 1;
    _anz_alle_klassenobjekte_innerhalb_loc = 0;
    {
      _obj_klasse = _x select 1;
      _alle_klassenobjekte_innerhalb_loc = nearestObjects [_loc_pos, [_obj_klasse], _groesse];
      _anz_alle_klassenobjekte_innerhalb_loc = _anz_alle_klassenobjekte_innerhalb_loc + (count _alle_klassenobjekte_innerhalb_loc);
    } foreach _liste_klasse_anz;// x = [34,"Land_i_Barracks_V1_F"]
    _liste_locobjekte pushback [_lobobjekt_kennung, _anz_alle_klassenobjekte_innerhalb_loc];
  } foreach _eo_obj_klassen_prio;
  /*4->*/_loc_param pushback _liste_locobjekte;
  _alle_loc_params pushback _loc_param;
} forEach (nearestLocations [[worldsize/2,worldsize/2,0], ["NameVillage","NameCity","NameCityCapital"], worldsize]);



systemchat "locationberechnung: filterobjekte werden gesucht...";
private _obj = objnull;
private _objekte_ausserhalb_loc = [];
{
  _liste_klasse_anz = _x select 1;
  {
    _obj_klasse = _x select 1;
    _alle_obj_auf_map = nearestObjects [[worldsize/2,worldsize/2,0], [_obj_klasse], worldsize];
    {
      _obj = _x;
      for "_i" from 0 to ((count _alle_loc_params) -1) do {
        if ((position _obj) inarea (format["m_loc_area_%1",_i])) exitwith {_obj = objnull};
      };
      if (!isnull _obj) then {_objekte_ausserhalb_loc pushback _obj};
    } foreach _alle_obj_auf_map;
  } foreach _liste_klasse_anz;// x = [34,"Land_i_Barracks_V1_F"]
} foreach _eo_obj_klassen_prio;




systemchat "locationberechnung: objektlocations werden erstellt...";
private _objekte_ausserhalb_loc_nicht_verwendet = [];
private _obj_klasse_obj_ausserhalb_loc = "";
private _haeufigkeit_obj = 0;
private _haeufigkeit_obj_max_in_kategorie = 0;
private _multiplikator_kategorie = 0;
private _obj_displayname = 0;
{
  _obj = _x;
  _loc_pos = position _obj;
  _groesse = _DEF_groesse_obj_area;
  {
    if (_loc_pos inarea [_x select 1,_x select 2,_x select 2,0,false]) exitwith {_objekte_ausserhalb_loc_nicht_verwendet pushback _obj; _obj = objnull};
  } foreach _alle_loc_params;
  if (! isnull _obj) then {
    _obj_displayname = gettext(configFile >> "CfgVehicles" >> typeof _obj >> "displayname");
    _gebaeudeauswahl = [_loc_pos,_groesse,_DEF_geb_positionen] call fnc_s_gebaeudeauswahl;
    _liste_locobjekte = [];
    {
      _lobobjekt_kennung = _x select 0;
      _liste_klasse_anz = _x select 1;
      _anz_alle_klassenobjekte_innerhalb_loc = 0;
      {
        _obj_klasse = _x select 1;
        _alle_klassenobjekte_innerhalb_loc = nearestObjects [_loc_pos, [_obj_klasse], _groesse];
        _anz_alle_klassenobjekte_innerhalb_loc = _anz_alle_klassenobjekte_innerhalb_loc + (count _alle_klassenobjekte_innerhalb_loc);
      } foreach _liste_klasse_anz;// x = [34,"Land_i_Barracks_V1_F"]
      _liste_locobjekte pushback [_lobobjekt_kennung, _anz_alle_klassenobjekte_innerhalb_loc];
    } foreach _eo_obj_klassen_prio;
    _alle_loc_params pushback [_obj_displayname,_loc_pos,_groesse,count _gebaeudeauswahl,_liste_locobjekte];
  };
} foreach _objekte_ausserhalb_loc;






systemchat "locationberechnung: level-bereiche werden errechnet...";
private _pkt_max = 0;
private _alle_loc_params_pkt_obj = [];
{
  _eintrag = _x;
  //_pkt = floor((_eintrag select 3)/20) + ((_pos_basis distance (_eintrag select 1))/_DEF_dist_teiler);
  _pkt = (_eintrag select 3);// + ((_pos_basis distance (_eintrag select 1))/_DEF_dist_teiler);
  _obj_liste = _eintrag select 4;
  {
    _faktor = _loc_obj_aufwertungen select _foreachindex;
    _pkt = _pkt + ((_x select 1) * _faktor);
  } foreach _obj_liste;
  _eintrag pushback _pkt;
  _alle_loc_params_pkt_obj pushback _eintrag;
  if (_pkt_max < _pkt) then {_pkt_max = _pkt};
} foreach _alle_loc_params;


private _lvl_steps = [];
for "_i" from 1 to 7 do {_lvl_steps pushback ((_pkt_max/7) * _i)};

s_loc_params = [];

{
  _params = _x;
  _lvl = 0;
  _pkt =  (_params select 5);
  {
    if (_pkt < _x) exitwith {_lvl = _foreachindex};
    _lvl = 7;
  } foreach _lvl_steps;
  _params pushback _lvl;
  s_loc_params pushback _params;
} foreach _alle_loc_params_pkt_obj;



copytoclipboard (str s_loc_params);
systemchat "locationberechnung: beendet...";

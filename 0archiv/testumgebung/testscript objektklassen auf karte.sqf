_liste_klassen = [];
for "_i" from 1 to 100 do {
  call compile format["if (!isnil ""obj_klassentest_%1"") then {_liste_klassen pushback (typeof obj_klassentest_%1)};",_i];
};


{
  _alle_obj = nearestObjects [[worldsize/2,worldsize/2,0], [_x], worldsize];
  {
    _marker = createMarker [format["m_obj_%1",floor((position _x) select 0)],(position _x)];
    _marker setMarkerType "mil_dot";
    _marker setMarkerColor "ColorYellow";
    _marker setmarkertext (typeof _x);
  } foreach _alle_obj;

} foreach _liste_klassen;

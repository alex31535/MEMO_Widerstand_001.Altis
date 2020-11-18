
//eo_flagge_basis
_db = [
  name-str,pos-array,groesse,lvl-nr,pkt,status-nr
];





private _marker = createMarker ["m_test_flaeche", eo_flagge_basis];
_marker  setMarkerShape "ELLIPSE";
_marker setMarkerColor "ColorYellow";
_marker setMarkerSize [100, 100];
//_marker setmarkertext (format["%1",str(position _marker)]);
_marker setmarkertext (format["%1",_marker]);


// ...spieler klickt auf map
// ...alle marker "m_test_flaeche" auf inarea pruefen -> marker-name


_pos = getmarkerpos "m_test_flaeche";

_marker = createMarker ["m_test_icon", _pos];
_marker setMarkerType "mil_dot";
_marker setMarkerColor "ColorGreen";
_marker setMarkertext "ColorGreen";

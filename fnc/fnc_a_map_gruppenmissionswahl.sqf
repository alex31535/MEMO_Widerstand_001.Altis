/*
  fnc_a_map_gruppenmissionswahl.sqf
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.15
	Description: moving player to a position by clicking on map
  Called by: action
	Parameters: nothing
	Returns: nothing
  Necessary Globals: nothing
	Example: unnecessary

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
params ["_lvl_spieler","_loc_params"];
private _mapitem_hinzugefuegt = true;
private _fake_pos = position player;//[random(worldSize/2),random(worldSize/2),0];
// # pruefen ob map im inventar des spielers vorhanden
{if ((toLowerANSI(_x)) == "itemmap") exitwith {_mapitem_hinzugefuegt = false}} foreach (assignedItems player);
if (_mapitem_hinzugefuegt) then {player linkItem "ItemMap"};
// # positions-/auswahl-marker erstellen
private _marker = createMarkerLocal ["m_lokal_missionswahl",_fake_pos];
"m_lokal_missionswahl" setMarkerShapelocal "ICON";
"m_lokal_missionswahl" setMarkerTypelocal "mil_unknown";
"m_lokal_missionswahl" setMarkercolorlocal "ColorGrey";
"m_lokal_missionswahl" setMarkertextlocal "Keine Auswahl";
// # map erzwingen
openMap [true, false];
// # bekanntgabe max-lvl
cutText [format["<t color='#ffa600' size='4'>Du kannst Einsatzziele Level <t color='#ff0000' size='6'>%1<t color='#ffa600' size='4'> auswaehlen!",_lvl_spieler], "PLAIN", -1, true, true];
// # map-klick-analyse
private _pos_marker = getmarkerpos "m_lokal_missionswahl";
private _pos_marker_alt = _pos_marker;
private _params = [];
private _markerfarbe_loc = "";
while {visibleMap} do {
  onMapSingleClick "'m_lokal_missionswahl' setmarkerposlocal _pos;"; //
  _pos_marker = getmarkerpos "m_lokal_missionswahl";
  // # wurde die positionierung geaendert?
  if (!(_pos_marker isEqualTo _pos_marker_alt)) then {
    cutText ["", "PLAIN", -1, true, true];
    {
      if (_pos_marker inarea (format["m_loc_area_%1",_foreachindex])) exitwith {
        _params = _x;
        _markerfarbe_loc = markercolor (format["m_loc_area_%1",_foreachindex]);
      };
      _params = [];
    } foreach _loc_params;
    _pos_marker_alt = _pos_marker;
    if ((count _params) > 0) then {
      if (_lvl_spieler < (_params select 6)) then {
        "m_lokal_missionswahl" setMarkerTypelocal "mil_warning";
        "m_lokal_missionswahl" setMarkercolorlocal _markerfarbe_loc;
        "m_lokal_missionswahl" setMarkertextlocal "Level zu hoch";
        _params = [];
      } else {
        if (_markerfarbe_loc == (format["Color%1",str(side player)])) then {
          "m_lokal_missionswahl" setMarkerTypelocal "mil_flag";
          "m_lokal_missionswahl" setMarkercolorlocal (format["Color%1",str(side player)]);
          "m_lokal_missionswahl" setMarkertextlocal "Erobert";
          _params = [];
        } else {
          "m_lokal_missionswahl" setMarkerTypelocal "mil_join";
          "m_lokal_missionswahl" setMarkercolorlocal (format["Color%1",str(side player)]);
          "m_lokal_missionswahl" setMarkertextlocal "Angriff";
        };
      };
    } else {
      "m_lokal_missionswahl" setMarkerTypelocal "mil_unknown";
      "m_lokal_missionswahl" setMarkercolorlocal "ColorGrey";
      "m_lokal_missionswahl" setMarkertextlocal "Keine Auswahl";
    };
  };
};
// # abbruch sofern keine gueltige location ausgewaehlt
if ((count _params) == 0) exitwith {
  [] remoteexec ["fnc_s_locmarker_selectarea_an_aus",2];
  cutText ["<t color='#ff0000' size='2'>Du hast kein Ziel ausgewaehlt!", "PLAIN", -1, true, true];
};

_params remoteexec ["fnc_s_gruppenmission_starten",2];

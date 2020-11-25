/*
  c_action_spieler_zu_mappos.sqf
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
private _markertext = "Hier hin...";
private _mapitem_hinzugefuegt = true;
private _fake_pos = position player;//[random(worldSize/2),random(worldSize/2),0];
private _pos_player = [];
private _marker = objnull;
player allowdammage false;
// # pruefen ob map zugewiesen
{if ((toLowerANSI(_x)) == "itemmap") exitwith {_mapitem_hinzugefuegt = false}} foreach (assignedItems player);
if (_mapitem_hinzugefuegt) then {player linkItem "ItemMap"};
// # marker erstellen
_marker = createMarkerLocal ["mappos_local",_fake_pos];
"mappos_local" setMarkerShapelocal "ICON";
"mappos_local" setMarkerTypelocal "hd_start";
"mappos_local" setMarkerTextLocal _markertext;
// # map erzwingen
openMap [true, false];
// # warten auf map-close
while {visibleMap} do {player setpos _fake_pos; onMapSingleClick "'mappos_local' setmarkerposlocal _pos;"};
// # spieler auf pos setzen und marker loeschen
_pos_player = AGLToASL (getmarkerpos "mappos_local");
//_pos_player set [2,0.5];
player setposasl _pos_player;
player setVectorUp (surfaceNormal (position player));
deleteMarkerLocal "mappos_local";
// # ggf erzwungene map loeschen
if (_mapitem_hinzugefuegt) then {player unlinkItem "ItemMap"};
//sleep 1;
//while {(player distance _pos_player) > 1} do {sleep 0.3};
player allowdammage true;

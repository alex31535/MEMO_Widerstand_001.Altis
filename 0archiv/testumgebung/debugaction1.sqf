// debugaction
s_debugpos = getposworld player;

if (!isnil "eo_debugpos") then {s_debugpos = getposworld eo_debugpos; deletevehicle eo_debugpos};

//deletevehicle eo_liberty;

//private _params = ["Land_Destroyer_01_base_F",[15291.9,14257.3,0.016737],257.714];
//eo_liberty = (_params select 0) createVehicle [0,0,0];
//eo_liberty setposworld (_params select 1);
//eo_liberty setdir (_params select 2);


player setposworld s_debugpos;






//[[eo_liberty,"Land_Destroyer_01_hull_04_F"] call BIS_fnc_Destroyer01GetShipPart,1,true] call BIS_fnc_Destroyer01AnimateHangarDoors;

//for "_i" from 0 to 50 do {
  //systemchat format ["debugaction: tuer %1",_i];
  //uisleep 3;
  //systemchat "debugaction: tuer schliesst...";
  //[eo_liberty, _i, 1] call BIS_fnc_door;
  //systemchat "debugaction: tuer geschlossen...";
//};
//systemchat "debugaction: fertig...";

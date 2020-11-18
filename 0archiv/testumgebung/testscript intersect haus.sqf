private _unit = player;
private _intersect = lineIntersectsSurfaces [AGLToASL(position _unit),(AGLToASL(position _unit)) vectorAdd [0, 0, 20],objnull,objNull,true,1,"GEOM","NONE"];

while {true} do {
  _intersect = lineIntersectsSurfaces [AGLToASL(position _unit),(AGLToASL(position _unit)) vectorAdd [0, 0, 20],_unit,_unit,true,1,"GEOM","NONE"];
  if ((count _intersect) >0) then {
    systemchat format["testscript: %1",typeof((_intersect select 0) select 2)];
  };
  uisleep 0.3;
};


//private _intersect = lineIntersectsSurfaces [AGLToASL(position player),(AGLToASL(position _unit)) vectorAdd [0, 0, 20],objnull,objNull,true,1,"GEOM","NONE"];
//if ((count _intersect) > 1) then {systemchat format["dmd haus: %1",typeof (_intersect select 2)]};
//if (((count _intersect) > 1) && {(_intersect select 2) == _haus}) exitwith {true};
//false

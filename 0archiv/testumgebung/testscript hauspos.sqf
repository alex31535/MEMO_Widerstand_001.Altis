
fnc_s_fr_gebaeudeauswahl_test = compile preprocessfilelinenumbers "testumgebung\fnc_s_fr_gebaeudeauswahl.sqf";
fnc_s_fr_positionen_innerhalb_haus_test = compile preprocessfilelinenumbers "testumgebung\fnc_s_fr_positionen_innerhalb_haus.sqf";

private _pos_test = position eo_testscript; deletevehicle eo_testscript;
private _alle_haeuser = [_pos_test, 100,4] call fnc_s_fr_gebaeudeauswahl_test;
if ((count _alle_haeuser) == 0) exitwith {systemchat "testscript: zu wenig gebaeude"};

private _haus = _alle_haeuser select 0;

private _positionen_im_haus = [_haus] call fnc_s_fr_positionen_innerhalb_haus_test;



private _unit = objnull;
private _erstelle_objekte = [];
{
  _unit = (creategroup [west,true]) createUnit ["B_Survivor_F", [0,0,0], [], 0, "NONE"];
  //_unit setposasl _x;
  _unit setposasl (agltoasl _x);
  _unit setdir (random 360);
  _erstelle_objekte pushback _unit;
  if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_unit] call fnc_s_debugmarker_erstellen};
} foreach _positionen_im_haus;



systemchat format["testscript: %1 units erstellt fuer %2",count _erstelle_objekte,typeof _haus];

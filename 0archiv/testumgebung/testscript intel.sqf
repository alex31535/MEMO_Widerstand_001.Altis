//"Land_File_research_F"

#define _def_action_ext 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];

if (!isserver) exitwith {};

while {isnil "s_debugmarker"} do {uisleep 1};



fnc_s_fr_gebaeudeauswahl_test = compile preprocessfilelinenumbers "testumgebung\fnc_s_fr_gebaeudeauswahl.sqf";
fnc_s_fr_positionen_innerhalb_haus_test = compile preprocessfilelinenumbers "testumgebung\fnc_s_fr_positionen_innerhalb_haus.sqf";

private _pos_test = position eo_testscript; deletevehicle eo_testscript;
private _alle_haeuser = [_pos_test, 50,4] call fnc_s_fr_gebaeudeauswahl_test;
if ((count _alle_haeuser) == 0) exitwith {systemchat "testscript: zu wenig gebaeude"};

private _haus = _alle_haeuser select 0;

private _positionen_im_haus = [_haus] call fnc_s_fr_positionen_innerhalb_haus_test;




private _obj = "Land_File_research_F" createVehicle [0,0,0];
_obj setposasl (agltoasl (selectrandom _positionen_im_haus));
_obj setdir (random 360);
if ((!isnil "s_debugmarker") && {s_debugmarker}) then {[_obj] call fnc_s_debugmarker_erstellen};


[_obj] remoteexec ["BIS_fnc_initIntelObject",0,true];


_obj setVariable ["RscAttributeDiaryRecord_texture","a3\structures_f_epc\Items\Documents\Data\document_secret_01_co.paa",true];
[_obj,"RscAttributeDiaryRecord",["Titel","Text"]] call BIS_fnc_setServerVariable;
_obj setVariable ["recipients", east, true];
_obj setVariable ["RscAttributeOwners", [west], true];




[
		_obj,
		"IntelObjectFound",
		{
			params[ "", "_foundBy" ];
			private _msg = format[ "Intel Found by %1", name _foundBy ];
			_msg remoteExec[ "systemChat" ];
		}
	 ] call BIS_fnc_addScriptedEventHandler;

systemchat "testscript: beendet";

// # init-params---------------------------------------------------------------------------------------------------------------------------------------------------------


// # funktionen---------------------------------------------------------------------------------------------------------------------------------------------------------
fnc_a_garage_spieler_waehlt = compile preprocessfilelinenumbers "fnc\fnc_a_garage_spieler_waehlt.sqf";


// # auf spieler warten-----------------------------------------------------------------------------------------------------------------------------------auf spieler warten
// # warten bis der spieler bereit ist
while {getClientStateNumber < 10} do {sleep 0.3};
waituntil {!(IsNull (findDisplay 46))};
// # auf externe sicht schalten
player switchCamera "EXTERNAL";


// # map-indikatoren--------------------------------------------------------------------------------------------------------------------------------------map-indikatoren
disableMapIndicators [	false,							true,						false,					true];
//										[	0:disableFriendly,	1:disableEnemy,	2:disableMines,	3:disablePing]

// # scoretabelle------------------------------------------------------------------------------------------------------------------------------------------------scoretabelle
player addEventHandler ["Handlescore", {false}];// # TSM: punkte auf spieler (benoetigt ebenfalls einen eventhandler ENTITIEKILLED auf server)

// # faehigkeiten----------------------------------------------------------------------------------------------------------------------------------------------faehigkeiten
player setUnitTrait ["Medic",false];
player setUnitTrait ["engineer",false];
player setUnitTrait ["explosiveSpecialist",false];
player setUnitTrait ["UAVHacker",false];

// # arsenal vorladen-----------------------------------------------------------------------------------------------------------------------------------------arsenal vorladen
["Preload"] spawn BIS_fnc_arsenal;

// # pers. arsenal deaktivieren?-------------------------------------------------------------------------------------------------------------------pers. arsenal deaktivieren?
[missionNamespace, "arsenalOpened",
	{
		disableSerialization;
		params ["_anzeige"];
		_anzeige displayAddEventHandler ["keydown", "_this select 3"];
		{(_anzeige displayCtrl _x) ctrlShow false} forEach [44151, 44150, 44146, 44147, 44148, 44149, 44346];
  }] call BIS_fnc_addScriptedEventHandler;


// # event bei arsenal ende?----------------------------------------------------------------------------------------------------------------------------event bei arsenal ende?
[missionNamespace, "arsenalClosed",
	{
	//[getunitloadout player] remoteExecCall ["fnc_s_spcfg_loadout_spieler_speichern",2]
	}] call BIS_fnc_addScriptedEventHandler;


// # witti: enticklungsumgebung----------------------------------------------------------------------------------------------------------------------------witti: enticklungsumgebung
[] execvm "witti\initPlayerLocal.sqf";



// # abschluss/ende/a_lokaler_debug---------------------------------------------------------------------------------------------------------abschluss/ende/a_lokaler_debug
if (!isserver) exitwith {};

if ((getplayeruid player) == "76561197996449012") then {
	[] execvm "debug\testscript.sqf";
	player addAction ["DEBUGACTION", "debug\debugaction.sqf"];
	player addAction ["DEBUGDISCONNECT", "debug\debugdisconnect.sqf"];
};


private _text = "";
while {true} do {
	hintsilent parsetext _text;
	_text = "";
	_text = _text + format["<br />FPS: %1",floor(diag_fps)];
	_text = _text + format["<br />vec-mod: %1 ",((((configSourceMod(configFile >> "CfgVehicles" >> (typeof(objectparent player)))) splitstring "@") select 0) splitString " ") joinString "_"];
	if (! isnil "s_sys_landfahrzeuge_1") then {_text = _text + format["<br />landfahrzeuge: %1 ", count s_sys_landfahrzeuge_1]};
	if (! isnil "s_sys_landfahrzeuge_1") then {_text = _text + format["<br />luftfahrzeuge: %1 ", count s_sys_luftfahrzeuge_1]};
	if (! isnil "s_sys_landfahrzeuge_1") then {_text = _text + format["<br />wasserfahrzeuge: %1 ", count s_sys_wasserfahrzeuge_1]};
	_text = _text + format["<br />onroad: %1",isonroad (position player)];
	//------
	_pos_ende = (eyePos player) vectorAdd ((player weaponDirection(currentWeapon player)) vectorMultiply 1.2);
	if (weaponLowered player) then {_pos_ende = (eyePos player) vectorAdd ((eyeDirection player) vectorMultiply 1.2)};
	_liste_lineintersect = lineIntersectsSurfaces [(eyePos player),_pos_ende,player,objNull,true,1,"GEOM","NONE"];
	_intersect_obj = "nichts";
	if ((count _liste_lineintersect) >1) then {_intersect_obj = _liste_lineintersect select 2};
	_text = _text + format["<br />intersect: %1",_intersect_obj];
	//------
	//_uid_var = [];
	//call compile format["_uid_var = if (isnil ""s_%1"") then [{[]},{s_%1}];",getplayeruid player];
	//{_text = _text + format["<br />uidvar %1: %2",_x select 0,_uid_var select _foreachindex]} foreach s_uid_var_eintraege;
	//------
	if (!isnil "fnc_s_loadout_zu_objektliste") then {
		_objektliste = [player] call fnc_s_loadout_zu_objektliste;
		_text = _text + format["<br />_objektliste: %1",_objektliste];
	};
	//------
	if (!isnil "s_map_mods")then {
	 _text = _text + format["<br />s_map_mods: %1",s_map_mods];
 };


  uisleep 0.3;
};

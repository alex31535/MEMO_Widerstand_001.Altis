// # init-params---------------------------------------------------------------------------------------------------------------------------------------------------------
#define _DEF_mapindikatoren [false,true,false,true]
//->[0:disableFriendly, 1:disableEnemy, 2:disableMines, 3:disablePing]

a_score_aktiv = false;
a_trait_medic = true;
a_trait_engineer = true;
a_trait_explosive = true;
a_trait_uavhacker = true;
a_pers_arsenal = false;
a_arsenal_ende_event = true; // zb speichern der letzten ausstattung im zwischenspeicher
a_lokaler_debug = isserver;

// # funktionen---------------------------------------------------------------------------------------------------------------------------------------------------------
// <ADMIN
fnc_a_admin_spieler_waehlt_nebel = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_admin_spieler_waehlt_nebel.sqf";
fnc_a_admin_spieler_waehlt_uhrzeit = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_admin_spieler_waehlt_uhrzeit.sqf";
fnc_a_admin_spieler_waehlt_wetter = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_admin_spieler_waehlt_wetter.sqf";
fnc_a_admin_spieler_waehlt_ki_level_min = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_admin_spieler_waehlt_ki_level_min.sqf";
fnc_a_admin_spieler_waehlt_ki_level_max = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_admin_spieler_waehlt_ki_level_max.sqf";
fnc_a_tfar_frequenzen_setzen = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_tfar_frequenzen_setzen.sqf";
fnc_a_sys_wasser_zwischen_a_und_b = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_sys_wasser_zwischen_a_und_b.sqf";
fnc_a_sys_gebaeudeauswahl = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_sys_gebaeudeauswahl.sqf";
fnc_a_sys_positionen_innerhalb_haus = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_sys_positionen_innerhalb_haus.sqf";
fnc_a_sys_winkel_pos1_zu_pos2 = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_sys_winkel_pos1_zu_pos2.sqf";
// ADMIN>
// <alex_hq/missions
fnc_a_mission_spieler_waehlt_mission = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_mission_spieler_waehlt_mission.sqf";
// alex_hq/missions>
// <l4d_respawn

// l4d_respawn>
// <SpCFG
fnc_a_spieler_waehlt_ausstattung = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_spieler_waehlt_ausstattung.sqf";
// SpCFG>
// <Garage hq/hafen
fnc_a_sys_garage_spieler_parkt_aus = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_sys_garage_spieler_parkt_aus.sqf";
// Garage hq/hafen>

// MISSIONS-FUNKTIONEN
fnc_a_sys_speedlimit = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_sys_speedlimit.sqf";
fnc_a_mission_spieler_waehlt_parameter = compile preprocessfilelinenumbers "alex_funktionen\fnc_a_mission_spieler_waehlt_parameter.sqf";


// # auf spieler warten-----------------------------------------------------------------------------------------------------------------------------------auf spieler warten
// # warten bis der spieler bereit ist
while {getClientStateNumber < 10} do {sleep 0.3};
waituntil {!(IsNull (findDisplay 46))};
// # auf externe sicht schalten
player switchCamera "EXTERNAL";


// # map-indikatoren--------------------------------------------------------------------------------------------------------------------------------------map-indikatoren
disableMapIndicators _DEF_mapindikatoren;


// # scoretabelle------------------------------------------------------------------------------------------------------------------------------------------------scoretabelle
player addEventHandler ["Handlescore", {a_score_aktiv}];// # TSM: punkte auf spieler (benoetigt ebenfalls einen eventhandler ENTITIEKILLED auf server)

// # faehigkeiten----------------------------------------------------------------------------------------------------------------------------------------------faehigkeiten
player setUnitTrait ["Medic",a_trait_medic];
player setUnitTrait ["engineer",a_trait_engineer];
player setUnitTrait ["explosiveSpecialist",a_trait_explosive];
player setUnitTrait ["UAVHacker",a_trait_uavhacker];

// # arsenal vorladen-----------------------------------------------------------------------------------------------------------------------------------------arsenal vorladen
["Preload"] spawn BIS_fnc_arsenal;

// # pers. arsenal deaktivieren?-------------------------------------------------------------------------------------------------------------------pers. arsenal deaktivieren?
if (!a_pers_arsenal) then {
	[missionNamespace, "arsenalOpened",
		{
			disableSerialization;
			params ["_anzeige"];
			_anzeige displayAddEventHandler ["keydown", "_this select 3"];
			{(_anzeige displayCtrl _x) ctrlShow false} forEach [44151, 44150, 44146, 44147, 44148, 44149, 44346];
	  }] call BIS_fnc_addScriptedEventHandler;
};

// # event bei arsenal ende?----------------------------------------------------------------------------------------------------------------------------event bei arsenal ende?
if (a_arsenal_ende_event) then {
	[missionNamespace, "arsenalClosed",
		{[getunitloadout player] remoteExecCall ["fnc_s_spcfg_loadout_spieler_speichern",2]}
	] call BIS_fnc_addScriptedEventHandler;
};



// # abschluss/ende/a_lokaler_debug---------------------------------------------------------------------------------------------------------abschluss/ende/a_lokaler_debug
if (!a_lokaler_debug) exitwith {};
[] execvm "testumgebung\testscript.sqf";
player addAction ["DEBUGACTION", "testumgebung\debugaction.sqf"];


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
	_text = _text + format["<br />allunits: %1",count allunits];
	_text = _text + format["<br />vehicles: %1",count vehicles];
	_text = _text + format["<br />alldead: %1",count alldead];
	if (!isnull(objectparent player)) then {
		//_text = _text + format["<br />gunnerName: %1",getText(configFile >> "CfgVehicles" >> typeOf (objectparent player) >> "gunnerName")];
		//_text = _text + format["<br />turrets: %1",getarray(configFile >> "CfgVehicles" >> typeOf (objectparent player) >> "turrets")];
		_text = _text + format["<br />transportSoldier: %1",getnumber(configFile >> "CfgVehicles" >> typeOf (objectparent player) >> "transportSoldier")];
	};
	if (isOnRoad player) then {
		_text = _text + format["<br />getRoadInfo: %1",getRoadInfo (roadAt player)];
	};
	_text = _text + format["<br />s_map_mods: %1",s_map_mods];
	//copytoclipboard (str s_map_mods);
	



  uisleep 0.3;
};

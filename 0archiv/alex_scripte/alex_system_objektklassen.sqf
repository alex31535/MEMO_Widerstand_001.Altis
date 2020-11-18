/*
  alex_system_objektklassen.sqf
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by: Client-Init: ["loop"] execVM "alex_inkognito\init_inkognito.sqf";
	Parameters: "loop" or "fnc"
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: unnecessary

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
private _obj = objnull;
private _mod = "";
for "_i" from 1 to 20 do {
	_obj = objnull;
	call compile format["if (! isnil ""eo_mod_%1"") then {_obj = eo_mod_%1};",_i];
	if (!isnull _obj) then {
		_mod = ((((configSourceMod(configFile >> "CfgVehicles" >> (typeof _obj))) splitstring "@") select 0) splitString " ") joinString "_";
		if (_mod != "") then {
			s_map_mods pushback _mod;
		};
		deletevehicle _obj;
	};
};


// --------------------------------------------------------------------------------------------------------------------------- erstellen von mod-anhaengigen unit- & vec-listen
private _config = (configFile >> "CfgVehicles");
private _config_eintrag = [];
private _seiten_nr = -1;
private _loadout = [];
//private _alle_mods = []; -> debug: feststellen, welche mods geladen wurden ...
for "_i" from 0 to ((count _config)-1) do {
	if (isClass((_config select _i))) then {
		_config_eintrag = configName(_config select _i);
		_seiten_nr = getNumber ((_config select _i) >> "side");

		// # trennung : scope , seitennummer , !static
		if (((getNumber ((_config select _i) >> "scope")) == 2) && {_seiten_nr < 4} && {!(_config_eintrag isKindOf "StaticWeapon")}) then {

			// # trennung : mod
			_mod = ((((configSourceMod(_config >> _config_eintrag)) splitstring "@") select 0) splitString " ") joinString "_";

			if (isnil "_mod") then {_mod = "vanilla"};
			if (_mod == "") then {_mod = "vanilla"};
			//["vanilla","expansion","CUP_Vehicles","Zombies_and_Demons"]
			if (_mod in s_map_mods) then {
				// # trennung : CAManBase
				if (_config_eintrag isKindOf "CAManBase") then {
					if (_mod == "Zombies_and_Demons") then {
						if ((_config_eintrag find "boss") == -1) then {
							call compile format["s_zombies_aus_cfg_%1 pushback _config_eintrag;",_seiten_nr];
						} else {
							call compile format["s_zombieboss_aus_cfg_%1 pushback _config_eintrag;",_seiten_nr];
						};
					} else {/* # trennung : CAManBase : seitennummer 3/andere*/
						if (_seiten_nr == 3) then {
							s_units_aus_cfg_3 pushback _config_eintrag;
						} else {
							_loadout = getUnitLoadout (configFile >> "CfgVehicles" >> _config_eintrag);
							if (((count (_loadout select 0)) + (count (_loadout select 1)) + (count (_loadout select 2))) > 0) then {/* unit muss waffen haben ! */
		           	call compile format["s_units_aus_cfg_%1 pushback _config_eintrag;",_seiten_nr];
		        	};
						};// # trennung : CAManBase : seitennummer 3/andere
					};//(_mod == "Zombies_and_Demons")
				};// # trennung : CAManBase
				if ((_config_eintrag isKindOf "LandVehicle") && {(getNumber ((_config select _i) >> "artilleryScanner")) == 0}) then {
					if (_config_eintrag isKindOf "Tank") then {
						call compile format["s_sys_vec_kette_%1 pushback _config_eintrag;",_seiten_nr];
					};
					if (_config_eintrag isKindOf "Car") then {
						if (((tolower _config_eintrag) find "btr80") == -1) then {
							call compile format["s_sys_vec_rad_%1 pushback _config_eintrag;",_seiten_nr];
						};
					};
				};

				if (_config_eintrag isKindOf "Air") then {
					if (_config_eintrag isKindOf "Helicopter") then {
						call compile format["s_sys_vec_heli_%1 pushback _config_eintrag;",_seiten_nr];
					};
					if (_config_eintrag isKindOf "Plane") then {
						call compile format["s_sys_vec_flug_%1 pushback _config_eintrag;",_seiten_nr];
					};
				};

				if ((_mod != "CUP_Vehicles") && {_config_eintrag isKindOf "Ship"}) then {
					call compile format["s_sys_wasserfahrzeuge_%1 pushback _config_eintrag;",_seiten_nr];
				};
			};// # trennung : mod
		};// # trennung : scope , seitennummer , !static

	};
};

//copytoclipboard str([s_units_aus_cfg_0,s_units_aus_cfg_1,s_units_aus_cfg_2,s_units_aus_cfg_3]);

// --------------------------------------------------------------------------------------------------------------------------- definieren und veraendfer von insel-markierungen
private _markertype = "";
private _anz_inselmarker = 0;
for "_i" from 1 to 100 do {
	call compile format["_markertype = getMarkerType ""em_insel_%1"";",_i];
	if (_markertype == "") exitwith {_anz_inselmarker = _i};
	call compile format[" ""em_insel_%1"" setmarkeralpha 0;",_i];
};
private _groesse = 0;
private _auf_insel = false;
{
  _groesse = (((size _x) select 0)+((size _x) select 1))/2;
	_auf_insel = false;
	for "_i" from 1 to _anz_inselmarker do {
		call compile format[" if ((locationposition _x) inarea ""em_insel_%1"") exitwith {_auf_insel = true};",_i];
	};
  s_sys_locations pushback [
    /*0*/text _x,
    /*1 loc- innen */[locationposition _x, _groesse, _groesse, 0, false],/* loc area */
    /*2 loc "aktivierung" */[locationposition _x, _groesse + s_sys_dist_loc_aktivierung, _groesse + s_sys_dist_loc_aktivierung, 0, false],
    /*3 loc "deaktivierung" */[locationposition _x, _groesse + s_sys_dist_loc_deaktivierung, _groesse + s_sys_dist_loc_deaktivierung, 0, false],
		/*4 loc auf einer insel */_auf_insel
  ];
} forEach (nearestLocations [[worldsize/2,worldsize/2,0], ["NameVillage","NameCity","NameCityCapital"], worldsize]);

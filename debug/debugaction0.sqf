private _filter = [
"EdSubcat_Launchers",
"EdSubcat_AssaultRifles",
"EdSubcat_Pistols",
"EdSubcat_MachineGuns",
"EdSubcat_SubMachineGuns",
"EdSubcat_ShotGuns",
"EdSubcat_SniperRifles",
"EdSubcat_Explosives", /*xxx*/
"EdSubcat_Cars",
"EdSubcat_Artillery",
"EdSubcat_Boats",
"EdSubcat_Drones",
"EdSubcat_AAs",
"EdSubcat_Planes",
"EdSubcat_Helicopters",
"EdSubcat_Tanks",
"EdSubcat_APCs",
"EdSubcat_Submersibles",/*xxx*/
"EdSubcat_TopSlot_Collimators",
"EdSubcat_FrontSlot",
"EdSubcat_TopSlot_Optics",
"EdSubcat_SideSlot",
"EdSubcat_BottomSlot",
"EdSubcat_DismantledWeapons",
"EdSubcat_Hats"
];
private _filter_west = [
"EdSubcat_Helmets",/*xxx*/
"EdSubcat_Uniforms"/*xxx*/
];
private _strg_array = [];
private _var_name = "";
{
	_strg_array = _x splitstring "_";
	_var_name = _strg_array select ((count _strg_array) -1);
	call compile format["s_%1 = [];",_var_name];
} foreach _filter;



private _config = (configFile >> "CfgVehicles");
private _config_eintrag = [];
private _seiten_nr = -1;
private _seiten_strg = "";
private _mod = "";

for "_i" from 0 to ((count _config)-1) do {
  systemchat format["analysiere config...%1",((count _config)-1) - _i];
	// # ist eine obj-klasse?
	if (isClass((_config select _i))) then {
		// # ist ein nutzbares objekt?
		if ((getNumber ((_config select _i) >> "scope")) == 2) then {
			_config_eintrag = configName(_config select _i);// ...eintrag
			_seiten_nr = getNumber ((_config select _i) >> "side"); // ... seiten-nummer
			// # gueltige seitennummer?
			if (_seiten_nr in [0,1,2,3]) then {
				_seiten_strg = ["EAST","WEST","RESISTANCE","CIVILIAN"] select _seiten_nr;
				_mod = ((((configSourceMod(_config >> _config_eintrag)) splitstring "@") select 0) splitString " ") joinString "_"; // ...mod ermitteln
				if (isnil "_mod") then {_mod = "vanilla"}; // ...mod nil-korrektur
				if (_mod == "") then {_mod = "vanilla"}; // ...mod null-korrektur
				// # gueltige mod?
				if (_mod in s_map_mods) then {
					_subcat = gettext (_config >> _config_eintrag >> "editorSubcategory");
					if ((_filter find _subcat) != -1) then {
						_strg_array = _subcat splitstring "_";
						_var_name = _strg_array select ((count _strg_array) -1);
						call compile format["s_%1 pushback [gettext((_config select _i) >> ""displayname""),_config_eintrag,_mod,_seiten_strg];",_var_name];
					};
          if (((_filter_west find _subcat) != -1) && {_seiten_nr == 1}) then {
            _strg_array = _subcat splitstring "_";
						_var_name = _strg_array select ((count _strg_array) -1);
						call compile format["s_%1 pushback [gettext((_config select _i) >> ""displayname""),_config_eintrag,_mod,_seiten_strg];",_var_name];
					};
          if (_config_eintrag isKindOf "MineBase") then {
            s_Explosives pushback [gettext((_config select _i) >> "displayname"),_config_eintrag,_mod,_seiten_strg];
          };
				}; //(_mod in s_map_mods)
			};//(_seiten_nr in [0,1,2,3])
		};//((getNumber ((_config select _i) >> "scope")) == 2)
	};//(isClass((_config select _i)))
};

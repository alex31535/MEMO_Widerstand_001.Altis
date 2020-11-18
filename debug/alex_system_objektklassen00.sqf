private _config = (configFile >> "CfgVehicles");


for "_i" from 0 to ((count _config)-1) do {
	// # ist eine obj-klasse?
	if (isClass((_config select _i))) then {
		// # ist ein nutzbares objekt?
		if ((getNumber ((_config select _i) >> "scope")) == 2) then {
			_config_eintrag = configName(_config select _i);// ...gesamter config-eintrag
			_seiten_nr = getNumber ((_config select _i) >> "side"); // ... seiten-nummer
			// # gueltige seitennummer?
			if (_seiten_nr < 4) then {
				_seiten_strg = ["EAST","WEST","RESISTANCE";"CIVILIAN"] select _seiten_nr;
				_mod = ((((configSourceMod(_config >> _config_eintrag)) splitstring "@") select 0) splitString " ") joinString "_"; // ...mod ermitteln
				if (isnil "_mod") then {_mod = "vanilla"}; // ...mod nil-korrektur
				if (_mod == "") then {_mod = "vanilla"}; // ...mod null-korrektur
				// # gueltige mod?
				if (_mod in s_map_mods) then {
					// fahrzeug: landvehicle?
					if (_config_eintrag isKindOf "LandVehicle") then {
						// fahrzeug: landvehicle: ari?
						if ((getNumber ((_config select _i) >> "artilleryScanner")) == 0 then {
							s_ari pushback [gettext((_config select _i) >> "displayname"),_config_eintrag,_mod,_seiten_strg];
						// fahrzeug: landvehicle: keine ari...
						} else {
							// fahrzeug: landvehicle: keine ari: panzer?
							if (_config_eintrag isKindOf "Tank") then {
								s_tank pushback [gettext((_config select _i) >> "displayname"),_config_eintrag,_mod,_seiten_strg];
							};
						};
						// fahrzeug: landvehicle: auto ?
						if (_config_eintrag isKindOf "Car") then {
							s_car pushback [gettext((_config select _i) >> "displayname"),_config_eintrag,_mod,_seiten_strg];
						};
					};//(_config_eintrag isKindOf "LandVehicle")
					// fahrzeug: luftfahrzeug?
					if (_config_eintrag isKindOf "Air") then {
						// fahrzeug: luftfahrzeug: heli?
						if (_config_eintrag isKindOf "Helicopter") then {
							s_heli pushback [gettext((_config select _i) >> "displayname"),_config_eintrag,_mod,_seiten_strg];
						};
						// fahrzeug: luftfahrzeug: starrfluegler?
						if (_config_eintrag isKindOf "Plane") then {
							s_plane pushback [gettext((_config select _i) >> "displayname"),_config_eintrag,_mod,_seiten_strg];
						};
					};//(_config_eintrag isKindOf "Air")
					// fahrzeug: wasserfahrzeug?
					if (_config_eintrag isKindOf "Ship") then {
						s_ship pushback [gettext((_config select _i) >> "displayname"),_config_eintrag,_mod,_seiten_strg];
					};
					// waffe?
					if (_config_eintrag isKindOf "Weapon_Base_F") then {
						s_waffe pushback [gettext((_config select _i) >> "displayname"),_config_eintrag,_mod,_seiten_strg];
					};
					// waffen-accessorie?
					if ((_config_eintrag isKindOf "Item_Base_F") && {(gettext((_config select _i) >> "vehicleclass"))  == "WeaponAccessories"}) then {
						s_waffenaufsatz pushback [gettext((_config select _i) >> "displayname"),_config_eintrag,_mod,_seiten_strg];
					};
					// sprengladung?
					if ((gettext((_config select _i) >> "vehicleclass"))  == "Mines") then {
						s_spreng pushback [gettext((_config select _i) >> "displayname"),_config_eintrag,_mod,_seiten_strg];
					};
				}; //(_mod in s_map_mods)
			};//(_seiten_nr < 4)
		};//((getNumber ((_config select _i) >> "scope")) == 2)
	};//(isClass((_config select _i)))
};

s_ari
s_tank
s_car
s_heli
s_plane
s_ship
s_waffe
s_waffenaufsatz
s_spreng
//"Weapon_Base_F"
//"Item_Base_F" - "vehicleclass" = "WeaponAccessories"
//"vehicleclass" = "Mines"
configfile >> "CfgVehicles" >> "Weapon_launch_NLAW_F" >> "editorSubcategory"
= "EdSubcat_Launchers" / werfer
= "EdSubcat_AssaultRiffles" / sturmgewehre
= "EdSubcat_Pistols" / pistolen
= "EdSubcat_MachineGuns" / maschinengewehre
= "EdSubcat_SubMachineGuns" / MPs
= "EdSubcat_ShotGuns" / Schotflinten
= "EdSubcat_SniperRiffles" / Scharfschuetzengewehre
= "EdSubcat_Explosives" / sprengladungen
= "EdSubcat_Cars" / autos
= "EdSubcat_Artillery" / ari
= "EdSubcat_Boats" / Boote
= "EdSubcat_Drones" / Drohnen
= "EdSubcat_AAs" / luftabwehr
= "EdSubcat_Planes" / flugzeuge
= "EdSubcat_Helicopters" / helis
= "EdSubcat_Tanks" / Panzer
= "EdSubcat_APCs" / truppentransporter
= "EdSubcat_Submersibles" / UBoote
= "EdSubcat_TopSlot_Collimators" /
= "EdSubcat_FrontSlot" /
= "EdSubcat_TopSlot_Optics" /
= "EdSubcat_SideSlot" /
= "EdSubcat_BottomSlot" /
= "EdSubcat_DismantledWeapons" /
= "EdSubcat_Hats" /
= "EdSubcat_Helmets" /
= "EdSubcat_Uniforms" /

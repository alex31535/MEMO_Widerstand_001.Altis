fnc_s_loadout_zu_objektliste = compile preprocessfilelinenumbers "testumgebung\fnc_s_loadout_zu_objektliste.sqf";
fnc_s_objektklassen_listenvergleich = compile preprocessfilelinenumbers "testumgebung\fnc_s_objektklassen_listenvergleich.sqf";



// # alle units aus config
s_units_aus_cfg_0 = [/*0:EAST*/];
s_units_aus_cfg_1 = [/*1:WEST*/];
s_units_aus_cfg_2 = [/*2:RESISTANCE*/];
s_units_aus_cfg_3 = [/*3:CIVILIAN*/];
s_units_aus_cfg_3_west = [/*3:CIVILIAN*/];
s_units_aus_cfg_3_east = [/*3:CIVILIAN*/];
s_units_aus_cfg_4 = [/*4:NEUTRAL*/];
s_arsenal_whitelist_0 = [/*0:EAST*/];
s_arsenal_whitelist_1 = [/*1:WEST*/];
s_arsenal_whitelist_2 = [/*2:RESISTANCE*/];
s_arsenal_whitelist_3 = [/*3:CIVILIAN*/];
s_arsenal_whitelist_4 = [/*4:NEUTRAL*/];
private _config = (configFile >> "CfgVehicles");
private _config_eintrag = [];
private _seiten_nr = -1;
private _whitelist = [];
private _nicht_enthaltene_obj = [];
private _loadout = [];
private _modliste = [];
private _mod = "";
for "_i" from 0 to ((count _config)-1) do {
	if (isClass((_config select _i) ) ) then {
		_config_eintrag = configName(_config select _i);
		//if (((configSourceMod(_config >> _config_eintrag)) in ["A3"]) && {_config_eintrag isKindOf "CAManBase"} && {(getNumber ((_config select _i) >> "scope")) == 2}) then {
    _mod = configSourceMod(_config >> _config_eintrag);
    if ((_modliste find _mod) == -1) then {_modliste pushback _mod};
    //if ((_config_eintrag isKindOf "CAManBase") && {(getNumber ((_config select _i) >> "scope")) == 2}) then {
    if ((_mod == "") && {_config_eintrag isKindOf "CAManBase"} && {(getNumber ((_config select _i) >> "scope")) == 2}) then {
			_seiten_nr = getNumber ((_config select _i) >> "side");
      if (_seiten_nr < 5) then {
        /* unit in entsprechender klassen-var ablegen */
        _loadout = getUnitLoadout (configFile >> "CfgVehicles" >> _config_eintrag);
        if ((count _loadout) != 0) then {
          if (_seiten_nr != 3) then {
            call compile format["s_units_aus_cfg_%1 pushback _config_eintrag;",_seiten_nr];
            call compile format["_whitelist = s_arsenal_whitelist_%1;",_seiten_nr];
            _objektliste = [_loadout] call fnc_s_loadout_zu_objektliste;
            _nicht_enthaltene_obj = [_objektliste,_whitelist] call fnc_s_objektklassen_listenvergleich;
            _whitelist append _nicht_enthaltene_obj;
            call compile format["s_arsenal_whitelist_%1 = _whitelist;",_seiten_nr];
          } else {
            if ((count ((_loadout select 0) + (_loadout select 1) + (_loadout select 2))) == 0) then {
              call compile format["s_units_aus_cfg_%1 pushback _config_eintrag;",_seiten_nr];
            };
          };
        };
			};
		};
	};
};



private _unit_klasse = "";
private _alle_fraktionen = [];
private _alle_einheiten_der_seite = [];
private _fraktion = "";
private _fraktionseintrag = [];
private _alle_obj_der_unit = [];
private _alle_obj_der_fraktion = [];
private _seitennummer = -1;
{
  _seitennummer = _x;
  call compile format["_alle_einheiten_der_seite = s_units_aus_cfg_%1;",_seitennummer];
  {
    _unit_klasse = _x;
    _fraktion = gettext(configFile >> "CfgVehicles" >> _unit_klasse >> "faction");
    _fraktionseintrag = [_fraktion,[]];
    {if ((_x select 0) == _fraktion) exitwith {_fraktionseintrag = _x; _alle_fraktionen deleteat _foreachindex}} foreach _alle_fraktionen;
    _alle_obj_der_fraktion = _fraktionseintrag select 1;
    _alle_obj_der_unit = [getUnitLoadout (configFile >> "CfgVehicles" >> _unit_klasse)] call fnc_s_loadout_zu_objektliste;
    {
      _obj_klasse = _x;
      if ((_alle_obj_der_fraktion findIf {_obj_klasse == _x}) != -1) then {_obj_klasse = ""};
      if (_obj_klasse != "") then {_alle_obj_der_fraktion pushback _obj_klasse};
    } foreach _alle_obj_der_unit;
    //call compile format["_alle_obj_der_fraktion = _alle_obj_der_fraktion + _pflicht_%1;",_seitennummer];
    _fraktionseintrag set [1,_alle_obj_der_fraktion];
    _alle_fraktionen pushback _fraktionseintrag;
  } foreach _alle_einheiten_der_seite;
} foreach [1];

copytoclipboard str _alle_fraktionen;



{call compile format["s_arsenal_%1 = %2",_x select 0, _x select 1]} foreach _alle_fraktionen;

systemchat format["testscript: mods: %1",_modliste];

if (true) exitwith {};
[
["BLU_GEN_F",
  [
    "SMG_05_F","hgun_P07_F","U_B_GEN_Soldier_F","V_TacVest_gen_F","H_MilCap_gen_F","ItemMap","ItemRadio","ItemCompass","ItemWatch",
    "U_B_GEN_Commander_F","H_Beret_gen_F","Binocular","SMG_03C_black"]],["BLU_T_F",["arifle_MX_khk_ACO_Pointer_F","acc_pointer_IR",
    "optic_Aco","hgun_P07_khk_F","U_B_T_Soldier_F","V_PlateCarrier1_tna_F","B_Carryall_oli_BTAmmo_F","H_HelmetB_tna_F","ItemMap",
    "ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F","U_B_T_Soldier_AR_F","V_Chestrig_rgr","B_Kitbag_rgr_AAR","H_HelmetB_Light_tna_F",
    "Rangefinder","arifle_MXC_khk_Holo_Pointer_F","optic_Holosight_khk_F","B_HMG_01_support_grn_F","B_Mortar_01_support_grn_F",
    "B_Carryall_oli_BTAAA_F","B_Carryall_oli_BTAAT_F","arifle_MX_SW_khk_Pointer_F","bipod_01_F_khk","V_PlateCarrier2_tna_F",
    "arifle_MX_khk_Pointer_F","V_PlateCarrierSpec_tna_F","B_AssaultPack_tna_BTMedic_F","arifle_MXC_khk_F","U_B_T_Soldier_SL_F",
    "V_BandollierB_rgr","H_HelmetCrew_B","B_Kitbag_rgr_BTEng_F","V_PlateCarrierGL_tna_F","B_Kitbag_rgr_BTExp_F","H_HelmetB_Enh_tna_F",
    "arifle_MX_GL_khk_ACO_F","B_GMG_01_Weapon_grn_F","B_HMG_01_Weapon_grn_F","B_Mortar_01_Weapon_grn_F","U_B_HeliPilotCoveralls",
    "V_TacVest_blk","H_CrewHelmetHeli_B","NVGoggles","SMG_01_Holo_F","optic_Holosight_smg","H_PilotHelmetHeli_B","arifle_MXM_khk_MOS_Pointer_Bipod_F",
    "optic_SOS_khk_F","launch_B_Titan_tna_F","B_Kitbag_rgr_BTAA_F","launch_B_Titan_short_tna_F","B_Kitbag_rgr_BTAT_F","arifle_MXC_khk_ACO_F",
    "hgun_Pistol_heavy_01_F","H_MilCap_tna_F","ItemGPS","B_Parachute","U_B_PilotCoveralls","H_PilotHelmetFighter_B",
    "arifle_MX_khk_Holo_Pointer_F","B_AssaultPack_tna_BTRepair_F","launch_NLAW_F","B_AssaultPack_rgr_BTLAT_F","arifle_MX_khk_Hamr_Pointer_F",
    "optic_Hamr_khk_F","Binocular","arifle_MX_GL_khk_Hamr_Pointer_F","B_UAV_01_backpack_F","B_UavTerminal","arifle_SDAR_F","hgun_P07_snds_F",
    "muzzle_snds_L","U_B_Wetsuit","V_RebreatherB","B_Assault_Diver","G_B_Diving","B_AssaultPack_blk_DiverExp","arifle_MX_khk_ACO_Pointer_Snds_F",
    "muzzle_snds_H_khk_F","B_Kitbag_rgr_BTReconExp_F","H_Booniehat_tna_F","arifle_MX_GL_khk_Holo_Pointer_Snds_F","H_Watchcap_camo",
    "Laserdesignator","arifle_MXM_khk_MOS_Pointer_Bipod_Snds_F","arifle_MXC_khk_ACO_Pointer_Snds_F","B_AssaultPack_rgr_BTReconMedic",
    "B_AssaultPack_rgr_ReconLAT","arifle_MX_khk_Hamr_Pointer_Snds_F","srifle_LRR_tna_LRPS_F","optic_LRPS_tna_F","U_B_T_Sniper_F",
    "U_B_T_FullGhillie_tna_F","B_UAV_06_backpack_F","B_UAV_06_medical_backpack_F","B_Carryall_oli_Mine","launch_MRAWS_green_F",
    "B_AssaultPack_rgr_BTLAT2_F"
  ]
],
["BLU_CTRG_F",
  [
    "arifle_SPAR_01_blk_ERCO_Pointer_F","acc_pointer_IR","optic_ERCO_blk_F","hgun_P07_khk_Snds_F","muzzle_snds_L","U_B_CTRG_Soldier_F",
    "V_TacVest_oli","H_HelmetB_TI_tna_F","G_Balaclava_TI_G_tna_F","Rangefinder","ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",
    "NVGogglesB_grn_F","V_PlateCarrierIAGL_oli","B_Kitbag_rgr_CTRGExp_F","Binocular","B_AssaultPack_rgr_CTRGMedic_F",
    "arifle_SPAR_03_blk_MOS_Pointer_Bipod_F","optic_SOS","bipod_01_F_blk","launch_NLAW_F","B_AssaultPack_rgr_CTRGLAT_F",
    "arifle_SPAR_02_blk_ERCO_Pointer_F","arifle_SPAR_01_GL_blk_ERCO_Pointer_F","Laserdesignator_01_khk_F","hgun_P07_khk_F","U_B_CTRG_Soldier_3_F",
    "V_PlateCarrier2_rgr_noflag_F","G_Tactical_Black","launch_MRAWS_green_F","B_AssaultPack_rgr_CTRGLAT2_F"]],["BLU_G_F",["arifle_TRG21_F",
    "U_BG_Guerilla1_1","V_Chestrig_oli","H_Shemag_olive","ItemMap","ItemRadio","ItemCompass","ItemWatch","arifle_TRG20_F","V_BandollierB_blk",
    "H_Cap_oli","arifle_TRG20_ACO_F","optic_ACO_grn","hgun_ACPC2_F","U_BG_leader","V_Chestrig_blk","H_Watchcap_blk","Binocular",
    "arifle_Mk20_GL_ACO_F","V_TacVest_blk","H_Booniehat_khk","LMG_Mk200_BI_F","bipod_03_F_blk","U_BG_Guerilla2_1","H_Bandanna_khk",
    "arifle_Mk20_F","U_BG_Guerilla2_3","G_FieldPack_Medic","U_BG_Guerilla2_2","G_TacticalPack_Eng","H_Watchcap_camo","arifle_Mk20C_ACO_F",
    "G_Carryall_Exp","arifle_TRG21_GL_F","arifle_Mk20_MRCO_F","optic_MRCO","U_BG_Guerilla3_1","V_BandollierB_khk","launch_RPG32_F",
    "U_BG_Guerrilla_6_1","G_FieldPack_LAT","G_Carryall_Ammo","arifle_TRG21_MRCO_F","ItemGPS","arifle_TRG21_GL_MRCO_F","U_I_G_Story_Protagonist_F",
    "H_Bandanna_khk_hs","U_I_G_resistanceLeader_F","V_I_G_resistanceLeader_F","srifle_DMR_06_camo_khs_F","optic_KHS_old","V_BandollierB_oli",
    "arifle_AKM_F","hgun_Pistol_heavy_02_F","U_B_G_Captain_Ivan_F","V_Chestrig_rgr","H_Booniehat_oli","G_Spectacles","hgun_PDW2000_F",
    "U_BG_Guerilla1_2_F","V_Pocketed_coyote_F","B_Messenger_Olive_F","H_Hat_Safari_sand_F","launch_MRAWS_olive_rail_F","G_FieldPack_LAT2"
  ]
],
["BLU_F",
  [
    "arifle_MX_ACO_pointer_F","acc_pointer_IR","optic_Aco","hgun_P07_F","U_B_CombatUniform_mcam","V_PlateCarrier1_rgr","H_HelmetB","ItemMap",
    "ItemRadio","ItemCompass","ItemWatch","NVGoggles","U_Rangemaster","V_Rangemaster_belt","H_Cap_headphones","arifle_MX_ACO_F",
    "U_B_CombatUniform_mcam_vest","V_BandollierB_rgr","H_MilCap_mcamo","arifle_MX_GL_ACO_F","V_PlateCarrierGL_rgr","H_HelmetSpecB_blk","
    arifle_MX_SW_pointer_F","bipod_01_F_snd","U_B_CombatUniform_mcam_tshirt","V_PlateCarrier2_rgr","H_HelmetB_grass","arifle_MX_Hamr_pointer_F",
    "optic_Hamr","H_HelmetB_desert","Binocular","ItemGPS","arifle_MX_GL_Hamr_pointer_F","H_HelmetSpecB","arifle_MXM_Hamr_LP_BI_F","launch_NLAW_F",
    "B_AssaultPack_rgr_LAT","H_HelmetB_sand","arifle_MX_pointer_F","V_PlateCarrierSpec_rgr","B_AssaultPack_rgr_Medic","H_HelmetB_light_desert",
    "arifle_MX_Holo_pointer_F","optic_Holosight","B_AssaultPack_rgr_Repair","H_HelmetB_light_sand","arifle_MXC_Holo_pointer_F","B_Kitbag_rgr_Exp",
    "SMG_01_Holo_F","optic_Holosight_smg","U_B_HeliPilotCoveralls","V_TacVest_blk","H_PilotHelmetHeli_B","B_AssaultPack_mcamo_Ammo",
    "launch_B_Titan_short_F","B_AssaultPack_mcamo_AT","launch_B_Titan_F","B_AssaultPack_mcamo_AA","V_Chestrig_rgr","B_Kitbag_mcamo_Eng",
    "arifle_MXC_F","H_HelmetCrew_B","arifle_MXC_ACO_F","hgun_Pistol_heavy_01_MRD_F","optic_MRD","U_Competitor","U_B_PilotCoveralls","B_Parachute",
    "H_PilotHelmetFighter_B","arifle_MXC_Holo_F","H_CrewHelmetHeli_B","B_UAV_01_backpack_F","B_UavTerminal","arifle_SDAR_F","hgun_P07_snds_F",
    "muzzle_snds_L","U_B_Wetsuit","V_RebreatherB","B_Assault_Diver","G_B_Diving","B_AssaultPack_blk_DiverExp","arifle_MX_ACO_pointer_snds_F",
    "muzzle_snds_H","H_Watchcap_camo","B_AssaultPack_rgr_ReconLAT","H_HelmetB_plain_mcamo","B_AssaultPack_rgr_ReconExp","H_Booniehat_mcamo",
    "arifle_MXC_ACO_pointer_snds_F","B_AssaultPack_rgr_ReconMedic","H_HelmetB_light","arifle_MX_RCO_pointer_snds_F","G_Shades_Black","Rangefinder",
    "arifle_MXM_DMS_LP_BI_snds_F","optic_DMS","arifle_MX_GL_Holo_pointer_snds_F","Laserdesignator","U_B_GhillieSuit","srifle_LRR_camo_LRPS_F",
    "optic_LRPS","U_B_CTRG_2","V_PlateCarrierL_CTRG","V_PlateCarrier_Kerry","H_Helmet_Kerry","arifle_MX_GL_Black_Hamr_pointer_F","U_B_CTRG_1",
    "V_PlateCarrierH_CTRG","H_HelmetB_light_snakeskin","arifle_MX_Black_Hamr_pointer_F","H_Cap_khaki_specops_UK","srifle_EBR_Hamr_pointer_F",
    "U_B_CTRG_3","H_Watchcap_blk","arifle_MX_SW_Black_Hamr_pointer_F","B_Kitbag_rgr_AAR","B_Carryall_mcamo_AAT","B_Carryall_mcamo_AAA",
    "B_HMG_01_weapon_F","B_GMG_01_weapon_F","B_Mortar_01_weapon_F","B_HMG_01_support_F","B_Mortar_01_support_F","U_B_Protagonist_VR","G_Goggles_VR",
    "U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_FullGhillie_ard","srifle_DMR_03_tan_AMS_LP_F","optic_AMS_snd","srifle_DMR_02_sniper_AMS_LP_S_F",
    "muzzle_snds_338_sand","srifle_DMR_02_camo_AMS_LP_F","optic_AMS","bipod_01_F_blk","MMG_02_sand_RCO_LP_F","V_PlateCarrierSpec_mtp","H_Beret_Colonel",
    "arifle_SPAR_01_blk_ERCO_Pointer_F","optic_ERCO_blk_F","G_Aviator","V_DeckCrew_yellow_F","B_Patrol_Soldier_Leader_weapon_F","muzzle_snds_H_snd_F",
    "B_Patrol_Soldier_Pistol_F","muzzle_snds_acp","B_Patrol_Respawn_bag_F","H_HelmetSpecB_paint1","B_Patrol_Soldier_Operator_weapon_F",
    "B_Patrol_Soldier_Marksman_weapon_F","muzzle_snds_B","G_Bandanna_khk","B_Patrol_Soldier_Medic_weapon_F","B_Patrol_Medic_bag_F","H_HelmetSpecB_sand",
    "B_Patrol_Soldier_Autorifleman_weapon_F","H_HelmetB_snakeskin","B_Patrol_Soldier_MachineGunner_weapon_F","G_Bandanna_oli",
    "B_Patrol_Soldier_HeavyGunner_weapon_F","H_HelmetB_camo","B_Patrol_Soldier_Carrier_weapon_F","optic_Arco","B_Patrol_Supply_bag_F",
    "B_Patrol_Soldier_Specialist_weapon_F","B_Patrol_Launcher_bag_F","H_HelmetB_light_grass","V_PlateCarrierGL_mtp","H_HelmetSpecB_paint2",
    "B_UAV_06_backpack_F","B_UAV_06_medical_backpack_F","B_Carryall_oli_Mine","launch_MRAWS_sand_F","B_AssaultPack_rgr_LAT2","B_UGV_02_Science_backpack_F",
    "B_UGV_02_Demining_backpack_F"]],["BLU_W_F",["arifle_MX_Black_ACO_Pointer_F","acc_pointer_IR","optic_Aco","hgun_P07_khk_F",
    "U_B_CombatUniform_mcam_wdl_f","V_PlateCarrier1_wdl","B_Carryall_wdl_BWAmmo_F","H_HelmetB_plain_wdl","ItemMap","ItemRadio","ItemCompass",
    "ItemWatch","NVGoggles_INDEP","U_B_CombatUniform_tshirt_mcam_wdL_f","V_Chestrig_rgr","B_Kitbag_rgr_BWAAR","H_HelmetB_light_wdl","Rangefinder",
    "arifle_MXC_Black_Holo_Pointer_F","optic_Holosight_blk_F","B_HMG_01_support_grn_F","B_Mortar_01_support_grn_F","B_Carryall_wdl_BWAAA_F",
    "B_Carryall_wdl_BWAAT_F","arifle_MX_SW_Black_Pointer_F","bipod_01_F_blk","V_PlateCarrier2_wdl","arifle_MX_Black_Pointer_F","V_PlateCarrierSpec_wdl",
    "B_AssaultPack_wdl_BWMedic_F","arifle_MXC_Black_F","U_B_CombatUniform_vest_mcam_wdl_f","V_BandollierB_rgr","H_HelmetCrew_B",
    "B_Kitbag_rgr_BTEng_F","V_PlateCarrierGL_wdl","B_Kitbag_rgr_BTExp_F","H_HelmetSpecB_wdl","B_Carryall_wdl_Mine","arifle_MX_GL_Black_ACO_F",
    "B_GMG_01_Weapon_grn_F","B_HMG_01_Weapon_grn_F","B_Mortar_01_Weapon_grn_F","U_B_HeliPilotCoveralls","V_TacVest_blk","H_CrewHelmetHeli_B",
    "NVGoggles","SMG_01_Holo_F","optic_Holosight_smg","H_PilotHelmetHeli_B","arifle_MXM_Black_MOS_Pointer_Bipod_F","optic_SOS","launch_B_Titan_tna_F",
    "B_Kitbag_rgr_BTAA_F","launch_B_Titan_short_tna_F","B_Kitbag_rgr_BTAT_F","arifle_MXC_Black_ACO_F","hgun_Pistol_heavy_01_F","H_MilCap_wdl",
    "ItemGPS","arifle_MX_Black_Holo_Pointer_F","B_AssaultPack_wdl_BWRepair_F","launch_NLAW_F","B_AssaultPack_wdl_BWLAT_F","launch_MRAWS_green_F",
    "B_AssaultPack_wdl_BWLAT2_F","arifle_MX_Black_Hamr_pointer_F","optic_Hamr","Binocular","arifle_MX_GL_Black_Hamr_pointer_F",
    "arifle_MXC_Black_Holo_FL_F","acc_flashlight","U_B_CBRN_Suit_01_Wdl_F","B_CombinationUnitRespirator_01_F","H_HelmetB","G_AirPurifyingRespirator_01_F",
    "B_RadioBag_01_wdl_F","B_UAV_01_backpack_F","B_UavTerminal","B_UGV_02_Science_backpack_F","B_UGV_02_Demining_backpack_F"
  ]
],
["gm_fc_ge",
  [
    "gm_p1_blk","gm_ge_army_uniform_pilot_oli","gm_ge_army_vest_pilot_oli","gm_ge_headgear_sph4_oli","ItemMap","ItemRadio","gm_ge_army_conat2",
    "ItemWatch","gm_ge_army_uniform_pilot_rolled_sar","gm_mp2a1_blk","gm_ge_army_uniform_crew_80_oli","gm_ge_army_vest_80_crew",
    "gm_ge_headgear_crewhat_80_blk","gm_ferod16_oli","gm_g3a4_oli","gm_ge_army_uniform_soldier_80_oli","gm_ge_army_vest_80_rifleman",
    "gm_backpack_t10_parachute","gm_ge_headgear_m62_net","gm_watch_kosei_80","gm_ge_army_vest_80_officer","gm_ge_army_vest_80_mp_wht",
    "gm_ge_headgear_beret_red_militarypolice","gm_g3a3_oli_feroz24","gm_feroz24_blk","gm_ge_army_uniform_soldier_80_ols","gm_g3a3_oli",
    "gm_ge_army_backpack_80_grenadier_oli","gm_mg3_blk","gm_ge_army_vest_80_machinegunner","gm_ge_army_backpack_80_mg3_oli",
    "gm_pzf44_2_oli_feroz2x17","gm_feroz2x17_pzf44_2_blk","gm_ge_army_backpack_80_pzf44_oli","gm_pzf84_oli_feroz2x17","gm_feroz2x17_pzf84_blk",
    "gm_ge_army_backpack_80_pzf84_oli","gm_fim43_oli","gm_milan_launcher_weaponBag","gm_ge_army_vest_80_medic","gm_ge_army_vest_80_demolition",
    "gm_ge_army_backpack_80_demolition_oli","gm_ge_army_vest_80_leader","gm_ge_army_backpack_80_engineer_oli","gm_p2a1_blk","gm_g3a4_blk",
    "gm_ge_army_uniform_soldier_bdu_80_wdl","gm_dk_army_backpack_73_oli","gm_ge_headgear_winterhat_80_oli","gm_mp5a3_blk",
    "gm_ge_headgear_hat_beanie_blk","gm_g3a3_blk_feroz24","gm_mp5a2_blk","gm_dk_army_backpack_73_pzf84_oli","gm_ge_headgear_hat_boonie_wdl",
    "gm_ge_headgear_hat_boonie_oli","gm_dk_army_backpack_73_demolition_oli","gm_mp5sd3_blk_feroz24","gm_ge_army_vest_80_leader_smg",
    "gm_ge_army_uniform_soldier_parka_80_win","gm_ge_army_uniform_soldier_parka_80_oli","gm_ge_army_uniform_soldier_parka_80_ols",
    "gm_ge_headgear_m62_cover_win"]],["gm_fc_ge_bgs",["gm_p1_blk","gm_ge_pol_uniform_pilot_grn","gm_ge_headgear_sph4_oli","ItemMap","ItemRadio",
    "gm_ge_army_conat2","ItemWatch","gm_mg3_blk","gm_ge_bgs_uniform_soldier_80_smp","gm_ge_bgs_vest_80_rifleman","gm_ge_bgs_headgear_m35_53_net_blk",
    "gm_mp5a2_blk","gm_ge_army_backpack_80_mg3_oli","gm_watch_kosei_80","gm_p2a1_blk","gm_ferod16_oli"]],["gm_fc_dk",["gm_gvm75carb_oli",
    "gm_dk_army_uniform_soldier_84_oli","gm_dk_army_vest_54_crew","gm_ge_headgear_headset_crew_oli","gm_ferod16_grn","ItemMap","ItemRadio",
    "ItemCompass","ItemWatch","gm_gvm75_oli","gm_dk_army_uniform_soldier_84_m84","gm_dk_army_vest_54_rifleman","gm_dk_headgear_m52_net_oli",
    "gm_gvm75_oli_feroz24","gm_feroz24_blk","gm_lmgm62_blk","gm_dk_army_vest_54_machinegunner","gm_dk_army_backpack_73_mg3_oli",
    "gm_pzf84_oli_feroz2x17","gm_feroz2x17_pzf84_blk","gm_fim43_oli","gm_dk_army_backpack_73_pzf84_oli","gm_ge_backpack_satchel_80_san",
    "gm_dk_army_backpack_73_demolition_oli","gm_p2a1_blk","gm_dk_army_backpack_73_oli","gm_dk_army_uniform_soldier_84_win",
    "gm_dk_headgear_m52_net_win","gm_gvm95_blk_c79a1","gm_c79a1_blk","gm_dk_army_vest_m00_m84_rifleman","gm_dk_headgear_m96_cover_m84",
    "gm_dk_army_vest_m00_m84_machinegunner","gm_dk_army_vest_m00_win_rifleman","gm_dk_headgear_m96_cover_wht","gm_dk_army_vest_m00_win_machinegunner",
    "gm_g3a4_blk","gm_ge_headgear_hat_beanie_blk","gm_mp5a2_blk","gm_g3a3_blk_feroz24","gm_dk_headgear_hat_boonie_m84","gm_ge_headgear_winterhat_80_oli"
  ]
]
]

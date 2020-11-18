[] execvm "alex_spielerloadout_cfg\fnc_a_spcfg_memo_teamleader.sqf";
[] execvm "alex_spielerloadout_cfg\fnc_a_spcfg_memo_funker.sqf";
[] execvm "alex_spielerloadout_cfg\fnc_a_spcfg_memo_antitank.sqf";
[] execvm "alex_spielerloadout_cfg\fnc_a_spcfg_memo_sani.sqf";
[] execvm "alex_spielerloadout_cfg\fnc_a_spcfg_memo_machinegunner.sqf";
[] execvm "alex_spielerloadout_cfg\fnc_a_spcfg_memo_grenadier.sqf";
[] execvm "alex_spielerloadout_cfg\fnc_a_spcfg_memo_combatsniper.sqf";
[] execvm "alex_spielerloadout_cfg\fnc_a_spcfg_memo_sniper_dlc.sqf";
[] execvm "alex_spielerloadout_cfg\fnc_a_spcfg_memo_pilot.sqf";

sleep 10;

_loadouts = [];
_ld = getunitloadout psycho_teamleader; _loadouts pushback ["psycho_teamleader",_ld];
_ld = getunitloadout psycho_funker; _loadouts pushback ["psycho_funker",_ld];
_ld = getunitloadout psycho_antitank; _loadouts pushback ["psycho_antitank",_ld];
_ld = getunitloadout psycho_sani; _loadouts pushback ["psycho_sani",_ld];
_ld = getunitloadout psycho_machinegunner; _loadouts pushback ["psycho_machinegunner",_ld];
_ld = getunitloadout psycho_grenadier; _loadouts pushback ["psycho_grenadier",_ld];
_ld = getunitloadout psycho_combatsniper; _loadouts pushback ["psycho_combatsniper",_ld];
_ld = getunitloadout psycho_sniper_dlc; _loadouts pushback ["psycho_sniper_dlc",_ld];
_ld = getunitloadout psycho_pilot; _loadouts pushback ["psycho_pilot",_ld];

copytoclipboard (str(_loadouts));
systemchat "tes beendet";
[
  ["psycho_teamleader",[
    ["CUP_arifle_HK416_Wood","CUP_muzzle_snds_M16_camo","CUP_acc_ANPEQ_15_Flashlight_OD_L","CUP_optic_ACOG_Reflex_Wood",["CUP_100Rnd_556x45_BetaCMag_ar15",100],[],"CUP_bipod_Harris_1A2_L_BLK"],
    [],
    ["CUP_hgun_Glock17_tan","CUP_muzzle_snds_M9","CUP_acc_CZ_M3X","optic_MRD",["CUP_17Rnd_9x19_glock17",17],[],""],
    ["CUP_U_B_GER_Fleck_Crye",[["FirstAidKit",1],["CUP_17Rnd_9x19_glock17",3,17],["CUP_30Rnd_556x45_PMAG_QP_Olive",1,30]]],
    ["CUP_V_B_GER_PVest_Fleck_TL",[["FirstAidKit",2],["CUP_100Rnd_556x45_BetaCMag_ar15",3,100],["MiniGrenade",3,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShell",2,1],["CUP_30Rnd_556x45_PMAG_QP_Olive",3,30]]],
    [],
    "CUP_H_OpsCore_Covered_Fleck_SF",
    "CUP_G_ESS_BLK_Scarf_Face_Grn_GPS",
    ["Laserdesignator_01_khk_F","","","",["Laserbatteries",1],[],""],
    ["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","TFAR_microdagr","NVGogglesB_grn_F"]
    ]
  ],
  ["psycho_funker",[
    ["CUP_arifle_HK416_Wood","CUP_muzzle_snds_M16_camo","CUP_acc_ANPEQ_15_Flashlight_OD_L","CUP_optic_ACOG_Reflex_Wood",["CUP_100Rnd_556x45_BetaCMag_ar15",100],[],"CUP_bipod_Harris_1A2_L_BLK"],
    [],
    [],
    ["CUP_U_B_GER_Fleck_Crye2",[["FirstAidKit",3],["SmokeShell",2,1]]],
    ["CUP_V_B_GER_PVest_Fleck_RFL_LT",[["HandGrenade",3,1],["CUP_30Rnd_556x45_PMAG_QP_Olive",5,30]]],
    ["TFAR_mr3000_bwmod",[["CUP_100Rnd_556x45_BetaCMag_ar15",2,100]]],
    "CUP_H_OpsCore_Covered_Fleck_SF",
    "G_Balaclava_TI_G_blk_F",
    ["Laserdesignator_01_khk_F","","","",["Laserbatteries",1],[],""],
    ["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","TFAR_microdagr","NVGogglesB_grn_F"]
    ]
  ],
  ["psycho_antitank",[
    ["CUP_arifle_HK416_Wood","CUP_muzzle_snds_M16_camo","CUP_acc_ANPEQ_15_Flashlight_OD_L","CUP_optic_ACOG_Reflex_Wood",["CUP_100Rnd_556x45_BetaCMag_ar15",100],[],"CUP_bipod_Harris_1A2_L_BLK"],
    ["launch_I_Titan_short_F","","","",["Titan_AT",1],[],""],
    [],
    ["CUP_U_B_GER_Fleck_Crye",[["FirstAidKit",3]]],
    ["CUP_V_B_GER_PVest_Fleck_RFL_LT",[["CUP_30Rnd_556x45_PMAG_QP_Olive",4,30],["CUP_100Rnd_556x45_BetaCMag_ar15",1,100],["SmokeShell",1,1],["MiniGrenade",2,1]]],
    ["CUP_B_GER_Pack_Flecktarn",[["Titan_AT",1,1]]],
    "CUP_H_OpsCore_Covered_Fleck_SF",
    "CUP_G_Grn_Scarf_Shades_GPSCombo",
    ["Laserdesignator_01_khk_F","","","",["Laserbatteries",1],[],""],
    ["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","TFAR_microdagr","NVGogglesB_grn_F"]
    ]
  ],
  ["psycho_sani",[
    ["CUP_arifle_HK416_Wood","CUP_muzzle_snds_M16_camo","CUP_acc_ANPEQ_15_Flashlight_OD_L","CUP_optic_ACOG_Reflex_Wood",["CUP_30Rnd_556x45_PMAG_QP_Olive",30],[],"CUP_bipod_Harris_1A2_L_BLK"],
    [],
    [],
    ["CUP_U_B_GER_Fleck_Crye",[["FirstAidKit",3],["SmokeShell",2,1]]],
    ["CUP_V_B_GER_PVest_Fleck_Med_LT",[["CUP_30Rnd_556x45_PMAG_QP_Olive",5,30],["SmokeShell",4,1],["CUP_100Rnd_556x45_BetaCMag_ar15",1,100]]],
    ["CUP_B_GER_Medic_Flecktarn",[["FirstAidKit",5],["Medikit",1]]],
    "CUP_H_OpsCore_Covered_Fleck_SF",
    "CUP_G_Grn_Scarf_Shades_GPS",
    ["Laserdesignator_01_khk_F","","","",["Laserbatteries",1],[],""],
    ["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","TFAR_microdagr","NVGogglesB_grn_F"]
    ]
  ],
  ["psycho_machinegunner",[
    ["CUP_lmg_m249_pip2","CUP_muzzle_mfsup_SCAR_L","","CUP_optic_Elcan_SpecterDR_RMR_black",["CUP_200Rnd_TE4_Red_Tracer_556x45_M249",200],[],""],
    [],
    [],
    ["CUP_U_B_GER_Fleck_Crye2",[["FirstAidKit",3]]],
    ["CUP_V_B_GER_PVest_Fleck_MG",[["CUP_200Rnd_TE4_Red_Tracer_556x45_M249",2,200],["CUP_200Rnd_TE4_Red_Tracer_556x45_L110A1",2,200],["MiniGrenade",1,1],["gm_smokeshell_wht_gc",1,1]]],
    [],
    "CUP_H_OpsCore_Covered_Fleck_SF",
    "G_Bandanna_beast",
    ["Laserdesignator_01_khk_F","","","",["Laserbatteries",1],[],""],
    ["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","TFAR_microdagr","NVGogglesB_grn_F"]
    ]
  ],
  ["psycho_grenadier",[
    ["CUP_arifle_HK416_AGL_Wood","CUP_muzzle_snds_M16_camo","CUP_acc_ANPEQ_15_Flashlight_OD_L","CUP_optic_ACOG_Reflex_Wood",["CUP_30Rnd_556x45_PMAG_QP",30],["CUP_1Rnd_HE_M203",1],""],
    [],
    [],
    ["CUP_U_B_GER_Fleck_Crye",[["FirstAidKit",3],["SmokeShell",2,1],["CUP_30Rnd_556x45_PMAG_QP",1,30]]],
    ["CUP_V_B_GER_PVest_Fleck_Gren",[["SmokeShell",1,1],["CUP_30Rnd_556x45_PMAG_QP",2,30],["CUP_1Rnd_HE_M203",4,1],["CUP_100Rnd_556x45_BetaCMag_ar15",2,100],["CUP_30Rnd_556x45_PMAG_QP_Olive",2,30],["MiniGrenade",2,1],["CUP_1Rnd_HEDP_M203",3,1],["UGL_FlareWhite_F",2,1]]],
    [],
    "CUP_H_OpsCore_Covered_Fleck_SF",
    "CUP_G_Grn_Scarf_Shades_GPS",
    ["Laserdesignator_01_khk_F","","","",["Laserbatteries",1],[],""],
    ["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","TFAR_microdagr","NVGogglesB_grn_F"]
    ]
  ],
  ["psycho_combatsniper",[
    ["CUP_arifle_HK417_20_Wood","muzzle_snds_B_snd_F","CUP_acc_ANPEQ_15_Flashlight_OD_L","optic_AMS_khk",["CUP_20Rnd_762x51_HK417_Camo_Wood",20],[],"CUP_bipod_Harris_1A2_L"],
    [],
    [],
    ["CUP_U_B_GER_Fleck_Crye",[["FirstAidKit",3],["MiniGrenade",2,1]]],
    ["CUP_V_B_GER_Carrier_Vest_3",[["SmokeShell",1,1],["CUP_20Rnd_762x51_HK417_Camo_Wood",5,20],["CUP_20Rnd_TE1_Red_Tracer_762x51_HK417",3,20]]],
    [],
    "CUP_H_OpsCore_Covered_Fleck_SF",
    "CUP_G_PMC_Facewrap_Tropical_Glasses_Dark",
    ["Laserdesignator_01_khk_F","","","",["Laserbatteries",1],[],""],
    ["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","TFAR_microdagr","NVGogglesB_grn_F"]
    ]
  ],
  ["psycho_sniper_dlc",[
    ["srifle_DMR_02_camo_F","muzzle_snds_338_green","CUP_acc_ANPEQ_15_Flashlight_Tan_L","optic_AMS",["10Rnd_338_Mag",10],[],"CUP_bipod_Harris_1A2_L_BLK"],
    [],
    [],
    ["U_B_T_Sniper_F",[["FirstAidKit",3],["MiniGrenade",2,1],["10Rnd_338_Mag",1,10]]],
    ["V_PlateCarrier1_tna_F",[["SmokeShell",1,1],["10Rnd_338_Mag",6,10]]],
    [],
    "CUP_H_OpsCore_Covered_Fleck_SF",
    "CUP_G_PMC_Facewrap_Tropical_Glasses_Dark",
    ["Laserdesignator_01_khk_F","","","",["Laserbatteries",1],[],""],
    ["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","TFAR_microdagr","NVGogglesB_grn_F"]
    ]
  ],
  ["psycho_pilot",[
    ["CUP_smg_MP7_woodland","CUP_muzzle_snds_MP7","CUP_acc_ANPEQ_15_Flashlight_Tan_L","CUP_optic_AC11704_OD",["CUP_40Rnd_46x30_MP7",40],[],""],
    [],
    ["CUP_hgun_Glock17_tan","","CUP_acc_CZ_M3X","optic_MRD",["CUP_17Rnd_9x19_glock17",17],[],""],
    ["U_I_pilotCoveralls",[["FirstAidKit",3],["MiniGrenade",2,1],["CUP_40Rnd_46x30_MP7",2,40]]],
    ["V_PlateCarrier2_rgr_noflag_F",[["SmokeShell",1,1],["CUP_40Rnd_46x30_MP7",4,40],["CUP_17Rnd_9x19_glock17",3,17],["CUP_40Rnd_46x30_MP7_Red_Tracer",3,40]]],
    ["B_Parachute",[]],
    "H_PilotHelmetFighter_B",
    "CUP_G_PMC_Facewrap_Tropical_Glasses_Dark",
    ["Laserdesignator_01_khk_F","","","",["Laserbatteries",1],[],""],
    ["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","TFAR_microdagr",""]
    ]
  ]
]

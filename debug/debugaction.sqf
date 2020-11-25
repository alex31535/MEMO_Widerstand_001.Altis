//############################ auto-loadout fuer ki
/*
masch.gew
[
  ["LMG_Zafir_F","","","",["150Rnd_762x54_Box",150],[],""],
  [],
  [],
  ["CUP_U_B_USMC_MCCUU_M81_roll_2_gloves",[["FirstAidKit",1],["HandGrenade",1,1]]],
  ["V_BandollierB_oli",[["150Rnd_762x54_Box",1,150]]],
  ["B_AssaultPack_dgtl",[["150Rnd_762x54_Box",3,150]]],
  "H_Beret_blk",
  "",
  [],
  ["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]
]
sturmgew
[
  ["CUP_arifle_AKM_Early","","","",["CUP_30Rnd_762x39_AK47_bakelite_M",30],[],""],
  [],
  [],
  ["CUP_U_B_USMC_MCCUU_M81_roll_2_gloves",[["FirstAidKit",1],["HandGrenade",1,1]]],
  ["V_BandollierB_oli",[["CUP_30Rnd_762x39_AK47_bakelite_M",7,30]]],
  [],
  "H_Beret_blk",
  "",
  [],
  ["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]
]
pistole
[
  [],
  [],
  ["PISTOLENKLASSE","","","",["PISTOLENMAGAZIN",AMMOCOUNT],[],""],
  ["CUP_U_B_USMC_MCCUU_M81_roll_2_gloves",[["FirstAidKit",1],["HandGrenade",1,1]]],
  ["V_BandollierB_oli",[["PISTOLENMAGAZIN",10,AMMOCOUNT]]],
  [],
  "H_Beret_blk",
  "",
  [],
  ["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]
]
*/

ts_waffen = [

[/* lvl 0 */
/* pistolen */
[2,"CUP_hgun_Compact",false],
[2,"CUP_hgun_Duty",false],
[2,"CUP_hgun_Phantom",false],
[2,"CUP_hgun_Glock17",false],
[2,"gm_lp1_blk",false],
[2,"CUP_hgun_Colt1911",false],
[2,"CUP_hgun_M9",false],
[2,"CUP_hgun_Makarov",false],
[2,"CUP_hgun_MicroUzi",false],
[2,"hgun_P07_khk_F",false],
[2,"hgun_P07_blk_F",false],
[2,"gm_p1_blk",false],
[2,"gm_p2a1_blk",false],
[2,"CUP_hgun_PB6P9",false],
[2,"hgun_Pistol_01_F",false],
[2,"gm_pm_blk",false],
[2,"CUP_hgun_SA61",false],
[2,"CUP_hgun_TaurusTracker455",false],
[2,"CUP_hgun_TaurusTracker455_gold",false],
[2,"gm_wz78_blk",false],
/* sturmgewehre */
[0,"gm_mpiak74n_brn",false],
[0,"gm_mpiak74n_prp",false],
[0,"gm_mpiaks74n_brn",false],
[0,"gm_mpiaks74n_prp",false],
[0,"gm_mpiaks74nk_brn",false],
[0,"gm_mpiaks74nk_prp",false],
[0,"gm_mpikm72_brn",false],
[0,"gm_mpikm72_prp",false],
[0,"gm_mpikms72_brn",false],
[0,"gm_mpikms72_prp",false],
/* maschinengewehre */
[0,"CUP_lmg_Pecheneg",true]
/* schrotgewehre */

],
[/* lvl 1 */
/* pistolen */

/* sturmgewehre */
[0,"arifle_AK12_F",false],
[0,"arifle_AK12_GL_F",false],
[0,"CUP_arifle_AK107",false],
[0,"CUP_arifle_AK107_GL",false],
[0,"CUP_arifle_AK47",false],
[0,"CUP_arifle_AK74",false],
[0,"CUP_arifle_AK74_GL",false],
[0,"CUP_arifle_AK74M",false],
[0,"CUP_arifle_AK74M_GL",false],
[0,"CUP_arifle_AKM",false],
[0,"arifle_AKM_F",false],
[0,"gm_akm_wud",false],
[0,"gm_akmn_wud",false],
[0,"CUP_arifle_AKS",false],
[0,"CUP_arifle_AKS_Gold",false],
[0,"arifle_AKS_F",false],
[0,"CUP_arifle_AKS74",false],
[0,"CUP_arifle_AKS74U",false],
[0,"gm_c7a1_oli",false],
[0,"gm_c7a1_blk",false],
[0,"CUP_arifle_FNFAL5061",false],
[0,"CUP_arifle_FNFAL5062",false],
[0,"CUP_arifle_FNFAL_railed",false],
[0,"CUP_arifle_FNFAL_OSW",false],
[0,"CUP_arifle_FNFAL",false],
[0,"gm_g3a3_oli",false],
[0,"gm_g3a3_grn",false],
[0,"gm_g3a3_blk",false],
[0,"gm_g3a3_des",false],
[0,"gm_g3a4_oli",false],
[0,"gm_g3a4_grn",false],
[0,"gm_g3a4_blk",false],
[0,"gm_g3a4_des",false],
[0,"gm_gvm75_oli",false],
[0,"gm_gvm75_grn",false],
[0,"gm_gvm75_blk",false],
[0,"gm_gvm75carb_oli",false],
[0,"gm_gvm75carb_grn",false],
[0,"gm_gvm75carb_blk",false],
[0,"gm_gvm95_blk",false],
[0,"gm_m16a1_blk",false],
[0,"CUP_arifle_M16A2",false],
[0,"gm_m16a2_blk",false],
[0,"CUP_arifle_M16A2_GL",false],
[0,"CUP_arifle_M16A4_Base",false],
[0,"CUP_arifle_M16A4_GL",false],

/* maschinengewehre */
[0,"CUP_lmg_L7A2",true],
[0,"LMG_03_F",true],
[0,"gm_lmgm62_blk",true],
[0,"gm_mg3_blk",true],
[0,"gm_mg3_des",true],
[0,"CUP_lmg_PKM",true],
[0,"gm_hmgpkm_prp",true],
[0,"CUP_lmg_UK59",true],

/* schrotgewehre */
[0,"CUP_sgun_M1014",false]

]
];


ts_uniloadout = [
  [],
  [],
  [],
  ["CUP_U_B_USMC_MCCUU_M81_roll_2_gloves",[["FirstAidKit",1],["HandGrenade",1,1]]],
  [],
  [],
  "H_Beret_blk",
  "",
  [],
  ["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]
];

private _loadout = []; {_loadout pushback _x} foreach ts_uniloadout;
private _lvl = 0;
private _waffen_params = [0,"CUP_lmg_L7A2",true];//selectrandom (ts_waffen select _lvl);
private _loadout_index = _waffen_params select 0;
private _waffenklasse = _waffen_params select 1;
private _rucksack_munition = _waffen_params select 2;

private _magazinklasse = selectrandom (getArray(configFile >> "CfgWeapons" >> _waffenklasse >> "magazines"));

private _patronen = getNumber(configfile >> "CfgMagazines" >> _magazinklasse >> "count");
_loadout set [_loadout_index,[_waffenklasse,"","","",[_magazinklasse,_patronen],[],""]];
_loadout set [4,["V_BandollierB_oli",[[_magazinklasse,10,_patronen]]]];
private _loadout_rucksackeintrag = [];
if (_rucksack_munition) then {
  _loadout set [5,["B_AssaultPack_dgtl",[[_magazinklasse,4,_patronen]]]];
  _loadout set [4,[]];
};
player setunitloadout _loadout;

/*
  fnc_s_feindkonfig
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by:
	Parameters: params ["_unit","_lvl"] fnc_s_feindkonfig
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: unnecessary

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
params ["_unit","_lvl"];
_unit setskill (((100/8) * _lvl) + (random(100/8)))/100;
private _loadout = [
  [],[],[],
  ["CUP_U_B_USMC_MCCUU_M81_roll_2_gloves",[["FirstAidKit",1],["HandGrenade",1,1]]],
  [],[],
  "H_Beret_blk",
  "",[],
  ["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]
];
if (side _unit == resistance) then {
  _loadout = [
    [],[],[],
    ["CUP_U_B_BDUv2_roll_gloves_dirty_DCU_US",[["FirstAidKit",1],["HandGrenade",1,1]]],
    [],[],
    "CUP_H_FR_BandanaGreen",
    "",[],
    ["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]
  ];
};


private _feindausstattung = s_feindausstattung select _lvl; _feindausstattung call BIS_fnc_arrayShuffle;
private _waffen_params = selectrandom _feindausstattung;
private _waffenklasse = _waffen_params select 1;
private _magazinklasse = selectrandom (getArray(configFile >> "CfgWeapons" >> _waffenklasse >> "magazines"));
private _patronen = getNumber(configfile >> "CfgMagazines" >> _magazinklasse >> "count");
_loadout set [_waffen_params select 0,[_waffenklasse,"","","",[_magazinklasse,_patronen],[],""]];
_loadout set [4,["V_BandollierB_oli",[[_magazinklasse,10,_patronen]]]];
private _loadout_rucksackeintrag = [];
if (_waffen_params select 2) then {
  _loadout set [5,["B_AssaultPack_dgtl",[[_magazinklasse,4,_patronen]]]];
  _loadout set [4,[]];
};
_unit setunitloadout _loadout;
_unit allowfleeing 0;

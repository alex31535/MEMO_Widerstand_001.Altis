/*
  fnc_s_sys_unit_konfig_loadout.sqf
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: unnecessary

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
#define _DEF_klondistanz 100
params ["_unit","_loadouttyp"];
private _loadout = getunitloadout _unit;
switch (_loadouttyp) do {
  case "selbstmoerder": {
    _loadout = [
      [],
      [],
      [],
      [selectrandom s_sys_lo_uniformen_banditen,[["FirstAidKit",2]]],
      [],
      selectrandom s_sys_lo_rucksacksets_selbstmoerder,
      "",
      (selectrandom s_sys_lo_brillen_banditen),
      [],
      ["","","","","",""]
    ];
    _unit setspeedmode "FULL";
    _unit setBehaviourStrong "CARELESS";
  };
  case "spielerklon": {
    private _spieler_in_distanz = (playableunits select {alive _x}) inareaarray [position _unit,_DEF_klondistanz,_DEF_klondistanz,0,false];
    if ((count _spieler_in_distanz) > 0) then {_unit setunitloadout (getunitloadout(selectrandom _spieler_in_distanz))};
  };
  case "bandit": {
    _loadout = [
      [],
      [],
      [],
      [selectrandom s_sys_lo_uniformen_banditen,[["FirstAidKit",2]]],
      [],
      [],
      "",
      (selectrandom s_sys_lo_brillen_banditen),
      [],
      ["","","","","",""]
    ];
  };
  case "geisel": {
    _loadout = [
      [],
      [],
      [],
      [selectrandom s_sys_lo_uniformen_geiseln,[["FirstAidKit",1]]],
      [selectrandom s_sys_lo_westen_geiseln,[]],
      [],
      "",
      "",
      [],
      ["","","","","",""]
    ];
  };
};
_unit setunitloadout _loadout;

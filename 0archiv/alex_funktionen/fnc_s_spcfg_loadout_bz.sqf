/*
  fnc_s_spcfg_loadout_bz.sqf
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
params ["_unit"];
private _loadout = [[],[],[],[],[],[],"","",[],["","","","","",""]];
private _gewaehlt = selectrandom s_spcfg_bz_loadout_0_4;
private _gewaehlt_element = _gewaehlt select 1;
_gewaehlt_element set [0,selectrandom s_spcfg_bz_loadout_4_weste];
_gewaehlt set [1,_gewaehlt_element];
_loadout set [0,_gewaehlt select 0];
_loadout set [4,_gewaehlt select 1];
_loadout set [3,[selectrandom s_spcfg_bz_loadout_3_uniform,[["FirstAidKit",2],["RyanZombiesAntiVirusCure_Item",1],["RyanZombiesAntiVirusTemporary_Item",1]]]];
_loadout set [7,selectrandom s_spcfg_bz_loadout_7_brillen];
_unit setunitloadout _loadout;

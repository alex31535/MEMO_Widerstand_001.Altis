/*
  a_spcfg_oeffnet_arsenal
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
["Open",[nil,player,player]] call bis_fnc_arsenal;
waitUntil {!(isNull(uiNamespace getVariable["BIS_fnc_arsenal_cam",objNull]))};
waitUntil {isNull(uiNamespace getVariable["BIS_fnc_arsenal_cam",objNull])};

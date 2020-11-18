/*
  fnc_s_spcfg_spieler_ausstatten_psycho
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
params ["_datensatz","_spieler"];
call compile format["_spieler setUnitLoadout %1;",_datensatz];
[] remoteexec ["fnc_a_tfar_frequenzen_setzen",_spieler];
//if (!isnil "TFAR_fnc_activeSwRadio") then {[[(call TFAR_fnc_activeSwRadio), 1, s_tfar_sr]] remoteexec ["TFAR_fnc_SetChannelFrequency",_spieler]};
//if (!isnil "TFAR_fnc_activeSwRadio") then {[[(call TFAR_fnc_activeLrRadio), 1, s_tfar_lr]] remoteexec ["TFAR_fnc_SetChannelFrequency",_spieler]};

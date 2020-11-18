/*
  fnc_s_spcfg_action_auf_obj
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
params ["_obj"];
{
  [_obj, ["<t color='#ffbb00'>Psychos Ausstattungen",{_this remoteexec ["fnc_s_spcfg_ausstattungen_auflisten_psycho",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_x];
  [_obj, ["<t color='#ffbb00'>Schnellausstattung",{_this remoteexec ["fnc_s_spcfg_ausstattungen_auflisten",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_x];
  [_obj, ["<t color='#ffbb00'>MEMO Waffenkammer",{_this remoteexec ["fnc_s_spcfg_arsenal_memo",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_x];
  [_obj, ["<t color='#ffbb00'>MEMO Waffenkammer: Letzte Ausstattung",{_this remoteexec ["fnc_s_spcfg_arsenalloadout_auf_spieler",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_x];
} foreach playableunits;

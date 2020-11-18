/*
  fnc_s_spcfg_arsenalloadout_auf_spieler
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
params ["_action_obj","_spieler","_action_id","_uebergabe","_typ","_seite"];

if (!(s_mission_params select 6)) exitwith {
  [["<t color='#ff0000' size='2'>Ausruestungen stehen in dieser Mission nicht zur Verfuegung!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};

private _loadout = [];
call compile format["if (! isnil ""s_%1_loadout_arsenal"") then {_loadout = s_%1_loadout_arsenal};",getplayeruid _spieler];
if ((count _loadout) == 0) exitwith {
  [["<t color='#ff0000' size='2'>Du musst zuerst eine NEUE Ausstattung aus der Waffenkammer gewaehlt haben!", "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
[_spieler,_loadout] remoteexec ["setunitloadout",_spieler];
//if (!isnil "TFAR_fnc_activeSwRadio") then {[[(call TFAR_fnc_activeSwRadio), 1, s_tfar_sr]] remoteexec ["TFAR_fnc_SetChannelFrequency",_spieler]};
//if (!isnil "TFAR_fnc_activeSwRadio") then {[[(call TFAR_fnc_activeLrRadio), 1, s_tfar_lr]] remoteexec ["TFAR_fnc_SetChannelFrequency",_spieler]};

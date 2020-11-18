/*
  fnc_s_sys_unit_folgt.sqf
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
#define _DEF_dist_grp_erkennung 3
#define _DEF_unit_wird_gefuehrt (_zivilist checkAIFeature "MOVE")
#define _DEF_anfuehrer (leader _zivilist)

params ["_unit"];

if (isnull _unit) exitwith {};

if (!alive _unit) exitwith {};



// # anfuehrer = spieler, anfueher bewustlos,
if ((_DEF_anfuehrer != _zivilist) && {(lifeState _DEF_anfuehrer) == "INCAPACITATED"} && {_DEF_unit_wird_gefuehrt}) exitwith {
  [_zivilist] joinsilent grpnull;
  _zivilist disableAI "MOVE";
};

private _spieler_in_naehe = (playableunits inareaarray [getposatl _zivilist,_DEF_dist_grp_erkennung,_DEF_dist_grp_erkennung,0,false,_DEF_dist_grp_erkennung]) select {alive _x};

if (((count _spieler_in_naehe) == 0) && {_zivilist checkAIFeature "MOVE"}) exitwith {
  [_zivilist] joinsilent grpnull;
  //_zivilist move (position _zivilist);
  _zivilist disableAI "MOVE";
};

[_zivilist] joinsilent (_spieler_in_naehe select 0);
_zivilist enableAI "Move";
if (captive _zivilist) then {_zivilist setcaptive false};

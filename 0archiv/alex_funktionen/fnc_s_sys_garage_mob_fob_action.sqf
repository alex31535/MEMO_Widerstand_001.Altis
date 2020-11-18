/*
  fnc_s_sys_garage_mob_fob_action
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.13
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: unnecessary

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
params ["_fzg","_spieler"];
private _reichweite = (sizeOf (typeof _fzg)) *2;

[_fzg,
["<t color='#ffbb00'>Schnellreise: HQ",{
  _this append ["s_pos_transfer_hq"];_this remoteexec ["fnc_s_sys_transfer_zu_hq_x",2]
},"",_reichweite,true,true,"","",2]] remoteExec ["addAction",_spieler];

[_fzg,
["<t color='#ffbb00'>Schnellreise: Hafen",{
  _this append ["s_pos_transfer_hq_w"];_this remoteexec ["fnc_s_sys_transfer_zu_hq_x",2]
},"",_reichweite,true,true,"","",2]] remoteExec ["addAction",_spieler];


if (!isnil "fnc_s_spcfg_ausstattungen_auflisten_psycho") then {
  [_fzg,
  ["<t color='#ffbb00'>Psychos Ausstattungen",
  {_this append [1];_this remoteexec ["fnc_s_spcfg_ausstattungen_auflisten_psycho",2]},
  "",_reichweite,true,true,"","",2]] remoteExec ["addAction",_spieler];
};

if (!isnil "fnc_s_spcfg_ausstattungen_auflisten") then {
  [_fzg,
  ["<t color='#ffbb00'>Schnellausstattung",
  {_this append [1];_this remoteexec ["fnc_s_spcfg_ausstattungen_auflisten",2]},
  "",_reichweite,true,true,"","",2]] remoteExec ["addAction",_spieler];
};

if (!isnil "fnc_s_spcfg_arsenal_memo") then {
  [_fzg,
  ["<t color='#ffbb00'>MEMO Waffenkammer",
  {_this append [1];_this remoteexec ["fnc_s_spcfg_arsenal_memo",2]},
  "",_reichweite,true,true,"","",2]] remoteExec ["addAction",_spieler];
};

if (!isnil "fnc_s_spcfg_arsenalloadout_auf_spieler") then {
  [_fzg,
  ["<t color='#ffbb00'>MEMO Waffenkammer: Letzte Ausstattung",
  {_this append [1];_this remoteexec ["fnc_s_spcfg_arsenalloadout_auf_spieler",2]},
  "",_reichweite,true,true,"","",2]] remoteExec ["addAction",_spieler];
};

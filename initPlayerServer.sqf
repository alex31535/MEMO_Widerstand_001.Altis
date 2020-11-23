params ["_spieler","_jip"];
private _uid = getplayeruid _spieler;

// # auf server warten ----------------------------------------------------------------------------------------------------------auf server warten
while {!s_initserver_beendet} do {
  [["....warte auf Server....", "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler];
  uisleep 1;
};


// # spieler/uid-var bearbeiten ---------------------------------------------------------------------------------------------------------------------spieler/uid-var bearbeiten
private _uid_var = [];
call compile format["_uid_var = if (isnil ""s_%1"") then [{[]},{s_%1}];",_uid];
if ((count _uid_var) == 0) then {[_spieler] call fnc_s_uid_var_lesen};
call compile format["_uid_var = if (isnil ""s_%1"") then [{[]},{s_%1}];",_uid];
if ((count _uid_var) == 0) then {[_spieler] call fnc_s_uid_var_neu};
[_spieler] call fnc_s_uid_var_anwenden;

// # objekt-action ---------------------------------------------------------------------------------------------------------------------------------objekt-action
[["....initialisiere Action-Objekte....", "BLACK FADED", -1, true, true]] remoteexec ["titleText",_spieler]; uisleep 1;
[eo_basis_ausruestung, ["<t color='#ffbb00'>Waffenkammer",{_this remoteexec ["fnc_s_waffenkammer",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];

[eo_garage_steuerung, ["<t color='#ffbd00'>Radfahrzeug ausparken",
    {_this append ["s_garage_area","s_garage_rad","RoadBarrier_small_F"];_this remoteexec ["fnc_s_garage_ausparken",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];

[eo_garage_steuerung, ["<t color='#ffbb00'>Einparken",
    {_this append ["s_garage_area"];_this remoteexec ["fnc_s_garage_einparken",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];

[eo_missionen,["<t color='#ffbb00'>Gruppenmission waehlen",
    {_this remoteexec ["fnc_s_action_gruppenmission_waehlen",2]},"", 1.5,true,true,"","",2]] remoteExec ["addAction",_spieler];


// # missions allgemein ------------------------------------------------------------------------------------------------------------------------missions allgemein


// # witti: enticklungsumgebung----------------------------------------------------------------------------------------------------------------------------witti: enticklungsumgebung
[] execvm "witti\initPlayerServer.sqf";


// # spieler freigeben ------------------------------------------------------------------------------------------------------------------------spieler freigeben
[["....bereit....", "BLACK IN", 2, true, true]] remoteexec ["titleText",_spieler];
//[] remoteexec ["fnc_a_tfar_frequenzen_setzen",_spieler];

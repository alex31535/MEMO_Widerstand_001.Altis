/*
  fnc_a_tfar_frequenzen_setzen
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
//https://github.com/michail-nikolaev/task-force-arma-3-radio/wiki/API:-Functions
//_hasRadio = [_player] call TFAR_fnc_hasRadio;

systemchat "Pruefe SW-Radio...";
uisleep 2;
if (call TFAR_fnc_haveSWRadio) then {
  systemchat "Setze Default-Frequenzen fuer SW-Radio...";
  [(call TFAR_fnc_activeSwRadio), 1, "111"] call TFAR_fnc_SetChannelFrequency;
  [(call TFAR_fnc_activeSwRadio), 2, "112"] call TFAR_fnc_SetChannelFrequency;
  [(call TFAR_fnc_activeSwRadio), 3, "113"] call TFAR_fnc_SetChannelFrequency;
  [(call TFAR_fnc_activeSwRadio), 4, "114"] call TFAR_fnc_SetChannelFrequency;
  [(call TFAR_fnc_activeSwRadio), 5, "115"] call TFAR_fnc_SetChannelFrequency;
  [(call TFAR_fnc_activeSwRadio), 6, "116"] call TFAR_fnc_SetChannelFrequency;
  [(call TFAR_fnc_activeSwRadio), 7, "117"] call TFAR_fnc_SetChannelFrequency;
  [(call TFAR_fnc_activeSwRadio), 8, "118"] call TFAR_fnc_SetChannelFrequency;
  [(call TFAR_fnc_activeSwRadio), 9, "119"] call TFAR_fnc_SetChannelFrequency;
} else {
  systemchat "SW-Radio. nicht gefunden...";
};

systemchat "Pruefe LR-Radio...";
if (call TFAR_fnc_haveLrRadio) then {
  systemchat "Setze Default-Frequenzen fuer LR-Radio...";
  [(call TFAR_fnc_activeLrRadio), 1, "75"] call TFAR_fnc_SetChannelFrequency;
} else {
  systemchat "LR-Radio. nicht gefunden...";
};

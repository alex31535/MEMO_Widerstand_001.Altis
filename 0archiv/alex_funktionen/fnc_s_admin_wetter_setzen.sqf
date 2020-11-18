/*
  fnc_s_admin_wetter_setzen
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
systemchat format["fnc_s_admin_wetter_setzen: %1",_this];
private _overcast = 0; call compile format["_overcast = %1;",_this select 0];
private _regen = 0;
private _blitze = 0;
if (_overcast >= 0.7) then {_regen = 0.25};
if (_overcast >= 0.8) then {_regen = 0.50};
if (_overcast >= 0.9) then {_regen = 0.75};
if (_overcast >= 1) then {_regen = 1};
50 setrain _regen;
if (_overcast >= 0.9) then {_blitze = 0.5};
if (_overcast >= 1) then {_blitze = 1};
50 setLightnings _blitze;
50 setOvercast _overcast;
forceWeatherChange;

//-------------------------------------------------------------------------
if (true) exitwith {};

s_pause_ambiente_setzen set [1,(s_pause_ambiente_setzen select 0) + time];
s_wetter set [0,_overcast];
if (_overcast >= 0.7) then {_regen = 0.25};
if (_overcast >= 0.8) then {_regen = 0.50};
if (_overcast >= 0.9) then {_regen = 0.75};
if (_overcast >= 1) then {_regen = 1};
50 setrain _regen;
if (_overcast >= 0.9) then {_blitze = 0.5};
if (_overcast >= 1) then {_blitze = 1};
50 setLightnings _blitze;
50 setOvercast _overcast;
forceWeatherChange;

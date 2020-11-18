player setpos (getmarkerpos "m_debug_sprung");

uisleep 1;
systemchat "mitspieler werden beschaedigt";

{
  if (_x != player) then {_x setdammage 1};
} foreach playableunits;

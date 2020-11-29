/*
  fnc_s_vert_moerserziel
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.11
	Description:
  Called by:
	Parameters: [0:[pos1#zentrum],1:[pos2#abstand]]
	Returns: winkel pos1 auf pos2 (numerisch)
  Necessary Globals:
	Example: unnecessary

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
params ["_spieler","_projektil"];
s_vert_moersersignal_zaehler = s_vert_moersersignal_zaehler +1;
if (s_vert_moersersignal_zaehler > s_vert_anz_moersersignal) exitwith {
  [[format["<t color='#bf0222' size='2'>Die maximale Anzahl von %1 Moerser-Anforderungen wurde bereits erreicht!",s_vert_anz_moersersignal], "PLAIN", -1, true, true]] remoteExec ["cutText",_spieler];
};
{
  [[format["<t color='#bf0222' size='2'>%1 hat einen Moerserangriff #%2 angefordert!",name _spieler,s_vert_anz_moersersignal], "PLAIN DOWN", -1, true, true]] remoteExec ["cutText",_x];
} foreach playableunits;
uisleep 3;
[s_vert_moerser_pos,position _projektil,"east",50,3] remoteexec ["fnc_s_sys_moerser",2];

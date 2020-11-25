/*
  init_objektmuelleimer.sqf
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Necessary functions:
	Example:
    intervall call: if ((! isnil "s_objektmuelleimer") && {time>s_objmuell_naechste_leerung}) then {[] spawn fnc_s_objmuell_intervall};
    add objects: if (!isnil "s_objektmuelleimer") then {s_objektmuelleimer pushback [OBJECT,PLAYER_FREE_DISTANCE]};
    delete object call: if ((! isnil "s_objektmuelleimer") && {[OBJECT] spawn fnc_s_objmuell_obj};
    delete all call: if ((! isnil "s_objektmuelleimer") && {[] spawn fnc_s_objmuell_alles};

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/

// diese version hat die annahme, dass die zuerst hinzugefuegten objekte im missionsverlauf am weitesten von spielern entfernt sind !

while {true} do {
  if ((count s_objektmuelleimer) > 0) then {
    _eintrag = s_objektmuelleimer select 0;
    if (((_eintrag select 1) > 0) && {(count(allplayers inareaarray [position (_eintrag select 0),_eintrag select 1,_eintrag select 1,0,false])) == 0}) then {
      deletevehicle (_eintrag select 0);
      s_objektmuelleimer deleteat 0;
    };
  };
  uisleep 0.3;
};

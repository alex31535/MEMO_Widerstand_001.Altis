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
#define _DEF_intervall_totes_aufraeumen 60;
params ["_objmuell_intervall"];
s_objmuell_intervall = _objmuell_intervall;
// # fix-params
s_objmuell_naechste_leerung = time + s_objmuell_intervall;
s_objektmuelleimer = [/*[obj,dist]*/];

_zeitstempel_totes_aufraeumen = time + _DEF_intervall_totes_aufraeumen;


// # core
while {true} do {

  if (time > s_objmuell_naechste_leerung) then {[] call fnc_s_objmuell_intervall};


  if (time > _zeitstempel_totes_aufraeumen) then {
    {
      deleteVehicle _x;
    } forEach allDead;
    _zeitstempel_totes_aufraeumen = time + _DEF_intervall_totes_aufraeumen;
  };


  uisleep 0.3;
};

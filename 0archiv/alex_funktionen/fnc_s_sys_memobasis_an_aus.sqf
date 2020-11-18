/*
  fnc_s_sys_memobasis_an_aus
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
if (isnil "s_sys_memobasis_an_aus") then {s_sys_memobasis_an_aus = []};
if ((count s_sys_memobasis_an_aus) > 0) then {
  {
    (objectfromnetid (_x select 0)) setdir (_x select 2);
    (objectfromnetid (_x select 0)) setposworld (_x select 1);
  } foreach s_sys_memobasis_an_aus;
  s_sys_memobasis_an_aus = [];
} else {
  {
    s_sys_memobasis_an_aus pushback [netid _x,getposworld _x,getdir _x];
    _x setpos [random worldsize,0,0];
  } foreach [
      eo_admin,
      eo_obj_spcfg,
      eo_garage_hq_steuerung,
      eo_garage_w_steuerung,
      eo_hq_missionsteilnahme,
      eo_hq_missionsgeber];
};

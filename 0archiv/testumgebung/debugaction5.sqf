//[player] call fnc_s_spcfg_loadout_bz;


[] call fnc_s_sys_memobasis_an_aus;

if (true) exitwith {};
/*
eo_admin
eo_obj_spcfg
eo_garage_hq_steuerung
eo_garage_w_steuerung
eo_hq_missionsteilnahme
eo_hq_missionsgeber
*/


s_temp_versetzung = [];
{
  s_temp_versetzung pushback [netid _x,getposworld _x,getdir _x];
  _x setpos [random worldsize,0,0];
} foreach [eo_admin,eo_obj_spcfg,eo_garage_hq_steuerung,eo_garage_w_steuerung,eo_hq_missionsteilnahme,eo_hq_missionsgeber];
systemchat "versetzt";
uisleep 10;
{
  (objectfromnetid (_x select 0)) setdir (_x select 2);
  (objectfromnetid (_x select 0)) setposworld (_x select 1);
} foreach s_temp_versetzung;

systemchat "zurueck";

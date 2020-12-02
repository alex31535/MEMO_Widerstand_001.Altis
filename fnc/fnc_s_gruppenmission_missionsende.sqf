/*
  fnc_s_gruppenmission_missionsende
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.13
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: [_loc_params,_erstellte_objekte,_erstellte_marker] call fnc_s_gruppenmission_missionsende;

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/

params ["_loc_params","_erstellte_objekte","_erstellte_marker"];

reverse s_spieler_oder_ki;

// # die globalen loc-params mit den lokalen parametern setzen/aktualisieren
s_loc_params set [s_mission_params select 3,_loc_params];
(format["m_loc_icon_%1",s_mission_params select 3]) setmarkercolor (_loc_params select 7);
(format["m_loc_area_%1",s_mission_params select 3]) setmarkercolor (_loc_params select 7);


// # globale loc-params speichern
while {s_db_aktiv} do {uisleep 0.3}; s_db_aktiv = true;
private _db = ["new", format["%1_s_loc_params_%2",s_pref_spiel,(toLowerANSI worldname)]] call OO_INIDBI;
{["write",[_x select 0,_x select 0,_x]] call _db;} foreach s_loc_params;
_db = ["new", format["%1_s_spieler_oder_ki_%2",s_pref_spiel,(toLowerANSI worldname)]] call OO_INIDBI;
["write",["s_spieler_oder_ki","s_spieler_oder_ki",s_spieler_oder_ki]] call _db;
s_db_aktiv = false;

// bereinigungen -> objektmuelleimer
{deletemarker _x} foreach _erstellte_marker;
{s_objektmuelleimer pushback [_x,750]; _x allowfleeing 1} foreach _erstellte_objekte;

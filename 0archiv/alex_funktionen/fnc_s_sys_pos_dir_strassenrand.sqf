/*
  fnc_s_sys_pos_dir_strassenrand
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.13
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: _pos_platzierung = [strasse] call fnc_s_pos_dir_strassenrand;
						[[pos],dir] (strassenrand) -> leeres array wenn fehlgeschlagen

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
params ["_strasse"];
private _pos_platzierung = [];
private _verbundene_strassen = roadsConnectedTo _strasse;
if ((count _verbundene_strassen) > 0) then {
	private _pos_strasse = getposatl _strasse;
	private _dir = [_pos_strasse, getpos(_verbundene_strassen select 0)] call fnc_a_sys_winkel_pos1_zu_pos2;
	_pos_platzierung = [[((_pos_strasse select 0) + ((sin (_dir +90)) *3)),((_pos_strasse select 1) + ((cos (_dir +90)) *3)),0],_dir];
};
_pos_platzierung

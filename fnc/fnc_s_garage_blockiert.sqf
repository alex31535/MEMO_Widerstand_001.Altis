/*
  fnc_s_garage_blockiert
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.12
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: [OBJ, KLASSE, DISPLAYNAME] = [fzg_pos_obj_area, "LandVehicle"] call fnc_s_LandVehicle_im_garagenbereich;

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
params ["_area"];
private _liste  = (vehicles inAreaArray _area);
if ((count _liste) == 0) exitwith {[objnull,"","Leer"]};
[_liste select 0, typeof(_liste select 0),getText(configfile >> "CfgVehicles" >> typeof(_liste select 0) >> "DisplayName")]
